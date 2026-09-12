#!/usr/bin/env bash
# Preceptor: Academic Learning Engine Installer (macOS & Linux)
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/<owner>/preceptor/main/scripts/install.sh | bash
#   bash scripts/install.sh [--target all|claude|cursor|windsurf|antigravity|copilot|cline] [--global|--project]

set -e

# ANSI color codes
BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

TARGET="auto"
SCOPE="global"
REPO_URL="https://github.com/<owner>/preceptor"
RAW_URL="https://raw.githubusercontent.com/<owner>/preceptor/main"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="$2"
      shift 2
      ;;
    --project)
      SCOPE="project"
      shift
      ;;
    --global)
      SCOPE="global"
      shift
      ;;
    --help|-h)
      echo "Preceptor: Academic Learning Engine Installer"
      echo "Usage: install.sh [OPTIONS]"
      echo "  --target <all|claude|cursor|windsurf|antigravity|copilot|cline>  Target harness (default: auto)"
      echo "  --global                                                         Install to user-level config (default)"
      echo "  --project                                                        Install to current project directory"
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      exit 1
      ;;
  esac
done

echo -e "${BOLD}${BLUE}======================================================${NC}"
echo -e "${BOLD}${BLUE}   Preceptor: Academic Learning Engine Installer      ${NC}"
echo -e "${BOLD}${BLUE}======================================================${NC}"

# Find local source or download
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." 2>/dev/null && pwd || echo "")"

if [[ -d "$ROOT_DIR/skills" ]]; then
  SRC_SKILLS="$ROOT_DIR/skills"
  SRC_DIST="$ROOT_DIR/dist"
  echo -e "${GREEN}✓ Detected local repository at: $ROOT_DIR${NC}"
else
  TEMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TEMP_DIR"' EXIT
  echo -e "${YELLOW}Downloading skill suite from GitHub...${NC}"
  git clone --depth 1 "$REPO_URL.git" "$TEMP_DIR/suite" >/dev/null 2>&1 || {
    echo -e "${RED}Failed to clone repository. Make sure git is installed.${NC}"
    exit 1
  }
  SRC_SKILLS="$TEMP_DIR/suite/skills"
  SRC_DIST="$TEMP_DIR/suite/dist"
fi

installed_count=0

install_to_antigravity() {
  echo -e "\n${BOLD}Installing for Google Antigravity / Gemini CLI...${NC}"
  if [[ "$SCOPE" == "global" ]]; then
    local dest="$HOME/.gemini/config/skills"
  else
    local dest="./.agents/skills"
  fi
  mkdir -p "$dest"
  cp -R "$SRC_SKILLS/"* "$dest/"
  echo -e "${GREEN}✓ Installed 7 skills to $dest${NC}"
  ((installed_count++))
}

install_to_claude() {
  echo -e "\n${BOLD}Installing for Claude Code...${NC}"
  if [[ "$SCOPE" == "global" ]]; then
    local dest="$HOME/.claude/skills"
  else
    local dest="./.claude/skills"
  fi
  mkdir -p "$dest"
  cp -R "$SRC_SKILLS/"* "$dest/"
  echo -e "${GREEN}✓ Installed 7 skills to $dest${NC}"
  ((installed_count++))
}

install_to_cursor() {
  echo -e "\n${BOLD}Installing for Cursor (Composer & Agent)...${NC}"
  if [[ "$SCOPE" == "project" ]]; then
    local dest="./.cursor/rules"
    mkdir -p "$dest"
    if [[ -d "$SRC_DIST/cursor" ]]; then
      cp "$SRC_DIST/cursor/"*.mdc "$dest/"
    else
      cp -R "$SRC_SKILLS/"* "./.cursor/skills/"
    fi
    echo -e "${GREEN}✓ Installed Cursor rules to $dest${NC}"
  else
    local dest="$HOME/.cursor/skills"
    mkdir -p "$dest"
    cp -R "$SRC_SKILLS/"* "$dest/"
    echo -e "${GREEN}✓ Installed global skills to $dest${NC}"
  fi
  ((installed_count++))
}

install_to_windsurf() {
  echo -e "\n${BOLD}Installing for Windsurf (Cascade)...${NC}"
  if [[ "$SCOPE" == "global" ]]; then
    local dest="$HOME/.windsurf/skills"
  else
    local dest="./.windsurf/rules"
  fi
  mkdir -p "$dest"
  cp -R "$SRC_SKILLS/"* "$dest/" 2>/dev/null || cp "$SRC_DIST/clinerules" "$dest/teaching.md"
  echo -e "${GREEN}✓ Installed to $dest${NC}"
  ((installed_count++))
}

install_to_copilot() {
  echo -e "\n${BOLD}Installing for GitHub Copilot...${NC}"
  local dest="./.github"
  mkdir -p "$dest"
  if [[ -f "$SRC_DIST/copilot-instructions.md" ]]; then
    cp "$SRC_DIST/copilot-instructions.md" "$dest/copilot-instructions.md"
    echo -e "${GREEN}✓ Copied copilot-instructions.md to $dest/copilot-instructions.md${NC}"
    ((installed_count++))
  fi
}

install_to_cline() {
  echo -e "\n${BOLD}Installing for Cline / Roo Code...${NC}"
  if [[ -f "$SRC_DIST/clinerules" ]]; then
    cp "$SRC_DIST/clinerules" "./.clinerules"
    echo -e "${GREEN}✓ Created ./.clinerules${NC}"
    ((installed_count++))
  fi
}

# Execution based on target
if [[ "$TARGET" == "antigravity" ]]; then
  install_to_antigravity
elif [[ "$TARGET" == "claude" ]]; then
  install_to_claude
elif [[ "$TARGET" == "cursor" ]]; then
  install_to_cursor
elif [[ "$TARGET" == "windsurf" ]]; then
  install_to_windsurf
elif [[ "$TARGET" == "copilot" ]]; then
  install_to_copilot
elif [[ "$TARGET" == "cline" ]]; then
  install_to_cline
elif [[ "$TARGET" == "all" ]]; then
  install_to_antigravity
  install_to_claude
  install_to_cursor
  install_to_windsurf
  install_to_copilot
  install_to_cline
else
  # Auto-detection
  echo -e "${YELLOW}Auto-detecting installed AI coding harnesses...${NC}"
  detected=0

  if [[ -d "$HOME/.gemini" || -d "./.agents" ]]; then
    install_to_antigravity
    detected=1
  fi

  if [[ -d "$HOME/.claude" || -d "./.claude" ]]; then
    install_to_claude
    detected=1
  fi

  if [[ -d "$HOME/.cursor" || -d "./.cursor" || -n "$(command -v cursor 2>/dev/null)" ]]; then
    install_to_cursor
    detected=1
  fi

  if [[ -d "$HOME/.windsurf" || -d "./.windsurf" ]]; then
    install_to_windsurf
    detected=1
  fi

  if [[ -d "./.github" ]]; then
    install_to_copilot
    detected=1
  fi

  if [[ $detected -eq 0 ]]; then
    echo -e "${YELLOW}No specific harness detected. Installing default to Claude / Open Agent Skills standard...${NC}"
    install_to_claude
  fi
fi

echo -e "\n${BOLD}${GREEN}======================================================${NC}"
echo -e "${BOLD}${GREEN}   Successfully installed to $installed_count harness(es)!       ${NC}"
echo -e "${BOLD}${GREEN}======================================================${NC}"
echo -e "You can now use skills in your chat via:"
echo -e "  • @teach            (Open learning router)"
echo -e "  • @teach-roadmap    (Curriculum planning)"
echo -e "  • @teach-conceptual (Mental models & analogies)"
echo -e "  • @teach-socratic   (Guided discovery & active recall)"
echo -e "  • @teach-applied    (Practice problems & hint ladder)"
echo -e "  • @teach-deepdive   (First principles & formal derivations)"
echo -e "  • @teach-exam       (Closed-book test & diagnostic report)\n"
