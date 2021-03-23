# Copyright 2020 Canonical Ltd.
# Licensed under the AGPLv3, see LICENCE file for details.

DOCKER_USERNAME ?= jujusolutions
BUILD_IMAGE=sh -c '. "./make_functions.sh"; build_image "$$@"' build_image
IMAGE_TAG=sh -c '. "./make_functions.sh"; image_tag "$$@"' image_tag 
IMAGES=ubuntu\:20.04 ubuntu\:18.04 ubuntu\:20.10 ubuntu\:21.04

default: build

build: $(IMAGES)

ubuntu\:% :
	BASE_IMAGE=ubuntu $(BUILD_IMAGE) $(shell echo  $@ | cut -f 2 -d ':')

print-image-tags:
	@$(foreach image,$(IMAGES), BASE_IMAGE=$(shell echo $(image) | cut -f 1 -d ':') $(IMAGE_TAG) $(shell echo $(image) | cut -f 2 -d ':') ; )

.PHONY: default
.PHONY: build
.PHONY: ubuntu\:%
.PHONY: print-image-tags

