# Pocket GO toolchain docker image

Small Dockerfile to build a toolchain docker image for rust development on PocketGO.

## Build the docker image

```
$ docker build -t pocketgo-rust .
```

The [toolchain](https://github.com/bittboy/buildroot.git) is based on a fork of the
[buildroot](https://buildroot.org/) project.

I am using [rustup](https://rustup.rs/) to download and install `cargo`, `rust` and the standard 
library for the PocketGo target `armv5te-unknown-linux-musleabi`. 

## Create a new rust project

```
$ docker run -it pocketgo-rust
# cd /root
# cargo init my_project
# cargo build
```

You can also mount a local project inside the container using `-v`.