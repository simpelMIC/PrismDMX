# PrismDMX

PrismDMX is a Swift application designed to facilitate the control and management of DMX-based lighting fixtures. It provides a user-friendly interface for configuring, controlling, and customizing DMX devices, making it ideal for use in stage lighting, events, and installations.

## Features

- **DMX Control**: PrismDMX allows users to control DMX-based lighting fixtures with ease, providing intuitive controls for adjusting channel values and settings.
  
- **Fixture Management**: Users can manage fixtures by adding, removing, and configuring various types of lighting devices, including dimmers, RGB fixtures, moving heads, lasers, and more.
  
- **Customization**: PrismDMX offers customization options for fixture control, allowing users to tailor settings and channels according to their specific lighting requirements.
  
- **Color Control**: The application includes features for controlling color parameters, enabling users to manipulate RGB, RGBW, and other color channels with precision.
  
- **Streamlined Interface**: With a clean and organized interface, PrismDMX ensures that users can navigate and operate the application efficiently, even in complex lighting setups.

## Getting Started

To get started with PrismDMX, follow these steps:

**Install on Ubuntu**: Install PrismDMX with https://github.com/simpelMIC/PrismDMX/Installation/install_pmx.sh or with the following command:
```
bash -c 'sudo apt update && sudo apt install -y git && git clone https://github.com/simpelMIC/PrismDMX.git temp && mv temp/* temp/.* . 2>/dev/null || true && rm -rf temp && chmod +x install_swift.sh run.sh build.sh install_required_packages.sh && ./install_required_packages.sh && ./install_swift.sh && ./build.sh && echo "Installation done..." && read -p "Would you like to launch PrismDMX? (y/n): " LAUNCH && [[ "$LAUNCH" == "y" ]] && echo "Launching..." && ./run.sh || echo "Done"'
```
If you want to run the Application, go in the Application Folder and start ./run.sh:
```
./run.sh
```

## Contributing

Contributions to PrismDMX are welcome! If you encounter any bugs, have feature requests, or would like to contribute enhancements, please feel free to submit a pull request or open an issue on the GitHub repository.

## License

PrismDMX is licensed under the MIT License.
