---
description: Update project context file (context.md)
---
Update `/Users/programza/AI/ThaimartMarketplac/context.md` to reflect the CURRENT state of the project:

1. Read the existing `context.md` first.
2. Review what actually changed in this session: run `git status`, `git log --oneline -5`, and `git diff HEAD~1 --stat` to see the latest work.
3. Update ONLY these sections based on real evidence (never invent):
   - **Work State / Completed** — move finished items here
   - **Work State / Active** — work in progress, uncommitted changes, pending verification
   - **Work State / Blocked** — anything blocked
   - **Next Move** — the immediate next action
4. Keep sections **Objective** and **Important Details** accurate; append newly agreed decisions/conventions there if not already recorded.
5. Do NOT delete history that is still relevant; keep the file concise (aim < 120 lines).

Rules:
- อย่าเดา — ใช้ git status/log/diff และไฟล์จริงเป็นหลักฐานเสมอ
- ถ้า user ตัดสินใจ UI/UX ใหม่ (สี, spacing, font) ให้บันทึกใน context.md และเตือนให้อัปเดต `ui-spec.md` ด้วย
- ห้ามลบ `requirement.md` หรือแก้ requirement โดยไม่ถาม user
