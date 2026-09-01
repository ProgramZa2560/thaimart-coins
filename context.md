# Project Context — Thaimart Coins

> อัปเดตไฟล์นี้ทุกครั้งที่มีการเปลี่ยนแปลงสำคัญ (ใช้คำสั่ง `/update-c`)
> เริ่ม session ใหม่ด้วยการอ่านไฟล์นี้ก่อน (ใช้คำสั่ง `/new-s`)

## Objective
- สร้าง Flutter app "Thaimart Coins" (coin market ใช้ Coinranking API v2) ตาม design mock ใน `design/` + `UI mock.png`, `UI last.png`, `Search Mock.png` — ทำงานครบทุก feature, UI ละเอียดระดับ pixel, มี tests, README, GitHub repo + CI/CD

## Important Details
- Project: `/Users/programza/AI/ThaimartMarketplac` — Flutter 3.47.2, Dart 3.13, package `coinmarket`, bundle id `com.thaimart.thaimartcoins`, ชื่อแอป "Thaimart Coins"
- GitHub: `ProgramZa2560/thaimart-coins` (public, main, SSH) — live web: https://programza2560.github.io/thaimart-coins/
- Coinranking API key: GitHub secret `COINRANKING_API_KEY`; local gitignored `lib/core/api_key.dart` (format `String.fromEnvironment('COINRANKING_API_KEY', defaultValue: '<key>')`); committed template `lib/core/api_key.ci.dart` — CI/CD ทุก job ทำ `cp api_key.ci.dart api_key.dart`
- Architecture: Clean Architecture (data/domain/presentation) ใต้ `lib/features/coin/`, Cubit (flutter_bloc), get_it DI, Dio, Equatable Coin model, i18n en (gen-l10n)
- Font: system font ของแต่ละ platform (SF Pro บน iOS) — **ห้าม** ใช้ Inter / google_fonts
- สี (ดูทั้งหมดใน `ui-spec.md`): bg `#FEF7FF`, red `#EF5350`/border `#EE3E37`, green `#66BB6A`/border `#49B54F`, divider `#DAD3DE`, Try again `#715EA9`, Read more `#66AAF4`
- Workflow ก่อน push ทุกครั้ง: `flutter analyze` → `flutter test` → รัน iOS simulator + screenshot ตรวจ (`xcrun simctl io 8005A63C-CD9D-4728-8DFE-66CD1C264F07 screenshot`) → commit+push → รอ CD ผ่าน (`gh run list`)
- ตรวจ pixel ระดับละเอียด: ใช้ python3+PIL crop จาก simulator screenshot
- **Rhythm 12dp** — ขอบซ้ายขวา + ระยะระหว่าง element ทุก section (list item, invite, search, top3, detail) ใช้ 12dp หมด
- `simctl io screenshot` ไม่จับ Home Indicator (system chrome) — ดูในหน้าต่าง Simulator app เท่านั้น
- iOS เครื่องจริงติดตั้งไม่ได้ (ไม่มี paid Apple dev) — install page มีแค่ Android APK + Web App
- Android เครื่องจริง: `2b3b02ff` (2510ERA8BG) รันได้ปกติ

## Work State
### Completed
- Feature ครบ 8 ข้อ + i18n, two-pane responsive (≥800dp), 19 tests ผ่าน, README, CI (analyze/test/scan) + CD (APK/IPA/Web + GitHub Pages) ผ่านทั้งหมด
- Bugs ที่แก้แล้ว: SVG overflow (FittedBox), SOL 3-digit hex, MainActivity package, web base-href, web mouse drag, CD race/checkout
- Badge % ครั้งแรก: fixed-width + FittedBox scale-down — commit `080f925` pushed (CI ผ่าน, CD รันต่อจากนั้น user ขอปรับเพิ่ม)
- เอกสารโปรเจกต์: `context.md`, `requirement.md`, `ui-spec.md` + opencode commands `/update-c`, `/new-s`, `/update-all`, `/commit-push`
- pageSize เปลี่ยน 10 → **20** (`lib/core/constants.dart`) + แก้ tests ให้ใช้ `AppConstants.pageSize` แทน hardcode 10

### Active (uncommitted ทั้งหมด — รอ user สั่ง `/commit-push`)
- Badge %: font **10pt**, กรอบ fixed **48dp**, padding ทุกด้าน 3 (`change_badge.dart`)
- List item + Invite tile: padding **12dp ทุกด้าน** (horizontal 12, vertical 12, gap 12)
- Detail content: padding **12dp ทุกด้าน** (บน 12, ล่าง 24); Read more ใช้ height 1.5 เหมือน desc → pitch บรรทัดเท่ากัน 21dp
- Search bar: outer `(12, 4, 12, 4)`, **กล่องสูง fixed 42dp**, text/hint **16pt**, icon 20, radius 12
- Mock % เอาออกแล้ว, Home indicator ไม่โชว์ใน simctl screenshot = พฤติกรรมปกติของเครื่องมือ (ไม่ใช่บั๊ก)
- ไฟล์แปลกปลอมใน repo root: `Screenshot 2569-09-01 at 18.06.16.png` (untracked — user ใช้อ้างอิง UI, ห้าม commit)
- Tests: 19/19 ผ่าน, analyze ไม่มี issue

### Blocked
- (ไม่มี)

## Next Move
- รอ user สั่ง `/commit-push` หรือให้ปรับ UI เพิ่ม (วัดจาก screenshot ด้วย PIL ก่อนแก้ทุกครั้ง)

## Key Files
- `lib/features/coin/presentation/pages/home_page.dart` — main list, two-pane, search debounce
- `lib/features/coin/presentation/widgets/` — coin_list_item, change_badge, coin_search_bar, coin_detail_content, top_coins_section, invite_friends_tile
- `lib/core/` — theme.dart, constants.dart, formatters.dart, invite_positions.dart, api_key.dart (gitignored), api_key.ci.dart
- `.github/workflows/ci.yml`, `cd.yml`
- `test/` — 19 tests
- `requirement.md`, `ui-spec.md` — อ้างอิงก่อนแก้อะไรเสมอ
