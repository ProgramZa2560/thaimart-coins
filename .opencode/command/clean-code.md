---
description: Clean up the whole codebase — remove dead code, split large files, centralize constants (behavior must stay identical)
---
Clean the entire codebase safely. **Behavior must stay 100% identical** — this is
refactoring only, never feature/UX changes.

## Procedure

1. **Baseline first:** run `flutter analyze` and `flutter test` — everything must
   pass BEFORE touching anything.
2. **Survey** (report findings to the user before big refactors):
   - Dead code: unused classes/functions/fields/assets (`dart analyze`, grep)
   - Files > ~300 lines that mix responsibilities → propose a split
   - Duplicated literals (colors, sizes, strings) used in 2+ places → centralize
     (colors → `lib/core/theme.dart`, sizes/urls → `lib/core/constants.dart`,
     shared widgets → `lib/features/coin/presentation/widgets/`)
   - Leftover experiment files (e.g. splash experiments) → delete
3. **Apply** one small change at a time; after each step run `flutter analyze`
   and `flutter test`.
4. **Verify builds** at the end: `flutter build apk --debug` +
   `flutter build web --release`.
5. Report a summary: what was removed/split/centralized + proof nothing broke.

## Rules

- ห้ามเปลี่ยน UI/UX/พฤติกรรมแม้แต่จุดเดียว — เปลี่ยนแค่โครงสร้างโค้ด
- ห้าม rename public APIs ที่ tests อ้างถึง ถ้าจำเป็นต้องแก้ tests ด้วย
- ห้ามแตะไฟล์ native (android/ios) เว้นแต่มีขยะชัดเจนจากการทดลองที่ user ยืนยันแล้ว
- ไม่ต้อง commit — รอ user สั่ง `/commit-push`
- ถ้าไม่แน่ใจว่าโค้ดไหนตายหรือเปล่า ให้ถาม user ก่อนลบ
