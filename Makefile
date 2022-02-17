# Copyright 2020 Canonical Ltd.
# Licensed under the AGPLv3, see LICENCE file for details.

BUILD_IMAGE=bash -c '. "./make_functions.sh"; build_image "$$@"' build_image
IMAGES=$(shell cat images.yaml | yq -o=t '.images | keys')

default: build

build: OUTPUT_TYPE = "type=image,push=false"
build: $(IMAGES)

check:
	shellcheck ./*.sh

push: OUTPUT_TYPE = "type=image,push=true"
push: $(IMAGES)

%:
	$(BUILD_IMAGE) "$@" "$(OUTPUT_TYPE)"

.PHONY: default
.PHONY: build
.PHONY: check
.PHONY: push
.PHONY: %

