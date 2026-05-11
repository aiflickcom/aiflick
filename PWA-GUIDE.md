# AIFLICK PWA (Progressive Web App) 가이드

웹사이트를 **앱처럼 설치/사용**할 수 있게 만든 구성. 별도 앱스토어 등록 없이 사용자가 홈 화면에 추가 → 풀스크린 앱처럼 실행됨.

---

## 사용자 입장 — 설치 방법

### Android (Chrome / Edge / Samsung Internet)
1. `https://aiflick.pages.dev/` 접속
2. 우상단 아바타 → 메뉴 → **📲 앱으로 설치** 클릭
   - 또는 브라우저 메뉴 → "앱 설치" / "홈 화면에 추가"
3. 확인 → 홈 화면에 AIFLICK 아이콘 생성됨
4. 아이콘 탭 → 풀스크린 앱처럼 실행 (브라우저 UI 없음)

### iOS (Safari)
- iOS는 자동 설치 프롬프트 미지원 → 수동 설치:
1. Safari에서 `https://aiflick.pages.dev/` 접속
2. 하단 **공유** 아이콘 (□↑)
3. **"홈 화면에 추가"** 선택
4. 확인 → 홈 화면 아이콘 생성

### 데스크톱 (Chrome / Edge)
1. 주소창 우측에 **설치 아이콘** (⊕ 또는 모니터+다운로드 아이콘) 클릭
2. 또는 사이트 메뉴 → "AIFLICK 설치"
3. 데스크톱 앱처럼 별도 창에서 실행

---

## PWA가 제공하는 것

✅ **홈 화면 아이콘** — 앱처럼 보임
✅ **풀스크린 실행** — 브라우저 주소창/탭 안 보임
✅ **앱 전환 시 별도 창** — 다른 앱과 마찬가지
✅ **오프라인 지원** — 인터넷 끊겨도 마지막 본 화면 보임 (Service Worker 캐시)
✅ **빠른 로딩** — 정적 자원 캐시됨
✅ **스플래시 화면** — 실행 시 브랜드 색 + 아이콘 표시 (Android)
✅ **홈 화면 단축키** (Android) — 길게 누르면 FLICK / Guess / 내 페이지 바로가기
✅ **푸시 알림** — 아직 미구현 (Phase 2에서 가능)

---

## 구성 파일

| 파일 | 역할 |
|------|------|
| `manifest.json` | 앱 메타데이터 (이름, 아이콘, 시작 URL, 색상 등) |
| `sw.js` | Service Worker — 캐시 + 오프라인 |
| `icon.svg` | 앱 아이콘 (벡터) |

### 캐시 전략 (sw.js)
- **HTML 페이지**: network-first — 항상 최신 시도, 실패 시 캐시
- **정적 자원** (CSS/JS/이미지): cache-first — 빠른 로딩
- **Supabase / YouTube / 폰트**: 캐시 안 함 — 실시간

---

## ⚠️ 한 가지 남은 작업 — PNG 아이콘

`manifest.json`이 `icon-192.png`, `icon-512.png`, `icon-maskable-512.png`를 참조하지만 아직 파일 없음. SVG는 있어서 Android Chrome은 정상 작동하지만 **iOS는 PNG 필요**.

### PNG 생성 (5분 작업)
1. https://realfavicongenerator.net/ 접속 (또는 https://maskable.app/editor)
2. `icon.svg` 파일 업로드
3. 192x192, 512x512 PNG 다운로드
4. 다음 이름으로 c:\DEV\aiflick\ 폴더에 저장:
   - `icon-192.png`
   - `icon-512.png`
   - `icon-maskable-512.png` (마스커블 — 가장자리 안전영역 포함)
5. `git add icon-*.png && git commit && git push`

또는 임시로 SVG만 사용해도 Android에선 동작함.

---

## 테스트 방법

### 1. PWA 인스톨 가능 여부 확인
- 데스크톱 Chrome → DevTools (F12) → **Application** 탭 → **Manifest**
- 좌측 사이드바: Service Workers, Storage 등 확인
- "Installability" 섹션에 오류 없는지 체크
- 오류 있으면 거기에 정확히 뭐가 빠졌는지 표시됨

### 2. 실제 설치
- 모바일 Chrome 또는 데스크톱 Chrome으로 https://aiflick.pages.dev/ 접속
- 우상단 아바타 메뉴에 "📲 앱으로 설치" 항목이 보이는지
- 클릭 → 설치 확인 → 홈 화면/바탕화면에 아이콘

### 3. Lighthouse 점수 (선택)
- DevTools → **Lighthouse** 탭
- "PWA" 카테고리만 체크하고 분석
- 점수 90+ 목표 (PNG 아이콘 추가하면 100점 가능)

---

## 향후 추가 가능 (선택)

1. **푸시 알림** — Web Push API로 새 글/댓글 알림
   - 서비스 워커에서 처리, Supabase Realtime + Web Push 조합
2. **백그라운드 동기화** — 오프라인에서 댓글 작성 → 인터넷 연결 시 자동 전송
3. **공유 타겟** — 다른 앱에서 AIFLICK으로 영상/이미지 공유 (manifest "share_target")
4. **App Store / Play Store 등록** — TWA (Trusted Web Activity)로 Android 스토어 등록 가능

지금은 MVP 단계라 이 정도면 충분. 사용자 모이면 추가.

---

## 트러블슈팅

**"앱으로 설치" 버튼이 안 보임**
- HTTPS여야 함 (Cloudflare Pages는 자동 HTTPS) ✓
- manifest.json이 정상 로드돼야 함 → DevTools에서 확인
- Service Worker가 정상 등록돼야 함 → DevTools → Application → Service Workers
- 이미 설치된 경우엔 버튼 안 보임 (정상)

**아이콘이 이상하게 보임**
- PNG 파일 없으면 일부 브라우저는 fallback 이미지 사용
- → 위 "PNG 생성" 단계 진행

**오프라인에서 화면 빈 채로 뜸**
- Service Worker가 페이지 캐시 못한 경우 — 한 번 온라인에서 방문 후 다시 시도

**iOS에서 "홈 화면 추가" 후 풀스크린 안 됨**
- meta `apple-mobile-web-app-capable` 인식 못함 — 보통 iOS 자동 처리, 안 되면 사용자 OS 버전 확인 (iOS 13+ 권장)
