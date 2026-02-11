# Justfile for Multi-Agent Development (Universal Edition)
# Combines Observability, Mastery, and Superpowers

set dotenv-load

default:
    @just --list

# 🚀 Init
setup:
    @echo "Installing specialized dependencies..."
    bash scripts/setup_env.sh 2>/dev/null || true
    @echo "✅ Setup complete! Run 'just dev' to start."

# 🐛 Development Environment
dev:
    tmux new-session -A -s multi-agent

# 🧠 Superpowers & Planning
brainstorm topic:
    @echo "Start brainstorming session for: {{topic}}"
    # Requires Claude Code running
    @echo "Run inside Claude: /brainstorm {{topic}}"

plan goal:
    @echo "Planning goal: {{goal}}"
    @echo "Run inside Claude: /plan_w_team {{goal}}"

review:
    @echo "Requesting code review..."
    @echo "Run inside Claude: /code-reviewer"

# 🔍 Observability (Delegates to project scripts)
server:
    just -f justfile.orig server

client:
    just -f justfile.orig client

start-observability:
    just -f justfile.orig start

stop-observability:
    just -f justfile.orig stop

# 📦 Sandbox Skill
sandbox prompt:
    @echo "Running sandbox with prompt: {{prompt}}"
    echo "Please use the agent tool to invoke the sandbox skill."

# 🔧 Hooks Management
enable-hook hook_name:
    chmod +x .claude/hooks/{{hook_name}} 2>/dev/null || true
    @echo "Enabled {{hook_name}}"

list-hooks:
    @ls -1 .claude/hooks

# 🧹 Cleanup
clean:
    rm -rf node_modules
    rm -rf apps/server/node_modules
    rm -rf apps/client/node_modules
