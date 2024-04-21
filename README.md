# `wharf`

A collection of Dockerfiles for building FPGA docker images.

## Project Layout

Each tool has its own respective directory which contains the `Dockerfile` used to build the relevant image. Jobs processed through GitHub Actions are responsible for running the docker builds and updating DockerHub with the latest images.

## Supported Images

The following tools are available on [DockerHub](https://hub.docker.com/u/cdotrus):

- ### ModelSim-Intel (Ubuntu 18.04)
```
Model Technology ModelSim ALTERA STARTER EDITION vsim 10.5b Simulator 2016.10 Oct  5 2016
```

- ### Intel Quartus Prime Lite (Ubuntu 18.04)

```
Quartus Prime Shell
Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition
Copyright (C) 2019  Intel Corporation. All rights reserved.
```