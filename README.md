# 🎓 Preceptor

[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Preceptor-blue.svg)](https://skills.sh)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Multi-Harness](https://img.shields.io/badge/Harnesses-Cursor%20%7C%20Claude%20%7C%20Windsurf%20%7C%20Copilot%20%7C%20Antigravity-brightgreen.svg)]()

**Preceptor** turns your AI coding assistant into an active 1-on-1 academic tutor. Instead of spoon-feeding code and answers, it guides your reasoning, provides scaffolded hints when you're stuck, and tests your mastery across **Cursor, Claude Code, Windsurf, GitHub Copilot, and Google Antigravity**.

Designed to overcome the classic pitfalls of AI tutors—monologue lectures, spoon-feeding answers, and tech-only bias—by embedding proven teaching techniques into modular agent skills.

---

## ⚡ Quick Install

```bash
# Recommended: Install via open Agent Skills (skills.sh)
npx skills add samuli-h/preceptor

# Or via 1-liner installer (auto-detects all installed harnesses):
curl -fsSL https://raw.githubusercontent.com/samuli-h/preceptor/main/scripts/install.sh | bash       # macOS/Linux
irm https://raw.githubusercontent.com/samuli-h/preceptor/main/scripts/install.ps1 | iex             # Windows
```

<details>
<summary><b>Installer Flags & Manual Placement Options</b></summary>

### Installer Script Options
```bash
# Target a specific harness (auto, all, claude, cursor, windsurf, antigravity, copilot, cline)
bash scripts/install.sh --target cursor --global
.\scripts\install.ps1 -Target Claude -Scope Project
```

### Via GitHub CLI (`gh skill`, v2.90+)
```bash
gh skill install samuli-h/preceptor --agent claude-code
gh skill install samuli-h/preceptor --agent cursor
```

### Manual Directory Placement
| Harness | Target Directory | Source Files |
| :--- | :--- | :--- |
| **Cursor** | `.cursor/rules/` | Copy `dist/cursor/*.mdc` |
| **Claude Code** | `.claude/skills/` or `~/.claude/skills/` | Copy `skills/*` |
| **Windsurf** | `.windsurf/rules/` or `.agents/skills/` | Copy `skills/*` |
| **Google Antigravity** | `.agents/skills/` or `~/.gemini/config/skills/` | Copy `skills/*` |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Copy `dist/copilot-instructions.md` |
| **Cline / Roo Code** | `.clinerules` | Copy `dist/clinerules` |
| **Aider / Universal** | `AGENTS.md` | Copy `dist/AGENTS.md` |

</details>

---

## 🔄 The Learning Lifecycle

You don't need to choose which skill to use ahead of time. Just prompt **`@teach <anything>`**, and Preceptor figures out what you need in one turn:

```mermaid
graph TD
    A["@teach (Master Router)"] --> B["1. Plan & Structure<br><b>@teach-roadmap</b>"]
    A --> C["2. Intuition & Mental Models<br><b>@teach-conceptual</b>"]
    A --> D["3. Guided Discovery<br><b>@teach-socratic</b>"]
    A --> E["4. Deliberate Practice<br><b>@teach-applied</b>"]
    A --> F["5. First Principles & Rigor<br><b>@teach-deepdive</b>"]
    A --> G["6. Testing & Defense<br><b>@teach-exam</b>"]
```

---

## 📚 The 7 Skills at a Glance

| Skill | Mode | What It Does | Trigger Example |
| :--- | :--- | :--- | :--- |
| **`@teach`** | **Master Router** | Diagnoses your goal in 1 turn or automatically routes uploaded course materials. | `@teach I want to learn monetary policy` |
| **`@teach-roadmap`** | **Curriculum Architect** | Generates multi-week study plans, milestone checklists, and visual prerequisite maps. | `@teach-roadmap 8-week syllabus for microeconomics from scratch` |
| **`@teach-conceptual`** | **Mental Models & Intuition** | Explains complex ideas using grounded analogies, visuals, and unassisted transfer checks. | `@teach-conceptual Explain opportunity cost with an everyday analogy` |
| **`@teach-socratic`** | **Guided Discovery** | Never gives direct answers; challenges your reasoning with one focused question per turn. | `@teach-socratic Guide me through why the Weimar Republic collapsed` |
| **`@teach-applied`** | **Deliberate Practice** | Practice problem coach with progressive hints and streak-based mastery checks. | `@teach-applied Practice problem on deadweight loss with hints` |
| **`@teach-deepdive`** | **First Principles & Proofs** | Advanced rigor: formal derivations, boundary conditions, and competing perspectives. | `@teach-deepdive Analyze Keynesian vs Austrian business cycle theory` |
| **`@teach-exam`** | **Closed-Book Mock Examiner** | Realistic closed-book tests and oral defenses with zero hints, objective scoring, and gap reports. | `@teach-exam 3-question closed-book exam on macroeconomics with grading` |

---

## 📂 Bring Your Own Course Materials (optional)

Attach or paste your existing course materials directly into chat. Preceptor automatically detects the document type and adapts to your course:

- **Syllabus or Reading List (`@syllabus.pdf`):** Turns course schedules and topics into an interactive, step-by-step learning roadmap (`curriculum-[topic].md`).
- **Lecture Slides or Notes (`@slides.pdf`):** Breaks down the material into bite-sized concepts with checks to ensure you understand before moving on.
- **Assignments & Problem Sets (`@homework.py`):** Preceptor will **never solve your exact homework problem**. Instead, it creates and solves a *parallel problem* with the same underlying mechanics, then asks you to apply that method to your own assignment.
- **Practice Exams & Review Guides (`@exam-review.pdf`):** Simulates a closed-book test with zero hints, citing specific slide and reading references for any concepts you missed.

---

## 💡 Why It Works

When an AI gives you the answer immediately, it *feels* like learning. But reading a polished solution isn't the same as understanding it—and the moment you have to solve a problem on your own, you get stuck.

Preceptor fixes this by acting like a real 1-on-1 teacher:

1. **Makes you think first:** It asks for your intuition or hypothesis before explaining, so your brain is actively working instead of passively reading.
2. **Short, focused conversations:** No overwhelming walls of text. Turns stay short, ending with a single question or calculation so you stay engaged.
3. **Hints instead of spoilers:** When you're stuck, it gives a gentle nudge first, then a structural clue, and only shows a full worked example on a separate problem if you're completely blocked.
4. **Earned progress:** Advancing through practice requires consistently solving problems correctly without relying on heavy hints.
5. **No training wheels in exam mode:** All hints are turned off during exams so you can prove you actually know the material without AI assistance.

> 📖 *Curious about the learning science? See [pedagogical-core.md](./skills/references/pedagogical-core.md) for the research and evidence behind these techniques.*

---

## 🔨 Development & Building Adapters

If you modify any skill in `skills/`, recompile all multi-harness adapters with:
```bash
node scripts/build-adapters.js
```

---

## 📄 License

MIT License — see [LICENSE](./LICENSE) for details.
