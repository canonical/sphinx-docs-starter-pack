---
myst:
  substitutions:
    ulwazi_zip: "{file}`ulwazi-0.1.tar.gz`"
---

# How to use Ulwazi Sphinx theme in the starter pack

The [Ulwazi theme] is a Sphinx theme built on top of Canonical's [Vanilla framework], with the base layout and functionality derived from [sphinx-basic-ng].

This guide outlines the steps required to use the Ulwazi theme in your Sphinx documentation project.

## Update Sphinx documentation project files

You will need to update several files in your Sphinx documentation repository for the Ulwazi theme to be properly installed and take effect.

### Update `requirements.txt`

Remove the `canonical-sphinx` extension, and add the following packages -- including the Ulwazi theme -- in {file}`requirements.txt`.

```{code-block} text
:caption: requirements\.txt

# Canonical Ulwazi theme
canonical-sphinx-config @ git+https://github.com/Canonical/canonical-sphinx-config.git@main
ulwazi==0.2
sphinx-basic-ng

[...]

# Other Ulwazi dependencies
sphinx
beautifulsoup4
build
sphinx-modern-pdf-style
```

### Update `conf.py`

Update the project configuration in {file}`conf.py`:

- Add the "version" setting
- Update the "copyright" string
- Add the "project", "author", and "license" details
- Add the configuration options for for GitHub issues
- Add the configuration options for the product menu, main horizontal menu, and footer
- Set the limit of levels for on-page table of contents
- Set "html_theme" setting to use Ulwazi for the project
- Remove "canonical_sphinx" from the list of "extensions"
- Add "ulwazi", "canonical_sphinx_config", "myst_parser", and "sphinx_modern_pdf_style" to the list of "extensions"
- Add the settings for the {spellexception}`Pygment` syntax highlighter
- Add the PDF configuration setting

````{dropdown} conf.py
```{code-block} python
:linenos:
:emphasize-lines: 3, 6, 12-26, 31-65, 71-72, 79, 82-86, 89-112, 117-120, 125

[...]
# TODO: To include a version number, add it here (hardcoded or automated).
version = "beta"

[...]
copyright = f"{datetime.date.today().year}"

[...]
    # TODO: To add a tag image, uncomment and update as needed.
    # 'product_tag': '_static/tag.png',
    #
    # Inherit project name
    "project": project, 
    # Inherit the author value
    "author": author,
    # Licensing information
    # 
    # TODO: Change your product's license name and a link to its file.
    # For the name, we recommend using the standard shorthand identifier from
    # https://spdx.org/licenses
    # For the URL, link directly to the product's license statement, typically found on
    # the product's home page or in its GitHub project.
    "license": {
        "name": "LGPL-3.0-only",
        "url": "https://github.com/canonical/ulwazi/blob/main/LICENSE",
    },

[...]
    "display_contributors": False,

    # Required for feedback button    
    "feedback": True,
    "github_issues": "enabled",
    "default_source_extension": ".md",
    "default_edit_url": "https://github.com/canonical/ulwazi/edit/main/docs/index.rst",
    "default_view_url": "https://github.com/canonical/ulwazi/blob/main/docs/index.rst",

    # Horizontal Nav Menu
    "company": "Canonical",
    "link1_URL": "https://snapcraft.io/",
    "link1_name": "First optional link",
    "link2_URL": "https://snapcraft.io/",
    "link2_name": "Second optional link",

    # Canonical Product menu
    # Uncomment if you need a product menu added on the top of every page
    "add_product_menu": True,
    
    # Main Horizontal menu
    # "is_docs": False, # Purpose unknown
    "logo_link_URL": "https://documentation.ubuntu.com",
    "logo_img_URL": "https://assets.ubuntu.com/v1/82818827-CoF_white.svg",
    "logo_title": "Canonical",

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
}

[...]
# slug = ''

# Limit the number of levels for Table of contents
localtoc_max_depth = 3

[...]
#######################
# Template and asset locations
#######################

html_theme = "ulwazi"

[...]
myst_enable_extensions = {
    "colon_fence",
    "deflist",
    "tasklist"
}

[...]
extensions = [
    "canonical_sphinx_config",
    "notfound.extension",
    "sphinx_design",
    "sphinx_reredirects",
    "sphinx_tabs.tabs",
    "sphinxcontrib.jquery",
    "sphinxext.opengraph",
    "sphinx_config_options",
    "sphinx_contributor_listing",
    "sphinx_filtered_toctree",
    "sphinx_related_links",
    "sphinx_roles",
    "sphinx_terminal",
    "sphinx_ubuntu_images",
    "sphinx_youtube_links",
    "sphinxcontrib.cairosvgconverter",
    "sphinx_last_updated_by_git",
    "sphinx.ext.intersphinx",
    "sphinx_sitemap",
    "myst_parser",
    "ulwazi",
    "sphinx_modern_pdf_style",
]
[...]

# html_js_files = []

# Syntax highlighting settings

highlight_language = "none" # default
pygments_style = "autumn" # see https://pygments.org/styles for more

[...]
# PDF

set_modern_pdf_config = True
```
````

## Build the documentation

Once you've completed the setup, you are ready to build your documentation site.

```{code-block}
make clean
make run
```

% LINKS

[Ulwazi theme]: https://pypi.org/project/ulwazi/0.2/
[Vanilla framework]: https://github.com/canonical/vanilla-framework
[sphinx-basic-ng]: https://github.com/pradyunsg/sphinx-basic-ng
