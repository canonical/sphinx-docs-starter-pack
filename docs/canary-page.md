---
relatedlinks: "[Example&#32link](https://example.com)"
hide-toc: true
---

# Test page for default extensions

This page contains basic example structures from every MyST and rST extension that is included in the Sphinx Stack by default.

## `canonical_sphinx`

Below are the default extensions bundled into `canonical_sphinx`.

### Furo theme

This is partially tested by setting Furo's `hide-toc` feature to `true` in this page's metadata.

**Expectation**: The right side of the page should **not** contain a table of contents.

**HTML check**: The HTML of this page does **not** contain the following `<div>` classes:

```html
<div class="toc-title-container">
    (...)
<div class="toc-tree-container">
    (...)
```

### MyST parser

This is tested with the `{sub-ref}` MyST directive to count words through `wordcount-words`.

**Expectation**: There is a number in the sentence "This page has {sub-ref}`wordcount-words` words".

### linkify-it-py

This is tested by writing a URL in plain text and checking that it turns into a link.

**Expectation**: //localhost is a clickable link.

**HTML check**:

```html
<a class="reference external" href="//localhost">//localhost</a>
```

## `notfound.extension`

This is tested by accessing a non-existent sub-page of this documentation set.

**Expectation**: https://documentation.ubuntu.com/sphinx-stack/a renders a "Page not found" message with the same CSS styling as the rest of the documentation, maintaining the left-side navigation and upper menu.

## `sphinx_design`

This is tested by rendering sample structures based on [`sphinx-design` documentation examples](https://sphinx-design.readthedocs.io/en/latest/index.html).

### Grids

#### Basic grid

**Expectation**: The following grids have an outer outline and three grid items.

````{grid}
:outline:

```{grid-item}
MyST grid item 1
```
```{grid-item}
MyST grid item 2
```
```{grid-item}
MyST grid item 3
```
````

```{eval-rst}
.. grid::
    :outline:

    .. grid-item::
        reST grid item 1

    .. grid-item::
        reST grid item 2

    .. grid-item::
        reST grid item 3
```

**HTML check**:

```html
<div class="sd-container-fluid sd-sphinx-override sd-mb-4 sd-border-1 docutils">
    (...)
```

#### Card grids

**Expectation**: The following grids are composed of cards.

````{grid}
```{grid-item-card}  Title 1
MyST grid item card 1
```
```{grid-item-card}  Title 2
MyST grid item card 2
```
```{grid-item-card}  Title 3
MyST grid item card 3
```
````

```{eval-rst}
.. grid::

    .. grid-item-card::  Title 1

        reST grid item card 1

    .. grid-item-card::  Title 2

        reST grid item card 2

    .. grid-item-card::  Title 3

        reST grid item card 3
```

**HTML check**:

```html
<div class="sd-container-fluid sd-sphinx-override sd-mb-4 docutils">
    (...)
```

### Cards

#### Basic card

```{card} MyST card title
Card content
```

```{eval-rst}
.. card:: reST card title

    Card content
```

**HTML check**:

```html
<div class="sd-card sd-sphinx-override sd-mb-3 sd-shadow-sm docutils">
    (...)
```

#### Card with header and footer

**Expectation**: The following cards have header and footer text.

```{card} MyST card title
Header
^^^
Card content
+++
Footer
```

```{eval-rst}
.. card:: reST card title

    Header
    ^^^
    Card content
    +++
    Footer
```

**HTML check**:

```html
<div class="sd-card-header docutils">
    (...)
<div class="sd-card-footer docutils">
```

#### Clickable card

**Expectation**: The following cards are clickable, and links to documentation.ubuntu.com/sphinx-stack :

```{card} Click me
:link: https://documentation.ubuntu.com/sphinx-stack/

This MyST card links to `https://documentation.ubuntu.com/sphinx-stack/`
```

```{eval-rst}
.. card:: Click me
    :link: https://documentation.ubuntu.com/sphinx-stack/

    This reST card links to ``https://documentation.ubuntu.com/sphinx-stack/``
```

**HTML check**:

```html
<a class="sd-stretched-link sd-hide-link-text reference external" href="https://documentation.ubuntu.com/sphinx-stack/latest/">
    <span>https://documentation.ubuntu.com/sphinx-stack/latest/</span>
</a>
```
### Dropdowns

#### Basic dropdown

**Expectation**: The dropdowns are open by default.

```{dropdown} MyST dropdown title
:open:

Dropdown content
```

```{eval-rst}
.. dropdown:: reST dropdown title
    :open:

    Dropdown content
```

**HTML check**:

```html
<details class="sd-sphinx-override sd-dropdown sd-card sd-mb-3" open="">
    (...)
```

#### Custom dropdown

**Expectation**: The dropdowns are closed by default, have a grey title card, and a wrench icon.

```{dropdown} MyST dropdown title
:icon: tools
:color: secondary

Dropdown content
```

```{eval-rst}
.. dropdown:: reST dropdown title
    :icon: tools
    :color: secondary

    Dropdown content
```

**HTML check**:

```html
<summary class="sd-summary-title sd-card-header sd-bg-secondary sd-bg-text-secondary">
    (...)
    <span class="sd-summary-icon">
    (...)
```

### Tabs

**Expectation**: The following MyST tab sets synchronize with each other:

````{tab-set}
```{tab-item} MyST label 1
:sync: myst-label-1

MyST tab content 1
```
```{tab-item} MyST label 2
:sync:  myst-label-2

MyST tab content 2
```
````

`````{tab-set}
````{tab-item} MyST label 1
:sync:  myst-label-1

This MyST tab includes a code block:
```{code-block} python
print("hello")
```
````
````{tab-item} MyST label 2
:sync:  myst-label-2

```{card}
This MyST card is inside a MyST tab.
```
````
`````

```{eval-rst}
**Expectation**: The following reST tab sets synchronize with each other:

.. tab-set::

    .. tab-item:: reST label 1
        :sync: rest-label-1

        reST tab content 1

    .. tab-item:: reST label 2
        :sync: rest-label-2

        reST tab content 2

.. tab-set::

    .. tab-item:: reST label 1
        :sync: rest-label-1

        This reST tab includes a code block:

        .. code-block:: python

            print("hello")

    .. tab-item:: reST label 2
        :sync: rest-label-2

        .. card::
            This reST card is inside a reST tab.
```

### Badges, Buttons and Icons

#### Inline badges

**Expectation**: Blue badge labelled "info" and white badge with a blue outline labelled "info-line" are visible.

MyST badges: {bdg-info}`info`, {bdg-info-line}`info-line`
```{eval-rst}
reST badges: :bdg-info:`info`, :bdg-info-line:`info-line`
```

#### Inline clickable badges

**Expectation**: Blue and white badge with a blue outline, both labelled "https://example.com, are visible and clickable.

MyST badges: {bdg-link-info}`https://example.com`, {bdg-link-info-line}`https://example.com`
```{eval-rst}
reST badges: :bdg-link-info:`https://example.com`, :bdg-link-info-line:`https://example.com`
```

#### Clickable buttons

**Expectation**: The following buttons are labelled "https://example.com" and are clickable:

MyST button:

```{button-link} https://example.com
:color: info
```
```{eval-rst}
reST button:

.. button-link:: https://example.com
    :color: info
```

#### Inline icons

**Expectation**: Inline icons of "{spellexception}`octicon`" style are visible. They are a right arrow, a circle containing a check mark, a gear, and a circle containing an x.

MyST icons: {octicon}`arrow-right`, {octicon}`check-circle`, {octicon}`gear`, {octicon}`x-circle`
```{eval-rst}
reST icons: :octicon:`arrow-right`, :octicon:`check-circle`, :octicon:`gear`, :octicon:`x-circle`
```

### Additional

**Expectation**: A block of information about an article is displayed. It shows an avatar, author, date, and read duration:

```{article-info}
:avatar: https://assets.ubuntu.com/v1/cc828679-docs_illustration.svg
:avatar-outline: muted
:author: MyST author
:date: Jul 24, 2021
:read-time: 5 min read
:class-container: sd-p-2 sd-outline-muted
```

```{eval-rst}

.. article-info::
    :avatar: https://assets.ubuntu.com/v1/cc828679-docs_illustration.svg
    :avatar-outline: muted
    :author: reST author
    :date: Jul 24, 2021
    :read-time: 5 min read
    :class-container: sd-p-2 sd-outline-muted
```

## `sphinx_rerediraffe`

**Expectation**:

[canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/**test-rerediraffe**](https://canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/test-rerediraffe)

redirects to

[canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/**canary-page**](https://canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/canary-page).

## `sphinx_reredirects`

**Expectation**:

[canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/**test-reredirects**](https://canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/test-reredirects)

redirects to

[canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/**canary-page**](https://canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/canary-page).

## `sphinx_tabs.tabs`

**Expectation**: The following MyST tab sets synchronize with each other:

````{tabs}
```{group-tab} MyST label 1
MyST tab content 1
```
```{group-tab} MyST label 2
MyST tab content 2
```
````

`````{tabs}
````{group-tab} MyST label 1

This MyST tab includes a code block:
```{code-block} python
print("hello")
```
````
````{group-tab} MyST label 2

```{card}
This MyST card is inside a MyST tab.
```
````
`````

```{eval-rst}
**Expectation**: The following reST tab sets synchronize with each other:

.. tabs::
    .. group-tab:: reST label 1

        reST tab content 1

    .. group-tab:: reST label 2

        reST tab content 2

.. tabs::
    .. group-tab:: reST label 1

        This reST tab includes a code block:

        .. code-block:: python

            print("hello")

    .. group-tab:: reST label 2

        .. card::

            This reST card is inside a reST tab.
```

## `sphinxext.opengraph`

**HTML check**: The HTML source of this page should include the following meta tags:

```html
<meta property="og:title" content="Test page for default extensions" />
<meta property="og:type" content="website" />
<meta property="og:url" content="https://canonical-sphinx-stack-testing.readthedocs-hosted.com/canary-page/" />
<meta property="og:site_name" content="Project" />
<meta property="og:description" content="This page contains basic example structures from every MyST and rST extension that is included in the Sphinx Stack by default. canonical_sphinx: These are the default extensions bundled into canoni..." />
<meta property="og:image" content="https://assets.ubuntu.com/v1/cc828679-docs_illustration.svg" />
<meta property="og:image:alt" content="Project" />
```

## `sphinx_config_options`

**Expectation**: Collapsed config option blocks can be expanded to reveal the following parameters: key, type, default, live update, condition, and scope.

```{config:option} cache.enabled.myst
:shortdesc: Enable or disable caching (MyST)
:type: boolean
:default: false
:scope: server
:liveupdate: true
:condition: Only available with premium license

Controls whether the application uses caching to improve performance.
```

**Expectation**: {config:option}`cache.enabled.myst` should link to the MyST config block.

```{eval-rst}
.. config:option:: cache.enabled.rest
    :shortdesc: Enable or disable caching (reST)
    :type: boolean
    :default: false
    :scope: server
    :liveupdate: true
    :condition: Only available with premium license

    Controls whether the application uses caching to improve performance.

**Expectation**: :config:option:`cache.enabled.rest` should link to the reST config block.
```

## `sphinx_contributor_listing`

**Expectation**: The footer of this page should contain clickable text starting with "Thanks to". Clicking it should display a pop-up list of contributors.

**HTML check**:

```html
<a class="display-contributors">
```

## `sphinx_filtered_toctree`

This is tested by creating the page {ref}`hidden-page` as a sibling of this current page, and hiding it from the TOC with `:exclude:`.

**Expectation**: The left-side TOC should **not** visibly contain a page called {ref}`hidden-page`.

**HTML check**: The HTML of this page should **not** contain

```html
<a class="reference internal" href="hidden-page/">Hidden page</a>
```

## `sphinx_llm.txt`

This is tested by appending `llms-full.txt` to the site root.

**Expectation**: https://canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/llms-full.txt contains the documentation in raw markdown text.

## `sphinx_related_links`

This is tested by adding `relatedlinks` to this page's metadata with an example link.

**Expectation**: A "Related links" list can be seen on the right side of this page and contains an example link.

## `sphinx_roles`

**Expectation**: The following literal references are links to example.com.

This is a {literalref}`literal reference in MyST <https://example.com>`.

```{eval-rst}
This is a :literalref:`literal reference in reST <https://example.com>`.
```

**Expectation**:

"{spellexception}`Lorem ipsum`" should be excluded from the spell checker (MyST directive).

```{eval-rst}
":spellexception:`Lorem ipsum`" should be excluded from the spell checker (reST directive).
```

**Expectation**:
There should be no inline text following "directive:"

Phrase hidden by MyST directive: {none}`If you can see this text, you might have an issue with the sphinx_roles extension.`

```{eval-rst}
Phrase hidden by reST directive: :none:`If you can see this text, you might have an issue with the sphinx_roles extension.`
```

## `sphinx_terminal`

**Expectation**: Dark terminals showing `user@pc` running the command `echo 'hello'` in `~/path`. The output is `hello`.

The input command `echo 'hello'` can be copied with the copy button on the top right of the terminal:

```{terminal}
:copy:
:user: user
:host: pc
:dir: ~/path

echo 'hello MyST'

hello MyST
```

<br>

```{eval-rst}
.. terminal::
    :copy:
    :user: user
    :host: pc
    :dir: ~/path

    echo 'hello reST'

    hello reST
```

**Expectation**: The terminals below only show the output:

```{terminal}
:output-only:

hello MyST
```

<br>

```{eval-rst}
.. terminal::
    :output-only:

    hello reST
```

## `sphinx_ubuntu_images`

**Expectation**: Lists of images for Ubuntu 26.04 LTS (Resolute Raccoon).

MyST directive output:

```{ubuntu-images}
:releases: resolute-
```

reST directive output:

```{eval-rst}
.. ubuntu-images::
    :releases: resolute-
```

## `sphinx_youtube_links`

```{youtube} https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

**Expectation**: There should be a "Watch on YouTube" button with an orange play icon to the right of this paragraph. This one is generated with MyST.

This text is written below the <code>```{youtube}</code> MyST directive. Therefore it should render to the left of the button and wrap around it.

Text below the button should expand back into taking up the full horizontal length of the section.

```{eval-rst}
.. youtube:: https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

**Expectation**: There should be a second "Watch on YouTube" button with an orange play icon to the right of this paragraph. This one is generated with reST.

This text is written below the `.. youtube::` reST directive. Therefore it should render to the left of the button and wrap around it.

Text below the button should expand back into taking up the full horizontal length of the section.

## `sphinx_last_updated_by_git`

**Expectation**: The page footer should contain text that says "Last updated on", followed by a date.

**HTML check**:

```html
<a class="display-contributors">
```

## `sphinx.ext.intersphinx`

**Expectation**: Both intersphinx references below should link to [documentation.ubuntu.com/sphinx-stack/latest/how-to/optional-customisation/external-referencing-intersphinx/](https://documentation.ubuntu.com/sphinx-stack/latest/how-to/optional-customisation/external-referencing-intersphinx/).

MyST reference: {ref}`sphinx-stack-docs:how-to-link-docs-intersphinx`

```{eval-rst}
reST reference :ref:`sphinx-stack-docs:how-to-link-docs-intersphinx`
```

## `sphinx_sitemap`

**Expectation**: https://canonical-sphinx-stack-testing.readthedocs-hosted.com/agentic-tests/sitemap.xml contains an XML file listing all pages in this documentation set.