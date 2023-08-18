# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build
VENV          = .sphinx/venv/bin/activate


# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help


.sphinx/venv:
	@echo "... setting up virtualenv"
	python3 -m venv .sphinx/venv
	. $(VENV); pip install --upgrade -r .sphinx/requirements.txt

	@echo "\n" \
		"--------------------------------------------------------------- \n" \
		"* watch, build and serve the documentation: make run \n" \
                "* only build: make html \n" \
                "* only serve: make serve \n" \
                "* clean built doc files: make clean-doc \n" \
                "* clean full environment: make clean \n" \
                "* check spelling: make spelling \n" \
                "* check inclusive language: make woke \n" \
                "* other possible targets: make <press TAB twice> \n" \
		"--------------------------------------------------------------- \n"


install: .sphinx/venv

.PHONY:  install


run:
	. $(VENV); sphinx-autobuild -c . -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)"

.PHONY: run


html:
	. $(VENV); $(SPHINXBUILD) -c . -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)" -w .sphinx/warnings.txt

.PHONY: html


epub:
	. $(VENV); $(SPHINXBUILD) -c . -b epub "$(SOURCEDIR)" "$(BUILDDIR)" -w .sphinx/warnings.txt

.PHONY: epub


serve:
	cd "$(BUILDDIR)"; python3 -m http.server 8000

.PHONY: serve


clean: clean-doc
	rm -rf .sphinx/venv

.PHONY: clean


clean-doc:
	git clean -fx "$(BUILDDIR)"

.PHONY: clean-doc


spelling: html
	. $(VENV) ; python3 -m pyspelling -c .sphinx/spellingcheck.yaml

.PHONY: spelling


linkcheck:
	. $(VENV) ; $(SPHINXBUILD) -c . -b linkcheck  "$(SOURCEDIR)" "$(BUILDDIR)"

.PHONY: linkcheck


woke:
	type woke >/dev/null 2>&1 || { sudo snap install woke; }
	woke *.rst **/*.rst -c https://github.com/canonical-web-and-design/Inclusive-naming/raw/main/config.yml

.PHONY: woke


# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	. $(VENV); $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: Makefile
