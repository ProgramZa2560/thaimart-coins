# Documentation & Spec — Thaimart Coins

> เอกสารรวม (Doc + Spec) อธิบายระบบเป็นส่วน ๆ — อ้างอิงข้อกำหนดจาก `requirement.md`
> และค่า UI จาก `ui-spec.md` ทุกหัวข้อ พร้อมไฟล์ implementation และ tests
> อัปเดตเมื่อแก้โค้ด/UI ที่เกี่ยวข้องทุกครั้ง

---

## 0. Overview

| หัวข้อ | ค่า |
|---|---|
| ชื่อแอป | Thaimart Coins |
| Framework | Flutter 3.47.2 / Dart 3.13 |
| API | [Coinranking API v2](https://coinranking.com/api/documentation) (referenceCurrency=USD) |
| State | Cubit (flutter_bloc) |
| DI | get_it |
| HTTP | Dio |
| Font | SF Pro Display (bundled, 400/500/700) — ⚠️ ดู license warning ใน README |
| i18n | en (gen-l10n) — ทุก string ผ่าน `lib/l10n/app_en.arb` |
| Tests | 19 (analyze clean ทุก push) |
| Live web | https://programza2560.github.io/thaimart-coins/ |
| Install page | https://programza2560.github.io/thaimart-coins/install.html |

**Design tokens หลัก** (ทั้งหมดใน `ui-spec.md`):
- Background `#FEF7FF`, Text primary `#000000`, secondary `#B9B7BA`
- Badge ขึ้น `#66BB6A` (border `#49B54F`) / Badge ลง `#EF5350` (border `#EE3E37`)
- Divider `#DAD3DE`, Try again `#715EA9`, Read more `#66AAF4`
- Invite: พื้น `#EDE7F6`, หัวข้อ `#5E31B2`, รอง `#A994D3`, ไอคอน `#6A43B8`

**Layout convention — Rhythm 12dp:** ขอบซ้ายขวาและระยะระหว่าง element ทุก section
ใช้ 12dp (ยกเว้น search bar outer บน/ล่าง 4dp)

---

## 1. Coin List — รายการเหรียญ

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 1 — จาก `/coins` (referenceCurrency=USD): symbol, name, icon, price, marketCap, change% |
| UI Spec | §Layout / §List Item |
| Code | `coin_list_item.dart`, `top_coins_section.dart`, `coin_list_cubit.dart`, `coin_api_client.dart` |
| Tests | `coin_repository_impl_test.dart`, `coin_list_cubit_test.dart` |

**Spec UI:**
- Row: padding 12dp ทุกด้าน, icon 46×46 (SVG), gap 12
- symbol 15pt w700 ดำ / marketCap 12pt w400 `#B9B7BA` / price 12pt w400 ดำ
- Divider indent 70 (จบที่ขอบขวา)
- Pagination: pageSize **20** (`lib/core/constants.dart`), infinite scroll เลื่อนใกล้จบ 200px โหลดหน้าถัดไป
- Pull to refresh (ปิดระหว่าง search)

---

## 2. Top 3 Coins

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 2 — card section บนสุดของ list |
| UI Spec | §Top 3 |
| Code | `top_coins_section.dart` |

**Spec UI:**
- การ์ด 3 ใบแนวนอน, ไอคอน 36, symbol 14pt w700, ราคา 12pt `#5A585C`
- พื้น `#F7F2FA`, เงา `#E1DBE2`, radius 14, outer padding `(12, 8, 12, 8)`
- ซ่อนตอนกำลัง search; เหรียญ 3 ตัวแรกไม่ซ้ำใน list หลัก

---

## 3. Coin Detail

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 3 — tap coin → detail: price, marketCap, description (Read more) |
| UI Spec | §Detail |
| Code | `coin_detail_content.dart`, `coin_detail_sheet.dart`, `coin_detail_cubit.dart` |
| Tests | `coin_detail_cubit_test.dart` |

**Spec UI:**
- Padding 12dp ทุกด้าน (ล่าง 24), icon 64×64, badge จัดกึ่งกลาง
- ชื่อเหรียญสีตาม `coin.color` (default ดำ), symbol 18pt w400
- ค่า price/marketCap สี `#6D6A6F`
- Description 14pt height 1.5; link **Read more** `#66AAF4` ขีดเส้นใต้ **w400**
  - Read more ใช้ `height: 1.5` เหมือน desc → pitch บรรทัดเท่ากัน 21dp (ไม่มี SizedBox คั่น)
  - ไม่มี website → ไม่แสดง link; description ว่าง → "No description"
- มือถือ (<800dp): bottom sheet / แท็บเล็ต (≥800dp): pane ขวา sticky

---

## 4. Search

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 4 — debounce filter ใน list, มีปุ่ม clear × |
| UI Spec | §Search Bar |
| Code | `coin_search_bar.dart`, `coin_list_cubit.dart` (search/clearSearch) |
| Tests | `coin_list_cubit_test.dart` (search, empty query, refresh no-op ระหว่าง search) |

**Spec UI:**
- กล่อง: พื้น `#EFEDF0`, radius 12, **สูง fixed 42dp** (วัดจริง 41.7)
- Outer padding `(12, 4, 12, 4)`; icon 🔍 20 ห่างซ้าย 7; gap icon→text 4
- Text/hint **16pt** (hint `#5A585C`); ปุ่ม clear × 36×36 แสดงเมื่อมีข้อความ
- **Debounce 1s** (`searchDebounce`); แตะเหรียญ → unfocus ก่อนเปิด detail (กัน keyboard เด้งกลับ)

---

## 5. Change Badge

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 5 — % change ขาวบนพื้นเขียว/แดง มี border เข้มกว่าพื้น |
| UI Spec | §Change Badge |
| Code | `change_badge.dart`, `formatters.dart` |

**Spec UI:**
- Text **10pt w600** ขาว, `height: 1.0` + `TextLeadingDistribution.even`
- กรอบ **fixed 48dp** กึ่งกลาง, padding ทุกด้าน 3, radius 20, border 1px
- `FittedBox(scaleDown)` — เลขยาว (เช่น -559.590%) ย่อ font แทนขยายกรอบ → **ราคาไม่ขยับ**
- สี: ขึ้น `#66BB6A`/border `#49B54F`, ลง `#EF5350`/border `#EE3E37`

---

## 6. Invite Friends Tile

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 6 — ตำแหน่งคงที่หลังแถวที่ 5,10,20,40,80,160 (absolute) — ซ่อนตอน search |
| UI Spec | §Invite Friends |
| Code | `invite_friends_tile.dart`, `invite_positions.dart`, `home_page.dart` (`_rows()`) |
| Tests | `invite_positions_test.dart` |

**Spec UI:**
- โครงสร้างเดียวกับ list item: icon 46×46, gap 12, padding 12dp ทุกด้าน, divider indent 70
- พื้น `#EDE7F6`, หัวข้อ 15pt w700 `#5E31B2`, รอง 12pt `#A994D3`, ไอคอน 28 `#6A43B8`
- แตะ → share sheet (`share_plus`) เปิด URL รับสมัคร

---

## 7. Internationalization (i18n)

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 7 — localization English (en) |
| Code | `lib/l10n/app_en.arb`, `l10n.yaml`, `app.dart` (delegates + supportedLocales) |

- ทุก string UI ผ่าน `AppLocalizations` — ไม่มี hardcode
- เพิ่มภาษาใหม่: เพิ่ม `app_xx.arb` ใน `lib/l10n/` (flutter gen-l10n ทำงานอัตโนมัติ)

---

## 8. Responsive

| รายการ | รายละเอียด |
|---|---|
| Requirement | ข้อ 8 — ≥800dp two-pane, <800dp single + sheet |
| Code | `home_page.dart` (`LayoutBuilder`, `wideBreakpoint`), `coin_detail_sheet.dart` |

- ≥800dp: list ซ้าย (420dp) + divider + detail pane ขวา sticky
- <800dp: single column + bottom sheet
- แหล่งความจริงเดียวสำหรับ list (`_rows()`) — ใช้ได้ทั้งสอง layout

---

## 9. Error / Loading States

- โหลดหน้าแรกไม่สำเร็จ: ข้อความ + ปุ่ม **Try again** `#715EA9` (เต็มหน้า)
- Load-more ไม่สำเร็จ: footer แสดง Try again (ไม่ทำ list หาย)
- Detail โหลดไม่สำเร็จ: ใน sheet/pane มี Try again
- ระหว่างโหลด: `CircularProgressIndicator` (loadingMore แสดงท้าย list)
- Code: `error_view.dart`, state flags ใน `CoinListState` (`loadingMoreFailed` ฯลฯ)

---

## 10. Install / Deploy

| ช่องทาง | วิธี |
|---|---|
| **Web** | เปิด https://programza2560.github.io/thaimart-coins/ ตรง ๆ |
| **iPhone/iPad (PWA)** | เปิดลิงก์ใน Safari → Share ⬆︎ → เลื่อนล่างสุด → Add to Home Screen (ไม่ต้องมีคอม) |
| **Android** | Chrome → Install app หรือดาวน์โหลด APK จาก [CD artifacts](https://github.com/ProgramZa2560/thaimart-coins/actions/workflows/cd.yml) |
| **iOS แบบแอปจริง** | ต้องมี paid Apple Developer ($99/ปี) — ปัจจุบัน IPA เป็น unsigned |

**CD pipeline** (`cd.yml`): Build Android APK → Build iOS (unsigned IPA) → Build Web (API key จาก secret) → Deploy GitHub Pages
**CI pipeline** (`ci.yml`): analyze (`--fatal-infos`) → test (coverage) → secret scan

> ⚠️ การเปลี่ยนแปลงใด ๆ ในเอกสารนี้ต้องมีหลักฐานจากโค้ด/การวัดจริง — อ้างข้อมูลจาก `git log` และ screenshot ที่วัดด้วย PIL เสมอ
