-- AIFLICK Phase 1 — schema migration
-- Run this in Supabase SQL Editor (Dashboard > SQL Editor) once.
-- Reversible: only adds nullable columns, doesn't drop anything.

-- 1) post_type — distinguishes flick (general video) / guess (Real or AI? game) / talk (text post)
-- (drop & re-add the CHECK constraint in case it was created with an older value set)
ALTER TABLE posts DROP CONSTRAINT IF EXISTS posts_post_type_check;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS post_type TEXT;
ALTER TABLE posts ADD CONSTRAINT posts_post_type_check
  CHECK (post_type IS NULL OR post_type IN ('flick','guess','talk'));

-- 1b) 이전 마이그레이션에서 'quiz'로 저장됐다면 'guess'로 변경
UPDATE posts SET post_type = 'guess' WHERE post_type = 'quiz';

-- 2) correct_answer — guess 정답 (NULL이면 guess 아니거나 정답 비공개)
ALTER TABLE posts ADD COLUMN IF NOT EXISTS correct_answer TEXT
  CHECK (correct_answer IS NULL OR correct_answer IN ('ai','real'));

-- 3) body — talk(글) 본문 (마크다운 가능)
ALTER TABLE posts ADD COLUMN IF NOT EXISTS body TEXT;

-- 4) 기존 posts 마이그레이션 (가역적 UPDATE — 원하면 NULL로 되돌리면 됨)
--    category 'guess' / 'lab' → guess, 나머지 → flick
UPDATE posts SET post_type = 'guess'
  WHERE post_type IS NULL AND category IN ('guess','lab');

UPDATE posts SET post_type = 'flick'
  WHERE post_type IS NULL AND category IN ('hot','funny');

-- 끝. 원래대로 되돌리려면:
--   ALTER TABLE posts DROP COLUMN body;
--   ALTER TABLE posts DROP COLUMN correct_answer;
--   ALTER TABLE posts DROP COLUMN post_type;
-- (기존 category 칼럼은 그대로 보존되어 있어 폴백 가능)
