# Learning Log

## 2026-06-27 — Standardized AI Portfolio Publishing

### Goal

Make every public AI project explain what was built, how it supported operations,
and what design decisions I owned—without exposing customer data, operational
records, credentials, local paths, or personal commit email addresses.

### What Changed

1. Created `dmed05/ai-project-template` as the reusable starting point for new
   portfolio projects.
2. Added a README structure requiring:
   - the operational problem;
   - what I built;
   - operational impact;
   - my role and design decisions;
   - privacy boundaries; and
   - tested validation instructions.
3. Added `scripts/portfolio-check.sh` to validate README structure, synthetic or
   private-data boundaries, known private emails, local filesystem paths,
   credential-shaped values, high-risk data directories, unresolved template
   markers, and GitHub `noreply` commit authorship.
4. Added a GitHub Actions workflow that runs the same policy on pull requests
   and pushes to `main`.
5. Added active repository rulesets requiring `portfolio-policy` to pass and
   blocking force-pushes to `main`.
6. Installed and verified the policy in:
   - `sales-commission-core`;
   - `icm-concept`;
   - `local-first-agent-workflow`;
   - `ai-workflow-builder`; and
   - `ai-inspection-report-demo`.
7. Set the local global Git author email to
   `75545911+dmed05@users.noreply.github.com` for future commits made on this
   computer.
8. Added `scripts/create-ai-project.sh` so a new repository can be created from
   the template, protected with the ruleset, cloned, and configured with the
   `noreply` email in one workflow.

### How The Protection Works

```text
create from template
        ↓
replace project placeholders
        ↓
commit on a branch with noreply email
        ↓
open pull request
        ↓
portfolio-policy checks content and privacy boundaries
        ↓
ruleset allows merge only after the check passes
        ↓
main remains portfolio-ready
```

### What This Does Not Guarantee

- Pattern checks cannot prove that every sentence is safe or accurate.
- A human must still review staged files, claims, examples, and Git history.
- Existing older commits that already exposed personal email addresses were not
  rewritten.
- GitHub account email-privacy settings still need to be enabled manually.
- Creating a repository through GitHub's template button copies files but not
  repository rulesets; use `scripts/create-ai-project.sh` for the complete setup.

### Result

The portfolio now has a repeatable publishing standard instead of relying on a
manual README and privacy review for every project. Automation catches common
mistakes, while human review remains responsible for truthfulness and safe
publication.
