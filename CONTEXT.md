# AIFlick 프로젝트 컨텍스트

## 🎯 프로젝트 개요
**AIFlick** — AI 영상 전문 놀이터. 누구나 올리고 즐길 수 있는 AI 영상 커뮤니티 플랫폼.

- **타겟**: AI 영상 제작자 + 감상자
- **목표**: 바이럴·조회수 넘치는 AI 영상 전문 사이트
- **비용 전략**: 무료 티어(Supabase + GitHub Pages + Cloudflare) 활용

---

## 🏗️ 기술 스택

| 항목 | 사용 중 |
|------|---------|
| 호스팅 | GitHub Pages (`https://aiflickcom.github.io/aiflick`) |
| DB/Auth/Storage | Supabase (신규 계정, `nhjnotsgolywogbvzisz.supabase.co`) |
| 로그인 | Google OAuth |
| 프론트 | Vanilla HTML/CSS/JS (빌드 없음) |
| 외부 라이브러리 | `@supabase/supabase-js@2` (CDN) |
| 폰트 | Orbitron + Space Grotesk + Noto Sans KR |

---

## 📁 파일 구조

```
aiflick/
├── index.html      # 메인 (숏츠/피드/게시판 3가지 뷰)
├── admin.html      # 관리자 페이지 (이메일 로그인)
└── README.md
```

---

## 🗄️ DB 스키마 (Supabase)

### 테이블
```sql
posts (
  id uuid PK,
  title text,
  video_url text,           -- YouTube URL 또는 Supabase Storage URL
  video_type text,          -- 'youtube' | 'upload'
  thumbnail_url text,
  category text,            -- 'hot' | 'funny' | 'guess' | 'lab'
  persona_id uuid,
  storage_path text,        -- 직접 업로드 파일 경로
  view_count int,
  created_at timestamp
)

votes (id, post_id, vote_type, voter_id, created_at)
  -- vote_type: 'ai' | 'real' | 'a' | 'b'

reactions (id, post_id, type, reactor_id, created_at)
  -- type: 'like' | 'funny' | 'hot' | 'wow'

comments (id, post_id, content, nickname, created_at)

profiles (id, email, is_admin, created_at)
  -- auth.users와 연결, is_admin으로 관리자 구분

personas (id, name, description, avatar_url)
```

### Storage
- Bucket: `videos` (Public)
- Admin만 업로드 가능
- 일반 유저도 로그인 후 업로드 가능 (50MB 제한)

### RLS 정책 핵심
- 읽기: 누구나
- 투표/리액션/댓글 insert: 누구나
- posts insert: 로그인한 유저만 (admin 아닌 일반 유저도 가능)
- posts 수정/삭제: admin만
- Storage upload/delete: admin만

---

## ✅ 현재 구현된 기능

### 홈 (index.html)
- **3가지 뷰 모드** (상단 버튼으로 전환)
  - 🎬 숏츠 (기본값): 풀스크린, 세로 스크롤, TikTok 스타일
  - 📱 피드: 카드형 스크롤
  - 📋 게시판: 탭+리스트, 클릭하면 모달
- **카테고리 필터**: 전체 / 🔥 핫 / 😂 웃긴 / ❓ 맞춰봐 / 🧪 실험실
- **Google 로그인**: 비로그인은 구경만, 로그인하면 투표/댓글 가능
- **투표 시스템**: `맞춰봐`(AI/진짜), `실험실`(맞출수있다/모르겠다) 카테고리만 표시
- **리액션**: 🔥😂🤯👍
- **댓글**: 로그인 유저만 작성
- **업로드 모달**: 일반 유저도 YouTube URL 또는 파일 직접 업로드
- **영상 자동 재생 제어**: IntersectionObserver로 화면에 보이는 영상만 재생 (소리 겹침 방지, iframe DOM 제거/재생성 방식)
- **커스텀 비디오 컨트롤**: 직접 업로드 영상은 재생/일시정지/음소거/진행바/시간 표시

### 어드민 (admin.html)
- 이메일/비번 로그인 (is_admin=true만 접근)
- 통계 (영상/투표/리액션/댓글 수)
- 영상 업로드 (YouTube URL 또는 파일)
- 영상 목록 + 삭제

---

## 🎨 디자인 시스템

### 컬러
```css
--bg: #060608
--surface: #0d0d12
--card: #11111a
--accent: #a855f7    /* 보라 - 메인 */
--accent2: #06b6d4   /* 시안 - 서브 */
--accent3: #f59e0b   /* 앰버 - 리액션 */
--text: #f1f0ff
--muted: #6b6b80
```

### 폰트
- **로고**: Orbitron (futuristic, AI 느낌)
- **본문**: Space Grotesk + Noto Sans KR
- **시간 표시**: monospace

### 특징
- 보라↔시안 그라데이션 애니메이션 (로고 shimmer)
- 배경에 보라 그리드 텍스처
- 버튼에 글로우 효과 (box-shadow)
- 하트 팝 애니메이션
- 카드 호버 시 translateY + glow

---

## 🚧 진행 중 / 해야 할 일

### 즉시 가능한 것
- [ ] 숏츠에 좋아요/댓글 수 카운트 실시간 반영 개선
- [ ] 댓글 페이지네이션 (댓글 많을 때)
- [ ] 검색 기능
- [ ] 영상별 조회수 카운트 정확도 개선

### 나중에
- [ ] 실험실 카테고리 제대로 구현 — AI 툴 맞추기 (Sora, Runway, Kling 등 선택지 + 정답 체크)
- [ ] 광고 배너 영역 (각 영상 하단)
- [ ] 하트/댓글 실시간 동기화 (Supabase Realtime)
- [ ] 유저 프로필 페이지
- [ ] "이번 주 TOP" 랭킹
- [ ] SNS 공유 기능
- [ ] 크롤링 추가 (AIGATHERING처럼)

### 확장 계획
- Supabase Pro로 전환 (100GB 스토리지)
- Cloudflare R2 또는 Stream으로 영상 이전
- 자체 도메인 구매 (aiflick.xxx)

---

## 🔑 주요 사용자 선호사항

- 모바일 우선 고려
- 크롬 Whale에서 .html 파일 자동 열기 문제 → **.txt로 받아서 VS Code로 저장**
- 영상 소리는 기본값 mute가 아니라 **소리 켜진 상태**로
- 숏츠에서 카드 전환 시 이전 영상 소리 완전히 차단 필수
- UI/UX는 TikTok/Instagram 참고, AI 느낌 강조한 자체 스타일

---

## 🔐 Supabase 주요 설정

- Site URL: `https://aiflickcom.github.io/aiflick`
- Redirect URLs: `https://aiflickcom.github.io/aiflick`
- Google OAuth 활성화 완료
- profiles 테이블에 본인 프로필 읽기 정책 추가됨
- `videos` Storage 버킷 (Public)

---

## 💡 Claude Code 작업 팁

- 수정 전 `git pull` 잊지 말기
- HTML 파일은 크롬 확장프로그램 자동 열림 방지 위해 `.txt`로도 export 가능하게
- JS 로직보다 디자인/UX 개선 우선순위 높음
- 사용자는 한국어로 소통, 답변도 한국어로
- 대화는 간결하게, 긴 설명보다는 바로 코드 수정
