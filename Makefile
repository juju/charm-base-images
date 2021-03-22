# Copyright 2020 Canonical Ltd.
# Licensed under the AGPLv3, see LICENCE file for details.

DOCKER_USERNAME ?= jujusolutions
BUILD_IMAGE=sh -c '. "./make_functions.sh"; build_image "$$@"' build_image

default: build-ubuntu

build-ubuntu: ubuntu\:20.04 ubuntu\:18.04 ubuntu\:20.10 ubuntu\:21.04

ubuntu\:% :
	$(BUILD_IMAGE) $(shell echo  $@ | cut -f 2 -d ':')

.PHONY: default
.PHONY: build-ubuntu
.PHONY: ubuntu\:%
