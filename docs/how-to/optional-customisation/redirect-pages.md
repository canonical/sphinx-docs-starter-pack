---
myst:
  html_meta:
    description: How to redirect URLs in your documentation project. You can redirect a URL to a page inside your project, or to a page on another website.
relatedlinks: https://sphinxext-rediraffe.readthedocs.io/en/latest/
---

# Redirect pages

If a file in your documentation set is moved, deleted or renamed, it can no longer be found at its original location and users will be shown a 404 Not Found page. This can be frustrating for users.

To provide a better user experience, it is good practice to set up redirects to point to the new location, new file name, or to an alternative place where the information can be found. With documentation on Read the Docs, you can configure redirects [manually via the admin panel](https://docs.readthedocs.io/en/stable/guides/redirects.html). However, since this must be done separately, configuring redirects in RTD doesn't scale for complex and mature documentation where a lot of redirects must be maintained.

The **best practice** is to define and track redirects in your project source, so that when a file is moved, renamed or deleted, you can create a redirect at the same time. In this way, redirects will always be in place when such changes go live. Redirects can either be **external**, meaning that they point to a URL outside your documentation, or **internal**, where you want to point to a new location within your documentation.

To set up redirects in your project source, you can use the `sphinxext-rediraffe` extension that lets you store your redirects in a separate file (`redirects.txt`).

## Add sphinxext-rediraffe

`sphinxext-rediraffe` supports the `html` and `dirhtml` Sphinx builders. If you are using a different builder, change it in your `.readthedocs.yaml` file:

```{code-block} yaml
:caption: .readthedocs.yaml

# Build documentation in the docs/ directory with Sphinx
sphinx:
  builder: dirhtml
```

Now add `sphinxext-rediraffe` to your `requirements.txt` file.

Then, in your `conf.py` file, add the extension to the `extensions` list:

```{code-block} python
:caption: conf.py

# Add to the list of extensions
extensions = [
	"sphinxext.rediraffe",
]
```

Create a file called `redirects.txt` in the same directory as your `conf.py` file. This file will host all of your redirects.

Next, in your `conf.py` file, declare `rediraffe_redirects` variable and assign it the path of the redirects file you just created relative to `conf.py`:

```{code-block} python
:caption: conf.py

# Add redirects, so they can be updated here to land alongside docs being moved
rediraffe_branch = "main"
rediraffe_redirects = "redirects.txt"
```

## Define redirects in the file

Inside your `redirects.txt` file, add your redirects in the following patterns:

```{code-block} none
:caption: redirects.txt

# Client-side page redirects
# ---------------------------
# Comments start with a single hash (#)
# Each redirect appears on its own line in the format:
#
# redirect/from/ redirect/to/
#
# Paths are relative to the root of the `docs` directory
# The "from" path must be a file that *does not* exist
# The "to" path must be a file that *does* exist
# The separator between "from" and "to" paths is a single space (not a tab)

path/old-name/ path/new-name/			# To rename a file
path/file-name/ new-path/file-name/		# To move a file
path/old-name/ new-path/new-name/		# To move and rename a file
```

Redirects are relative to the root of the `docs/` directory, so for simplicity, it’s best to put the redirects.txt file in the root directory. This is an [example of a working](https://github.com/canonical/ubuntu-server-documentation/blob/main/redirects.txt) `redirect.txt` file.

## Layering redirects

In Rediraffe, multiple files can be redirected to the same target:

* A → D  
* B → D  
* C → D

Your `redirects.txt` file will look like:

```{code-block} none
:caption: redirects.txt

installation tutorial/basic-installation/
basic-installation tutorial/basic-installation/
```

This is common if files have been renamed more than once, creating layers of redirects. 