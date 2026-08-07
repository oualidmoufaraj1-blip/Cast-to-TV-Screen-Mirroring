# App Review notes — Cast To TV - Screen Mirroring (1.0.1)

## Guideline 5.6

This build has no advertising code path and no remote configuration:

- No ad SDKs (AdMob, AppLovin, Meta Audience Network, or custom `multiads` package).
- No remote ads/feature JSON (e.g. Google Drive).
- No rewarded, interstitial, banner, or app-open ads.
- No feature gating — Connect, Screen Mirror, Photos, Videos, YouTube/Vimeo, and TV Remote Guide open immediately.
- Review and production use the same feature set.

## How to test

1. Launch app → onboarding (first launch) or home.
2. **Connect** — AirPlay route picker + troubleshooting.
3. **Screen Mirror** — Control Center instructions + optional Wi‑Fi browser mirror of this app’s screen (not system-wide Screen Mirroring; the app cannot start Control Center mirroring).
4. **Photos** — pick and preview; use Control Center Screen Mirroring for TV.
5. **Videos** — pick and play with system AirPlay external playback.
6. **YouTube / Vimeo** — open links in in-app browser (not affiliated).
7. **TV Remote Guide** — instructional only; no IR remote.
8. **Settings** — language, theme, legal links.

## Demo account

None required.
