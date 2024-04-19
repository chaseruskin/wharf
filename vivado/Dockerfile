# Dock: Create a docker image containing tools and programs required
#   for Xilinx FPGAs.
#
# References: 
#   - https://www.reddit.com/r/FPGA/comments/bk8b3n/dockerizing_xilinx_tools/
#   - https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug973-vivado-release-notes-install-license.pdf
#   - https://docs.amd.com/v/u/2019.1-English/ug973-vivado-release-notes-install-license

# Stage 0: OS layer (Ubuntu 18.04) 
FROM ubuntu:18.04

# LABEL about the custom image
LABEL maintainer="crus800"
LABEL description="Xilinx Vivado 2018.3 on Ubuntu 18.04."

# Set the timezone
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


ENV XLNX_INSTALL_LOCATION=/opt/Xilinx

ENV DEBIAN_FRONTEND=noninteractive

# === Set BASH as the default shell
RUN echo "dash dash/sh boolean false" | debconf-set-selections 
RUN DEBIAN_FRONTEND=$DEBIAN_FRONTEND dpkg-reconfigure dash


# === Install dependencies
RUN apt-get update
RUN dpkg --add-architecture i386 
RUN apt-get update 
# petalinux base dependencies
RUN apt-get install -y \
	  	tofrodos \
	  	iproute2 \
		gawk \
		xvfb \
		git \
		make \
		net-tools \
		libncurses5-dev \
	  	update-inetd \
	  	tftpd \
		zlib1g-dev:i386 \
	  	libssl-dev \
	  	flex \
	  	bison \
	  	libselinux1 \
	  	gnupg \
	  	wget \
		diffstat \
		chrpath \
		socat \
		xterm \
		autoconf \
		libtool \
		libtool-bin \
		tar \
	  	unzip \
	  	texinfo \
		zlib1g-dev \
		gcc-multilib \
		build-essential \
		libsdl1.2-dev \
		libglib2.0-dev \
		screen \
		pax \
		gzip \
		python3-gi \
		less \
		lsb-release \
		fakeroot \
		libgtk2.0-0 \
		libgtk2.0-dev \
		cpio \
		rsync \
		xorg \
		expect \
		dos2unix

RUN apt-get install -y \
	 	libboost-signals-dev \
	 	google-perftools \
		default-jre


# Download Vivado installer

# === Set up configuration parameters
ENV XLNX_VIVADO_OFFLINE_INSTALLER=<YOUR_VIVADO_INSTALLER>.tar.gz
ENV XLNX_VIVADO_BATCH_CONFIG_FILE=<YOUR_VIVADO_CONFIG>.config
COPY $XLNX_VIVADO_OFFLINE_INSTALLER $XLNX_INSTALL_LOCATION/tmp/$XLNX_VIVADO_OFFLINE_INSTALLER
COPY $XLNX_VIVADO_BATCH_CONFIG_FILE $XLNX_INSTALL_LOCATION/tmp/$XLNX_VIVADO_BATCH_CONFIG_FILE

# === Extract installer and run xsetup
RUN cd $XLNX_INSTALL_LOCATION/tmp \
 	&& cat $XLNX_VIVADO_BATCH_CONFIG_FILE \
 	&& tar -zxf $XLNX_VIVADO_OFFLINE_INSTALLER && ls -al \
	&& echo "cd $XLNX_INSTALL_LOCATION" >> $HOME_DIR/.bashrc \
	&& echo "export LANG=en_US.UTF-8" >> $HOME_DIR/.bashrc \
	&& export "LANG=en_US.UTF-8" \
	&& echo ". $XLNX_INSTALL_LOCATION/Vivado/2018.3/settings64.sh" >> $HOME_DIR/.bashrc \
	&& echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XLNX_INSTALL_LOCATION/Vivado/2018.3/lib/lnx64.o/" >> $HOME_DIR/.bashrc

RUN cd $XLNX_INSTALL_LOCATION/tmp \
	&& mv $XLNX_VIVADO_BATCH_CONFIG_FILE Xilinx_Vivado_SDK_2018.3_1207_2324/ \
	&& cd Xilinx_Vivado_SDK_2018.3_1207_2324 \
# Setup installer permissions \
  	&& chmod a+x xsetup \
# Run Setup in batch mode to install Vivado \
	&& cd $XLNX_INSTALL_LOCATION/tmp/Xilinx_Vivado_SDK_2018.3_1207_2324 \
	&& ./xsetup \
  		--agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
  		--config $XLNX_VIVADO_BATCH_CONFIG_FILE \
  		--batch INSTALL \
# Cleanup Temporary Files \
  	&& cd $HOME_DIR \
  	&& rm -rf $XLNX_INSTALL_LOCATION/tmp


# === Cleanup and add to path

# Cleanup temporary install files 
RUN rm -rf $XLNX_INSTALL_LOCATION/tmp

# Cleanup apt cache and temporary files to reduce image size
RUN apt-get clean

RUN source $XLNX_INSTALL_LOCATION/Vivado/2018.3/settings64.sh
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XLNX_INSTALL_LOCATION/Vivado/2018.3/lib/lnx64.o/