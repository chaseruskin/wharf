# Installs a pre-built RISCV toolchain

# Stage 0: OS layer (Ubuntu 18.04) 
FROM ubuntu:18.04

# LABEL about the custom image
LABEL maintainer="Chase Ruskin"
LABEL description="RISCV Toolchain on Ubuntu 18.04"

# Install image dependencies
RUN apt-get update && apt-get -y install \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download pre-built toolchain
RUN wget https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz

# Extract tar.gz file
RUN tar -xvzf riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz

# Move to install location
RUN mv riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14 /opt/riscv

# Add toolchain binaries to path 
ENV PATH "$PATH:/opt/riscv/bin"
RUN echo "export PATH=\${PATH}:/opt/riscv/bin" >> /root/.bashrc

# Enter the shell
CMD ["bash"]