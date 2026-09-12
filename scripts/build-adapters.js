#!/usr/bin/env node
/**
 * build-adapters.js
 * Compiles the canonical `skills/` directory into harness-specific formats:
 * - dist/cursor/*.mdc             (Cursor rules)
 * - dist/copilot-instructions.md  (GitHub Copilot)
 * - dist/clinerules               (Cline / Roo Code)
 * - dist/AGENTS.md                (Universal fallback / Aider)
 *
 * Zero external dependencies. Uses only Node.js standard libraries.
 */

const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.resolve(__dirname, '..');
const SKILLS_DIR = path.join(ROOT_DIR, 'skills');
const DIST_DIR = path.join(ROOT_DIR, 'dist');
const CURSOR_DIST = path.join(DIST_DIR, 'cursor');

// Helper to parse YAML frontmatter and body
function parseSkillFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const match = content.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/);
  if (!match) {
    return { frontmatter: {}, body: content.trim() };
  }

  const rawYaml = match[1];
  const body = match[2].trim();

  const lines = rawYaml.split(/\r?\n/);
  const frontmatter = {};
  let currentKey = null;
  let currentVal = [];

  for (const line of lines) {
    const keyMatch = line.match(/^([a-zA-Z0-9_-]+):\s*(.*)$/);
    if (keyMatch) {
      if (currentKey) {
        frontmatter[currentKey] = currentVal.join(' ').trim();
      }
      currentKey = keyMatch[1];
      const val = keyMatch[2].replace(/^[>|][-+]?\s*/, '').trim();
      currentVal = val ? [val] : [];
    } else if (currentKey && /^\s+/.test(line)) {
      currentVal.push(line.trim());
    }
  }
  if (currentKey) {
    frontmatter[currentKey] = currentVal.join(' ').trim();
  }

  return { frontmatter, body };
}

function ensureDir(dirPath) {
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }
}

function build() {
  console.log('🚀 Building multi-harness adapters from skills/...');
  ensureDir(DIST_DIR);
  ensureDir(CURSOR_DIST);

  // 1. Discover all skills
  const skillDirs = fs.readdirSync(SKILLS_DIR).filter(item => {
    const fullPath = path.join(SKILLS_DIR, item);
    return fs.statSync(fullPath).isDirectory() && item !== 'references';
  });

  const skills = [];
  for (const dir of skillDirs) {
    const skillMdPath = path.join(SKILLS_DIR, dir, 'SKILL.md');
    if (fs.existsSync(skillMdPath)) {
      const parsed = parseSkillFile(skillMdPath);
      skills.push({
        id: dir,
        name: parsed.frontmatter.name || dir,
        description: parsed.frontmatter.description || '',
        body: parsed.body,
        filePath: skillMdPath
      });
    }
  }

  // Read shared pedagogical core if available
  let pedagogicalCore = '';
  const corePath = path.join(SKILLS_DIR, 'references', 'pedagogical-core.md');
  if (fs.existsSync(corePath)) {
    pedagogicalCore = fs.readFileSync(corePath, 'utf8');
  }

  console.log(`📦 Found ${skills.length} skills: ${skills.map(s => s.name).join(', ')}`);

  // 2. Build Cursor Rules (.cursor/rules/*.mdc)
  console.log('📝 Building Cursor .mdc rules...');
  for (const skill of skills) {
    const mdcContent = `---
description: "${skill.description.replace(/"/g, '\\"')}"
globs: ""
alwaysApply: false
---

${skill.body}
`;
    const mdcPath = path.join(CURSOR_DIST, `${skill.name}.mdc`);
    fs.writeFileSync(mdcPath, mdcContent, 'utf8');
  }
  console.log(`✅ Generated ${skills.length} Cursor rules in dist/cursor/`);

  // 3. Build GitHub Copilot Instructions (dist/copilot-instructions.md)
  console.log('📝 Building GitHub Copilot instructions...');
  const copilotContent = `# Preceptor: Adaptive Learning Engine for GitHub Copilot

This repository contains Preceptor, an adaptive educational skill suite. When the user asks to learn, practice, deep dive, or be tested on any subject, adopt the appropriate pedagogical mode below.

---

## The 6 Pedagogical Modes

${skills.map(s => `### Mode: \`${s.name}\`
**When to activate:** ${s.description}

${s.body}
`).join('\n---\n\n')}

---

## Core Turn-Taking Standards (Cognitive Load & Scaffolding)

${pedagogicalCore}
`;
  fs.writeFileSync(path.join(DIST_DIR, 'copilot-instructions.md'), copilotContent, 'utf8');
  console.log('✅ Generated dist/copilot-instructions.md');

  // 4. Build Cline / Roo Code rules (dist/clinerules)
  console.log('📝 Building Cline / Roo Code rules (dist/clinerules)...');
  fs.writeFileSync(path.join(DIST_DIR, 'clinerules'), copilotContent, 'utf8');
  console.log('✅ Generated dist/clinerules');

  // 5. Build Universal AGENTS.md (dist/AGENTS.md)
  console.log('📝 Building Universal AGENTS.md...');
  fs.writeFileSync(path.join(DIST_DIR, 'AGENTS.md'), copilotContent, 'utf8');
  console.log('✅ Generated dist/AGENTS.md');

  console.log('\n🎉 Multi-harness build completed successfully!');
}

build();
