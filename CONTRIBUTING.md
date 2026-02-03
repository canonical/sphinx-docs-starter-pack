# Contributing to the starter pack

The starter pack provides a shared foundation for Sphinx-based documentation across multiple Canonical projects. The work done here benefits every team that uses it. While most of the work is done by the Documentation Practice team, this in no way limits the external contributions.

Common contributions include:

- Bug fixes: Build errors, broken links, configuration issues
- Documentation: Guides for starter pack features, syntax references, troubleshooting, ad-hoc how-to guides
- Improvements: Better defaults, new extensions, workflow enhancements, CI/CD, style rules
- Dependency updates: Security patches, compatibility fixes, better tooling

If you use the starter pack and encounter an issue or see room for improvement, you're in the best position to contribute a fix.

## Review the project expectations

Review these three documents before contributing:

### Ubuntu Code of Conduct

When contributing, you must abide by the [Ubuntu Code of Conduct](https://ubuntu.com/community/ethos/code-of-conduct). Projects governed by Canonical expect good conduct and excellence from every member.

### Canonical Contributor License Agreement

Please read and sign our [Contributor License Agreement (CLA)](https://ubuntu.com/legal/contributors) before submitting any changes. The agreement grants Canonical permission to use your contributions. The author of a change remains the copyright owner of their code (no copyright assignment occurs).

Before committing anything, review the terms of the agreement. If you agree and sign it, your work can be incorporated into the repository.

#### CLA check in CI

When you open a pull request (PR) against the `main` branch, an automated check verifies that you have signed the CLA. This check uses the [canonical/has-signed-canonical-cla](https://github.com/canonical/has-signed-canonical-cla) GitHub Action.

If you haven't signed the CLA:
1. The check will fail with a message indicating the CLA requirement
2. Visit <https://ubuntu.com/legal/contributors> to review and sign the agreement
3. Once signed, re-run the failed check or push a new commit to trigger re-evaluation

The CLA check only runs on PRs to `main`. Internal team members working on other branches should ensure they have signed the CLA before their changes are merged to `main`.

### Open source license

The starter pack is licensed under [GPL-3.0](LICENSE). Documentation for this project is licensed under CC-BY-SA 3.0.

## Report an issue or open a request

If you find a bug or feature gap in the starter pack, look for it in the [project's GitHub issues](https://github.com/canonical/sphinx-docs-starter-pack/issues) first. If you have fresh input, add your voice to share new findings.

If the bug or feature doesn't have an issue, [open one](https://github.com/canonical/sphinx-docs-starter-pack/issues/new/choose).

## What belongs in the starter pack

The starter pack is designed to be a minimal, flexible foundation for diverse documentation projects.

**Belongs in the starter pack:**
- Fixes bugs in core functionality
- Improves the default configuration in ways that benefit all users
- Adds documentation about existing features
- Updates dependencies for security or compatibility

**May not belong in the starter pack:**
- Enables optional tooling or features by default (these should be opt-in)
- Adds opinionated formatting or linting rules
- Makes changes that conflict with existing workflows
- Introduces features that are project-specific rather than general-purpose
- UI-related changes may be better suited for the ongoing alternative theme update project (ask maintainers)

When in doubt, open an issue first to discuss whether the change aligns with the project's goals.

## Development setup

Create a [personal fork](https://github.com/canonical/sphinx-docs-starter-pack/fork) of the repository, then clone it and add the upstream remote:

With [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account):

```bash
git clone git@github.com:<username>/sphinx-docs-starter-pack
cd sphinx-docs-starter-pack
git remote add upstream git@github.com:canonical/sphinx-docs-starter-pack
git fetch upstream
```

With [HTTPS](https://docs.github.com/en/get-started/git-basics/about-remote-repositories#cloning-with-https-urls):

```bash
git clone https://github.com/<username>/sphinx-docs-starter-pack
cd sphinx-docs-starter-pack
git remote add upstream https://github.com/canonical/sphinx-docs-starter-pack
git fetch upstream
```

Install dependencies and verify the build:

```bash
cd docs
make install
make html
```

## Contribute a change

### Research the topic

All significant work should be tied to an existing issue. Before starting, comment on the issue to have it assigned to you.

#### Minor changes

Check [GitHub issues](https://github.com/canonical/sphinx-docs-starter-pack/issues) for existing reports. If none exists, [open one](https://github.com/canonical/sphinx-docs-starter-pack/issues/new/choose) and indicate you'd like to work on it.

#### Major changes

Describe your proposal in the issue thread, including the plan, tests, and documentation. For new documentation pages, propose a [Diataxis](https://diataxis.fr) category.

### Create a development branch

Sync and create a new branch:

```bash
git fetch upstream
git checkout -b <new-branch-name> upstream/dev
```

Name your branch `<ticket-id>-<description>` (e.g., `issue-235-add-string-sanitizer`), keeping it under 80 characters.

The upstream `dev` branch is for unreleased changes or work-in-progress features. You'll likely want to target this branch.

The upstream `main` branch is for changes that are ready for the next release. This is usually done by maintainers only

### Make your changes

Follow these guidelines:

- Use separate commits for each logical change, and for changes to different components
- Prefix your commit messages with names of components they affect, using the file hierarchy structure
- Keep the starter pack minimal by default; optional features should be opt-in
- Ensure your changes work in both light and dark themes where applicable

### Commit a change

```bash
git add <files>
git commit
```

Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format:

```
feat: add text sanitizer
```

To determine the commit type, check the file history with `git log --oneline <filename>`.

> Tip
>
> If you're unsure which type to use, the commit may be doing too much, so split it into smaller commits instead. Select the highest-ranked type that fits:
>
> - ci
> - build
> - feat
> - fix
> - perf
> - refactor
> - style
> - test
> - docs
> - chore

### Sign your commits

All commits require cryptographic signatures ([DCO 1.1](https://developercertificate.org/)):

```bash
git commit -S -m "docs: updated configuration guide"
```

Signed commits display a "Verified" badge in GitHub. Set up signing via [GitHub Docs - About commit signature verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification).

> Tip
>
> You can configure your Git client to sign commits by default for any local repository by running `git config --global commit.gpgsign true`. Once you have done this, you no longer need to add `-S` to your commits explicitly.
>
> See [GitHub Docs - Signing commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits) for more information.

If you've made an unsigned commit and encounter the "Commits must have verified signatures" error when pushing your changes to the remote:

1. Amend the most recent commit by signing it without changing the commit message, and push again:

   ```bash
   git commit --amend --no-edit -n -S
   git push
   ```

2. If you still encounter the same error, confirm that your GitHub account has been set up properly to sign commits as described in the [GitHub Docs - About commit signature verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification).

   > Tip
   >
   > If you use SSH keys to sign your commits, make sure to add a "Signing Key" type in your GitHub account. See [GitHub Docs - Adding a new SSH key to your account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) for more information.

### Test the change

Build and run the checks locally before submitting:

```bash
cd docs
make html
```

```bash
make spelling      # Check spelling
make linkcheck     # Validate links
make woke          # Check inclusive language
make lint-md       # Check Markdown style
make vale          # Check style guide compliance (optional)
```

Preview locally with live reload at `http://127.0.0.1:8000`:

```bash
make run
```

### Document the change

This documentation uses [Diataxis](https://diataxis.fr). For small changes, update existing how-to guides and references. For major changes or new flows, create new pages in the appropriate category.

Run the same basic checks locally that GitHub runs on PRs; see [Test the change](#test-the-change).

#### Changelog guidance

Doc-only changes generally do not require changelog entries. However, reviewers may request one for notable additions such as significant new how-to guides or reference documentation.

For non-documentation changes, ensure that feature changes and fixes are documented in the relevant release notes.

### Push the branch and open a PR

```bash
git push -u origin <branch-name>
```

Next, open a PR on GitHub. Format its title as a conventional commit (GitHub may do this automatically for single-commit branches).

### Describing PRs

Your PR should include the following details:

- Title: Short, descriptive summary
- Description: Problem solved, features added, or bugs fixed
- Relevant issues: [Link related issues and PRs](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/autolinked-references-and-urls)
- Testing: How reviewers can verify the change or test the fix
- Reversibility: For costly-to-reverse decisions, explain reasoning and reversal steps

Make sure to peek at the preview for documentation changes (find the `Read the Docs build` check and click `...` - `View details`). If your PR adds or changes specific documentation pages, include links to the preview pages in the PR description.

## CI/CD pipeline

The repository configures multiple automated checks. Some are conditional based on target branch or changed files.

Workflows marked "callable" below support `workflow_call`; those marked "manual dispatch" support `workflow_dispatch` via the GitHub UI.

If a check fails, review the logs for remediation guidance. For failures unrelated to your changes, rebase against the latest base branch.

### Checks on all PRs

These run on every PR and on pushes to `main`:

- Documentation build: Builds the documentation and checks for errors
- Spelling check: Verifies spelling using Vale
- Link check: Validates all links in the documentation
- Inclusive language check: Runs woke to check for non-inclusive language
- Python dependency build: Verifies dependencies can be built from source (callable, manual dispatch)

### Checks on PRs to `main` only

- CLA check: Verifies you have signed the Canonical Contributor License Agreement
- Removed URLs check: Detects if any URLs were removed without redirects (callable)

### Checks on changes to `docs/` only

- Markdown style check: Runs `pymarkdownlnt` on Markdown files (callable)
- Automatic documentation checks: Runs upstream documentation workflow checks (manual dispatch).
  The project uses [canonical/documentation-workflows](https://github.com/canonical/documentation-workflows) for automatic documentation checks. To modify this part of CI behavior, pass inputs to upstream workflows rather than creating or customizing local copies.

### Optional checks (allowed to fail)

- Style guide check (`vale`): Checks compliance with the Canonical style guide
- Accessibility check (`pa11y`): Checks accessibility of generated HTML

## Review process

PRs are typically reviewed within a week. Reviewers may request:

- Wording, terminology, or formatting changes
- Consistency with existing documentation patterns
- Proper reST or MyST markup style
- Minimal examples before listing options

### Responding to feedback

Push additional commits to address feedback (commit locally rather than via GitHub UI to avoid sync conflicts).

#### Using fixup commits

Use fixup commits to address feedback while keeping review history visible:

```bash
# Create a fixup commit targeting a specific commit
git commit --fixup <hash-of-commit-being-fixed>
```

This keeps updates granular and traceable.

Before merge (after final approval), squash the fixup commits:

```bash
git rebase -i --autosquash upstream/main
git push --force-with-lease
```

Don't force-push after approval; this obscures what exactly changed.

### Common feedback themes

- Terminology: Align naming with existing documentation and code
- Cross-references: Use proper reST or MyST syntax
- Examples: Start minimal, then show options; include verification steps
- Theme compatibility: Test in both light and dark modes

## Release process

<!-- TODO: Document release cadence, version numbering, changelog requirements, and the release workflow. This section will cover how releases are prepared and published. -->

## Branch management policy

<!-- TODO: Document the branching strategy, including the relationship between main and dev branches, when to target each branch, and how changes flow between branches. -->
