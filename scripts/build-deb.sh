#!/bin/bash
set -e

# Read package metadata directly from the DEBIAN/control file (Single Source of Truth)
PACKAGE_NAME=$(grep -i '^Package:' package/DEBIAN/control | awk '{print $2}')
VERSION=$(grep -i '^Version:' package/DEBIAN/control | awk '{print $2}')
ARCH=$(grep -i '^Architecture:' package/DEBIAN/control | awk '{print $2}')

if [ -z "$VERSION" ]; then
    echo "Error: Could not extract Version from package/DEBIAN/control"
    exit 1
fi

OUTPUT="${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"

echo "Building $PACKAGE_NAME version $VERSION for $ARCH..."

# Clean up any existing builds of this exact version locally
rm -f "$OUTPUT"

# Ensure the executable has the correct permissions before packaging
chmod +x package/usr/bin/* 2>/dev/null || true

# Build the Debian package
dpkg-deb --build package "$OUTPUT"

echo "Successfully built: $OUTPUT"
