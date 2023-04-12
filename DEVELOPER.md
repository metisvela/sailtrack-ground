> **Note**
> 
> Since SailTrack Ground is almost an exact copy of [SailTrack Core](https://github.com/metis-vela-unipd/sailtrack-core), you can start from the SailTrack Core [Developer's Guide](https://github.com/metis-vela-unipd/sailtrack-core/blob/main/DEVELOPER.md).

# Developer's Guide
This guide is intended to introduce new developers to all the aspects needed to contribute to SailTrack Ground.
If you haven't already, read the [documentation repository](https://github.com/metis-vela-unipd/sailtrack-docs) carefully to familiarize yourself with the SailTrack project and its components.
In this guide, we will assume that you're already familiar with the overall behavior of the system.

## Overview
SailTrack Ground is almost an exact copy of [SailTrack Core](https://github.com/metis-vela-unipd/sailtrack-core).
The idea behind this decision is to have a copy of SailTrack Core with the only difference being that the data are not coming from real sensor measurements but from a LoRa radio link.
To achieve this, the following modifications have been applied to the SailTrack Core system:
* Added the [`sailtrack-lora2mqtt`](https://github.com/metis-vela-unipd/sailtrack-ground/blob/main/sailtrack/sailtrack-lora2mqtt) script, which receives data from LoRa and publishes them as if they were coming from actual sensors.
* Removed the `sailtrack-processor` script, since the measurements coming from LoRa are already processed by SailTrack Core.
* Removed the `sailtrack-status` script, since the SailTrack Ground module is often not battery operated or under stress (there is no need to know its status).

On top of this, SailTrack Ground runs a desktop interface with Chromium in kiosk mode connected to the Grafana dashboards.
In this way, it's possible to connect SailTrack Ground to a monitor and automatically open the real-time dashboards.
