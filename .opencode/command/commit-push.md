---
description: Commit and push with pre-push checks (analyze, test)
---
Commit and push the current work following the project's fixed workflow:

1. Run `flutter analyze` — must be zero issues.
2. Run `flutter test` — must pass all tests.
3. Run `git status` and `git diff` — show the user what will be committed; stage ONLY files related to the current work (never stage unrelated/uncommitted leftovers unless the user asks).
4. Commit with a concise message matching repo style (e.g. `ui: ...`, `docs: ...`, `fix: ...`), then `git push`.
5. Monitor CI/CD with `gh run list --repo ProgramZa2560/thaimart-coins --limit 3` and report the result to the user.

Rules:
- ถ้า analyze หรือ test ไม่ผ่าน → หยุดทันที รายงานปัญหา ห้าม commit
- ห้าม stage ไฟล์ที่ไม่เกี่ยวข้องกับงานปัจจุบัน เว้นแต่ user สั่ง
- ถ้า user บอกข้อความ commit มาเอง ให้ใช้ข้อความนั้น
