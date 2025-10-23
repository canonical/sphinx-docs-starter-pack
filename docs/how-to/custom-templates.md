(custom-templates)=

# Use custom templates

If the default template in the Starter Pack doesn't fully meet your needs -- whether you want a unique layout, a custom header or footer, or a specialized sidebar for certain pages -- you can create and use a custom template for your Sphinx project.

This guide shows you how to extend or override the default templates in the Starter Pack to tailor the look and structure of your documentation.

```{note}
Base template customizations can be made to your documentation.
However, they are not officially supported by the team maintaining the starter pack.
Use them at your own discretion.
```

## Setup

First, create the {file}`docs/_templates` directory; all your custom templates will need to be stored in this folder.

Then uncomment this line in {file}`docs/conf.py` so your Sphinx project will use local templates (where available):

```{code-block} py
:caption: conf\.py

templates_path = ["_templates"]
```

In most cases, you will need to copy the default templates from the [canonical-sphinx theme] as a starting point and edit as needed.


```{seealso}
Sphinx uses the Jinja templating engine for its HTML templates; see the [Jinja template syntax reference] for more details.
```

## Use custom template for all pages

Sphinx looks for a template called {file}`page.html` as the entry point and main page template for documentation pages.
To customize your project's look and structure, check this file and determine which parts -- such as the header, footer, or sidebars -- need to be edited or overridden.

Here are some examples.

### Remove on-page TOC

To remove the on-page TOC in the right sidebar, make a copy of [page.html] in the {file}`docs/_templates` folder, and remove the applicable lines.
This will apply to all pages. 

```{code-block} html
:caption: page.html
:emphasize-lines: 3-14
:class: no-copybutton

{% block right_sidebar %}
<div class="toc-sticky toc-scroll">
   {% if not furo_hide_toc_orig %}
    <div class="toc-title-container">
      <span class="toc-title">
       {{ _("Contents") }}
      </span>
    </div>
    <div class="toc-tree-container">
      <div class="toc-tree">
        {{ toc }}
      </div>
    </div>
   {% endif %}
    {% if meta and ((meta.discourse and discourse_prefix) or meta.relatedlinks) %}
    <div class="relatedlinks-title-container">
      <span class="relatedlinks-title">
```

### Add icon for GitHub link in header

To customize the default header by adding an icon for the GitHub link, first make a copy of [header.html] in the {file}`docs/_templates` folder.

Then modify the conditional statement related to the GitHub URL with your code.

```{code-block} html
:caption: header.html
:emphasize-lines: 5-13

[...]     
          {% if github_url %}
          <li>
            <a href="{{ github_url }}" class="p-navigation__sub-link p-dropdown__link">
              <!-- GitHub icon (inline SVG) -->
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="currentColor" style="vertical-align:middle; margin-right:4px;">
                <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38
                0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52
                -.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89
                -3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82a7.65 7.65 0 012 0c1.53-1.03
                2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.28.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48
                0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"/>
              </svg>
              GitHub
            </a>
          </li>
          {% endif %}
[...]
```

## Use custom template for specific pages

If you want to use a custom template for specific pages in your project, you can do so by using conditional logic in {file}`page.html`.

First, create the base template with your modifications (e.g. {file}`special-header.html`, {file}`special-page.html`) and place it in the {file}`docs/_templates` folder.

Next, make a copy of [page.html].

### Partial template changes

To make partial changes (e.g. custom header) to specific pages, modify only the relevant parts of {file}`page.html` where you want the custom layout or behavior to apply.
For example, wrap the body block in a conditional statement so the custom header (e.g. {file}`special-header.html`) applies only to the "how-to/custom-templates" and "how-to/build" page.

```{code-block} html
:emphasize-lines: 2-6
:caption: _templates/page.html

{% block body -%}
   {% if pagename in ["how-to/build", "how-to/custom-templates"] %}
       {% include "special-header.html" %}
   {% else %}
       {% include "header.html" %}
   {% endif %}
   {{ super() }}
{%- endblock body %}
```

### Whole template changes

To make changes to the whole template (e.g. a custom layout for a landing page or marketing page), modify the `extends` statement in {file}`page.html` to specify the pages that will use different templates.
For example, the {file}`special-page.html` template applies only to the "how-to/customise" and "how-to/diagrams-as-code" page.

```{code-block} html
:caption: _templates/page.html

{% if pagename in ["how-to/customise", "how-to/diagrams-as-code"] %}
    {% extends "special-page.html" %}
{% else %}
    {% extends "furo/page.html" %}
{% endif %}
```

```{note}
The pages "how-to/customise" and "how-to/diagrams-as-code" will use {file}`special-page.html` as the base template, but all other blocks (e.g. footer, body, etc) will follow the default {file}`page.html`.
```

% LINKS
[canonical-sphinx theme]: https://github.com/canonical/canonical-sphinx/tree/main/canonical_sphinx/theme/templates
[Jinja template syntax reference]: https://jinja.palletsprojects.com/en/latest/templates/
[page.html]: https://github.com/canonical/canonical-sphinx/blob/main/canonical_sphinx/theme/templates/page.html
[header.html]: https://github.com/canonical/canonical-sphinx/blob/main/canonical_sphinx/theme/templates/header.html
