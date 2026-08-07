# App Review notes — Cast To TV - Screen Mirroring (1.0.2)

## Guideline 5.6 response summary

This update removes behavior that could look different in App Review vs production:

1. **Removed remote ads configuration** (previously fetched from Google Drive).
2. **Removed all ad SDKs** from the app binary dependency graph (`multiads` / AdMob / AppLovin / Facebook).
3. **Removed rewarded/interstitial gates** on Connect, Screen Mirror, and other features — every feature is available immediately.
4. **Removed app-open ads** on launch.
5. Banner placeholders collapse to zero height (no ads).

Review and production now present the same feature set with no monetization layer that can be toggled remotely.

## How to test

1. Launch app → onboarding (first launch) or home.
2. **Connect** — AirPlay route picker + troubleshooting (no ad first).
3. **Screen Mirror** — Control Center instructions + Wi‑Fi browser mirror of this app’s screen (not system-wide Screen Mirroring; the app cannot start Control Center mirroring).
4. **Photos** — pick and preview; use Control Center Screen Mirroring to show on TV.
5. **Videos** — pick and play with system AirPlay external playback.
6. **YouTube / Vimeo** — open links in in-app browser (not affiliated).
7. **TV Remote Guide** — instructional only; no IR remote.
8. **Settings** — language, theme, legal links.

## Demo account

None required.
