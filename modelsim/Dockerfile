# Dock: Create a docker image containing tools and programs required
#   to run simulations.
#
# References: 
#   https://staff.cs.upt.ro/~opritoiu/ca/labs/modelsim.pdf
#   https://github.com/goldenSniperOS/modelsim-docker/blob/master/Dockerfile

# Stage 0: OS layer (Ubuntu 18.04) 
FROM ubuntu:18.04

# LABEL about the custom image
LABEL maintainer="crus800"
LABEL description="ModelSim-Intel Starter Edition 19.1 on Ubuntu 18.04."

# Set the timezone
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install ModelSim-Intel dependencies (32-bit stuff)
# Reference: https://stackoverflow.com/questions/62718951/how-to-fix-libxft-so-2-cannot-open-shared-object-file-when-simulating-hardware
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get -y install \
    libc6:i386 \
    libncurses5:i386 \
    libx11-6:i386 \
    libxtst6:i386 \
    libstdc++6:i386 \
    libxft2 \
    libxft2:i386 \
    lib32ncurses5 \
    libxext6 \
    libxext6:i386 
    # lib32ncurses6 # not available on 18.04

# Install image dependencies
RUN apt-get update && apt-get -y install \
    tzdata \
    libglib2.0-0 \
    expect \
    locales \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set LOCALE to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

# Download and install Intel Quartus Prime Lite
RUN mkdir -p /root/modelsim \
    && cd /root/modelsim \    
    && wget http://download.altera.com/akdlm/software/acdsinst/19.1std/670/ib_installers/ModelSimSetup-19.1.0.670-linux.run -O ./ModelSimSetup-19.1.0.670-linux.run

RUN chmod +x ./ModelSimSetup-19.1.0.670-linux.run \
    && ./ModelSimSetup-19.1.0.670-linux.run --installdir /opt/altera/19.1 --accept_eula 1 --mode unattended \
    && rm -rf /root/modelsim

# Fix paths
RUN mv /opt/altera/19.1/modelsim_ase/linux /opt/altera/19.1/modelsim_ase/linux_rh60 \
    && mv /opt/altera/19.1/modelsim_ase/linuxaloem /opt/altera/19.1/modelsim_ase/linux_x86_64

# Add Quartus binaries to path 
ENV PATH "$PATH:/opt/altera/19.1/modelsim_ase/bin"

# Enter the shell
CMD ["bash"]