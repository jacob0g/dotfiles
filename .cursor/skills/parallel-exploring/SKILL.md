---
name: parallel-exploring
description: Explore a large codebase in parallel by launching multiple explore subagents that each investigate a different area simultaneously. Use when onboarding onto a new project, understanding architecture, investigating a cross-cutting concern, or generating an onboarding document.
---

# Parallel Explore

Use this skill when you need to understand a large or unfamiliar codebase quickly — onboarding onto a new project, investigating how a feature works across layers, or mapping the architecture.

## How It Works

Cursor's `explore` subagent is a fast, read-only agent optimized for searching and reading code. You can launch multiple explore agents in a single message and they run concurrently, each investigating a different area.

## Steps

1. **Identify the areas to explore** — break the codebase into logical zones. For a typical full-stack app:
   - Frontend: components, pages, routing, state management
   - Backend: API routes, database models, middleware, auth
   - Infrastructure: CI/CD, Docker, deployment config
   - Shared: types, utilities, constants

2. **Launch parallel explore agents** — use the Task tool with `subagent_type: "explore"` for each area. Launch them all in one message:

   ```
   Task 1: "Explore the frontend — find the main pages, routing setup, state management approach,
            and UI component library. Check src/app/, src/components/, src/pages/. Report the
            framework, router, styling approach, and key components."

   Task 2: "Explore the backend — find the API routes, database setup, ORM, auth middleware,
            and data models. Check src/server/, src/api/, lib/, prisma/. Report the framework,
            database, auth strategy, and key endpoints."

   Task 3: "Explore the infrastructure — find CI/CD config, Docker setup, deployment targets,
            and environment variable management. Check .github/, docker*, *.config.*, .env*.
            Report the deploy target, CI provider, and any IaC."
   ```

3. **Synthesize the results** — when all agents return, combine their findings into a coherent picture:
   - Tech stack summary (frontend, backend, database, infra)
   - Architecture diagram (describe the data flow)
   - Key files and entry points
   - Potential concerns or tech debt

## Other Use Cases

- **Cross-cutting investigation**: "Where is user authentication checked?" — launch agents to search the frontend (route guards), backend (middleware), and database (session storage) simultaneously.
- **Dependency audit**: launch agents to check different parts of the dependency tree for outdated packages, security issues, and unused imports.
- **Migration planning**: have agents simultaneously assess the frontend, backend, and tests to estimate the scope of a framework migration.

## Recipe: Codebase Onboarding

Generate a comprehensive onboarding document by launching 5 focused explore agents in parallel.

### 1. Launch Parallel Explorers

Spawn 5 `explore` subagents, each investigating a different area:

**Agent 1 — Architecture & Structure**
> "Map the top-level directory structure. Identify the framework (Next.js, Express, Django, etc.), monorepo tools (turbo, nx), and key config files. List every app/package and what it does."

**Agent 2 — Data Models & Database**
> "Find all database schemas, ORM models, migrations, and seed files. List every entity, its fields, and relationships. Identify the database (Postgres, MySQL, MongoDB, etc.) and ORM (Prisma, Drizzle, SQLAlchemy, etc.)."

**Agent 3 — API Routes & Endpoints**
> "Find all API route definitions. List every endpoint with its HTTP method, path, auth requirements, and what it does. Identify the API style (REST, GraphQL, tRPC)."

**Agent 4 — Authentication & Authorization**
> "Find how auth works. Identify the auth provider (Auth.js, Clerk, Supabase Auth, custom), session management, protected routes, role/permission checks, and middleware."

**Agent 5 — Deployment & Infrastructure**
> "Find deployment config (Dockerfile, Vercel config, fly.toml, terraform), CI/CD pipelines (GitHub Actions, etc.), environment variables needed, and how to run the app locally."

### 2. Synthesize

Combine the results from all 5 agents into a single onboarding document:

```markdown
# Codebase Onboarding

## Quick Start
1. Clone the repo
2. Install dependencies: `<command>`
3. Set up environment: copy `.env.example` to `.env`
4. Run database migrations: `<command>`
5. Start dev server: `<command>`

## Architecture
<Agent 1 findings>

## Data Models
<Agent 2 findings>

## API Reference
<Agent 3 findings>

## Authentication
<Agent 4 findings>

## Deployment
<Agent 5 findings>

## Key Files to Know
- `<file>` — <why it matters>
```

### 3. Save

Write the document to `ONBOARDING.md` in the project root, or wherever the user specifies.

### Tips

- For monorepos, consider one additional agent per app/package
- The document should be opinionated — highlight the "start here" files, not just list everything
- Include gotchas: common setup issues, env vars that are easy to forget, required system dependencies

## Notes

- Explore agents are read-only — they can't modify files.
- Use `thoroughness: "very thorough"` in the prompt for comprehensive analysis.
- Each agent has its own context window, so they can each read many files without running out of space.
- For a single focused question, just use Grep or SemanticSearch directly — subagents are for broad exploration.
