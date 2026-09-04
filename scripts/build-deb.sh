#!/bin/bash

set -e

PACKAGE_NAME="hello-asama"
VERSION="1.0.3"
ARCH="amd64"

OUTPUT="${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"

rm -f "$OUTPUT"

dpkg-deb --build package "$OUTPUT"

echo "Built: $OUTPUT"
