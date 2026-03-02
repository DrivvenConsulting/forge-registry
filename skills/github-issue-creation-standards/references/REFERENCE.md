## GitHub issue creation – CLI helper

This skill defines the standard issue structure (title, five body sections, labels, metadata) for DrivvenConsulting project 6. You can create issues that follow this standard using the GitHub CLI.

### Helper script

- `scripts/gh-issue-create.sh`
  - Uses `gh issue create` with:
    - Title from `TITLE`
    - Repository from `OWNER` and `REPO`
    - Milestone set to `MVP`
    - Assignee set to `JnsFerreira`
    - Optional implementation label (backend, frontend, data-engineering, devops, internal, quality-assurance)
    - Body from `assets/issue-template.md`, with a metadata note appended

Example:

```bash
OWNER=DrivvenConsulting \
REPO=adlyze \
TITLE="Implement Cognito login flow" \
LABEL="backend" \
ISSUE_TYPE="Task" \
./scripts/gh-issue-create.sh
```

### Core GitHub CLI commands

- `gh issue create --repo OWNER/REPO --title "Title" --body-file issue.md --label backend --milestone MVP --assignee JnsFerreira`
- `gh issue view <number> --repo OWNER/REPO`

### Official documentation

- GitHub CLI manual: `https://cli.github.com/manual/`
- `gh issue create`: `https://cli.github.com/manual/gh_issue_create`
- GitHub issue features: `https://docs.github.com/issues`

