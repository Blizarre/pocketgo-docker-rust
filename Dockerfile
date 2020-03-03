FROM ubuntu:18.04

ENV GIT_CHECKOUT_DIR=/root/buildroot
ENV INSTALL_DIR=/opt/buildroot

RUN apt-get update && apt-get install -y \
    # Generic packages
    vim \
    htop \
    curl \
    git \
    # buildroot-specific packages
    build-essential \
    bison \
    wget \
    cpio \
    python \
    libncurses-dev \
    unzip \
    rsync \
    bc \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/bittboy/buildroot.git $GIT_CHECKOUT_DIR \
    && make -C $GIT_CHECKOUT_DIR sdk \
    && rm $GIT_CHECKOUT_DIR/output/images/* \
    && ln -s "$GIT_CHECKOUT_DIR/output" "$INSTALL_DIR"

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /root/rustup_installer \
    && sh /root/rustup_installer -y \
    && rm /root/rustup_installer \
    && . $HOME/.cargo/env \
    && rustup target add armv5te-unknown-linux-musleabi

COPY cargo_config /root/.cargo/config

ENV PATH="$PATH:$INSTALL_DIR/host/bin"
ENV USER=root

CMD bash -l