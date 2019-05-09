FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
        sudo \
        passwd \
        software-properties-common \
        build-essential # This is just to speed up the startup bits

RUN useradd -u 1000 --user-group --create-home -G sudo jwilcox
RUN echo jwilcox:testpassword | chpasswd

COPY . /opt/no-place-like-home
RUN chown -R jwilcox:jwilcox /opt/no-place-like-home
RUN echo "jwilcox ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers

WORKDIR /opt/no-place-like-home
ENV NO_BECOME_PROMPT 1
ENV USER jwilcox
USER jwilcox
CMD ./setup
