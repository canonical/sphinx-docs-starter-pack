---
myst:
  html_meta:
    description: How to test the Ulwazi theme in a documentation project based on Canonical's Sphinx Starter Pack.
relatedlinks: "[Ulwazi&#32;on&#32;PyPI](https://pypi.org/project/ulwazi), [Vanilla](https://vanillaframework.org), [sphinx-basic-ng](https://github.com/pradyunsg/sphinx-basic-ng)"
---

(how-to-test-ulwazi-theme)=

# Test the Ulwazi theme

Ulwazi is a Sphinx theme built on Vanilla, with the base layout and functionality derived from sphinx-basic-ng.

This guide outlines the steps required to use the Ulwazi theme in your Sphinx documentation project.

## Update the dependencies

In your project's Python requirements, replace the canonical-sphinx package with Ulwazi and its dependencies. The minimum set is:

```{code-block} text
:caption: requirements.txt

sphinx
build
sphinx-autobuild
canonical-sphinx-config @ git+https://github.com/Canonical/canonical-sphinx-config.git@main
myst-parser~=4.0
sphinx-basic-ng
sphinxcontrib-jquery
beautifulsoup4
packaging
sphinxcontrib-svg2pdfconverter[CairoSVG]
sphinx-last-updated-by-git
sphinx-sitemap
ulwazi
```

## Update the configuration

This is the most important and tricky part -- updating the project configuration. A reference `conf.py` with all the required configuration and TODO markers is provided in the Ulwazi repository as [`default-conf.py`](https://github.com/canonical/ulwazi/blob/main/docs/default-conf.py). Copy it as the starting point for a new documentation set, or use it as a checklist when migrating an existing one.

### Set the theme

Tell Sphinx to use Ulwazi as the theme:

```{code-block} python
:caption: conf\.py

html_theme = "ulwazi"
```

### Update the extensions

In the list of extensions, replace canonical-sphinx with Ulwazi, and its dependencies:

```{code-block} diff
:caption: extensions in conf\.py

-"canonical-sphinx~=0.6"
+"ulwazi"
+"sphinx_terminal",
+"canonical_sphinx_config",
+"myst_parser",
+"sphinxcontrib.jquery",
```

If you need PDF output, add `sphinx_modern_pdf_style` to the list.

This is only a partial list. Your project may require additional extensions beyond those listed here.

### Add the required variables

Add and fill the following variables immediately before `html_context = {`:

```python
# TODO: Adjust to point to the repository where your documentation source files
# are stored.

github_repo = <https://github.com/your-org/your-repo>

# TODO: Select the default syntax for docs source files.
# This is for a fallback view/edit source code buttons.

default_source_extension = ".md"

# TODO: Change to your product website URL,
#       dropping the 'https://' prefix, e.g. 'ubuntu.com/lxd'.

product_page = <link-to-product-website>
```

If your project is written in reST, set `default_source_extension` to `".rst"`.

### Update the HTML context

You need to make several updates to the `html_context` dictionary.
For an example of all the changes, see the [Charmed Apache Kafka Ulwazi PR](https://github.com/canonical/kafka-operator/pull/444/files#diff-85933aa74a2d66c3e4dcdf7a9ad8397f5a7971080d34ef1108296a7c6b69e7e3).

The code snippets in this section might not match the exact layout of `html_context` in your `conf.py`.

Add these new variables, including the top-level variables you declared earlier:

```{code-block} python
:caption: html_context in conf\.py

"product_page": product_page,      # was: "your-product.example.com"
"github_url": github_repo,         # was: "https://github.com/your-org/your-repo"
"license": {
    "name": "Apache-2.0",          # TODO: set your license
    "url": github_repo + "/blob/main/LICENSE",
```

Add these entries so the theme can display the project name and author without duplicating them:

```{code-block} python
:caption: html_context in conf\.py

"project": project,
"author": author,
```

Add these entries to configure the settings related to your GitHub repository.
`default_edit_url` and `default_view_url` serve as fallback URLs for the view/edit source buttons on pages that do not have a specific source file path set.

```{code-block} python
:caption: html_context in conf\.py

"feedback": True,
"github_issues": "enabled",
"default_source_extension": default_source_extension,
"default_edit_url": github_repo + "/edit/main/docs/index" + default_source_extension,
"default_view_url": github_repo + "/blob/main/docs/index" + default_source_extension,
```

Add the horizontal navigation menu configuration:

```{code-block} python
:caption: html_context in conf\.py

# Horizontal Nav Menu
"company": "Canonical",
# "link1_URL": "https://example.com/",
# "link1_name": "First optional link",
# "link2_URL": "https://example.com/",
# "link2_name": "Second optional link",
```

Uncomment and adjust the parameters for `link1` and `link2` if you want to add the links in the top navigation bar.

Add main logo parameters and adjust their values for your documentation:

```{code-block} python
:caption: html_context in conf\.py

# Canonical Product menu
# Uncomment if you need a product menu added on the top of every page
# "add_product_menu": True,

"logo_link_URL": "https://documentation.ubuntu.com",
"logo_img_URL": "https://assets.ubuntu.com/v1/82818827-CoF_white.svg",
"logo_title": "Canonical",
```

Add the following parameters for the footer.

```{code-block} python
:caption: html_context in conf\.py

# TODO: Customize the footer.
"footer": {
    # Whether to add the product name as the first entry.
    "product": True,
    # Whether to add the license as the second entry.
    "license": True,
    # List your footer entries. Accepts HTML tags.
    "entries": [
        '<a class="js-revoke-cookie-manager" href="#tracker-settings">Manage your tracker settings</a>',
    ]
}
```

### Add syntax highlighting

Add these syntax highlighting settings after the list of extensions:

```{code-block} python
:caption: conf\.py

highlight_language = "none"  # default
pygments_style = "autumn"    # see https://pygments.org/styles for more
```

### Configure the sitemap

Add the lastmod setting to the sitemap section:

```{code-block} python
:caption: conf\.py

sitemap_show_lastmod = True
```

### Configure PDF output

If you need to render your docs to PDF, add the following at the end of the configuration:

```{code-block} python
:caption: conf\.py

set_modern_pdf_config = True
```

### Update the copyright

The Ulwazi theme expects a plain year string rather than the older {spellexception}`CC-BY-SA` format.

```{code-block} python
:caption: conf\.py

copyright = f"{datetime.date.today().year}"
```

The license information is now conveyed through the "license" key in "html_context".

## Test the documentation

Once configuration is complete, review everything again and build it from scratch (cleaning out the existing build files first):

```shell
cd docs
make clean
make run
```

This will start a local server at http://127.0.0.1:8000. Open it in your browser to verify the pages render correctly.

Report issues or feature requests in the [Ulwazi GitHub repository](https://github.com/canonical/ulwazi/issues/new).
