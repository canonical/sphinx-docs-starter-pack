.. _how-to-enable-google-analytics:

Enable Google Analytics
=======================

To enable Google Analytics on a Read the Docs project, you must implement a mechanism
for collecting consent from the reader. The Starter Pack contains the necessary files,
but they aren't enabled by default.

Once you're through with the guide, analytics will be collected on all public builds
of your documentation.


Add or update templates
-----------------------

The header template inserts the Google Analytics tracking tag onto each page. If a user
consents to tracking, their traffic and search data will be collected on each page
interaction.

The footer template provides a link for users to change their data collection
preferences.

Starting in version 1.6 of the Starter Pack, these templates were made available by
default. If you're on one of these versions, skip ahead to
:ref:`update-your-configuration-file`. To check your version, open a terminal in the
``docs/`` directory and run:

.. code-block:: bash

    cat .sphinx/version


On Starter Pack 1.5 or lower
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In version 1.5 of the Starter Pack and lower, the templates were sourced from a separate
repository.

Download the latest version of the templates, found at the following links:

- :literalref:`header.html <https://github.com/canonical/sphinx-docs-starter-pack/blob/main/docs/_templates/header.html>`
- :literalref:`footer.html <https://github.com/canonical/sphinx-docs-starter-pack/blob/main/docs/_templates/footer.html>`

Next, open a terminal in the ``docs/`` directory and create the directory to store the
templates:

.. code-block:: bash

    mkdir _templates

Then, move the ``header.html`` and ``footer.html`` files you downloaded into the
``_templates/`` directory.

If you find that your project already has a custom header, add the following HTML
immediately after the ``<header>`` line:

.. code-block:: html

    <!-- Google Tag Manager -->
    <script>
    (function(w, d, s, l, i) {
      w[l] = w[l] || [];
      w[l].push({
        'gtm.start': new Date().getTime(),
        event: 'gtm.js'
      });
      var f = d.getElementsByTagName(s)[0],
        j = d.createElement(s),
        dl = l != 'dataLayer' ? '&l=' + l : '';
      j.async = true;
      j.src =
        'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
      f.parentNode.insertBefore(j, f);
    })(window, document, 'script', 'dataLayer', 'GTM-KNX3CJC');
    </script>

Similarly, if your project already has a custom footer, add the following highlighted
line to the ``right-details`` division:

.. code-block:: html
    :emphasize-lines: 2

    <div class="right-details">
      <a href="" class="js-revoke-cookie-manager muted-link">Manage your tracker settings</a>
    </div>


.. _update-your-configuration-file:

Update your configuration file
------------------------------

Now that the templates are in place, you need to make Sphinx aware of them in your
project's configuration file.

If you're on version 1.6 of the Starter Pack or higher, these lines will already exist
in your configuration file. You'll only need to uncomment them in the following steps.
In lower versions, you'll need to add them.

Add or uncomment the following line in the ``conf.py`` file:

.. code-block:: python

    templates_path = ["_templates"]

The script and style sheet for the cookie banner are hosted remotely. Include them
in your docs by adding or uncommenting the following lines in the ``conf.py`` file:

.. code-block:: python

    html_css_files = ["https://assets.ubuntu.com/v1/d86746ef-cookie_banner.css"]

    html_js_files = ["https://assets.ubuntu.com/v1/287a5e8f-bundle.js"]


Test the cookie banner
----------------------

To verify that everything is working, run the following commands in the ``docs/``
directory:

.. code-block:: bash

    make clean
    make install
    make run

You may need to clear your browser cache or open the page in incognito mode for the
changes to take effect.
