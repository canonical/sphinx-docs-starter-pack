(howto-diagram-as-code-mermaid)=

# Create diagrams as code using Mermaid

Diagrams help users quickly understand and visualize complex ideas, but they can easily become outdated and difficult to maintain.
Creating diagrams as code solves this by keeping them alongside the software source, making updates and reviews simpler.

Mermaid is a popular choice that allows diagrams to be created, maintained, and updated directly in the documentation.
This guide explains how to set up the {doc}`sphinxcontrib-mermaid <sphinxcontrib-mermaid:index>` extension and use Mermaid diagrams in your documentation, with examples included.

```{note}
While there are many other tools and/or approaches for creating diagrams in visualizations in your documentation (e.g. [C4 model], [Dia], [PlantUML], [Structurizr], etc), we only provide support for `sphinxcontrib-mermaid` in the starter pack. 
```

## Installation and setup

First, add the "sphinxcontrib-mermaid" extension to {file}`requirements.txt` so that it's installed as part of your Sphinx project dependencies:

```{code-block} text
:emphasize-lines: 6
canonical-sphinx[full]
packaging
sphinxcontrib-svg2pdfconverter[CairoSVG]
sphinx-last-updated-by-git
sphinx-sitemap
sphinxcontrib-mermaid
```

Then add "sphinxcontrib.mermaid" in the "extensions" list in `conf.py`:

```{code-block} python
extensions = [
    [...]
    "sphinxcontrib.mermaid",
]
```

You are now ready embed Mermaid diagrams and visualization in your documentation using the `mermaid` directive.

### Optional configuration

You can further configure Mermaid's default settings in your project's {file}`conf.py`, such as specifying the image output format (e.g., "png", "raw"), enabling zoom on diagrams, or pinning the [Mermaid version] used for rendering.

See [Mermaid configuration values] for more information.

## Add a new diagram

Use the `mermaid` directive to embed a Mermaid diagram into your documentation.
You start by declaring the type of diagram (e.g. "flowchart", "sequenceDiagram", "timeline", etc), followed by definition and contents.
It is also possible to specify additional configuration or custom styles, depending on the diagram type.

Some examples will be covered below.

```{seealso}
See the [Mermaid - Diagram syntax] reference for details on the syntax and customization options for each diagram type.
```

### Flowchart diagram with default settings

The left-to-right flowchart below uses the default Mermaid settings.

```{include} /reuse/mermaid.txt
:start-after: mermaid-diagram-flowchart-start
:end-before: mermaid-diagram-flowchart-end
```

### Timeline diagram with pre-defined theme

The timeline diagram below uses a [pre-defined Mermaid theme].

```{include} /reuse/mermaid.txt
:start-after: mermaid-diagram-timeline-start
:end-before: mermaid-diagram-timeline-end
```

### Sequence diagram with global custom CSS

The sequence diagram below has custom styling applied using a global CSS file.
A global CSS file enables the styles to be easily applied to all sequence diagrams, based on the classes defined in your stylesheet.
You can also use the global CSS file to customize the diagrams in dark mode.

```{include} /reuse/mermaid.txt
:start-after: mermaid-diagram-sequence-start
:end-before: mermaid-diagram-sequence-end
```

### State diagram with image-specific styles

The state diagram below has image-specific custom styling applied using the [`classDef` keyword].

```{include} /reuse/mermaid.txt
:start-after: mermaid-diagram-state-start
:end-before: mermaid-diagram-state-end
```

## Projects using Mermaid

Here are some Canonical projects that use Mermaid for diagramming in their documentation:

- [Checkbox](https://canonical-checkbox.readthedocs-hosted.com/stable/explanation/remote/)
- [cloud-init](https://docs.cloud-init.io/en/latest/explanation/boot.html)
- [Charmed MySQL K8s](https://canonical-charmed-mysql-k8s.readthedocs-hosted.com/explanation/flowcharts/#)
- [Ubuntu Pro](https://documentation.ubuntu.com/pro/support-overview/)

## Related topics

- See the [Official Mermaid documentation] for setup and configuration instructions, full syntax for the different types of Mermaid diagrams.
- Try out the [Mermaid Live Editor] if you want a playground to work on your diagrams.

% LINKS

[Mermaid version]: https://unpkg.com/browse/mermaid/
[Mermaid configuration values]: https://sphinxcontrib-mermaid-demo.readthedocs.io/en/latest/#config-values
[Mermaid - Diagram syntax]: https://mermaid.js.org/intro/syntax-reference.html
[pre-defined Mermaid theme]: https://mermaid.js.org/syntax/timeline.html#themes
[`classDef` keyword]: https://mermaid.js.org/syntax/stateDiagram.html#styling-with-classdefs
[Official Mermaid documentation]: https://mermaid.js.org/intro/
[Mermaid Live Editor]: https://mermaid.live/
[C4 model]: https://c4model.com/
[Dia]: http://dia-installer.de/
[PlantUML]: https://plantuml.com/
[Structurizr]: https://structurizr.com/