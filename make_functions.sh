#!/bin/sh
set -euf

# Docker variables
DOCKER_USERNAME=${DOCKER_USERNAME:-jujusolutions}
DOCKER_BIN=${DOCKER_BIN:-$(which docker)}
BASE_IMAGE=${BASE_IMAGE:-ubuntu}

_base_image() {
    BASE_TAG=$1
    IMG_linux_amd64="amd64/${BASE_IMAGE}:${BASE_TAG}" \
    IMG_linux_arm64="arm64v8/${BASE_IMAGE}:${BASE_TAG}" \
    IMG_linux_ppc64le="ppc64le/${BASE_IMAGE}:${BASE_TAG}" \
    IMG_linux_s390x="s390x/${BASE_IMAGE}:${BASE_TAG}" \
    printenv "IMG_$(go env GOOS)_$(go env GOARCH)"
}

_image_path() {
    BASE_TAG=$1
    echo "${DOCKER_USERNAME}/${BASE_IMAGE}:${BASE_TAG}"
}

build_image() {
    BASE_TAG=$1
    "${DOCKER_BIN}" build --build-arg BASE_IMAGE=$(_base_image $BASE_TAG) -t "$(_image_path $BASE_TAG)" -f "Dockerfile-${BASE_IMAGE}" .
}
