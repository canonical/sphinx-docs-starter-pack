(how-to-test-ulwazi-theme)=

# Test the Ulwazi theme

The [Ulwazi theme] is a Sphinx theme built on top of Canonical's [Vanilla framework], with the base layout and functionality derived from [sphinx-basic-ng].

This guide outlines the steps required to use the Ulwazi theme in your Sphinx documentation project.

## 1. Update `requirements.txt`

Remove the `canonical-sphinx[full]` extension, and update the packages required by Ulwazi (and the documentation starter pack) in {file}`requirements.txt`.
Your {file}`requirements.txt` should contain, at minimum:

```{code-block} text
:caption: requirements\.txt

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

The `ulwazi` line installs the theme from PyPI.

## 2. Update `conf.py`

This is the most important and tricky part - updating the project configuration in {file}`conf.py`.

```{seealso}
A reference `conf.py` with all the required configuration and TODO markers is provided
in the Ulwazi repository as
[`default-conf.py`](https://github.com/canonical/ulwazi/blob/main/docs/default-conf.py).
Copy it as the starting point for a new documentation set, or use it as a checklist when migrating an existing one.
```

### 2.1. Set the theme

Set the "html_theme" setting to use Ulwazi for the project:

```{code-block} python
html_theme = "ulwazi"
```

### 2.2. Remove the `canonical-sphinx` extension

In the "extensions" list, remove "canonical-sphinx" and replace it with Ulwazi and its companion packages.

**Before:**

```python
extensions = [
    "canonical_sphinx",
    "sphinxcontrib.cairosvgconverter",
    "sphinx_last_updated_by_git",
    "sphinx.ext.intersphinx",
    "sphinx_sitemap",
]
```

**After:**

```python
extensions = [
    "sphinx_terminal",
    "sphinxcontrib.cairosvgconverter",
    "sphinx_last_updated_by_git",
    "sphinx.ext.intersphinx",
    "sphinx_sitemap",
    "ulwazi",
    "canonical_sphinx_config",
    "myst_parser",
    "sphinxcontrib.jquery",
]
```

```{note}
The "extensions" list shown here is only a partial list.
Your documentation may require additional extensions beyond those listed here.
```

### 2.3. Extract top-level variables for `html_context`

Before the "html_context" dictionary, add three new top-level variables.
These are referenced inside "html_context" and make it easier for users to configure the most commonly changed values in one place.

Add the following block immediately before `html_context = {`:

```python
# TODO: Adjust to point to the repository where your documentation source files
# are stored.

github_repo = "https://github.com/your-org/your-repo"

# TODO: Select the default syntax for docs source files.
# This is for a fallback view/edit source code buttons.

default_source_extension = ".md"

# TODO: Change to your product website URL,
#       dropping the 'https://' prefix, e.g. 'ubuntu.com/lxd'.

product_page = "your-product.example.com"
```

Replace the placeholder values with your actual repository URL, file extension (`.md` or `.rst`), and product page URL.

### 2.4. Update `html_context`

You will need to make several updates to the "html_context" dictionary.
For example, see the [Charmed Apache Kafka Ulwazi PR](https://github.com/canonical/kafka-operator/pull/444/files#diff-85933aa74a2d66c3e4dcdf7a9ad8397f5a7971080d34ef1108296a7c6b69e7e3).

```{note}
For clarity, the code snippets in this section include only the relevant code and may not match the exact layout of `html_context` in the source file.
```

#### Use the new top-level variables

Replace the {spellexception}`hardcoded` strings with the variables you defined in step 2.3:

```{code-block} python
:caption: html_context dictionary

    "product_page": product_page,      # was: "your-product.example.com"
    "github_url": github_repo,         # was: "https://github.com/your-org/your-repo"
    "license": {
        "name": "Apache-2.0",          # TODO: set your license
        "url": github_repo + "/blob/main/LICENSE",
```

#### Add `project` and `author` inheritance

Add these entries so the theme can display the project name and author without duplicating them:

```{code-block} python
:caption: html_context dictionary

    "project": project,
    "author": author,
```

#### Add feedback, source extension, and default URL entries

Add these entries to configure the settings related to your GitHub repository.
`default_edit_url` and `default_view_url` serve as fallback URLs for the view/edit source buttons on pages that do not have a specific source file path set.

```{code-block} python
:caption: html_context dictionary

    "feedback": True,
    "github_issues": "enabled",
    "default_source_extension": default_source_extension,
    "default_edit_url": github_repo + "/edit/main/docs/index" + default_source_extension,
    "default_view_url": github_repo + "/blob/main/docs/index" + default_source_extension,
```

#### Add navigation menu entries

Add the horizontal navigation menu configuration:

```{code-block} python
:caption: html_context dictionary

    # Horizontal Nav Menu
    "company": "Canonical",
    # "link1_URL": "https://example.com/",
    # "link1_name": "First optional link",
    # "link2_URL": "https://example.com/",
    # "link2_name": "Second optional link",
```

Uncomment and adjust the parameters for "link1" and "link2" if you want to add the links in the top navigation bar.

#### Add product menu and logo entries

Add main logo parameters and adjust their values for your documentation:

```{code-block} python
:caption: html_context dictionary

    # Canonical Product menu
    # Uncomment if you need a product menu added on the top of every page
    # "add_product_menu": True,

    "logo_link_URL": "https://documentation.ubuntu.com",
    "logo_img_URL": "https://assets.ubuntu.com/v1/82818827-CoF_white.svg",
    "logo_title": "Canonical",
```

#### Add footer configuration

Add the following parameters for the footer.

```{code-block} python
:caption: html_context dictionary

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

### 2.5. Add syntax highlighting settings

Add these syntax highlighting settings after the "extensions" list:

```python
highlight_language = "none"  # default
pygments_style = "autumn"    # see https://pygments.org/styles for more
```

### 2.6. Add sitemap settings

Add the "sitemap_show_lastmod" setting to your sitemap section:

```python
sitemap_show_lastmod = True
```

### 2.7. Configure PDF generation

If you need a PDF version of your docs, add the following at the end of `conf.py`:

```python
set_modern_pdf_config = True
```

You'll also need to add "sphinx_modern_pdf_style" to the "extensions" list.

### 2.8. Update the `copyright` format

The Ulwazi theme expects a plain year string rather than the older "CC-BY-SA" format.

```python
copyright = f"{datetime.date.today().year}"
```

The license information is now conveyed through the "license" key in "html_context".

## 3. Build the documentation

Once configuration is complete, review everything again and build it from scratch (cleaning out the existing build files first):

```{code-block}
cd docs
make clean
make run
```

This will start a local server at http://127.0.0.1:8000.
Open it in your browser to verify the site renders correctly.

Report issues or feature requests to the [Ulwazi GitHub repository].

% LINKS

[Ulwazi theme]: https://pypi.org/project/ulwazi
[Vanilla framework]: https://github.com/canonical/vanilla-framework
[sphinx-basic-ng]: https://github.com/pradyunsg/sphinx-basic-ng
[Ulwazi GitHub repository]: https://github.com/canonical/ulwazi/issues/new
