# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**CRITICAL**

- Always update CLAUDE.md and README.md When changing a feature that requires major work or essential changes to the content of the document. Ignore minor changes.
- Never create branches or make commits autonomously - always ask the user to do it manually
- Avoid unfounded assumptions - verify critical details
  - Don't guess file paths - use Glob/Grep to find them
  - Don't guess API contracts or function signatures - read the actual code
  - Reasonable inference based on patterns is OK
  - When truly uncertain about important decisions, ask the user

**IMPORTANT**

- If Claude repeats the same mistake, add an explicit ban to CLAUDE.md
  - Leveraging the Failure-Driven Documentation Pattern
- Proactively leverage frontmatter-based auto-triggering for skills and agents
  - Use .claude/skills/ for general principles (coding standards, work methodologies, ...)
  - Use .claude/agents/ for specialized expert domains (architecture, optimization, ...)
- Always gather context before starting work
  - Read related files first (don't work blind)
  - Check existing patterns in codebase
  - Review project conventions (naming, structure, etc.)
  - Reference .claude/skills/work-execution-principles for detailed guidance
- Always assess issue size and scope accurately - avoid over-engineering simple tasks
  - Apply to both implementation and documentation
  - Verbose documentation causes review burden for humans
