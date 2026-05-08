-- AIFLICK Phase 3 — media_type column
-- Distinguishes video / image / text content.
-- Combined with post_type ('flick' | 'guess' | 'talk'):
--   video + flick  = regular video
--   video + guess  = guess video (Real or AI? game)
--   image + flick  = regular image (AI art / photo share)
--   image + guess  = guess image (Real or AI? — image edition)
--   text  + talk   = text post (prompts, tips, discussion)

ALTER TABLE posts ADD COLUMN IF NOT EXISTS media_type TEXT
  CHECK (media_type IS NULL OR media_type IN ('video','image','text'));

-- Backfill existing posts (best effort heuristics)
UPDATE posts SET media_type = 'text'
  WHERE media_type IS NULL AND post_type = 'talk';

UPDATE posts SET media_type = 'video'
  WHERE media_type IS NULL AND video_url IS NOT NULL AND video_url <> '';

-- 끝. 되돌리려면:
--   ALTER TABLE posts DROP COLUMN media_type;
