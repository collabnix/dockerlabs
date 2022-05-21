FROM prom/prometheus:v1.5.2

ARG "version=0.1.0-dev"
ARG "build_date=unknown"
ARG "commit_hash=unknown"
ARG "vcs_url=unknown"
ARG "vcs_branch=unknown"

LABEL org.label-schema.vendor="Softonic" \
    org.label-schema.name="Prometheus" \
    org.label-schema.description="Scrapes node-exporter, cadvisor, prometheus and swarm metrics (4999 port)." \
    org.label-schema.usage="/src/README.md" \
    org.label-schema.url="https://github.com/bvis/docker-prometheus-swarm/blob/master/README.md" \
    org.label-schema.vcs-url=$vcs_url \
    org.label-schema.vcs-branch=$vcs_branch \
    org.label-schema.vcs-ref=$commit_hash \
    org.label-schema.version=$version \
    org.label-schema.schema-version="1.0" \
    org.label-schema.docker.cmd.devel="" \
    org.label-schema.build-date=$build_date

ADD rootfs /
