#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

EXPECTED_USER="notifierfree9-lang"
REPO_NAME="nameless-remote-registry-test"

ACTIVE_USER="$(gh api user --jq .login 2>/dev/null || true)"

if [ "$ACTIVE_USER" != "$EXPECTED_USER" ]; then
    echo "Wrong GitHub account: ${ACTIVE_USER:-not logged in}"
    echo "Run: gh auth login --hostname github.com --git-protocol https --web"
    exit 1
fi

if gh repo view "$EXPECTED_USER/$REPO_NAME" >/dev/null 2>&1; then
    git remote remove origin 2>/dev/null || true
    git remote add origin "https://github.com/$EXPECTED_USER/$REPO_NAME.git"
    git push -u origin main
else
    gh repo create "$EXPECTED_USER/$REPO_NAME" --public --source=. --remote=origin --push
fi

echo "Registry: https://raw.githubusercontent.com/$EXPECTED_USER/$REPO_NAME/refs/heads/main/registry.lua"
