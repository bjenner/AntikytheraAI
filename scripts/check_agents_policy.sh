#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail() {
  echo "[AGENTS POLICY] ERROR: $1" >&2
  exit 1
}

pass() {
  echo "[AGENTS POLICY] OK: $1"
}

[[ -f "AGENTS.md" ]] || fail "Missing root AGENTS.md"
pass "Root AGENTS.md exists"

[[ ! -f "docs/project/agents.md" ]] || fail "Deprecated file exists: docs/project/agents.md (move content to AGENTS.md)"
pass "Deprecated docs/project/agents.md is absent"

required_sections=(
  "## Agent Roles"
  "## Workflow Per Drawing Sheet"
  "## Definition of Done"
)

for section in "${required_sections[@]}"; do
  grep -Fq "$section" AGENTS.md || fail "AGENTS.md missing required section: $section"
  pass "Found section: $section"
done

pass "All AGENTS.md policy checks passed"
