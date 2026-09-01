---
description: Start new session by loading project context
---
Start a new session for the Thaimart Coins project:

1. Read `/Users/programza/AI/ThaimartMarketplac/context.md` fully — this is the project memory.
2. Read `requirement.md` (scope/features/constraints) and `ui-spec.md` (UI spec) to know the agreed specs.
3. Run `git status` and `git log --oneline -3` to confirm actual repo state matches context.md; if there is a mismatch (uncommitted changes, different last commit), tell the user and fix the context afterward with `/update-c`.
4. Summarize briefly to the user (in Thai):
   - สถานะล่าสุด (Active / Next Move จาก context.md)
   - สิ่งที่ค้าง commit/verify ถ้ามี
5. Then wait for the user's instruction. Do NOT start doing any work proactively.

Rules:
- ถ้า context.md ขัดกับ git state จริง → เชื่อ git state และแจ้ง user
- ห้ามแก้ไฟล์ใด ๆ ในขั้นตอนนี้ (อ่านอย่างเดียว)
