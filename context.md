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
- iOS เครื่องจริงติดตั้งไม่ได้ (ไม่มี paid Apple dev) — install page มีแค่ Android APK + Web App
- Android เครื่องจริง: `2b3b02ff` (2510ERA8BG) รันได้ปกติ

## Work State
### Completed
- Feature ครบ 8 ข้อ + i18n, two-pane responsive (≥800dp), 19 tests ผ่าน, README, CI (analyze/test/scan) + CD (APK/IPA/Web + GitHub Pages) ผ่านทั้งหมด
- Bugs ที่แก้แล้ว: SVG overflow (FittedBox), SOL 3-digit hex, MainActivity package, web base-href, web mouse drag, CD race/checkout
- UI ล่าสุด: spacing rhythm **12px**, badge % **9pt** w600 + FittedBox (เลขยาวย่อ font แทนขยายกรอบ), search bar manual Row, detail sheet ตาม spec — commit `a8bd152` deployed

### Active
- (ไม่มี — รอ feedback ถัดไปจาก user)

### Blocked
- (ไม่มี)

## Next Move
- รอ UI feedback จาก user (user iterate spacing/colors/fonts บ่อย — วัดระยะจาก screenshot ด้วย PIL ก่อนแก้ทุกครั้ง)

## Key Files
- `lib/features/coin/presentation/pages/home_page.dart` — main list, two-pane, search debounce
- `lib/features/coin/presentation/widgets/` — coin_list_item, change_badge, coin_search_bar, coin_detail_content, top_coins_section, invite_friends_tile
- `lib/core/` — theme.dart, constants.dart, formatters.dart, invite_positions.dart, api_key.dart (gitignored), api_key.ci.dart
- `.github/workflows/ci.yml`, `cd.yml`
- `test/` — 19 tests
- `requirement.md`, `ui-spec.md` — อ้างอิงก่อนแก้อะไรเสมอ
