# Copyright 2020 Canonical Ltd.
# Licensed under the AGPLv3, see LICENCE file for details.

ARCHS = amd64
OPERATOR_IMAGE_ACCOUNT = jujusolutions
VERSION = 2.9.0

default: build-ubuntu

build-ubuntu: ubuntu\:bionic-20200807 ubuntu\:focal-20200729

ubuntu\:% : 
	@for i in $(ARCHS); do \
		echo "Building ubuntu oci image for $@ and arch $$i"; \
		docker build --build-arg 'BASE_IMAGE=$@' -f Dockerfile-ubuntu . -t $(OPERATOR_IMAGE_ACCOUNT)/$$i/juju-oci:$(VERSION)-$(shell echo  $@ | cut -f 2 -d ':'); \
	done

