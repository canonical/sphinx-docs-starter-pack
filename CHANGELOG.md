# sphinx-docs-starter-pack changelog

## 1.3.0

* !!!BREAKING: Updated deps to use atomic extensions, not `canonical-sphinx[full]`. Updated `sphinx-terminal` uses backwards incompatible syntax
* Changed `html_baseurl` for better canonical URL support
* Changes metrics script to a less brittle Python script
* Introduce guidelines for adding diagrams-as-code
* Introduce guidelines for rendering CSV data as tables
* Introduce guidelines for pulling in docstrings using Sphinx `autodoc` extension
* Introduce guidelines for using custom base templates
* Dropped unused makefile variable `ALLFILES`
* Fix syntax error in Makefile that caused the fallback target to loop
  infinitely.
* Add a step to the tutorial about removing `CODEOWNERS`.

### Added

* `docs/.sphinx/metrics/build_metrics.py` [#373](https://github.com/canonical/sphinx-docs-starter-pack/pull/373)

## Changed

* `docs/Makefile` [#373](https://github.com/canonical/sphinx-docs-starter-pack/pull/373), [#456](https://github.com/canonical/sphinx-docs-starter-pack/pull/456)
* `docs/requirements.txt` [#449](https://github.com/canonical/sphinx-docs-starter-pack/pull/449), [#456](https://github.com/canonical/sphinx-docs-starter-pack/pull/456), [#460](https://github.com/canonical/sphinx-docs-starter-pack/pull/460)
* `docs/conf.py` [#429](https://github.com/canonical/sphinx-docs-starter-pack/pull/429), [#449](https://github.com/canonical/sphinx-docs-starter-pack/pull/449), [#442](https://github.com/canonical/sphinx-docs-starter-pack/pull/442), [#460](https://github.com/canonical/sphinx-docs-starter-pack/pull/460) [#462](https://github.com/canonical/sphinx-docs-starter-pack/pull/462)
* `docs/.sphinx/get_vale_conf.py` [#448](https://github.com/canonical/sphinx-docs-starter-pack/pull/448)
* `docs/.sphinx/update_sp.py` [#425](https://github.com/canonical/sphinx-docs-starter-pack/pull/425)
* `docs/.sphinx/metrics/build_metrics.py` [#448](https://github.com/canonical/sphinx-docs-starter-pack/pull/448)
* `.github/workflows/check-removed-urls.yml` [#437](https://github.com/canonical/sphinx-docs-starter-pack/pull/437), [#445](https://github.com/canonical/sphinx-docs-starter-pack/pull/445)
* `.github/workflows/markdown-style-checks.yml` [#445](https://github.com/canonical/sphinx-docs-starter-pack/pull/445)
* `.github/workflows/sphinx-python-dependency-build-checks.yml` [#445](https://github.com/canonical/sphinx-docs-starter-pack/pull/445)
* `.github/workflows/test-starter-pack.yml` [#445](https://github.com/canonical/sphinx-docs-starter-pack/pull/445)
* `docs/Makefile` [#461](https://github.com/canonical/sphinx-docs-starter-pack/pull/461)

### Removed

* `docs/.sphinx/metrics/build_metrics.sh` [#373](https://github.com/canonical/sphinx-docs-starter-pack/pull/373)

## 1.2.0

* Replaces spelling check with Vale.
* Fixes the Markdown linting GitHub action and adds a `make lint-md` check.
* Fixes the download branch name in the update script.
* Adds a check for removed URLs.

### Added

* `docs/.sphinx/.pymarkdown.json` [#379](https://github.com/canonical/sphinx-docs-starter-pack/pull/379)
* `.github/workflows/check-removed-urls.yml` [#410](https://github.com/canonical/sphinx-docs-starter-pack/pull/410)

### Changed

* `docs/.sphinx/update_sp.py` [#397](https://github.com/canonical/sphinx-docs-starter-pack/pull/397) [#410](https://github.com/canonical/sphinx-docs-starter-pack/pull/410)
* `.github/workflows/markdown-style-checks.yml` [#379](https://github.com/canonical/sphinx-docs-starter-pack/pull/379)
* `docs/Makefile` [#379](https://github.com/canonical/sphinx-docs-starter-pack/pull/379) [#410](https://github.com/canonical/sphinx-docs-starter-pack/pull/410)
* `docs/requirements.txt` [#410](https://github.com/canonical/sphinx-docs-starter-pack/pull/410)
* `docs/.sphinx/get_vale_conf.py` [#410](https://github.com/canonical/sphinx-docs-starter-pack/pull/410)

### Removed

* `docs/.sphinx/.markdownlint.json` [#379](https://github.com/canonical/sphinx-docs-starter-pack/pull/379)
* `docs/.sphinx/.wordlist.txt` [#410](https://github.com/canonical/sphinx-docs-starter-pack/pull/410)
* `docs/.sphinx/spellingcheck.yaml` [#410](https://github.com/canonical/sphinx-docs-starter-pack/pull/410)


## 1.1.0

* Adds sitemap support.
* Simplifies vale binary download & install.
* Leaves vale install output in STDOUT to reveal potential problems.
* Improves update logic.
* Update Makefile logic

### Changed

* `docs/conf.py` [#389](https://github.com/canonical/sphinx-docs-starter-pack/pull/389)
* `docs/requirements.txt`(https://github.com/canonical/sphinx-docs-starter-pack/pull/389)

## 1.0.1

Fixes an issue with Vale implementation, and adds words to main wordlist.

### Changed

* `docs/Makefile` [852c19b](https://github.com/canonical/sphinx-docs-starter-pack/commit/852c19bf162e4697d7f36b49e8bc36ad71302216)
* `docs/.sphinx/.wordlist.txt` [#367](https://github.com/canonical/sphinx-docs-starter-pack/pull/367)
* `docs/.sphinx/get_vale_conf.py` [#358](https://github.com/canonical/sphinx-docs-starter-pack/pull/358)

## 1.0.0

First versioned release. Adds an update command to better facilitate updates to
starter pack based documentation sets.

### Added

* `CHANGELOG.md` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `.github/pull_request_template.md` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `docs/.sphinx/version` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `docs/.sphinx/update_sp.py` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)

### Changed

* `.readthedocs.yaml` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `.github/workflows/sphinx-python-dependency-build-checks.yml` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `docs/.sphinx/.markdownlint.json` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `docs/Makefile` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `docs/conf.py` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)
* `docs/requirements.txt` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)

### Removed

* `.wokeignore` [#363](https://github.com/canonical/sphinx-docs-starter-pack/pull/363)
* `docs/.sphinx/_static/project_specific.css` [#357](https://github.com/canonical/sphinx-docs-starter-pack/pull/357)

## pre-version

This version is the initial versioned release, supporting the implementation of
updates.

### Added

* All files

## VERSION

{Summary of features}

### Added

* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}
* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}
* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}

### Changed

* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}
* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}
* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}

### Removed

* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}
* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}
* {File} {[Commit number](https://www.github.com) or [PR](https://www.github.com)}
