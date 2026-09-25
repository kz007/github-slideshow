FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# System packages + Ruby toolchain for the Jekyll (github-pages) site.
# Baking Ruby into the image is required because apt-installed packages do not
# persist through Cloud Agent snapshots/builds when installed at boot time.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        sudo \
        ruby-full \
        build-essential \
        zlib1g-dev \
        libyaml-dev \
        libffi-dev \
    && gem install bundler \
    && rm -rf /var/lib/apt/lists/*

# Ensure the non-root "ubuntu" user (uid 1000) expected by Cloud Agent tooling
# exists and has passwordless sudo.
RUN (id ubuntu >/dev/null 2>&1 || useradd -m -s /bin/bash -u 1000 ubuntu) \
    && echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

USER ubuntu
