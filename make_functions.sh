#!/bin/bash
set -euf

_tag_argument_builder() {
  reg_paths=$1
  tags=$2

  output=""
  for reg_path in ${reg_paths//,/ }; do
    for tag in ${tags//,/ }; do
      output="${output} -t ${reg_path}:${tag}"
    done
  done

  echo "$output"
}

build_image() {
  image=${1-""}
  if [ -z "$image" ]; then
    echo "You must supply the image to build in images.yaml"
    exit 1
  fi
  output=${2-""}
  if [ -z "$output" ]; then
    echo "You must supply the docker buildx output to use for image ${image}"
    exit 1
  fi

  dockerfile=$(yq ".images.[\"${image}\"].dockerfile" < images.yaml)
  context=$(yq ".images.[\"${image}\"].context" < images.yaml)
  bases=$(yq -o=c  ".images.[\"${image}\"].bases | keys" < images.yaml)
  reg_paths=$(yq -o=c ".images.[\"${image}\"].registry_paths" < images.yaml)

  echo "Building ${image} images from bases: $bases"
  for base in ${bases//,/ }; do
    echo "Building ${image} image for base: ${base}"
    # Convert any : in to - for the tag
    tag=${base//:/-}
    platforms=$(yq -o=c ".images[\"${image}\"].bases.[\"${base}\"].platforms" < images.yaml)
    tags=$(_tag_argument_builder "$reg_paths" "$tag")

    docker buildx build --platform "${platforms}" --build-arg "BASE_IMAGE=${base}" \
      -f "$dockerfile" "$context"  ${tags} -o "$output"
  done
}
