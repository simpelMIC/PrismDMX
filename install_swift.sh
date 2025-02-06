#!/bin/bash

# Make sure the system is updated
sudo apt-get update -y
sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install -y clang libicu-dev libssl-dev libblocksruntime-dev

# Download Swift

read -p "For which Ubuntu-Version are you installing Swift? (e.g. 20.04): " UBUNTU_VERSION
read -p "Which Swift-Version would you like to install? (e.g. 6.0.3): " SWIFT_VERSION
read -p "Would you like to install the aarch64 Version? (y/n): " AARCHYN

if [[ "$AARCHYN" == "y" ]]; then
AARCH="-aarch64"
else
AARCH=""
fi

UBUNTU_VERSION_RAW="${UBUNTU_VERSION//./}"

SWIFT_URL="https://download.swift.org/swift-${SWIFT_VERSION}-release/ubuntu${UBUNTU_VERSION_RAW}${AARCH}/swift-${SWIFT_VERSION}-RELEASE/swift-${SWIFT_VERSION}-RELEASE-ubuntu${UBUNTU_VERSION}${AARCH}.tar.gz"

# Download Swift
echo "Downloading Swift ${SWIFT_VERSION}..."
wget ${SWIFT_URL} -O swift-${SWIFT_VERSION}.tar.gz

# Extract Swift
echo "Extracting Swift..."
tar -xvzf swift-${SWIFT_VERSION}.tar.gz

# Move Swift to /usr/local
echo "Moving directories..."
sudo mv swift-${SWIFT_VERSION}-RELEASE-ubuntu${UBUNTU_VERSION} /usr/local/swift

# Add Swift to PATH
echo "Adding Swift to PATH..."
echo 'export PATH=/usr/local/swift/usr/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Clean up
rm swift-${SWIFT_VERSION}.tar.gz

echo "Swift ${SWIFT_VERSION} installation complete!"
echo "Verifying..."
swift --version
echo "You can verify the installation yourself by typing: swift --version"