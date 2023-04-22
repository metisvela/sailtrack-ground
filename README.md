<p align="center">
  <img src="https://raw.githubusercontent.com/metis-vela-unipd/sailtrack/main/Assets/SailTrack%20Logo.svg" width="180">
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/metis-vela-unipd/sailtrack-ground" />
  <img src="https://img.shields.io/github/v/release/metis-vela-unipd/sailtrack-ground" />
  <img src="https://img.shields.io/github/actions/workflow/status/metis-vela-unipd/sailtrack-ground/publish.yml" />
</p>

# SailTrack Ground

SailTrack Ground is the ground station of the SailTrack system, it receives, stores and visualizes real-time data coming from the boat via a radio link. To learn more about the SailTrack project, please visit the [project repository](https://github.com/metis-vela-unipd/sailtrack).

The SailTrack Ground module is based on a battery powered Raspberry Pi SBC running a custom version of the Raspberry Pi OS, namely, [DietPi](https://dietpi.com). For a more detailed hardware description of the module, please refer to the [Bill Of Materials](hardware/BOM.csv).

The module performs the following tasks:

* It receives data coming from the boat using LoRa.
* It creates the SailTrack Ground Network, the WiFi network to which connect in order to view the live dashboards.
* It runs the [InfluxDB](https://www.influxdata.com) database, gathering all the measurements coming from the boat.
* It runs the [Grafana](https://grafana.com) server, for the visualization of real-time and logged metrics.

<p align="center">
  <br/>
  <img src="hardware/Connection Diagram.svg">
</p>

## Installation

Follow the instructions below to get the SailTrack Ground OS correctly installed. If you encounter any problem, please [open an issue](https://github.com/metis-vela-unipd/sailtrack-ground/issues/new).

1. [Download](https://github.com/metis-vela-unipd/sailtrack-ground/releases/latest/download/SailTrack-Ground_RPi-ARMv8-Bullseye.7z) and extract the latest SailTrack Ground OS image.
2. Insert the Raspberry Pi microSD card into the computer.
3. Flash the downloaded `.img` file into the SD card using a flashing tool such as [balenaEtcher](https://www.balena.io/etcher/).
4. **(OPTIONAL)** Change the passwords from the default ones by modifying the `AUTO_SETUP_GLOBAL_PASSWORD` and the `SOFTWARE_WIFI_HOTSPOT_KEY` in the `dietpi.txt` file located inside the SD card.
5. Eject the SD card from the computer and insert it into the Raspberry Pi.
6. Connect the Raspberry Pi to internet with an ethernet cable.
7. Power on the Raspberry Pi. The first run setup will automatically start to download and configure the required packages. *Note: this might take a few minutes, depending on the internet connection quality, follow the next step to check the installation progress.*
8. **(OPTIONAL)** Check the installation progress:
   1. Connect to the Raspberry Pi using a device connected to the same network:
      ```
      ssh root@<raspberry-ip-address>
      ```
      The `<raspberry-ip-address>` can be found by checking the router administration dashboard or by using a tool such as [Angry IP Scanner](https://angryip.org). The password is the default one (`dietpi`) or the one set in Step 4.
   2. Dismiss the `DietPi first run setup is currently running on another screen` message by hitting <kbd>Ctrl</kbd> + <kbd>C</kbd>.
   3. Check the logs coming from the installation progress with the following command:
      ```
      tail -f /var/tmp/dietpi/logs/dietpi-firstrun-setup.log
      ```
9. Wait until the `SailTrack-GroundNet` WiFi network is visible, meaning that the installation process has been successfully completed.

## Usage

Once the installation process has been successfully completed, you can use SailTrack Ground by following the steps below.

1. Power on the module by pressing the power push button. Once the module is powered up, it will automatically start to receive measurments from the boat.
2. Connect to the `SailTrack-GroundNet` WiFi network with your pc, smartphone, tablet,... (password: `sailtracknet` or the one set in Step 4 of the installation).
3. Visit http://192.168.42.1:3001 (user: `admin`, password: `dietpi` or the one set in Step 4 of the installation) to connect to the Grafana dashboards to see real-time data and browse the database. To learn more about using Grafana, visit the [official guide](https://grafana.com/docs/grafana/latest/getting-started/getting-started/).
Alternatively, you can plug SailTrack Ground to a monitor with an HDMI cable and the real-time dashboard will automatically be displayed.
4. To power off the module press and hold the power push button of the Ground module until the power light starts blinking.

## Contributing

Contributors are welcome. If you are a student of the University of Padua, please apply for the Métis Vela Unipd team in the [website](http://metisvela.dii.unipd.it), specifying in the appliaction form that you are interested in contributing to the SailTrack Project. If you are not a student of the University of Padua, feel free to open Pull Requests and Issues to contribute to the project.

To learn more about contributing to this repository, check out the [Developer's Guide](DEVELOPER.md).

## License

Copyright © 2023, [Métis Vela Unipd](https://github.com/metis-vela-unipd). SailTrack Ground is available under the [GPL-3.0 license](https://www.gnu.org/licenses/gpl-3.0.en.html). See the LICENSE file for more info. 
