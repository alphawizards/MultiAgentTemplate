#!/bin/bash
echo "Installing Python dependencies for hooks..."
if command -v uv &> /dev/null; then
    uv pip install -r .claude/hooks/requirements.txt || echo "requirements.txt not found, skipping."
else
    pip install -r .claude/hooks/requirements.txt || echo "requirements.txt not found, skipping."
fi

# Ensure hooks are executable (ignore errors on WSL mounts)
chmod +x .claude/hooks/*.py 2>/dev/null || true

# Install Node dependencies for Server/Client
echo "Installing Node dependencies..."
if command -v bun &> /dev/null; then
    cd apps/server && bun install
    cd ../client && bun install
else
    echo "⚠️ Bun not found. Please install Bun to run the observability server."
    echo "curl -fsSL https://bun.sh/install | bash"
fi
