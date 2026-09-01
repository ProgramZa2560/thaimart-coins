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
- Font: **SF Pro Display (bundled)** — Regular 400 / Medium 500 / Bold 700 ใน `fonts/` + ลงทะเบียน pubspec, ใช้ทุก platform รวม web; ⚠️ license Apple จำกัดการแจกจ่าย — README มีคำเตือนแล้ว; **ห้าม** ใช้ Inter / google_fonts
- สี (ดูทั้งหมดใน `ui-spec.md`): bg `#FEF7FF`, red `#EF5350`/border `#EE3E37`, green `#66BB6A`/border `#49B54F`, divider `#DAD3DE`, Try again `#715EA9`, Read more `#66AAF4`
- Workflow ก่อน push ทุกครั้ง: `flutter analyze` → `flutter test` → รัน iOS simulator + screenshot ตรวจ (`xcrun simctl io 8005A63C-CD9D-4728-8DFE-66CD1C264F07 screenshot`) → commit+push → รอ CD ผ่าน (`gh run list`)
- ตรวจ pixel ระดับละเอียด: ใช้ python3+PIL crop จาก simulator screenshot; วัด web ได้ด้วย headless Chrome (`--headless=new --screenshot --virtual-time-budget`) กับ `flutter build web` + local http.server
- **Rhythm 12dp** — ขอบซ้ายขวา + ระยะระหว่าง element ทุก section (list item, invite, search, top3, detail) ใช้ 12dp หมด (ยกเว้น search bar outer บน/ล่าง 4dp)
- `simctl io screenshot` ไม่จับ Home Indicator (system chrome) — ดูในหน้าต่าง Simulator app เท่านั้น
- iOS เครื่องจริงติดตั้งไม่ได้ (ไม่มี paid Apple dev) — ใช้ **PWA**: `web/install.html` (หน้า install guide) + `web/manifest.json` ชื่อ "Thaimart Coins"; iPhone = Safari → Share → Add to Home Screen; Android = Chrome install หรือดาวน์โหลด APK จาก CD artifacts
- Android เครื่องจริง: `2b3b02ff` (2510ERA8BG) ติดตั้ง APK ผ่าน adb ได้ (`~/Library/Android/sdk/platform-tools/adb`)

## Work State
### Completed
- Feature ครบ 8 ข้อ + i18n, two-pane responsive (≥800dp), 19 tests ผ่าน, README, CI (analyze/test/scan) + CD (APK/IPA/Web + GitHub Pages) ผ่านทั้งหมด
- Bugs ที่แก้แล้ว: SVG overflow (FittedBox), SOL 3-digit hex, MainActivity package, web base-href, web mouse drag, CD race/checkout, keyboard เด้งกลับหลังปิด detail sheet (unfocus ก่อน+หลังเปิด sheet)
- UI ทั้งหมด deployed (รอบล่าสุด `c33f7ed`): rhythm 12dp, badge 48dp/10pt, search 42dp/16pt, Read more w400 + pitch เท่าบรรทัด desc
- **Font SF Pro Display bundled** — ทุก platform รวม web (`513085c`) + README คำเตือน license (`9db1f01`)
- **PWA install page** `web/install.html` + manifest "Thaimart Coins" + README สอนติดตั้ง (`c33f7ed`) — ลิงก์ https://programza2560.github.io/thaimart-coins/install.html
- **DOCS.md** เอกสารรวม Doc+Spec แยกตาม feature พร้อม screenshot (`a33291b`, `b4013fd`) + ลิงก์จาก README
- เอกสารโปรเจกต์: `context.md`, `requirement.md`, `ui-spec.md`, `DOCS.md` + opencode commands `/update-c`, `/new-s`, `/update-all`, `/commit-push`
- pageSize = **20** (`lib/core/constants.dart`)

### Active (uncommitted — icon app ครบทุก platform, รอ `/commit-push`)
- **App icon = `iconapp.png`** (1254×1254, ช้างแดง+เหรียญ BTC) ใช้แล้วทุกที่:
  - Android launcher `mipmap-*/ic_launcher.png` (48–192)
  - iOS `AppIcon.appiconset` ครบทุก size (20–1024)
  - Web: favicon, `icons/icon-192/512.png`, maskable (padding 66%)
  - `web/install.html` ใช้ icon ใหม่
- iOS `Info.plist` reformat (จาก package generate — เนื้อหาคงเดิม)
- การทดลอง native splash/loading (flutter_native_splash, logo ใน launch screen) **ลองแล้วไม่ผ่าน feedback ยกเลิกทั้งหมด** — กลับสู่ launch screen ดั้งเดิม (จอขาว → spinner กลางจอ → Home) ตามที่ user ยืนยัน "ใช้แบบเดิม จบปัญหา"
- ไฟล์ untracked ห้าม commit: `iconapp.png`, `web/iconapp.png` (ต้นฉบับ icon), `Screenshot 2569-09-01 at 18.06.16.png`, `sf-pro-display.zip`, `sf-pro-display/`
- Tests: 19/19 ผ่าน, analyze ไม่มี issue, build APK/iOS/Web ผ่าน, ติดตั้งเครื่องจริง Android แล้ว

### Blocked
- (ไม่มี)

## Next Move
- รอ user สั่ง `/commit-push` (icon app ทุก platform + docs) หรือให้ปรับเพิ่ม
- หมายเหตุ: native splash ปรับตำแหน่ง/ใส่ spinner ไม่ได้ตามใจ (Android 12+ OS บังคับ icon กลางจอ) — user ยืนยันใช้แบบเดิม อย่าเสนอเรื่องนี้ซ้ำ

## Key Files
- `lib/features/coin/presentation/pages/home_page.dart` — main list, two-pane, search debounce
- `lib/features/coin/presentation/widgets/` — coin_list_item, change_badge, coin_search_bar, coin_detail_content, top_coins_section, invite_friends_tile
- `lib/core/` — theme.dart, constants.dart, formatters.dart, invite_positions.dart, api_key.dart (gitignored), api_key.ci.dart
- `fonts/` — SFPRODISPLAYREGULAR/MEDIUM/BOLD.OTF
- `web/install.html`, `web/manifest.json` — PWA install guide
- `.github/workflows/ci.yml`, `cd.yml`
- `test/` — 19 tests
- `requirement.md`, `ui-spec.md` — อ้างอิงก่อนแก้อะไรเสมอ
