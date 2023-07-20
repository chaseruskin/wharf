# Dock: Create a docker image containing tools and programs required
#   to run FPGA toolflow (synthesis to bitstream).

# Stage 0: OS layer (Ubuntu 18.04) 
FROM ubuntu:18.04

# LABEL about the custom image
LABEL maintainer="crus800"
LABEL description="Quartus Prime Lite 19.1 on Ubuntu 18.04."

# Set the timezone
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install image dependencies
RUN apt-get update && apt-get -y install \
    tzdata \
    libglib2.0-0 \
    expect \
    libtcmalloc-minimal4 \
    locales \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set LOCALE to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

# Download and install Intel Quartus Prime Lite
RUN mkdir -p /root/quartus \
    && cd /root/quartus \
    && wget -q http://download.altera.com/akdlm/software/acdsinst/19.1std/670/ib_tar/Quartus-lite-19.1.0.670-linux.tar -O ./Quartus-lite-19.1.0.670-linux.tar \
    && tar -xvf ./Quartus-lite-19.1.0.670-linux.tar \
    && chmod +x ./components/QuartusLiteSetup-19.1.0.670-linux.run \
    && ./components/QuartusLiteSetup-19.1.0.670-linux.run --installdir /opt/intelFPGA_lite/19.1 --accept_eula 1 --mode unattended --disable-components modelsim_ase \
    && rm -rf /opt/intelFPGA_lite/19.1/nios2eds \
    && rm -rf /root/quartus

# Add Quartus binaries to path 
ENV PATH "$PATH:/opt/intelFPGA_lite/19.1/quartus/bin"

# Hacks for fixing malloc errors when using Quartus
ENV LD_PRELOAD "/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4"
RUN mv "/opt/intelFPGA_lite/19.1/quartus/linux64/libstdc++.so.6" "/opt/intelFPGA_lite/19.1/quartus/linux64/libstdc++.so.6.err"
ENV LD_LIBRARY_PATH "/usr/lib/x86_64-linux-gnu/"

# Enter the shell
CMD ["bash"]