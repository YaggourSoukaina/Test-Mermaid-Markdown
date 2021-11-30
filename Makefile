.PHONY: all build clean help test

all: help

build: render-md-mermaid ## Invoke render-md-mermaidm

clean: ## Remove rendered image
	@rm -f demo/rendered_image.{svg,png}

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

test: clean build ## Remove the rendered image, invoke the script an see if the expected image was craeted
	@ls demo/rendered_image.png
	@echo "👍"

-include render-md-mermaid.mk
