---
name: github-actions-lint-python
description: Add or update a GitHub Actions job that lints and tests a Python project with ruff and pytest. Use when creating or changing CI workflows that include lint and test steps for Python.
---

# Skill: GitHub Actions – Lint and test (Python)

Add a CI job that lints and runs tests for a Python project using ruff and pytest.

## When to use

- You are adding or changing a CI/CD workflow that includes a lint and test job for Python.
- You need a job that runs before Terraform or deploy jobs (other jobs use `needs: lint`).
- You are reviewing or documenting how lint and test should run in GitHub Actions.

## Steps

1. **Checkout** – Use `actions/checkout@v4` (or current major).
2. **Set up Python** – Use `actions/setup-python@v5` with the project’s Python version (e.g. `"3.12"`). Do not hardcode a version that conflicts with the project; prefer reading from `.python-version` or project standards.
3. **Install dependencies** – Upgrade pip and install from `requirements.txt`:
   - `python -m pip install --upgrade pip`
   - `pip install -r requirements.txt`
4. **Run linter** – Run ruff on source and tests: `ruff check src tests` (adjust paths to match the repo: e.g. `src`, `tests`, or `app`).
5. **Run tests** – Run pytest with `PYTHONPATH` set so imports resolve: `PYTHONPATH: src` (or the project’s top-level package path), then `pytest tests -v`.

## Job placement

- Name the job `lint` (or similar) so other jobs can depend on it with `needs: lint`.
- Run this job first so Terraform and deploy jobs run only after lint and tests pass.

## Do

- Use the project’s Python version and directory layout (e.g. `src`/`tests`).
- Set `PYTHONPATH` for pytest to the directory that contains the application package.
- Keep the job free of secrets; use only public checkout and dependency install.

## Do not

- Hardcode secrets or environment-specific URLs in the workflow.
- Skip the linter or tests on pull requests when the pipeline runs on PRs.

## Example job (reference)

```yaml
lint:
  name: Lint and test
  runs-on: ubuntu-latest
  steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Set up Python
      uses: actions/setup-python@v5
      with:
        python-version: "3.12"

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt

    - name: Run linter
      run: ruff check src tests

    - name: Run tests
      env:
        PYTHONPATH: src
      run: pytest tests -v
```

## Related rules

- `ci-cd-github-actions`: CI on PRs, no hardcoded secrets or env-specific paths.
- `code-quality-python`: pytest, tests in `tests/` mirroring source.
