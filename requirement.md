# Requirements — Thaimart Coins (Mobile Assignment)

> แหล่งความจริงสำหรับ feature/scope — **ห้ามแก้ requirement เดิมโดยไม่ยืนยันกับ user ก่อน**
> ใช้กันทำซ้ำ / ทำผิดขอบเขต ก่อนทำอะไรให้อ่านไฟล์นี้ + `ui-spec.md` เสมอ

## Source
- โจทย์: `JD - Mid – Sr. Mobile Developer.pdf` (Mobile Assignment)
- Design: `design/`, `UI mock.png`, `UI last.png`, `Search Mock.png`, `invite.png`

## Tech Constraints (แก้ไม่ได้)
- Flutter + Dart, state management: Cubit/BLoC, DI: get_it, HTTP: Dio
- Clean Architecture: data / domain / presentation
- i18n ต้องมี (en)
- Tests ต้องผ่าน, README อธิบาย decisions
- ห้ามใช้ google_fonts / Inter — ใช้ system font

## Features (8 ข้อ)
1. **Coin list** — จาก Coinranking `/coins` (referenceCurrency=USD) — symbol, name?, icon, price, marketCap, change%
2. **Top 3 coins** — card section บนสุดของ list
3. **Coin detail** — tap coin → detail (pane/tablet หรือ sheet/mobile): price, marketCap, description (Read more link)
4. **Search** — debounce filter ใน list, มีปุ่ม clear ×
5. **Change badge** — % change, ขาวบนพื้นเขียว/แดง มี border เข้มกว่าพื้น
6. **Invite Friends tile** — ตำแหน่งคงที่หลังแถวที่ 5,10,20,40,80,160 (absolute, ไม่ใช่ระยะห่าง) — `lib/core/invite_positions.dart` + test — ซ่อนตอนกำลัง search
7. **i18n** — ทุก string ผ่าน l10n (en)
8. **Responsive** — ≥800dp เป็น two-pane (list ซ้าย, detail ขวา), <800dp เป็น single + detail sheet

## Acceptance
- `flutter analyze` ไม่มี issue
- `flutter test` ผ่านทั้งหมด (ปัจจุบัน 19 tests)
- ตรวจ UI บน iOS simulator ก่อน push ทุกครั้ง
- CI (analyze/test/scan) + CD (APK/IPA/Web → GitHub Pages) ต้องเขียว

## Rules สำหรับ AI
- แก้ UI ทีละจุดตาม feedback — วัดระยะ/สีจาก screenshot ด้วย python3+PIL ก่อนเสมอ ห้ามเดา
- อย่า refactor โครงสร้าง/architecture ที่ตกลงไว้แล้ว
- อย่าแก้ `api_key.dart` (gitignored) — ถ้าหายให้ copy จาก `api_key.ci.dart`
- Workflow ตายตัว: analyze → test → simulator check → commit+push → รอ CD เขียว
