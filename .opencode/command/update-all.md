---
description: Update all 3 project docs (context.md, requirement.md, ui-spec.md)
---
Update all three project docs to reflect the CURRENT state. Work in this order:

## 1. Gather evidence (do not guess)
- Read current `context.md`, `requirement.md`, `ui-spec.md`
- Run `git status`, `git log --oneline -10`, `git diff HEAD~1 --stat` (and `git diff HEAD` if there are uncommitted changes)
- Inspect actually-changed files to confirm what was really done

## 2. Update `context.md`
- Refresh **Work State** (Completed / Active / Blocked) and **Next Move** from real evidence
- Append newly agreed decisions/conventions to **Important Details** if missing
- Keep concise (< 120 lines)

## 3. Update `requirement.md`
- ONLY if scope/features/acceptance actually changed and user confirmed it — ห้ามแก้ requirement เดิมเองโดยไม่มีหลักฐานจาก user
- Add new features/constraints verbatim as agreed

## 4. Update `ui-spec.md`
- If any UI value changed this session (สี, font size, weight, spacing, padding, layout, positions), update the matching section with the NEW measured value
- วัดจาก simulator screenshot ด้วย python3+PIL ก่อนบันทึกค่า ห้ามเดา
- If no UI change, leave untouched and say so

## 5. Finish
- Summarize (ภาษาไทย) what was updated in each file and what was skipped + why
- Do NOT commit/push unless user asks

Rules:
- ถ้าข้อมูลขัดแย้งกัน ให้เชื่อ git state + ไฟล์จริง แล้วแจ้ง user
- ห้ามลบประวัติ/ข้อตกลงที่ยัง relevant
