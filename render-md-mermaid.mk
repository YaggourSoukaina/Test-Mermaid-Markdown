.PHONY: render-md-mermaid
.PHONY: demo-md-mermaid

render-md-mermaid: $(shell find . -name "render-md-mermaid.sh") $(shell find . -name "*.md") ## Render all mermaid graphs in any .md file in the repository
	@for md in $(shell find . -name "*.md"); do "./$<" "$$md"; done
	
demo-md-mermaid: $(shell find . -name "demo-md-mermaid.sh") $(shell find . -name "*.md") ## Render all mermaid graphs in any .md file in the repository
	@for md in $(shell find . -name "*.md"); do "./$<" "$$md"; done
