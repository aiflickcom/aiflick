// AIFLICK Service Worker — Phase 1
// 캐시 전략: 셸은 cache-first, 나머지 동적 콘텐츠는 network-first

const CACHE = 'aiflick-v1';
const SHELL = [
  '/',
  '/index.html',
  '/admin.html',
  '/manifest.json',
  '/icon.svg',
];

// 외부 도메인 — 절대 가로채지 않음 (Supabase, YouTube, Google Fonts 등)
const SKIP_HOSTS = [
  'supabase.co',
  'youtube.com',
  'youtu.be',
  'ytimg.com',
  'googleapis.com',
  'gstatic.com',
  'jsdelivr.net',
];

// 설치 — 셸 캐싱
self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE)
      .then((c) => c.addAll(SHELL))
      .catch((err) => console.warn('[SW] cache fail:', err))
  );
  self.skipWaiting();
});

// 활성화 — 이전 캐시 정리
self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// 요청 처리
self.addEventListener('fetch', (e) => {
  const url = new URL(e.request.url);

  // 외부 호스트나 GET 아닌 요청은 그대로 통과
  if (e.request.method !== 'GET') return;
  if (SKIP_HOSTS.some((h) => url.hostname.includes(h))) return;
  if (url.origin !== location.origin) return;

  // HTML 요청 — network-first (콘텐츠 최신성 우선)
  const isHTML = e.request.headers.get('accept')?.includes('text/html');
  if (isHTML) {
    e.respondWith(
      fetch(e.request)
        .then((res) => {
          if (res.ok) {
            const clone = res.clone();
            caches.open(CACHE).then((c) => c.put(e.request, clone));
          }
          return res;
        })
        .catch(() => caches.match(e.request).then((r) => r || caches.match('/index.html')))
    );
    return;
  }

  // 정적 자산 (icon, manifest, css 등) — cache-first
  e.respondWith(
    caches.match(e.request).then((cached) => {
      if (cached) return cached;
      return fetch(e.request).then((res) => {
        if (res.ok && res.type === 'basic') {
          const clone = res.clone();
          caches.open(CACHE).then((c) => c.put(e.request, clone));
        }
        return res;
      });
    })
  );
});

// 클라이언트에서 업데이트 트리거 보내면 새 SW 즉시 활성화
self.addEventListener('message', (e) => {
  if (e.data === 'SKIP_WAITING') self.skipWaiting();
});
