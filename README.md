# _Wharf_

[![Build](https://github.com/chaseruskin/wharf/actions/workflows/build.yml/badge.svg?branch=trunk)](https://github.com/chaseruskin/verb/actions/workflows/pipeline.yml) [![DockerHub](https://img.shields.io/badge/DockerHub-images-important.svg?logo=docker)](https://hub.docker.com/u/chaseruskin) 

A collection of Dockerfiles for building docker images that contain tools needed for digital hardware (FPGA/ASIC) development.

## Supported Images

The following tools are built into separate images and are available on [DockerHub](https://hub.docker.com/u/chaseruskin):

- ### ModelSim-Intel (Ubuntu 18.04)
```
$ vsim -version
Model Technology ModelSim ALTERA STARTER EDITION vsim 10.5b Simulator 2016.10 Oct  5 2016
```

- ### Intel Quartus Prime Lite (Ubuntu 18.04)

```
$ quartus_sh -version
Quartus Prime Shell
Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition
Copyright (C) 2019  Intel Corporation. All rights reserved.
```

- ### GHDL (Ubuntu 22.04)

```
$ ghdl -v
```

## Details

Each tool has its own respective directory which contains the `Dockerfile` used to build the relevant image. Jobs processed through GitHub Actions are responsible for running the docker builds and updating DockerHub with the latest images.