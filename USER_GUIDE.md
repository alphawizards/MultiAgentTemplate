# Universal Multi-Agent Template - User Guide

Welcome to your **Universal Multi-Agent Development Environment**.

This template empowers you to build software using a team of specialized AI agents. It combines three powerful frameworks:
1.  **Observability**: Real-time dashboard to watch your agents think (`disler/claude-code-hooks`).
2.  **Mastery**: Team orchestration, security limits, and helper commands (`disler/claude-code-hooks-mastery`).
3.  **Superpowers**: A library of "Skills" that force agents to follow best practices like TDD and systematic debugging (`obra/superpowers`).

---

## 🚀 Getting Started

### 1. Initialize a New Project
Run this command from the root of your new project. It installs Python dependencies (for hooks) and Node/Bun dependencies (for the dashboard).

```bash
just setup
```

### 2. Start the Environment
This single command launches the **Observability Server**, **Client Dashboard**, and a **Claude Code** session inside a standardized `tmux` layout.

```bash
just dev
```

*   **Dashboard**: Open [http://localhost:5173](http://localhost:5173) to see your agents working in real-time.
*   **Terminal**: You are now in `tmux`.
    *   **Main Pane**: Your interactive Claude Code session.
    *   **Side Panes**: Server and Client logs (usually hidden or minimized).
    *   **Navigation**: `Ctrl+b` then `arrow keys` to switch panes.

---

## 🛠️ The Core Workflow

Follow this cycle to maximize the potential of your agentic team.

### Phase 1: Ideation (Brainstorming)
*Powered by Superpowers*

Never start coding without a plan. Use the **Brainstorming** skill to refine your architecture.

```bash
# Inside Claude Code
just brainstorm "We need a new caching layer for the API"
```
**What happens under the hood:**
The agent loads the `skills/brainstorming/SKILL.md` file. This forces it to:
1.  Ask clarifying questions about constraints and edge cases.
2.  Challenge your assumptions.
3.  Output a structured design summary.

### Phase 2: Planning (Team Orchestration)
*Powered by Mastery*

Create a detailed implementation plan using a team of agents.

```bash
# Inside Claude Code
just plan "Implement the caching layer using Redis based on the design"
```
**What happens under the hood:**
1.  The `/plan_w_team` command is invoked.
2.  A **Planner Agent** breaks the project into granular tasks.
3.  Tasks are assigned to specialized sub-agents (e.g., `builder`).
4.  A **Specification** file is created at `specs/plan.md`. *Review this file before proceeding!*

### Phase 3: Execution (Building)
*Powered by Mastery & Superpowers*

Execute the plan. You can run tasks yourself or delegate them to the **Builder** agent.

**The Builder Agent:**
The template includes a specialized `builder` agent designed for coding. It has unique hooks:
*   **Auto-Linting**: After every file edit, it runs `ruff` (Python) or `tsc` (TypeScript) to catch errors immediately.
*   **Focus**: It is instructed to do *one thing at a time* and not get distracted.

```bash
# Inside Claude Code
/agent run builder "Execute task #1 from the plan: Set up Redis connection"
```

**Test Driven Development (TDD) Skill:**
If you ask the agent to "implement feature X using TDD", it loads `skills/test-driven-development/SKILL.md`. This forces a strict cycle:
1.  🔴 Write a failing test.
2.  🟢 Write minimal code to pass the test.
3.  🔵 Refactor.

### Phase 4: Review (Quality Control)
*Powered by Superpowers*

Before merging, have an AI review the code.

```bash
# Inside Claude Code
just review
```
**What happens under the hood:**
The `code-reviewer` agent (`.claude/agents/code-reviewer.md`) is spawned. It reads your Git diffs and checks for:
*   Security vulnerabilities.
*   Logic bugs.
*   Missing tests.
*   Use of anti-patterns.

---

## ⚡ Superpowers Deep Dive

Your agents have access to a library of "Skills" in the `skills/` directory. They will automatically use them if the context matches, or you can force them.

### 🧠 Systematic Debugging
If you report a bug, the agent uses `skills/systematic-debugging`.
**It will NOT just guess.** It will:
1.  Create a reproduction script to confirm the bug.
2.  Log a hypothesis.
3.  Add logging/tracing to the code.
4.  Verify the fix with the reproduction script.

### 🌳 Git Worktrees
For complex tasks, the agent can use `skills/using-git-worktrees` to create a temporary, isolated environment. This keeps your main branch clean while the agent experiments.

### 📋 Full Skills Library

| Skill | Purpose | Used By |
| :--- | :--- | :--- |
| `brainstorming` | Turn ideas into designs before coding | Frontend, Backend |
| `test-driven-development` | Red/Green/Refactor cycle | Backend, QA, Debugger |
| `systematic-debugging` | 4-phase root cause analysis | Debugger |
| `verification-before-completion` | Evidence before claims | ALL agents |
| `writing-plans` | Create bite-sized implementation plans | Frontend, Backend, DevOps |
| `executing-plans` | Follow plans task-by-task | Backend |
| `dispatching-parallel-agents` | Run independent tasks concurrently | Debugger |
| `finishing-a-development-branch` | Verify → Options → Merge/PR | DevOps |
| `using-git-worktrees` | Isolated workspaces for experiments | DevOps |
| `requesting-code-review` | Dispatch code reviewer after work | QA |
| `receiving-code-review` | Evaluate feedback technically | Frontend, Backend |
| `subagent-driven-development` | Fresh subagent per task | ALL (orchestration) |
| `agent-sandbox-skill` | Run untrusted code safely | DevOps |

---

## 🏗️ Specialist Sub-Agents

Instead of using the generic `builder` for all tasks, this template includes **5 specialist agents**, each tuned for a specific domain. They have pre-configured skill loading, domain-specific hooks, and unique colour coding in the Observability dashboard.

### How to Dispatch a Specialist

Inside Claude Code, use the `/agent run` command:

```bash
# Frontend work
/agent run frontend-engineer "Build the dashboard sidebar component with responsive layout"

# Backend work
/agent run backend-engineer "Create the /api/v1/users endpoint with Pydantic validation"

# DevOps work
/agent run devops-engineer "Write a GitHub Actions workflow for CI/CD"

# Testing / Verification
/agent run qa-engineer "Write unit tests for the user authentication module"

# Debugging
/agent run debugger "Fix the NaN error on the Liabilities page"
```

### 🟣 Frontend Engineer
**File**: `.claude/agents/team/frontend-engineer.md` | **Colour**: Magenta

**Domain**: UI components, styling, responsive layouts, accessibility, client-side interactivity.

**Skills Loaded**:
| Skill | Why |
| :--- | :--- |
| `brainstorming` | Explore layout options and interaction patterns before coding |
| `writing-plans` | Break multi-step UI work into component-level tasks |
| `verification-before-completion` | Run dev server and visually confirm output |
| `receiving-code-review` | Evaluate review feedback technically |

**Guardrails**: Cannot modify backend logic, API routes, or database schemas.

---

### 🟢 Backend Engineer
**File**: `.claude/agents/team/backend-engineer.md` | **Colour**: Green

**Domain**: APIs, database schemas, server logic, data processing, integrations.

**Skills Loaded**:
| Skill | Why |
| :--- | :--- |
| `test-driven-development` | ALL backend logic follows Red/Green/Refactor |
| `executing-plans` | Follow implementation plans task-by-task |
| `verification-before-completion` | Run tests and confirm pass/fail output |
| `receiving-code-review` | Evaluate review feedback technically |

**Guardrails**: Cannot modify frontend components or UI styling. Uses `Decimal` for financial logic. Validates all inputs with Pydantic/Zod.

---

### 🔵 DevOps Engineer
**File**: `.claude/agents/team/devops-engineer.md` | **Colour**: Blue

**Domain**: CI/CD pipelines, Docker, infrastructure-as-code, deployments, environment config, git workflows.

**Skills Loaded**:
| Skill | Why |
| :--- | :--- |
| `using-git-worktrees` | Create isolated environments for deployment testing |
| `finishing-a-development-branch` | Verify tests → Present options → Execute merge/PR |
| `verification-before-completion` | Run deployment verification commands |
| `writing-plans` | Plan multi-step infrastructure changes |

**Guardrails**: Cannot modify application business logic or UI. Always provides verification CLI commands. Updates `.env.example` when adding new env vars.

---

### 🟡 QA Engineer
**File**: `.claude/agents/team/qa-engineer.md` | **Colour**: Yellow

**Domain**: Test writing, acceptance criteria verification, regression testing, specification validation.

**Skills Loaded**:
| Skill | Why |
| :--- | :--- |
| `test-driven-development` | Strict Red/Green/Refactor for every test |
| `verification-before-completion` | Run EVERY test command and read FULL output |
| `requesting-code-review` | Dispatch code review to validate test quality |
| `receiving-code-review` | Evaluate feedback on test design |

**Guardrails**: Tests verify BEHAVIOUR, not implementation. Covers edge cases (null, empty, boundaries). Runs the full test suite after every change.

---

### 🔴 Debugger
**File**: `.claude/agents/team/debugger.md` | **Colour**: Red

**Domain**: Root cause analysis, hypothesis testing, targeted fixes, regression prevention.

**Skills Loaded**:
| Skill | Why |
| :--- | :--- |
| `systematic-debugging` | MANDATORY 4-phase process: Investigate → Pattern → Hypothesis → Verify |
| `verification-before-completion` | Run reproduction script AFTER fix |
| `test-driven-development` | Write regression test BEFORE applying fix |
| `dispatching-parallel-agents` | If multiple independent bugs, dispatch separate agents |

**Guardrails**: ONE fix at a time. Never stacks fixes. After 3 failed attempts, stops and escalates to user. Always writes a regression test.

---

### Agent Summary Table

| Agent | Colour | Primary Skills | Use Case |
| :--- | :--- | :--- | :--- |
| `frontend-engineer` | 🟣 Magenta | brainstorming, writing-plans | UI, components, styling |
| `backend-engineer` | 🟢 Green | TDD, executing-plans | APIs, schemas, server logic |
| `devops-engineer` | 🔵 Blue | git-worktrees, finishing-branch | CI/CD, Docker, deployments |
| `qa-engineer` | 🟡 Yellow | TDD, verification, code-review | Tests, acceptance criteria |
| `debugger` | 🔴 Red | systematic-debugging, TDD | Bug fixing, root cause analysis |
| `builder` | 🔵 Cyan | (generic) | General-purpose coding |
| `validator` | 🟡 Yellow | (read-only) | Inspects work without modifying |

---

## 📊 Observability Deep Dive

The dashboard at [http://localhost:5173](http://localhost:5173) gives you X-Ray vision into your agents.

### The Timeline
Every event is logged chronologically.
*   🔧 **PreToolUse**: The agent *wants* to do something (e.g., edit a file).
*   ✅ **PostToolUse**: The action completed successfully.
*   ❌ **Failure**: The tool failed (e.g., syntax error, file not found).

### Agent Swimlanes
When running multiple agents (e.g., a "Builder" and a "Validator" in parallel), use the **Filter** dropdown to see only one agent's actions. This is crucial for debugging multi-agent race conditions.

### The Pulse Chart
The graph at the top visualizes "Tokens per Second" (activity density).
*   **Spikes**: Intense tool usage (reading/writing).
*   **Flatline**: Agent is thinking or waiting for an API response.

---

## 🛡️ Security & Safety

This template includes "Guardrails" to prevent AI accidents.

1.  **Deletion Block**: The `pre_tool_use.py` hook intercepts any command containing `rm -rf`. It will **block** the action and warn the agent.
2.  **Secret Protection**: Agents are strictly forbidden from reading `.env` files or outputting their contents.
3.  **Sandboxing**: The `skills/agent-sandbox-skill` allows agents to run experimental code in a safe container (if configured).

---

## 🤖 Justfile Command Reference

The `Justfile` is your control center. Here are the commands:

| Command | Description | Background Action |
| :--- | :--- | :--- |
| `just setup` | Initialize project | Installs `uv` (Python) and `bun` (Node) dependencies. |
| `just dev` | **Start Everything** | Runs `tmux` session with Server, Client, and Claude Code. |
| `just brainstorm "topic"` | Ideation Session | Injects `skills/brainstorming` into context. |
| `just plan "goal"` | Team Planning | Runs `/plan_w_team` command to generate `specs/plan.md`. |
| `just review` | Code Review | Spawns `code-reviewer` agent to analyze `git diff`. |
| `just start` | Start Observability | Runs only the Server and Client (no Claude Code). |
| `just stop` | Kill Everything | Stops all background processes and frees ports. |
| `just clean` | Save Disk Space | Deletes `node_modules` folders. |

---

## 📂 Key Files & Folders

*   **`.claude/hooks/`**: The Python scripts that intercept agent actions (Security, Logging).
*   **`.claude/agents/team/`**: Specialist agents — `frontend-engineer`, `backend-engineer`, `devops-engineer`, `qa-engineer`, `debugger`, plus the generic `builder` and `validator`.
*   **`.claude/agents/code-reviewer.md`**: The standalone code review agent.
*   **`.claude/commands/`**: Custom slash commands like `/plan_w_team`.
*   **`skills/`**: The Superpowers library (13 skills including `TDD`, `Debugging`, `Brainstorming`, etc.).
*   **`apps/`**: Source code for the Observability Server and Dashboard.
*   **`specs/`**: Where the agent stores its Plans and Design Docs.
