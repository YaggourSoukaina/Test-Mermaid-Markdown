# This can be invoked on any Markdown file to render embedded mermaid diagrams, provided they are presented in the following format:
#
# ![rendered image description](relative/path/to/rendered_image.png)
# <details>
#   <summary>diagram source</summary>
#   This details block is collapsed by default when viewed in GitHub. This hides the mermaid graph definition, while the rendered image
#   linked above is shown. The details tag has to follow the image tag. (newlines allowed)
#
# ```mermaid
# graph LR
#    A[Christmas] -->|Get money| B(Go shopping)
#    B --> C{Let me think}
#    C -->|One| D[Laptop]
#    C -->|Two| E[iPhone]
#    C -->|Three| F[fa:fa-car Car]
# ```
# </details>
