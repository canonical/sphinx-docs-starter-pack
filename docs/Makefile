# Minimal makefile for Sphinx documentation
#
# Add your customisation to `Makefile` instead.

# You can set these variables from the command line, and also
# from the environment for the first two.

DEV_DIR          ?= _dev
SPHINX_OPTS      ?= -c . -d $(DEV_DIR)/.doctrees -j auto
SPHINX_BUILD     ?= $(DOCS_VENVDIR)/bin/sphinx-build
SPHINX_HOST      ?= 127.0.0.1
SPHINX_PORT      ?= 8000
SPHINX_AUTOBUILD_OPTS ?= -D llms_txt_enabled=0
DOCS_VENVDIR     ?= .venv
DOCS_VENV        ?= $(DOCS_VENVDIR)/bin/activate
DOCS_SOURCEDIR   ?= .
DOCS_BUILDDIR    ?= _build
DOCS_PDFPACKAGES ?= latexmk fonts-freefont-otf texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng
DOCS_VOCAB       ?= $(DEV_DIR)/styles/config/vocabularies/Canonical
VALE_DIR         ?= $(DOCS_VENVDIR)/lib/python*/site-packages/vale
VALE_CONFIG      ?= $(DEV_DIR)/vale.ini
CHECK_PATH       ?= $(filter-out $(DOCS_VENVDIR) $(DOCS_BUILDDIR) $(DEV_DIR),$(wildcard *))

# ============================================================
# CLI setup

.DEFAULT_GOAL := help

# ------------------------------------------------------------
#  Arguments

override NUM_ARGS     := $(words $(MAKECMDGOALS))
override CLI_CMD      := $(word 1,$(MAKECMDGOALS))
# Separate positional args from flags (flags passed after --)
override ALL_ARGS     := $(wordlist 2,$(NUM_ARGS),$(MAKECMDGOALS))
override PATH_FLAG    := $(filter --path,$(ALL_ARGS))
override HELP_FLAG    := $(filter --help,$(ALL_ARGS))
override VERBOSE_FLAG := $(filter --verbose,$(ALL_ARGS))
override CLEAN_FLAG   := $(filter --clean,$(ALL_ARGS))
override REFRESH_FLAG := $(filter --refresh,$(ALL_ARGS))

# Returns all words after the first occurrence of $(1) in $(2)
define words-after
$(if $(filter $(1),$(firstword $(2))),\
    $(wordlist 2,$(words $(2)),$(2)),\
    $(call words-after,$(1),$(wordlist 2,$(words $(2)),$(2))))
endef

# Extract the value following --path in ALL_ARGS (e.g. "make build -- --path /out")
PATH_VALUE := $(if $(PATH_FLAG),$(firstword $(call words-after,--path,$(ALL_ARGS))),)

# Strip flags, --, and the --path value from positional args
override POS_ARGS := $(filter-out -- --%,$(filter-out $(PATH_VALUE),$(ALL_ARGS)))
override CLI_ARG1 := $(word 1,$(POS_ARGS))

# ------------------------------------------------------------
#  Aliases

override VALID_ALIASES_BUILD := run auto serve server
override VALID_ALIASES_CHECK := lint
override VALID_ALIASES_SETUP := install
override VALID_ALIASES := $(VALID_ALIASES_BUILD) $(VALID_ALIASES_CHECK) $(VALID_ALIASES_SETUP)

# Resolve aliases to primary command (used by help target)
override RESOLVE_ARG1 := $(CLI_ARG1)
ifneq ($(filter $(CLI_ARG1),$(VALID_ALIASES_BUILD)),)
  override RESOLVE_ARG1 := build
else ifneq ($(filter $(CLI_ARG1),$(VALID_ALIASES_CHECK)),)
  override RESOLVE_ARG1 := check
else ifneq ($(filter $(CLI_ARG1),$(VALID_ALIASES_SETUP)),)
  override RESOLVE_ARG1 := setup
endif

# ------------------------------------------------------------
#  Validate command and options

override VALID_CMD := build check clean help setup remove update
override VALID_OPTS_GLOBAL := --verbose --help

# Command-specific options
override VALID_OPTS_BUILD := html pdf --clean --path
override VALID_OPTS_CHECK := style markdown links accessibility
override VALID_OPTS_SETUP := --refresh
override VALID_OPTS_HELP := $(VALID_CMD) $(VALID_ALIASES)

# ............................................................
#  Validation block, when MAKELEVEL is 0

ifeq ($(MAKELEVEL),0)

override INVALID_CMD := 0
ifeq ($(CLI_CMD),)
  # No command — default goal will handle it
else ifneq ($(filter _%,$(CLI_CMD)),)
  override INVALID_CMD := 1
else ifeq ($(filter $(CLI_CMD),$(VALID_CMD) $(VALID_ALIASES)),)
  override INVALID_CMD := 1
endif
ifeq ($(INVALID_CMD),1)
$(error Invalid command: '$(CLI_CMD)'. Run 'make help' for valid commands)
endif

ifneq ($(CLI_ARG1),)
  ifneq ($(filter $(CLI_CMD),build $(VALID_ALIASES_BUILD)),)
    override VALID_FOR_ARG1 := $(VALID_OPTS_GLOBAL) $(VALID_OPTS_BUILD)
  else ifneq ($(filter $(CLI_CMD),check $(VALID_ALIASES_CHECK)),)
    override VALID_FOR_ARG1 := $(VALID_OPTS_GLOBAL) $(VALID_OPTS_CHECK)
  else ifneq ($(filter $(CLI_CMD),setup $(VALID_ALIASES_SETUP)),)
    override VALID_FOR_ARG1 := $(VALID_OPTS_GLOBAL) $(VALID_OPTS_SETUP)
  else ifneq ($(filter $(CLI_CMD),help),)
    override VALID_FOR_ARG1 := $(VALID_OPTS_GLOBAL) $(VALID_OPTS_HELP)
  else
    override VALID_FOR_ARG1 := $(VALID_OPTS_GLOBAL)
  endif
  ifeq ($(filter $(CLI_ARG1),$(VALID_FOR_ARG1)),)
    $(error Invalid option '$(CLI_ARG1)' for command '$(CLI_CMD)'. Run 'make help$(if $(filter $(CLI_CMD),help),, $(CLI_CMD))' for valid options)
  endif
endif

endif # End of MAKELEVEL validation block

# ============================================================
# CLI help messages

define HELP_GLOBAL
Usage:
    make <command> [<option>...]

These docs are managed with 'make'. Use it for different actions in the docs,
including setup, rendering, and checking for problems.

Run 'make help <command>' to view a command's usage.

Main commands:
             build  Render the docs
             check  Check for problems in the documentation
             clean  Remove built docs and temporary files
              help  View help for the commands

Setup commands:
             setup  Set up the docs environment
            update  Update the docs base
            remove  Remove the docs environment

Global options:
         --verbose  Show more commands in the terminal
            --help  Show this help
endef
export HELP_GLOBAL

define HELP_BUILD
Usage:
    make build <mode> -- [<option>...]

Render the docs. Three output types are available:

- 'run' (default) hosts the docs in a local server you can view in the web
  browser. When you save a change to a source file, the server updates the
  doc in real time.
- 'html' renders the docs as a static set of HTML pages
- 'pdf' renders the docs as a PDF file

Positional arguments:
              mode  Output type, either 'run' (default), 'html', or 'pdf'

Options:
           --clean  Clean the built docs and temporary files before building
            --path  Destination path for PDF builds

Global options:
         --verbose  Show more commands in the terminal
            --help  Show this help
endef
export HELP_BUILD

define HELP_CHECK
Usage:
    make check <type> -- [<option>...]

Check for problems in the documentation. Several checks are available:

- 'style' checks for spelling and style concerns
- 'markdown' looks for Markdown formatting issues
- 'links' checks for valid external hyperlinks
- 'accessibility' checks for web accessibility concerns

Positional arguments:
              type  The check to run, either 'all' (default), 'style',
                    'markdown', 'links', or 'accessibility'

Global options:
         --verbose  Show more commands in the terminal
            --help  Show this help
endef
export HELP_CHECK

define HELP_CLEAN
Usage:
    make clean -- [<option>...]

Remove all built docs and temporary files. Sometimes, stale files can cause
build failures, and the only solution is to clear the previous builds.

Global options:
         --verbose  Show more commands in the terminal
            --help  Show this help
endef
export HELP_CLEAN

define HELP_SETUP
Usage:
    make setup -- [<option>...]

Set up the docs environment.

Options:
         --refresh  Completely remove the old environment first

Global options:
         --verbose  Show more commands in the terminal
            --help  Show this help
endef
export HELP_SETUP

define HELP_REMOVE
Usage:
    make remove -- [<option>...]

Remove the docs environment.

Global options:
         --verbose  Show more commands in the terminal
            --help  Show this help
endef
export HELP_REMOVE

define HELP_UPDATE
Usage:
    make update -- [<option>...]

Update the docs base. The foundation of the docs comes from Canonical's
Starter Pack. This command syncs with that project, pulling in new file
structure, requirements, and templates.

Global options:
         --verbose  Show more commands in the terminal
            --help  Show this help
endef
export HELP_UPDATE

# ============================================================
# Public CLI targets

.PHONY: build run auto serve server check lint setup install clean help remove update

build run auto serve server:
	@if [ "$@" = "$(CLI_CMD)" ]; then \
		$(MAKE) --no-print-directory VERBOSE=$(if $(VERBOSE_FLAG),1,) PATH_VALUE="$(PATH_VALUE)" \
			$(if $(CLEAN_FLAG),_cmd_clean,) \
			$(if $(HELP_FLAG),_cmd_help_build,_cmd_build$(if $(CLI_ARG1),_$(CLI_ARG1),)); \
	fi

check lint:
	@if [ "$@" = "$(CLI_CMD)" ]; then \
		$(MAKE) --no-print-directory VERBOSE=$(if $(VERBOSE_FLAG),1,) \
			$(if $(HELP_FLAG),_cmd_help_check,_cmd_check$(if $(CLI_ARG1),_$(CLI_ARG1),)); \
	fi

setup install:
	@if [ "$@" = "$(CLI_CMD)" ]; then \
		$(MAKE) --no-print-directory VERBOSE=$(if $(VERBOSE_FLAG),1,) \
			$(if $(REFRESH_FLAG),_cmd_remove,) \
			$(if $(HELP_FLAG),_cmd_help_setup,_cmd_setup); \
	fi

clean:
	@if [ "$@" = "$(CLI_CMD)" ]; then \
		$(MAKE) --no-print-directory \
			$(if $(HELP_FLAG),_cmd_help_clean,_cmd_clean); \
	fi

help:
	@if [ "$@" = "$(CLI_CMD)" ] || [ -z "$(CLI_CMD)" ]; then \
		$(MAKE) --no-print-directory \
			_cmd_help$(if $(CLI_ARG1),_$(RESOLVE_ARG1),); \
	fi

remove:
	@if [ "$@" = "$(CLI_CMD)" ]; then \
		$(MAKE) --no-print-directory \
			$(if $(HELP_FLAG),_cmd_help_remove,_cmd_remove); \
	fi

update:
	@if [ "$@" = "$(CLI_CMD)" ]; then \
		$(MAKE) --no-print-directory VERBOSE=$(if $(VERBOSE_FLAG),1,) \
			$(if $(HELP_FLAG),_cmd_help_update,_cmd_update); \
	fi

# ============================================================
# CLI targets

# Variables used by targets

# Set QUIET, STDOUT_QUIET based on --verbose flag
# Typically use QUIET; use STDOUT_QUIET only when necessary
QUIET := -q
STDOUT_QUIET := > /dev/null
ifneq ($(VERBOSE),)
  QUIET :=
  STDOUT_QUIET :=
endif

# Values to use when `--path` is passed to `build` series of commands
PATH_STRING := $(DOCS_BUILDDIR)
ifneq ($(PATH_VALUE),)
  PATH_STRING := $(PATH_VALUE)
endif

# build command target group
.PHONY: _cmd_build _cmd_build_html _cmd_build_pdf

# check command target group
.PHONY: _cmd_check _cmd_check_style _cmd_check_markdown _cmd_check_links _cmd_check_accessibility

# standalone commands
.PHONY: _cmd_setup _cmd_clean _cmd_help _cmd_remove _cmd_update

# help target group
.PHONY: _cmd_help_build _cmd_help_check _cmd_help_setup _cmd_help_clean _cmd_help_remove _cmd_help_update

# check command shared targets
.PHONY: _shared_style _shared_markdown _shared_links _shared_accessibility

# build group of targets
_cmd_build: _cmd_setup
	@echo "Building the docs... (local server)"
	@. $(DOCS_VENV); $(DOCS_VENVDIR)/bin/sphinx-autobuild -b dirhtml \
		--host $(SPHINX_HOST) --port $(SPHINX_PORT) \
		"$(DOCS_SOURCEDIR)" "$(DOCS_BUILDDIR)" \
		$(SPHINX_OPTS) $(SPHINX_AUTOBUILD_OPTS) $(QUIET)

_cmd_build_html: _cmd_setup
	@echo "Building the docs... (html)"
	@. $(DOCS_VENV); $(SPHINX_BUILD) --fail-on-warning --keep-going -b dirhtml "$(DOCS_SOURCEDIR)" "$(PATH_STRING)" -w $(DEV_DIR)/warnings.txt $(SPHINX_OPTS) $(QUIET) $(STDOUT_QUIET)

_cmd_build_pdf: _cmd_setup pdf-prep
	@echo "Building the docs... (pdf)"
	@. $(DOCS_VENV); $(SPHINX_BUILD) -M latexpdf "$(DOCS_SOURCEDIR)" "$(PATH_STRING)" $(SPHINX_OPTS) $(QUIET) $(STDOUT_QUIET)
	@rm ./$(PATH_STRING)/latex/front-page-light.pdf || true
	@rm ./$(PATH_STRING)/latex/normal-page-footer.pdf || true
	@find ./$(PATH_STRING)/latex -name "*.pdf" -exec mv -t ./$(PATH_STRING) {} +
	@rm -r $(PATH_STRING)/latex
	@echo
	@echo "Output can be found in ./$(PATH_STRING)"

# check group of targets
_cmd_check: _cmd_build_html _shared_style _shared_markdown _shared_links _shared_accessibility
_cmd_check_style: _cmd_build_html _shared_style
_cmd_check_markdown: _cmd_build_html _shared_markdown
_cmd_check_links: _cmd_build_html _shared_links
_cmd_check_accessibility: _cmd_build_html _shared_accessibility

# standalone targets
_cmd_setup: $(DOCS_VENVDIR)
	@echo "Docs environment ready."

_cmd_clean:
	@echo "Cleaning the docs environment..."
	@git clean -fx "$(DOCS_BUILDDIR)" $(QUIET)
	@rm -rf $(DEV_DIR)/.doctrees
	@echo "Removed built docs and temporary files."

_cmd_remove:
	@echo "Removing the docs environment..."
	@test ! -e "$(DOCS_VENVDIR)" -o -d "$(DOCS_VENVDIR)" -a "$(abspath $(DOCS_VENVDIR))" != "$(DOCS_VENVDIR)"
	@rm -rf $(DOCS_VENVDIR)
	@rm -rf $(DEV_DIR)/node_modules/
	@rm -rf $(DEV_DIR)/styles
	@rm -rf $(VALE_CONFIG)
	@echo "Removed docs environment."

_cmd_update: _cmd_setup
	@echo "Updating docs base..."
	@. $(DOCS_VENV); _dev/update_sp.py

# help targets
_cmd_help:
	@echo "$$HELP_GLOBAL"

_cmd_help_build:
	@echo "$$HELP_BUILD"

_cmd_help_check:
	@echo "$$HELP_CHECK"

_cmd_help_setup:
	@echo "$$HELP_SETUP"

_cmd_help_clean:
	@echo "$$HELP_CLEAN"

_cmd_help_remove:
	@echo "$$HELP_REMOVE"

_cmd_help_update:
	@echo "$$HELP_UPDATE"

# shared targets
_shared_style: vale-install
	@echo Checking style...
	@cat $(DOCS_VOCAB)/accept.txt > $(DOCS_VOCAB)/accept_backup.txt
	@cat $(DOCS_SOURCEDIR)/.custom_wordlist.txt >> $(DOCS_VOCAB)/accept.txt
	@echo "Running Vale against $(CHECK_PATH). To change target set CHECK_PATH= with make command"
	@. $(DOCS_VENV); vale --config="$(VALE_CONFIG)" --filter='$(DEV_DIR)/styles/error.filter' --glob='*.{md,rst}' $(CHECK_PATH)
	@. $(DOCS_VENV); vale --config="$(VALE_CONFIG)" --filter='$(DEV_DIR)/styles/spelling.filter' --glob='*.{md,rst}' $(CHECK_PATH)
	@cat $(DOCS_VOCAB)/accept_backup.txt > $(DOCS_VOCAB)/accept.txt && rm $(DOCS_VOCAB)/accept_backup.txt

_shared_markdown: pymarkdownlnt-install
	@echo Linting Markdown files...
	@. $(DOCS_VENV); pymarkdownlnt \
		--config $(DEV_DIR)/.pymarkdown.json \
		--return-code-scheme explicit \
		scan \
			--recurse \
			--exclude=$(DEV_DIR)/** \
			--exclude=$(DOCS_VENVDIR)/** \
			$(DOCS_SOURCEDIR); \
	status=$$?; \
	if [ $$status -eq 1 ]; then \
		echo "No Markdown files selected for linting"; \
		exit 0; \
	fi; \
	echo "pymarkdownlnt exited with code $$status"; \
	exit $$status;

_shared_links:
	@echo "Checking links..."
	@. $(DOCS_VENV) ; $(SPHINX_BUILD) -b linkcheck $(QUIET)  "$(DOCS_SOURCEDIR)" "$(DOCS_BUILDDIR)" $(SPHINX_OPTS) $(STDOUT_QUIET) || { grep --color -F "[broken]" "$(DOCS_BUILDDIR)/output.txt"; exit 1; }

_shared_accessibility: vale-install
	@echo "Checking accessibility..."
	@cat $(DOCS_VOCAB)/accept.txt > $(DOCS_VOCAB)/accept_backup.txt
	@cat $(DOCS_SOURCEDIR)/.custom_wordlist.txt >> $(DOCS_VOCAB)/accept.txt
	@. $(DOCS_VENV); vale --config="$(VALE_CONFIG)" --filter='$(DEV_DIR)/styles/woke.filter' --glob='*.{md,rst}' $(CHECK_PATH)
	@cat $(DOCS_VOCAB)/accept_backup.txt > $(DOCS_VOCAB)/accept.txt && rm $(DOCS_VOCAB)/accept_backup.txt

# ------------------------------------------------------------
# Set up for various targets

# If requirements are updated, venv should be rebuilt and timestamped.
$(DOCS_VENVDIR):
	@echo "Setting up docs environment..."
	@python3 -m venv $(DOCS_VENVDIR) || { echo "You must install python3-venv before you can build the documentation."; exit 1; }
	@. $(DOCS_VENV); pip install $(PIPOPTS) $(QUIET) --require-virtualenv \
	    --upgrade -r requirements.txt \
            --log $(DOCS_VENVDIR)/pip_install.log
	@test ! -f $(DOCS_VENVDIR)/pip_list.txt || \
            mv $(DOCS_VENVDIR)/pip_list.txt $(DOCS_VENVDIR)/pip_list.txt.bak
	@. $(DOCS_VENV); pip list --local --format=freeze > $(DOCS_VENVDIR)/pip_list.txt
	@touch $(DOCS_VENVDIR)

pdf-prep: _cmd_setup
	@for packageName in $(DOCS_PDFPACKAGES); do (dpkg-query -W -f='$${Status}' $$packageName 2>/dev/null | \
        grep -c "ok installed" >/dev/null && echo "Package $$packageName is installed") $(STDOUT_QUIET) && continue || \
				(echo; echo "Error: PDF generation requires the installation of the following packages: $(DOCS_PDFPACKAGES)") && exit 1; done

pymarkdownlnt-install: _cmd_setup
	@. $(DOCS_VENV); test -d $(DOCS_VENVDIR)/lib/python*/site-packages/pymarkdown || pip install pymarkdownlnt==0.9.35 $(QUIET)

vale-install: _cmd_setup
	@. $(DOCS_VENV); test -f $(VALE_CONFIG) || python3 $(DEV_DIR)/get_vale_conf.py
	@echo '.Name=="Canonical.400-Enforce-inclusive-terms"' > $(DEV_DIR)/styles/woke.filter
	@echo '.Level=="error" and .Name!="Canonical.500-Repeated-words" and .Name!="Canonical.000-US-spellcheck"' > $(DEV_DIR)/styles/error.filter
	@echo '.Name=="Canonical.000-US-spellcheck"' > $(DEV_DIR)/styles/spelling.filter
	@. $(DOCS_VENV); find $(VALE_DIR)/vale_bin -size 195c -exec vale --version \;

# ------------------------------------------------------------
# Catch-all target

%:
	@:
