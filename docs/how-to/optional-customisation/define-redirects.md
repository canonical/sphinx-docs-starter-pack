---
myst:
  html_meta:
    description: How to define redirects in your repository
---

# Define redirects in your repository

If a file in your documentation set is moved, deleted or renamed, it can no longer be found at its original location and users will be shown a “404 Not Found” page. This can be frustrating for users.

To provide a better user experience, it is good practice to set up redirects to point to the new location, new file name, or to an alternative place where the information can be found. With documentation on Read the Docs, we can set up redirects [manually via the admin panel](https://docs.readthedocs.io/en/stable/guides/redirects.html). However, since this must be done separately, and *after* the file changes are made, this step can often be forgotten. 

The **best practice** is to define redirects alongside the documentation in your repository, so that when a file is moved, renamed or deleted, you can create a redirect at the same time. In this way, redirects will always be in place when such changes go “live”, without needing to remember to do it (manually) afterwards. Redirects can either be **external**, meaning that they point to a URL outside your documentation, or **internal**, where you want to point to a new location within your documentation.

There are two ways to do this:

* For **external** and/or a **small number** of internal redirects, you can set up redirects in your project’s configuration file (`conf.py`) using *Reredirects*.  
* If you have many **internal** redirects, which is typical as documentation matures, you can avoid cluttering your configuration file by setting up *Rediraffe*, which conveniently lets you store your redirects in a separate file (`redirects.txt`).

Note that if you need to specify external redirects *and* have a large number of internal redirects, it’s possible to use both methods at the same time.

When migrating from Discourse to Read the Docs, the entire redirects table can be preserved in your `redirects.txt` file so that old/deep links from Discourse docs still redirect to the correct pages in the RTD documentation, and the web team can use a simple global redirect.

## Set up redirects in `conf.py`

In the Starter Pack, the [reredirects Sphinx extension](https://documatt.com/sphinx-reredirects/usage/) is already installed. You can find the redirects section in your `conf.py` (or `custom_conf.py`) file, which looks something like this:

````
#############
# Redirects #
#############

# To set up redirects: https://documatt.gitlab.io/sphinx-reredirects/usage.html
# For example: 'explanation/old-name.html': '../how-to/prettify.html',

# NOTE: If undefined, set to None, or empty,
#       the sphinx_reredirects extension will be disabled.

redirects = {}
````

Any redirects you want to create are defined inside the “`redirects = {}`” variable. Inside this variable, add your redirects in the following patterns:

````
redirects = {
	"old/path/": "https://redirect-to.com/new-url", # External
	"rename/oldname/": "rename/newname/", # Internal file rename
	"move/file/from/filename/": "../moved/to/filename/" # Move a file
}
````

Here’s a [working example](https://github.com/canonical/ubuntu-server-documentation/blob/77d2718c06f5bcf504538cec09022131f9029a3d/custom_conf.py#L130):

````
redirects = {
    "how-to/containers/lxc-containers": "https://linuxcontainers.org/lxc/documentation/",
    "reference/backups/basic-backup-shell-script": "https://discourse.ubuntu.com/t/basic-backup-shell-script/36419"
}
````

   
See the [official reredirects documentation](https://documatt.com/sphinx-reredirects/usage/) for more information.

## Set up internal redirects (*in a separate file*)

To add the extension to your setup, add `sphinxext-rediraffe` in your `docs-requirements.txt` file. The file may be in the `.sphinx` subdirectory, and may just be called `requirements.txt`.

Then, in your `conf.py` file, add the extension to the `extensions` list:

````
# Add to the list of extensions
extensions = [
	"sphinxext.rediraffe",
]
````

Create a file called `redirects.txt` in the same directory as your `conf.py` (or `custom_conf.py`) file, on the branch that generates your documentation. This file will host all of your redirects.

Next, in your `conf.py` (or `custom_conf.py`) file, add the `rediraffe_redirects` variable, which is the name of the redirects file you just created (include the file path if the file is not in the same directory as your conf.py):

````
# Add redirects, so they can be updated here to land alongside docs being moved
rediraffe_branch = "main"
rediraffe_redirects = "redirects.txt"
````

The format of the `redirects.txt` file is very specific. These instructions assume you are using `dirhtml` as your Sphinx builder (which avoids having .html at the end of your page URLs). If you are not using `dirhtml`, you should set this up by defining it in your `.readthedocs.yaml` file:

````
# Build documentation in the docs/ directory with Sphinx
sphinx:
  builder: dirhtml
````

### Define redirects in the file

Inside your `redirects.txt` file, add your redirects in the following patterns:

````
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
path/old-name/ new-path/new-name/			# To move and rename a file
````

Redirects are relative to the root of the `docs/` directory, so for simplicity, it’s best to put the redirects.txt file in the root directory. This is an [example of a working](https://github.com/canonical/ubuntu-server-documentation/blob/main/redirects.txt) `redirect.txt` file.

### Layering redirects

In Rediraffe, multiple files can be redirected to the same target:

* A → D  
* B → D  
* C → D

In your redirects.txt file, this looks like:

````
installation tutorial/basic-installation/
basic-installation tutorial/basic-installation/
````

This is common if files have been renamed more than once, creating layers of redirects. 