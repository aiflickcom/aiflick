# AIFLICK 레벨/포인트 시스템 — 리서치 & 추천

> 작성: 2026-05-08 새벽 / Claude  
> 참고 사이트: 인벤, Civitai, Reddit, Stack Overflow, Discord(MEE6), Twitch, Duolingo + 게이미피케이션 디자인 가이드라인

---

## 0. TL;DR (먼저 결론)

너 사이트(AIFLICK)에 가장 잘 맞는 조합은 **"3-Layer 하이브리드"**:

1. **XP & 레벨** (활동량 기반) — Inven/MEE6 스타일, 단 일일 캡 + 어뷰징 방지
2. **Guess 정답률 + 스트릭 + 칭호** (게임 정체성 강조) — 너만의 무기
3. **뱃지 (Achievement)** — Stack Overflow 스타일로 명예/도전 의식

**가상 화폐(이니/베니 같은)는 도입 보류** — 운영 복잡도 대비 초기 가치 낮음. 사이트 커지면 그때.

자세한 근거는 ## 6 참고. 먼저 각 시스템 분석부터 정리.

---

## 1. 인벤(Inven) 시스템 분석

### 구조 — **5종 포인트 시스템**
| 포인트 | 용도 | 획득 방법 |
|--------|------|----------|
| **경험치 (XP)** | 레벨 상승 → 글쓰기/이미지첨부 등 기능 잠금해제 | 글 1pt, 댓글 1pt, 출석 50-100pt, 인증글 100pt, 광고 클릭 3pt |
| **이니 (Ini)** | 인장(아바타) 꾸미기, 스킬 습득 | 활동, 광고 |
| **베니 (Beni)** | 인장 장식, 라이센스 구매 — **희소** | 출석/광고 신고/인증글로만 (꾸준한 활동 필수) |
| **제니 (Zeni)** | 아이마트 경품 응모 | 활동 |
| **명성치** | 커뮤니티 내 인지도 | 글 추천 수, 인증글 선정 |

### 어뷰징 방지
- **일일 최대 5,000 XP 캡** — 글/댓글 무한 생성으로 빠른 레벨업 차단
- 캡 초과 시 글/댓글 작성 자체가 제한됨

### 핵심 메커닉
- **불로소득** — 스킬 레벨에 따라 매일 자동 XP (최대 220) 지급
- **출석체크 도장** — 단순 로그인 X, 명시적 클릭 필수
- **인벤마블** — 보드게임 + 랜딩 칸별 보상 (월간 초기화)

### 시사점 (AIFLICK 적용)
- ✅ **다중 화폐 분리**가 명확한 동기 부여 — 단, 너무 많으면 헷갈림 (3개 이하 추천)
- ✅ **일일 캡 + 어뷰징 방지**는 필수
- ✅ **출석 체크 도장**은 retention에 강력 (Duolingo 스트릭과 유사)
- ⚠️ **광고 클릭 보상**은 광고 수익화 단계 가야 가치 있음 — 초기엔 제외

---

## 2. Civitai (가장 비슷한 도메인 — AI 콘텐츠 커뮤니티)

### Buzz 시스템 (3색)
| 색깔 | 획득 | 사용 |
|------|------|------|
| **Blue Buzz** ⚡ | 무료 — 광고 시청, 일일 퀘스트, 리액션 받기 | 사이트 내 기능 |
| **Yellow Buzz** ⚡ | 암호화폐 결제 | 크리에이터 모델 사용 |
| **Green Buzz** ⚡ | 신용카드 결제 | 크리에이터 모델 사용 |

### 획득 메커닉
- **광고 시청** — ⚡0.25/광고, 시간당 100, 일당 400 캡
- **일일 퀘스트** — 최대 225 Buzz/일
- **리액션 받기** — 다른 사람이 내 글에 좋아요 누르면 자동 지급
- **신규 가입 보너스** — 100 Blue Buzz
- **콘텐츠 컬렉션 추가** — 다른 유저가 내 작품 모으면 보상

### 크리에이터 보상 분배
- 크리에이터 모델로 다른 사람이 이미지 생성 시 → **Buzz 일부 분배**
- 2025년 3월 한 달 $43,000 크리에이터 지급, 평균 $226/명
- → AI 크리에이터 경제(creator economy) 정착

### 시사점 (AIFLICK 적용)
- ✅ **신규 가입 보너스**는 즉시 동기 (첫인상)
- ✅ **남이 내 글에 반응 → 내 점수**는 핵심 — 콘텐츠 품질 ↑ 자연 유도
- ✅ **일일 퀘스트** = retention. AIFLICK에서 "오늘의 Guess 5개 풀기" 같은 형태 가능
- ⚠️ **광고 시청 보상**은 트래픽 충분할 때 (지금은 X)
- ⚠️ **현금 결제 화폐**는 AIFLICK 초기엔 너무 빠름

---

## 3. Reddit Karma 시스템

### 구조
- **Post Karma** — 글 받은 upvote/downvote 합산
- **Comment Karma** — 댓글 받은 upvote/downvote 합산
- **Awardee Karma** — 받은 어워드 기반 (별개)

### 핵심 디자인
- **Vote Fuzzing** — 실제 표 수와 표시 수가 다름 (봇 어뷰징 방어)
- **CQS (Contributor Quality Score)** — 5단계 (Lowest → Highest), 신규 계정 콘텐츠 노출에 영향
- **Karma 가중치** — 큰 서브레딧에서의 upvote가 더 많은 karma
- **upvote 1개 ≠ karma 1점** — 비선형 알고리즘

### 시사점 (AIFLICK 적용)
- ✅ **다른 사용자 추천이 곧 점수** — 가장 자연스러운 사회적 증명
- ✅ **신규 계정 가중치 다운**은 어뷰징 방지에 효과적
- ⚠️ **Karma 자체는 사용처가 없음** — 단순 숫자, 명예만. AIFLICK에선 더 활용 필요

---

## 4. Stack Overflow Reputation + Badges

### Reputation (수치)
| 행동 | Reputation |
|------|-----------|
| 답변 upvote 받음 | +10 |
| 질문 upvote 받음 | +5 |
| 답변 채택됨 | +15 |
| Downvote 받음 | -2 |
| Downvote 누름 (질문/답변) | -1 |

### Privileges (권한 잠금해제 — 가장 강력한 디자인)
- 15 rep → upvote 가능
- 50 rep → 댓글 가능
- 125 rep → downvote 가능
- 1000 rep → 모더레이션 도구 일부 사용
- 25000 rep → 사이트 분석 데이터 접근

→ 점수가 단순 명예가 아니라 **실제 기능**을 푸는 열쇠

### Badges (95개)
- **Bronze** — 신규 입문 (예: 첫 답변, 10 upvote)
- **Silver** — 의미 있는 기여 (예: 100 답변, 명예의 전당)
- **Gold** — 지속적 우수 기여 (희소)

### 시사점 (AIFLICK 적용)
- ✅ **권한 잠금해제 시스템 = 황금 디자인** — XP가 의미를 가짐
- ✅ **Bronze/Silver/Gold 3단계 뱃지**는 명확한 위계
- ✅ **다양한 행동 = 다양한 뱃지** — 단순 활동량만 아니라 게임 정확도, 첫 글, 100 댓글 등 다층적 보상

---

## 5. MEE6 (Discord 봇) — 가장 단순한 레벨업

### 구조
- 메시지 1개당 **15-25 XP 랜덤** 지급
- 누적 XP에 따라 레벨업
- 일정 레벨 도달 시 **자동 역할 부여** (예: Lv10 → Regular)
- 리더보드 (서버 내 순위)

### 시사점
- ✅ 가장 단순/직관 — XP만으로 시작하기 좋음
- ⚠️ 메시지 = 점수라 어뷰징 쉬움 (스팸으로 레벨업)
- → AIFLICK에선 행동별 차등 가중치 필수

---

## 6. Twitch Channel Points

### 구조
- 시청 시간 기반 자동 적립
- 채널별로 별도 (한 채널 = 한 화폐)
- **커스텀 리워드** — 스트리머가 50개까지 보상 정의
- **Predictions** — 채널 포인트로 베팅 (스트림 결과)

### 시사점 (AIFLICK 적용)
- ✅ **Predictions 메커닉이 흥미로움** — Guess 게임이랑 결합 가능
   - 예: "오늘의 화제 영상이 AI일까 진짜일까?" 포인트 베팅 → 결과 따라 보상
- ⚠️ 시청 시간 = 시간 기반 보상은 AIFLICK 모델에 안 맞음 (활동 기반이 맞음)

---

## 7. Duolingo Streak (Retention 끝판왕)

### 효과 데이터
- Retention 12% → **55%** (4.6배)
- 7일 스트릭 유지 사용자는 장기 유지율 **3.6배**
- iOS 위젯에 스트릭 노출 → 참여도 **60%↑**
- **Streak Freeze** (놓친 날 보호) → 이탈률 **21%↓**

### 핵심 심리학 — 손실 회피
> 사용자는 "+1 더 가자"가 아니라 "지금까지 쌓은 N일을 잃기 싫어서" 돌아옴
> Loss aversion is asymmetric — 잃는 고통 > 얻는 즐거움

### 레이어드 디자인 (사용자 단계별)
- **신규** — 1일차 즉시 보상 (achievable)
- **중기** — 보호할 가치 있는 것 (스트릭) + 경쟁 컨텍스트 (리그)
- **장기** — 희소 목표 (대다수 못 도달) + 사회적 책임감

### 시사점 (AIFLICK 적용)
- ✅ **출석/Guess 스트릭** 적극 활용 — 이미 Guess Hub에 부분 구현
- ✅ **Streak Freeze** — 1주에 1회 가능 (유료 또는 활동 보상으로)
- ✅ **사용자 단계별 다른 목표** — 신규/중기/장기 동기 분리

---

## 8. 어뷰징/공정성 디자인 패턴

### 흔한 어뷰징 시나리오
1. **자기 글 좋아요 (자추)** — 다중 계정으로 자기 콘텐츠 점수 펌핑
2. **봇/스팸** — 빈 댓글로 XP 농사
3. **순환 추천 (vote ring)** — 친구들끼리 서로 추천
4. **새 계정 어뷰징** — 가입 후 즉시 활동 기반 보상 수령

### 방어 디자인
- ✅ **일일 캡** (인벤 5000XP/일)
- ✅ **신규 계정 페널티** (Reddit CQS) — 첫 N일은 보상 가중치 ↓
- ✅ **자기 추천 무효** — 본인 글에 본인이 누른 vote는 점수 안 줌
- ✅ **Vote Fuzzing** — 실제 점수 ≠ 표시 점수 (봇 봉쇄)
- ✅ **이메일/IP 중복 체크** — 다중 계정 만들기 비용 ↑
- ✅ **Soft 제한** — 어뷰징 의심 시 silent shadow ban (계정 작동은 하되 점수 안 줌)

### AIFLICK 특화 위험
- **Guess 정답 어뷰징**: 본인이 정답 알고 있는 자기 영상에 본인이 맞히기 → 점수 인플레
   - 대책: **자기가 올린 Guess 영상엔 투표 점수 안 줌**
- **댓글 스팸**: 의미없는 한 글자 댓글 반복
   - 대책: 최소 글자 수 / 일일 최대 댓글 점수 캡

---

## 9. 종합 비교 표

| 시스템 | 동기부여 | 어뷰징 위험 | 운영 복잡도 | AIFLICK 적합도 |
|--------|---------|------------|-----------|---------------|
| Inven 5종 화폐 | ★★★★ | 중간 | 높음 | ★★ (과함) |
| Civitai Buzz | ★★★★★ | 낮음 (광고 기반) | 매우 높음 | ★★★ (수익 단계 후) |
| Reddit Karma | ★★★ | 중간 | 낮음 | ★★★★ (단순+증명됨) |
| Stack Overflow Rep + Badges | ★★★★★ | 낮음 | 중간 | ★★★★★ (권한 잠금해제 ++) |
| MEE6 XP | ★★★ | 높음 (메시지 = XP) | 매우 낮음 | ★★ (너무 단순) |
| Twitch Channel Points | ★★★★ | 낮음 (시간 기반) | 중간 | ★★ (모델 안 맞음) |
| Duolingo Streak | ★★★★★ | 매우 낮음 | 낮음 | ★★★★★ (Guess와 시너지) |

---

## 10. AIFLICK 추천 — 3가지 안

### 🥇 안 A. **하이브리드 (3-Layer) — 강력 추천**

**구성:**
1. **XP + 레벨** (활동 기반)
2. **Guess 정답률/스트릭** (게임 정체성)
3. **뱃지** (성취/명예)

**스키마 변경:**
```sql
ALTER TABLE profiles ADD COLUMN xp INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN level INT DEFAULT 1;
ALTER TABLE profiles ADD COLUMN streak_days INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN last_visit DATE;
ALTER TABLE profiles ADD COLUMN guess_correct INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN guess_total INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN guess_best_streak INT DEFAULT 0;

CREATE TABLE badges (
  id TEXT PRIMARY KEY,           -- 'first_post', 'guess_10streak' 등
  name TEXT, description TEXT, tier TEXT  -- 'bronze'/'silver'/'gold'
);
CREATE TABLE user_badges (
  user_id UUID REFERENCES auth.users(id),
  badge_id TEXT REFERENCES badges(id),
  earned_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (user_id, badge_id)
);
```

**XP 획득표:**
| 행동 | XP | 비고 |
|------|-----|------|
| 일일 출석 | +20 | 첫 방문 자동 (한 번/일) |
| 7일 연속 출석 | +50 보너스 | 매주 토요일 |
| 영상/사진 업로드 | +30 | 일 최대 3건까지 |
| 글(Talk) 작성 | +15 | 일 최대 5건 |
| 댓글 작성 | +3 | 일 최대 10개 |
| **내 글에 좋아요 받음** | +5/개 | (남이 한 좋아요만) |
| **내 글에 댓글 받음** | +3/댓글 | |
| **Guess 정답** | +10 | (남의 Guess 영상 정답 시) |
| Guess 오답 | 0 | 페널티 없음 |
| 5일 스트릭 유지 | +30 보너스 | |
| 30일 스트릭 유지 | +200 보너스 | |
| **일일 XP 캡** | **300** | 어뷰징 방지 |

**레벨 공식:** `next_level_xp = 100 * level^1.5`
- Lv1→2: 100 XP
- Lv5→6: 1118 XP
- Lv10→11: 3162 XP
- Lv20: 약 8944 누적

**레벨 보상 (Privileges 잠금해제) — Stack Overflow 스타일:**
- Lv1: 댓글 가능 (기본)
- Lv3: 영상 업로드 가능
- Lv5: Guess 모드 영상 만들 수 있음
- Lv10: 닉네임 색깔 변경
- Lv15: 자기소개 추가 (마이페이지에)
- Lv20: 프리미엄 뱃지 (시각적 강조)
- Lv30: "AI 감별사" 칭호

**Guess 게임 칭호:**
| 정답률 (50회 이상) | 칭호 |
|-------------------|------|
| 90%+ | 🎯 AI 감별 마스터 |
| 80%+ | 🔍 베테랑 감별사 |
| 70%+ | 👁 시청 전문가 |
| 60%+ | 🤔 입문자 |
| <60% | (칭호 없음) |

**뱃지 예시 (확장 가능):**
- **Bronze**: 첫 글, 첫 영상, 첫 댓글, 첫 Guess 정답, 7일 스트릭
- **Silver**: 100 댓글, 50개 좋아요 받기, Guess 10연속 정답, 30일 스트릭
- **Gold**: 1000 좋아요 받기, Guess 100연속 정답, 100일 스트릭, 인기 글 1위

**장점:**
- 활동 다양성 보상 (콘텐츠 만들기 / 소비 / 게임 모두)
- Guess 게임과 시너지 — AIFLICK 정체성 강화
- 점진적 권한 잠금해제 = 의미 있는 진행
- 어뷰징 방어 내장 (일일 캡, 자기 추천 무효)

**단점:**
- 구현 작업 큼 (XP 트리거, 레벨 계산, 뱃지 자동 발급)

---

### 🥈 안 B. **단순 XP-Only**

**구성:**
- XP + 레벨만. 뱃지 X, 칭호 X, 화폐 X
- MEE6 스타일

**장점:**
- 가장 단순, 빠른 구현 (1-2시간)
- 사용자 이해 쉬움

**단점:**
- 동기부여 단조로움 — 한번 레벨업 멈춰도 그 다음이 없음
- AIFLICK의 게임 정체성(Guess) 활용 안 됨

→ **MVP**용으로는 OK, 장기적으론 부족

---

### 🥉 안 C. **Civitai 풀 카피 (가상 화폐 + 크리에이터 보상)**

**구성:**
- 가상 화폐 (Buzz 모방 — 예: "Flick Coin")
- 크리에이터 보상 분배 (다른 사용자가 내 콘텐츠 사용 시)
- 광고/결제 통합

**장점:**
- 가장 강력한 동기 (실제 가치 있는 화폐)
- AI 크리에이터 경제 모델

**단점:**
- 구현 매우 복잡 (결제, 광고, 분배 로직)
- 트래픽 적은 초기엔 의미 없음
- 법적/세금 이슈 가능

→ **사이트 안정화 후** 1-2년 뒤 검토

---

## 11. 단계별 로드맵 (안 A 채택 시)

### Phase 1: XP + 레벨 (1-2일 작업)
- profiles에 xp/level 칼럼
- 행동별 XP 트리거 (DB Function 또는 클라이언트 호출)
- 일일 캡 enforcement
- 헤더 아바타 옆에 "Lv 5" 표시
- 마이페이지에 진행 바 + 다음 레벨까지 XP

### Phase 2: 출석 + 스트릭 (반나절)
- 일일 첫 방문 자동 XP 지급
- streak_days 추적 (어제 방문 기록 비교)
- 마이페이지에 🔥 스트릭 표시
- (선택) Streak Freeze — 점수로 구매 가능

### Phase 3: 뱃지 시스템 (1-2일)
- badges / user_badges 테이블
- 자동 발급 로직 (특정 조건 도달 시)
- 마이페이지에 뱃지 그리드
- 카드/모달에 작은 뱃지 아이콘 (예: Gold 사용자는 닉네임 옆 ⭐)

### Phase 4: 칭호 + 권한 잠금해제 (반나절)
- Guess 정확도 칭호 자동 부여
- Lv별 기능 잠금/해제 (UI에서 체크)
- 마이페이지에 "다음 권한까지 X 레벨 남음" 안내

### Phase 5: 어뷰징 방어 강화 (지속)
- 자기 콘텐츠 좋아요/투표 → XP 0
- 짧은 댓글 (< 5자) XP 0
- 신규 계정 (3일 미만) 가중치 0.5x
- IP/이메일 중복 체크
- 의심 활동 모니터링 (admin)

---

## 12. UI/UX 적용 위치

### 마이페이지 (#me)
```
[아바타] 사용자명 [Lv12] 🔥7일
        ━━━━━━░░░░  Lv12 → Lv13 (450/1280 XP)

📊 활동
  Posts: 14   Votes: 87   Comments: 32   Reactions: 195

🎯 Guess 기록
  정답률: 73% (38/52)   현재 스트릭: 5   최고: 12
  칭호: 👁 시청 전문가

🏆 뱃지 (12/95)
  [🥇 첫 영상]  [🥇 7일 스트릭]  [🥈 100 댓글]  [🥉 ...] +9
```

### 헤더 (모든 페이지)
- 아바타 옆 작은 레벨 배지: `Lv12` (Orbitron 작게)
- 호버 시 진행률 툴팁

### 카드/모달
- 작성자 이름 옆 칭호 한 글자 (예: 🎯)
- 닉네임 색깔 (레벨별)

### Guess 허브
- 이미 있는 정답률/스트릭 카드 → **칭호 추가 표시**

---

## 13. DB 스키마 종합 (Phase 1+2+3 적용 시)

```sql
-- profiles 확장
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS xp INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS level INT DEFAULT 1;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS streak_days INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS last_visit_date DATE;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS guess_correct INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS guess_total INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS guess_best_streak INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS title TEXT;  -- 칭호
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS daily_xp_today INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS daily_xp_date DATE;

-- 일일 활동 로그 (어뷰징 추적)
CREATE TABLE IF NOT EXISTS xp_log (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  action TEXT NOT NULL,  -- 'post', 'comment', 'vote_correct', 'streak_bonus' 등
  xp_delta INT NOT NULL,
  ref_id UUID,  -- post_id 또는 comment_id 등
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX ON xp_log (user_id, created_at);

-- 뱃지 마스터
CREATE TABLE IF NOT EXISTS badges (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  tier TEXT CHECK (tier IN ('bronze', 'silver', 'gold')),
  icon TEXT,           -- 이모지 또는 아이콘 키
  category TEXT,       -- 'creator', 'consumer', 'guess', 'social'
  hidden BOOLEAN DEFAULT FALSE  -- 깜짝 뱃지
);

-- 유저 뱃지 (다대다)
CREATE TABLE IF NOT EXISTS user_badges (
  user_id UUID REFERENCES auth.users(id),
  badge_id TEXT REFERENCES badges(id),
  earned_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (user_id, badge_id)
);
```

---

## 14. 구현 시 주의사항

### 트랜잭션 안정성
- XP 갱신은 atomic해야 함 (race condition 방지)
- Supabase RPC 함수로 처리 권장:
  ```sql
  CREATE FUNCTION award_xp(uid UUID, action TEXT, amount INT, ref UUID)
  RETURNS VOID AS $$ ... $$ LANGUAGE plpgsql;
  ```

### 클라이언트 신뢰 X
- 클라이언트가 "나 +50 XP 줘" 하면 위험
- 행동(글 작성, 투표 등) DB 트리거 또는 RPC로 처리
- RLS 정책으로 직접 profiles 업데이트 차단

### 시각적 피드백
- 레벨업 시 작은 토스트/애니메이션 (Duolingo 식)
- 뱃지 획득 시 모달 알림
- → 도파민 루프 강화

### 점수 인플레 방지
- 너무 빨리 레벨업하면 동기부여 손실
- 일일 캡 + 비선형 레벨 공식 (level^1.5)
- 1주에 약 1-2 레벨업이 적정선

---

## 15. 결론 및 다음 단계

### 가장 추천: **안 A (3-Layer 하이브리드)**

이유:
1. AIFLICK의 **고유 자산(Guess 게임)**을 시스템 핵심에 박음
2. 다양한 사용자 페르소나 모두 보상 (소비자/크리에이터/게이머)
3. 어뷰징 방어 내장
4. 단계별 도입 가능 — Phase 1만으로도 의미 있는 가치
5. 후일 Civitai식 가상 화폐로 확장 여지 있음

### 즉시 시작 가능한 Phase 1 (1-2일)
- profiles 칼럼 5개 추가
- XP 부여 RPC 함수
- 마이페이지 + 헤더에 레벨 표시
- 일일 캡 enforcement

이게 자리 잡으면 Phase 2(스트릭) → Phase 3(뱃지) → Phase 4(칭호) 순으로 확장.

### 내일 얘기 나눌 때 결정할 것
1. 안 A/B/C 중 어느 거? (내 추천: A)
2. Phase 1만 먼저 해보고 반응 보기 vs 한 번에 다 만들기
3. 뱃지 종류 — 내가 제시한 것 외에 추가하고 싶은 거?
4. Guess 칭호 이름 — "AI 감별 마스터" 같은 거 마음에 드는지

자고 일어나서 이 문서 보고 의견 알려줘. 좋은 밤!

---

## Sources

### 인벤
- [인벤 - 나무위키](https://namu.wiki/w/%EC%9D%B8%EB%B2%A4)
- [인벤 포인트 가이드 (경험치, 이니, 제니, 베니, 명성치)](https://www.inven.co.kr/board/ro/1952/255961)
- [출석체크 - 혜택.아이마트](https://imart.inven.co.kr/attendance/)
- [아이마트 FAQ](https://imart.inven.co.kr/faq/?faqType=1)

### Civitai
- [Guide to Buzz - the Civitai On-Site Currency!](https://education.civitai.com/civitais-guide-to-on-site-currency-buzz-%E2%9A%A1/)
- [A guide to earning your 200+ daily (blue) buzz](https://civitai.com/articles/10006/a-guide-to-earning-your-200-daily-blue-buzz)
- [Buzz Point Breakdown (how to Optimize Your Buzz)](https://civitai.com/articles/4827/buzz-point-breakdown-how-to-optimize-your-buzz)
- [Civitai Creator Program](https://civitai.com/creator-program)

### Reddit
- [What is karma? – Reddit Help](https://support.reddithelp.com/hc/en-us/articles/204511829-What-is-karma)
- [Reddit Karma System 2026 – Types + Decay Table](https://techevangelistseo.com/reddit-karma-system/)
- [Reddit Karma Demystified](https://biztalbox.com/blog/what-is-reddit-karma)

### Stack Overflow
- [Reputation and Voting | Stack Overflow Internal Help Center](https://internal.stackoverflow.help/en/articles/8775594-reputation-and-voting)
- [Stack Overflow badges explained](https://stackoverflow.blog/2021/04/12/stack-overflow-badges-explained/)
- [Stack Overflow - Wikipedia](https://en.wikipedia.org/wiki/Stack_Overflow)

### MEE6
- [Levels | MEE6 Wiki](https://wiki.mee6.xyz/plugins/levels)
- [Boost Engagement: How to Set Up a Leveling System](https://startit.bot/blog/boost-engagement-how-to-set-up-a-leveling-system-on-your-discord-server/)
- [Leaderboard | MEE6 Wiki](https://wiki.mee6.xyz/en/features/leaderboard)

### Twitch
- [Twitch Channel Points: How Small Streamers Use Them](https://viewbotter.com/blog/twitch-channel-points-how-streamers-use-them/)
- [Channel Points Guide for Viewers](https://link.twitch.tv/ViewersChannelPoints)

### Duolingo
- [Duolingo gamification explained | StriveCloud](https://www.strivecloud.io/blog/gamification-examples-boost-user-retention-duolingo)
- [Duolingo's Gamification Secrets](https://www.orizon.co/blog/duolingos-gamification-secrets)
- [Duolingo — Streak System Detailed Breakdown](https://medium.com/@salamprem49/duolingo-streak-system-detailed-breakdown-design-flow-886f591c953f)
- [The Psychology Behind Duolingo's Streak Feature](https://www.justanotherpm.com/blog/the-psychology-behind-duolingos-streak-feature)

### 디자인 패턴
- [Display Achievements to Encourage Website Usage | IxDF](https://www.interaction-design.org/literature/article/display-achievements-to-encourage-website-usage)
- [The Octalysis Framework for Gamification | Yu-kai Chou](https://yukaichou.com/gamification-examples/octalysis-complete-gamification-framework/)
- [Community Gamification Implementation Guide | Gainsight](https://www.gainsight.com/blog/community-gamification/)
