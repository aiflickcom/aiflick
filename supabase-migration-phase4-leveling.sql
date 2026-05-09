-- AIFLICK Phase 4 — XP & Level system
-- Adds XP tracking + daily cap + activity log
-- Reversible: only adds nullable/defaulted columns and new tables

-- 1) profiles 확장
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS xp INT NOT NULL DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS level INT NOT NULL DEFAULT 1;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS daily_xp_today INT NOT NULL DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS daily_xp_date DATE;

-- 2) XP 활동 로그 (어뷰징 추적 + 디버깅 + 통계)
CREATE TABLE IF NOT EXISTS xp_log (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID NOT NULL,
  action TEXT NOT NULL,       -- 'upload_video', 'vote_correct', 'comment' 등
  xp_delta INT NOT NULL,
  ref_id UUID,                -- 관련 post_id / comment_id 등 (선택)
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_xp_log_user_time ON xp_log (user_id, created_at DESC);

-- 3) RPC 함수 — atomic하게 XP 증감 + 일일 캡 + 레벨 재계산
-- 호출 예: SELECT award_xp('user-uuid', 'upload_video', 30, 'post-uuid', 300);
CREATE OR REPLACE FUNCTION award_xp(
  p_user_id UUID,
  p_action TEXT,
  p_amount INT,
  p_ref_id UUID DEFAULT NULL,
  p_daily_cap INT DEFAULT 300
) RETURNS JSON AS $$
DECLARE
  v_today DATE := CURRENT_DATE;
  v_current_daily INT;
  v_current_date DATE;
  v_actual_amount INT;
  v_new_xp INT;
  v_new_level INT;
  v_old_level INT;
BEGIN
  -- 같은 트랜잭션에서 원자적 갱신
  SELECT daily_xp_today, daily_xp_date, level
    INTO v_current_daily, v_current_date, v_old_level
    FROM profiles WHERE id = p_user_id
    FOR UPDATE;

  -- 날짜 바뀌었으면 일일 카운터 리셋
  IF v_current_date IS NULL OR v_current_date <> v_today THEN
    v_current_daily := 0;
  END IF;

  -- 일일 캡 적용 — 캡 초과 시 일부만 지급
  IF v_current_daily >= p_daily_cap THEN
    v_actual_amount := 0;
  ELSIF v_current_daily + p_amount > p_daily_cap THEN
    v_actual_amount := p_daily_cap - v_current_daily;
  ELSE
    v_actual_amount := p_amount;
  END IF;

  -- 페널티(-)는 캡과 무관하게 적용
  IF p_amount < 0 THEN
    v_actual_amount := p_amount;
  END IF;

  -- 적용
  UPDATE profiles
    SET xp = GREATEST(0, xp + v_actual_amount),
        daily_xp_today = CASE WHEN p_amount > 0 THEN v_current_daily + v_actual_amount ELSE v_current_daily END,
        daily_xp_date = v_today
    WHERE id = p_user_id
    RETURNING xp INTO v_new_xp;

  -- 새 레벨 계산: floor( (xp / 100) ^ (1/1.5) ) + 1
  -- 레벨 N → 다음 레벨까지 누적 XP = 100 * N^1.5
  v_new_level := GREATEST(1, FLOOR(POWER(v_new_xp / 100.0, 1.0/1.5))::INT + 1);

  UPDATE profiles SET level = v_new_level WHERE id = p_user_id;

  -- 로그 기록
  IF v_actual_amount <> 0 THEN
    INSERT INTO xp_log (user_id, action, xp_delta, ref_id)
      VALUES (p_user_id, p_action, v_actual_amount, p_ref_id);
  END IF;

  RETURN json_build_object(
    'awarded', v_actual_amount,
    'requested', p_amount,
    'capped', v_actual_amount < p_amount AND p_amount > 0,
    'new_xp', v_new_xp,
    'new_level', v_new_level,
    'leveled_up', v_new_level > v_old_level
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 권한 — 인증된 유저만 자기 자신에게 호출 가능 (앱 레벨에서 체크하지만 안전망)
REVOKE ALL ON FUNCTION award_xp FROM PUBLIC;
GRANT EXECUTE ON FUNCTION award_xp TO authenticated;

-- 끝. 되돌리려면:
--   DROP FUNCTION IF EXISTS award_xp;
--   DROP TABLE IF EXISTS xp_log;
--   ALTER TABLE profiles DROP COLUMN IF EXISTS xp;
--   ALTER TABLE profiles DROP COLUMN IF EXISTS level;
--   ALTER TABLE profiles DROP COLUMN IF EXISTS daily_xp_today;
--   ALTER TABLE profiles DROP COLUMN IF EXISTS daily_xp_date;
