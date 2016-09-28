#!/bin/bash
SOURCE_DIR=${PACKER_OUTPUT_DIRECTORY}

set -e
if [ ! -z "${DEBUG}" ]; then
  set -x
fi

DEPENDENCIES=("ovftool")
for dep in "${DEPENDENCIES[@]}"
  do
    if [ ! $(which ${dep}) ]; then
        echo "${dep} must be available."
	exit 1
    fi
done


if [[ -z "${SOURCE_DIR}" ]]; then
  echo "Source VMX folder not found"
  exit 1
fi

for vmx in "$SOURCE_DIR"/*.vmx; do
  name=$(basename "${vmx}" .vmx)
  ovftool -dm=thin --compress=1 "${vmx}" "${SOURCE_DIR}/${name}.ova"
done
