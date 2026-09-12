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
npx skills add <your-username>/preceptor

# Or via 1-liner installer (auto-detects all installed harnesses):
curl -fsSL https://raw.githubusercontent.com/<your-username>/preceptor/main/scripts/install.sh | bash       # macOS/Linux
irm https://raw.githubusercontent.com/<your-username>/preceptor/main/scripts/install.ps1 | iex             # Windows
```

<details>
<summary><b>Alternative Install Options (GitHub CLI & Manual Paths)</b></summary>

### Via GitHub CLI (`gh skill`, v2.90+)
```bash
gh skill install <your-username>/preceptor --agent claude-code
gh skill install <your-username>/preceptor --agent cursor
```

### Manual Directory Placement
| Harness | Target Directory | Source Files |
| :--- | :--- | :--- |
| **Cursor** | `.cursor/rules/` | Copy `dist/cursor/*.mdc` |
| **Claude Code** | `.claude/skills/` or `~/.claude/skills/` | Copy `skills/*` |
| **Windsurf** | `.windsurf/rules/` or `.agents/skills/` | Copy `skills/*` |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Copy `dist/copilot-instructions.md` |
| **Antigravity** | `.agents/skills/` or `~/.gemini/config/skills/` | Copy `skills/*` |
| **Cline / Roo Code** | `.clinerules` | Copy `dist/clinerules` |
| **Aider / Generic** | `AGENTS.md` | Copy `dist/AGENTS.md` |

</details>

---

## 📚 The 6 Skills at a Glance

| Skill | Mode | What It Does | Trigger Example |
| :--- | :--- | :--- | :--- |
| **`@teach`** | **Master Router** | Assesses your goal in 1 turn and routes you to the right learning mode. | `@teach I want to learn monetary policy` |
| **`@teach-roadmap`** | **Curriculum Architect** | Generates structured multi-week syllabi with visual prerequisite roadmaps. | `@teach-roadmap 8-week syllabus for microeconomics from scratch` |
| **`@teach-conceptual`** | **Mental Models & Intuition** | Explains complex ideas simply using grounded analogies, clear visuals, and plain English. | `@teach-conceptual Explain opportunity cost with an everyday analogy` |
| **`@teach-socratic`** | **Guided Discovery** | Never gives answers directly; challenges your reasoning with exactly one question per turn. | `@teach-socratic Guide me through why the Weimar Republic collapsed` |
| **`@teach-applied`** | **Deliberate Practice** | Practice problem coach with progressive hints that step in only when you get stuck. | `@teach-applied Practice problem on deadweight loss with hints` |
| **`@teach-deepdive`** | **First Principles & Proofs** | Goes deep into the mechanics: formal proofs, competing theories, and edge cases. | `@teach-deepdive Analyze Keynesian vs Austrian business cycle theory` |
| **`@teach-exam`** | **Closed-Book Mock Examiner** | Closed-book test with zero hints, objective grading, and a diagnostic scorecard. | `@teach-exam 3-question closed-book exam on macroeconomics with grading` |

---

## 💡 Why It Works

When an AI gives you the answer immediately, it *feels* like you learned it. But reading a polished solution isn't the same as understanding it—and when you have to solve a problem on your own later, you get stuck.

Preceptor fixes this by acting like a real teacher:

1. **Makes you think first:** It asks what you think is happening before explaining, so your brain is actively working instead of passively reading.
2. **Gives hints, not answers:** When you get stuck, it gives you a gentle nudge first, then a structural clue, and only shows a full example if you're truly blocked.
3. **Tests you without training wheels:** In exam mode, all hints are turned off so you can prove you actually know the material without AI assistance.

> 📖 *Curious about the learning science? See [pedagogical-core.md](./skills/references/pedagogical-core.md) for the empirical research behind these techniques.*

---

## 🔨 Development & Building Adapters

If you modify any skill in `skills/`, recompile all multi-harness adapters with:
```bash
node scripts/build-adapters.js
```

---

## 📄 License

MIT License — see [LICENSE](./LICENSE) for details.
