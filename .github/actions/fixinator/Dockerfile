from ghcr.io/foundeo/cfml-ci-tools/cfml-ci-tools:1.0.4

COPY entrypoint.sh $GITHUB_WORKSPACE

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT [ "/app/entrypoint.sh" ]