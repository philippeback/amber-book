#!/bin/bash

VM_INSTALL_URL="http://get.pharo.org/vm"
IMAGE_URL="https://ci.inria.fr/pharo-contribution/job/Pillar/PHARO=30,VERSION=stable,VM=vm/lastSuccessfulBuild/artifact/Pillar.zip"

usage() {
    cat <<HELP
Usage: $0 [-h|--help] [vm] [image]

Downloads the latest image and virtual machine (edit the script to set from where).  By default, only the image will be downloaded.

image: $IMAGE_URL
   VM: $VM_INSTALL_URL
HELP
}

get_vm() {
    curl "$VM_INSTALL_URL" | bash
}

get_image() {
    local tempzip="/tmp/image$$.zip"
    local tempzipdir="/tmp/unzipimage$$"
    trap "rm '$tempzip'; rm -r '$tempzipdir'" EXIT

    curl -# -o "$tempzip" "$IMAGE_URL"
    unzip "$tempzip" -d "$tempzipdir"
    for f in $(ls -1  "$tempzipdir"); do
        ext="${f##*.}"
        file=$(basename $f)
        if [ "$ext" == image -o "$ext" == changes ]; then
            echo "Pharo.$ext"
            cp "$tempzipdir/$f" "Pharo.$ext"
        elif [ "$file" == "pillar" ]; then
            echo pillar
            cp "$tempzipdir/$f" "pillar"
            chmod +x pillar
        fi
    done
}
prepare_image() {
    ./pharo Pharo.image --no-default-preferences eval --save "StartupPreferencesLoader allowStartupScript: false."
    ./pharo Pharo.image eval --save "Deprecation raiseWarning: false; showWarning: false. 'ok'"
}

# stop the script if a single command fails
set -e

should_prepare_image=0

if [ $# -eq 0 ]; then
    get_image
    get_vm
    should_prepare_image=1
else
    while [ $# -gt 0 ]; do
        case "$1" in
            -h|--help|help)
                usage; exit 0;;
            v|vm)
                get_vm;;
            i|img|image)
                get_image;
                should_prepare_image=1;;
            *) # boom
                usage; exit 1;;
        esac
        shift
    done
fi

if [[ $should_prepare_image -eq 1 ]]; then
    echo Preparing Pillar image
    prepare_image
fi
