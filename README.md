# charm-base-images

## Introduction
This repository is used for bulding the base charm images used by
[Juju](github.com/juju/juju/) in versions 2.9.0 onwards. Charm base images
provide the foundation layer for which charms and their associated application
code can excute on top of.

## Preerequisites
- Docker 19.02 (requires buildx support with quemu for building multiple
  platforms). See [Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/) for more
  information.
- GNU Make
- Bash
- [yq](https://github.com/mikefarah/yq)

**Optional**

- [act](https://github.com/nektos/act) For testing changes to this projects
  Github Actions.

## Image Locations
Images built by this repository can be found at:
- [Docker Hub](https://hub.docker.com/r/jujusolutions/charm-base)

## Usage

### Building the images in this repository
Images can be built by either running:

```sh
make
```

or

```sh
make build
```

### Pushing the images in this repository
Images can be built and pushed to a registry by runing:

```sh
make push
```

> :warning: **If you are pushing**: Be aware this repo is configured to push to
the official jujusolutions repository and may need to be change in
[images.yaml](./images.yaml).

### Adding, Removing, Updating image built by this repository.
All of the various sku's controlled by this repository can be found in
[images.yaml](./images.yaml).

To control how and what images are built by this repository please update this
file.
