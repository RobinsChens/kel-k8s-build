#!/bin/bash
set -e

here=$(cd "$(dirname "${BASH_SOURCE}")"; pwd -P)
. $here/_env.sh

cd kubernetes
make all

cd ../hyperkube
cp ../kubernetes/_output/local/go/bin/hyperkube .
sed "s/VERSION/${BUILD_TAG}/g" master.yml
docker build -t quay.io/kelproject/hyperkube .
