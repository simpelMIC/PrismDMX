#!/bin/bash

# Install required packages
echo "Installing required packages..."
sudo apt update
sudo apt install -y git

echo "Downloading program files..."

git clone https://github.com/simpelMIC/PrismDMX.git temp
mv temp/* temp/.* .
rm -rf temp

# Run the other script (replace with the correct path to the script)
echo "Installing swift..."
chmod +x install_swift.sh
chmod +x run.sh
chmod +x build.sh
chmod +x install_required_packages.sh

./install_required_packages.sh

./install_swift.sh

./build.sh

echo "Installation done..."

read -p "Would you like to launch PrismDMX? (y/n): " LAUNCH

if [[ "$LAUNCH" == "y" ]]; then
echo "Launching..."
./run.sh
else
echo "Done"
fi
