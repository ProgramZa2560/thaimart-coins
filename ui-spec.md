# UI Spec — Thaimart Coins

> เอกสารสเปก UI ฉบับละเอียด — อัปเดตทุกครั้งที่ user ขอเปลี่ยน UI
> ค่าตัวเลขทั้งหมดวัดจาก iOS simulator screenshot ด้วย PIL

## Design Tokens

### สี
| Token | Hex | ใช้ที่ |
|---|---|---|
| background | `#FEF7FF` | ทั้งหน้า |
| textPrimary | `#000000` | symbol, price |
| textSecondary | `#B9B7BA` | marketCap, placeholder ค้นหา |
| red | `#EF5350` | badge ลง |
| redBorder | `#EE3E37` | border badge ลง |
| green | `#66BB6A` | badge ขึ้น |
| greenBorder | `#49B54F` | border badge ขึ้น |
| divider | `#DAD3DE` | เส้นคั่น list |
| top3CardBg | `#F7F2FA` | การ์ด top 3 |
| top3CardShadow | `#E1DBE2` | เงาการ์ด |
| top3Price | `#5A585C` | ราคาในการ์ด |
| detailValue | `#6D6A6F` | price/marketCap ใน detail |
| tryAgain | `#715EA9` | ปุ่ม Try again |
| readMore | `#66AAF4` | link Read more (ขีดเส้นใต้) |
| inviteIcon | `#6A43B8` | ไอคอน invite |
| inviteHead | `#5E31B2` | หัวข้อ invite |
| inviteSub | `#A994D3` | ข้อความรอง invite |
| inviteBg | `#EDE7F6` | พื้นหลัง invite tile |

### Font
- System font ของ platform (SF Pro บน iOS) — ห้ามใช้ Inter / google_fonts

## Layout

### Rhythm
- Horizontal spacing รอบขอบหน้า + ระหว่าง element ใน row: **12px**
- List row: `12 | icon 46 | 12 | text (Expanded) … price | 12 | badge | 12`
- Divider indent: 70 (จบที่ขอบขวา)
- Search / Top3 / Invite outer padding: `EdgeInsets.fromLTRB(12, 8, 12, 8)`

### List Item (`coin_list_item.dart`)
| องค์ประกอบ | ขนาด | Weight | สี |
|---|---|---|---|
| icon | 46×46 | — | SVG network image |
| symbol (BNB) | 15pt | w700 | ดำ |
| marketCap | 12pt | w400 | `#B9B7BA` |
| price | 12pt | w400 | ดำ |

### Change Badge (`change_badge.dart`)
- Text: **9pt w600** สีขาว, `height: 1.0` + `TextLeadingDistribution.even`
- Padding: horizontal 8, vertical 3; radius 20; border 1px
- ห่อ `FittedBox(fit: BoxFit.scaleDown)` — ตัวเลขยาว (เช่น -559.590%) ย่อ font แทนขยายกรอบ

### Search Bar (`coin_search_bar.dart`)
- Manual Row (ไม่ใช้ prefixIcon): พื้นเทาอ่อน, radius, icon ค้นหา 20, gap 4, ปุ่ม clear × 36×36
- Empty-state สูง 46pt (padding แนวตั้ง 12)
- Debounce การค้นหา

### Top 3 (`top_coins_section.dart`)
- การ์ด 3 ใบแนวนอน, ไอคอน + symbol + ราคา + badge, พื้น `#F7F2FA` เงา `#E1DBE2`

### Invite Friends (`invite_friends_tile.dart`)
- ตำแหน่ง: หลังแถวที่ **5, 10, 20, 40, 80, 160** (absolute)
- พื้น `#EDE7F6`, หัวข้อ `#5E31B2`, รอง `#A994D3`, ไอคอน `#6A43B8`
- ซ่อนขณะ search

### Detail (mobile sheet / tablet pane — `coin_detail_content.dart`)
- ชื่อเหรียญสีตาม `coin.color` (default ดำ), symbol 18pt **w400**
- icon 64×64, badge จัดกึ่งกลาง
- ค่า price/marketCap สี `#6D6A6F`, description มี link Read more `#66AAF4` ขีดเส้นใต้

### Responsive
- ≥800dp: two-pane (list ซ้าย, detail ขวา sticky)
- <800dp: single column, tap → detail sheet

### หน้า App bar
- ไม่มี title, แค่ปุ่ม + พื้นหลัง `#FEF7FF`

### Error state
- ข้อความ + ปุ่ม "Try again" สี `#715EA9`
