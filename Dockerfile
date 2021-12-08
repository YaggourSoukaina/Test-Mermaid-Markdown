# FROM debian:9.5-slim
FROM minlag/mermaid-cli:latest

COPY entrypoint.sh /entrypoint.sh
COPY render-md-mermaid.sh /render-md-mermaid.sh

RUN ["chmod", "render-md-mermaid.sh", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]

