(sphinx-autodoc)=

# Import docstrings with Sphinx `autodoc`

Module and function details are useful reference material to have in documentation, but the process of manually pulling all the necessary details over can become tedious. The [Sphinx `autodoc` extension](https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html) provides the capability to automatically pull in docstrings and module information for Python code.

## Prerequisites

To use the Sphinx `autodoc` extension with the Starter Pack, you need:

* Python module files located within the same repository as your documentation

OR

* The code repository added as a [Git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) into the documentation repository

## Setup

In the {file}`conf.py` file in your docs directory, update the `sys.path` so that Sphinx can find your module files. At the top of the file, add a `sys.path.insert` that adds your `<code>` directory:

```{code-block} python
:caption: {file}`conf.py`

import sys
from pathlib import Path

relative_code_path = Path('..', '<code>')
absolute_code_path = relative_code_path.resolve()
absolute_code_path_str = str(absolute_code_path)
sys.path.insert(0, absolute_code_path_str) # insert at index 0 so it occurs early in the list
```

Then, further down in the {file}`conf.py`, add `sphinx.ext.autodoc` to the list of extensions:

```{code-block} python
:caption: {file}`conf.py`

extensions = [
    ...
    "sphinx.ext.autodoc",
]
```

## Usage

See [Sphinx's `autodoc` instructions](https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html#usage) for details.

## Known issues and limitations

There are a few issues and limitations that should be taken into consideration.

### Language

The extension's usage is limited to Python code. There are extensions for some other languages but they have not been tested with the Starter Pack, such as [sphinxcontrib-rust](https://sphinxcontrib-rust.readthedocs.io/en/stable/) for Rust.

### Docstring format

The `autodoc` extension pulls the docstrings straight into the the reStructuredText (reST) document, which requires the docstrings to be in reST format. For docstrings in the Numpy or Google style, the [napoleon](https://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html#module-sphinx.ext.napoleon) extension can convert the docstrings into reST prior to processing by `autodoc`.

For documentation that is written in MyST Markdown, wrap the `eval-rst` directive around the `autodoc` calls:

````{code-block} md

```{eval-rst}

.. py:currentmodule:: code.<module-name>

.. automodule:: <module-name>
    :members:

```
````

## Canonical examples

```{list-table} Canonical autodoc examples
:header-rows: 1

*  - Product
   - {file}`conf.py`
   - Raw Doc
   - Rendered Doc

*  - Jubilant
   - [conf.py](https://github.com/canonical/jubilant/blob/023ce73353352133c43dfb17b4a6cfad0f3e7816/docs/conf.py)
   - [jubilant.rst](https://github.com/canonical/jubilant/blob/023ce73353352133c43dfb17b4a6cfad0f3e7816/docs/reference/jubilant.rst)
   - [jubilant reference page](https://documentation.ubuntu.com/jubilant/reference/jubilant/)

*  - Ops
   - [conf.py](https://github.com/canonical/operator/blob/main/docs/conf.py)
   - [ops.rst](https://github.com/canonical/operator/blob/main/docs/reference/ops.rst)
   - [*ops* reference page](https://documentation.ubuntu.com/ops/latest/reference/ops/)

```
