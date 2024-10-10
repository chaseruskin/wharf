# Installs tools for SystemVerilog

# Stage 0: OS layer (Ubuntu 18.04) 
FROM ubuntu:18.04

# Specific commit to use when installing from git
ARG SVLINT_TAG

# LABEL about the custom image
LABEL maintainer="Chase Ruskin"
LABEL description="SystemVerilog tools on Ubuntu 18.04"

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Download Rust toolchain, compile, move orbit to bin/, and clean up Rust toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN $HOME/.cargo/bin/cargo install --bin svlint --git https://github.com/dalance/svlint.git --tag $SVLINT_TAG
RUN cp "$HOME/.cargo/bin/svlint" "/usr/local/bin/svlint"

RUN $HOME/.cargo/bin/rustup self uninstall -y

# Add toolchain binaries to path
ENV PATH "$PATH:/opt/riscv/bin"

# Enter the shell
CMD ["bash"]