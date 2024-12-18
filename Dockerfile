FROM ubuntu:24.04

COPY scripts/docker-setup /opt/docker-setup
RUN /opt/docker-setup

COPY . /opt/no-place-like-home
RUN chown -R jwilcox:jwilcox /opt/no-place-like-home

WORKDIR /opt/no-place-like-home
ENV NO_BECOME_PROMPT=1
ENV USER=jwilcox
USER jwilcox
RUN ln -sf playbooks/work-docker.yml playbook.yml
RUN ./setup
