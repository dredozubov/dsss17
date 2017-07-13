FROM ubuntu:16.04

MAINTAINER John Wiegley <jwiegley@gmail.com>
LABEL Description="Software dependencies for DeepSpec Summer School 2017"

# Install basic dependencies
RUN apt-get update && \
    apt-get --no-install-recommends install -y \
    curl ca-certificates bzip2 adduser perl python git

# Create the Nix user
RUN adduser --disabled-password --gecos '' nix && \
    mkdir -m 0755 /nix && chown nix /nix
USER nix
ENV USER nix
WORKDIR /home/nix

# Install Nix
RUN curl -o /tmp/install https://nixos.org/nix/install && sh /tmp/install

# Build the DSSS17 software dependencies
COPY ./ dsss17
USER root
RUN chown -R nix /home/nix && chmod -R u+rwX /home/nix
USER nix
WORKDIR /home/nix/dsss17
RUN . ~/.nix-profile/etc/profile.d/nix.sh && nix-build -Q -j4

# When run, put the user into the DSSS17 environment inside a "work" directory
WORKDIR /home/nix/work
CMD ["/home/nix/dsss17/result/bin/load-env-dsss17"]
