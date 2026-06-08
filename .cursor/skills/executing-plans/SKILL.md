---
name: executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute tasks using one of two modes, report for review.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

## Choosing an Execution Mode

**Mode A: Batch-sequential** (default) — Execute tasks yourself in batches of 3, pause for human review between batches. Best when tasks are tightly coupled or you want human-in-the-loop at every checkpoint.

**Mode B: Subagent-per-task** — Dispatch a fresh subagent for each task with two-stage automated review (spec compliance, then code quality). Best when tasks are mostly independent and you want faster iteration with automated quality gates.

## Step 1: Load and Review Plan (both modes)

1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create TodoWrite and proceed

## Mode A: Batch-Sequential Execution

### Step A2: Execute Batch
**Default: First 3 tasks**

For each task:
1. Mark as in_progress
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark as completed

### Step A3: Report
When batch complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback."

### Step A4: Continue
Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

## Mode B: Subagent-Per-Task Execution

### Step B2: Extract All Tasks
Read plan once and extract all tasks with their full text and context. Don't make subagents read the plan file — provide full text directly.

### Step B3: Per-Task Loop

For each task:

**1. Dispatch implementer subagent**

Use the Task tool (generalPurpose) with this structure:
- Provide the FULL TEXT of the task from the plan
- Provide scene-setting context (where this fits, dependencies, architecture)
- Instruct the subagent to ask questions before starting if anything is unclear
- Subagent implements, writes tests, verifies, commits, and self-reviews
- Subagent reports: what was implemented, test results, files changed, concerns

**2. Spec compliance review**

Dispatch a reviewer subagent (generalPurpose, readonly) to verify the implementation matches the spec — nothing missing, nothing extra:
- Provide the FULL TEXT of the task requirements
- Provide the implementer's report
- Reviewer MUST read actual code, not trust the report
- Result: ✅ Spec compliant or ❌ Issues found (with file:line references)

If issues found: resume the implementer subagent to fix, then re-review. Repeat until ✅.

**3. Code quality review**

Only after spec compliance passes. Dispatch a code-reviewer subagent:
- Provide what was implemented and the commit range (base SHA → head SHA)
- Result: Strengths, Issues (Critical/Important/Minor), Assessment

If issues found: resume the implementer subagent to fix, then re-review. Repeat until approved.

**4. Mark task complete** in TodoWrite and move to next task.

### Step B4: Final Review
After all tasks complete, dispatch a final code-reviewer subagent across the entire implementation.

### Prompt Templates (Mode B)

- `./implementer-prompt.md` — Template for dispatching implementer subagents
- `./spec-reviewer-prompt.md` — Template for spec compliance reviewer subagents
- `./code-quality-reviewer-prompt.md` — Template for code quality reviewer subagents

### Subagent Rules

- Never dispatch multiple implementation subagents in parallel (conflicts)
- Answer subagent questions clearly and completely before letting them proceed
- Spec compliance review MUST pass before code quality review
- Don't skip review loops — if reviewer found issues, implementer fixes, reviewer re-reviews
- Don't let implementer self-review replace actual review (both are needed)
- Don't accept "close enough" on spec compliance

## Step 5: Complete Development (both modes)

After all tasks complete and verified:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use finishing-a-development-branch
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker mid-task (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Mode A: between batches, just report and wait
- Mode B: don't skip review stages, don't rush subagents
- Stop when blocked, don't guess
- Never start implementation on main/master branch without explicit user consent

## Integration

**Required workflow skills:**
- **using-git-worktrees** - REQUIRED: Set up isolated workspace before starting
- **writing-plans** - Creates the plan this skill executes
- **finishing-a-development-branch** - Complete development after all tasks
- **requesting-code-review** - Code review template for reviewer subagents (Mode B)
