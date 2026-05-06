-- AIFLICK Phase 2 — user ownership tracking
-- Add user_id columns so My Page can show "posts/comments I created"
-- Reversible: only adds nullable columns referencing auth.users

-- 1) posts.user_id
ALTER TABLE posts ADD COLUMN IF NOT EXISTS user_id UUID;
-- (Optional FK constraint — only add if you want strict referential integrity)
-- ALTER TABLE posts ADD CONSTRAINT posts_user_id_fkey
--   FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE SET NULL;

-- 2) comments.user_id
ALTER TABLE comments ADD COLUMN IF NOT EXISTS user_id UUID;

-- 3) votes already has voter_id (anonymous local ID).
--    We add user_id for logged-in users so My Page can show "내가 한 투표" later.
ALTER TABLE votes ADD COLUMN IF NOT EXISTS user_id UUID;

-- 4) reactions: add user_id for "내가 한 리액션" tracking
ALTER TABLE reactions ADD COLUMN IF NOT EXISTS user_id UUID;

-- 끝. 되돌리려면:
--   ALTER TABLE posts DROP COLUMN user_id;
--   ALTER TABLE comments DROP COLUMN user_id;
--   ALTER TABLE votes DROP COLUMN user_id;
--   ALTER TABLE reactions DROP COLUMN user_id;
-- (기존 데이터는 user_id NULL로 남고, 새 데이터만 채워짐)
