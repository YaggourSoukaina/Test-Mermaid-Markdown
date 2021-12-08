# FROM debian:9.5-slim
FROM minlag/mermaid-cli:latest

WORKDIR /render-md-mermaid.sh
COPY entrypoint.sh /entrypoint.sh
COPY render-md-mermaid.sh /render-md-mermaid.sh

ENV ENTRYPOINT_PATH / render-md-mermaid.sh

ENTRYPOINT ["/render-md-mermaid.sh/entrypoint.sh"]
CMD [ "--help" ]
