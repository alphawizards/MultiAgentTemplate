# Universal Multi-Agent Template - User Guide

Welcome to your **Universal Multi-Agent Development Environment**.

This template combines the best tools from the Claude ecosystem into one powerful workflow:
1.  **Observability**: Real-time visualization of agent thoughts (`disler/claude-code-hooks`).
2.  **Mastery**: Team orchestration and security (`disler/claude-code-hooks-mastery`).
3.  **Superpowers**: Methodology and Skills (`obra/superpowers`).

---

## 🚀 Getting Started

### 1. Initialize a New Project
Run this command from the root of your new project to install dependencies (Python hooks, Bun server, etc.):

```bash
just setup
```

### 2. Start the Environment
This launches the **Observability Server**, **Client Dashboard**, and a **Claude Code** session inside `tmux`:

```bash
just dev
```

*   **Dashboard**: Open [http://localhost:5173](http://localhost:5173) to see your agents working in real-time.
*   **Terminal**: You are now in a `tmux` session.
    *   Use `Ctrl+b` then `"` to split horizontally.
    *   Use `Ctrl+b` then `%` to split vertically.
    *   Use `Ctrl+b` then `x` to close a pane.

---

## 🛠️ The Workflow

Follow this cycle to maximize the potential of your agentic team.

### Phase 1: Ideation (Brainstorming)
*Powered by Superpowers*

Before writing code, use the **Brainstorming** skill to refine your architecture and requirements.

```bash
# Inside Claude Code or Terminal
just brainstorm "We need a new caching layer for the API"
```
*What happens:* The agent uses the `brainstorming` skill to ask clarifying questions, challenge assumptions, and produce a solid design spec.

### Phase 2: Planning (Team Orchestration)
*Powered by Mastery*

Once the idea is clear, create a detailed implementation plan using a team of agents.

```bash
# Inside Claude Code or Terminal
just plan "Implement the caching layer using Redis based on the design"
```
*What happens:* The `/plan_w_team` command runs. It breaks the project into tasks, assigns them to specialized agents (e.g., `builder`), and creates a `specs/plan.md` file.

### Phase 3: Execution (Building)
*Powered by Mastery & Superpowers*

Execute the plan. The template provides specialized agents for this.

*   **Builder Agent**: A focused coding agent that runs validation hooks (linting/type-checking) after every edit.
*   **TDD Skill**: Forces the agent to follow Red/Green/Refactor.

```bash
# Inside Claude Code
/agent run builder "Execute task #1 from the plan: Set up Redis connection"
```

### Phase 4: Review (Quality Control)
*Powered by Superpowers*

Before merging or finishing, have an AI review the code.

```bash
# Inside Claude Code or Terminal
just review
```
*What happens:* The `code-reviewer` agent scans your changes, looks for bugs/security issues, and provides a report.

---

## 📊 Observability

This template tracks **everything**.

*   **Event Timeline**: See every tool use (`Read`, `Write`, `Bash`), user message, and error.
*   **Agent Swimlanes**: When using multiple agents, filter the dashboard to see who did what.
*   **Pulse Chart**: Visualize the "heartbeat" of your development session.

**Dashboard URL**: [http://localhost:5173](http://localhost:5173)

---

## 🛡️ Security Features

*   **`rm -rf` Block**: The `pre_tool_use.py` hook prevents agents from running destructive deletion commands.
*   **`.env` Protection**: Agents are blocked from reading or extracting secrets from `.env` files.
*   **Sandboxing**: Use the `agent-sandbox-skill` for running untrusted code in isolation.

---

## 🤖 Available Commands (`Justfile`)

| Command | Description |
| :--- | :--- |
| `just setup` | Install dependencies (Python, Node/Bun) |
| `just dev` | Start Server, Client, and Tmux session |
| `just start` | Start Observability Server & Client only |
| `just stop` | Stop all processes |
| `just brainstorm "topic"` | Start a design/brainstorming session |
| `just plan "goal"` | Orchestrate a team to plan a task |
| `just review` | Request an automated code review |
| `just clean` | Remove `node_modules` to save space |

---

## 📂 Directory Structure

*   `.claude/hooks/`: The "Brain" – Python scripts that intercept and modify agent behavior.
*   `.claude/agents/`: Definitions for `builder`, `validator`, and `code-reviewer`.
*   `.claude/commands/`: Custom slash commands like `/plan_w_team`.
*   `skills/`: The Superpowers library (`test-driven-development`, `debugging`, etc.).
*   `apps/`: The Observability Server and Client code.
