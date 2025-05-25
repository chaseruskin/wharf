# Creates a docker image for a development layer within the wharf project's
# hardware development stack.

# Build upon the operating system layer 
FROM ubuntu:22.04 AS os

# Custom image metadata
LABEL maintainer="Chase Ruskin"
LABEL description="A development layer for common processes"

# Add supportive tools, scripting languages, etc. for workflow processes

# @@@ Python (https://www.python.org) and other misc. packages
RUN apt-get update
RUN apt-get install -y \
    python3 \
    python3-pip \
    curl \
    git \
    unzip

# Create symlink to call python3 as python
RUN ln -svT /usr/bin/python3 /usr/bin/python

# Update pip
RUN pip install --upgrade pip

# Install some "always needed" python libraries
RUN pip install toml==0.10.2

# Log the tool's version
RUN echo "python --version" >> /etc/development-tools

# @@@ Ninja (https://github.com/ninja-build/ninja)
RUN curl -LO https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip
RUN unzip ninja-linux.zip
RUN cp "ninja" "/usr/local/bin/ninja"
# Log the tool's version
RUN { echo -n "echo ninja "; ninja --version; } >> /etc/development-tools

# @@@ Orbit (https://github.com/chaseruskin/orbit)
FROM chaseruskin/orbit:latest-ubuntu-22.04
COPY --from=os / /

# Download Rust compiler and tools for some installs
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# @@@ Just (https://github.com/casey/just)
RUN $HOME/.cargo/bin/cargo install just
RUN cp "$HOME/.cargo/bin/just" "/usr/local/bin/just"

# @@@ Verb (https://github.com/chaseruskin/verb)
RUN export VERB_VERSION="trunk" \
    && pip install git+"https://github.com/chaseruskin/verb.git@$VERB_VERSION#egg=verb&subdirectory=src/lib/python" \
    && orbit install verb+1pgjtja7i1rcf0i5ooubqjctt --url "https://github.com/chaseruskin/verb/archive/refs/heads/$VERB_VERSION.zip" \
    && orbit install verb+5zjl2nexva03reqgbw04f48di --url "https://github.com/chaseruskin/verb/archive/refs/heads/$VERB_VERSION.zip" \
    && $HOME/.cargo/bin/cargo install --git "https://github.com/chaseruskin/verb.git" --branch "$VERB_VERSION"

RUN cp "$HOME/.cargo/bin/verb" "/usr/local/bin/verb"

# Uninstall Rust compiler and tools
RUN $HOME/.cargo/bin/rustup self uninstall -y

# Add some configurations (https://github.com/chaseruskin/orbit-targets)
RUN git clone "https://github.com/chaseruskin/orbit-targets.git" "$HOME/.orbit/plugins/chaseruskin"
RUN orbit config --push include="plugins/chaseruskin/config.toml"

# Create orbit configuration assist command
COPY development/lab/orca.bash ./.orca.bash
RUN cat ./.orca.bash >> /root/.bashrc
# Note: To pull the latest changes, use: $ orca chaseruskin pull
# Note: To checkout a version, use: $ orca checkout <tag>

# Ensure the alias is loaded in non-interactive shells
RUN echo 'source /root/.bashrc' >> /root/.profile

# Add global git configurations
RUN git config --global --add advice.detachedHead false

# Log the tool's version
RUN echo "orbit --version" >> /etc/development-tools
RUN echo "just --version" >> /etc/development-tools
RUN echo "verb --version" >> /etc/development-tools
RUN { echo -n "echo .orbit/plugins/chaseruskin "; git -C "$HOME/.orbit/plugins/chaseruskin" rev-parse HEAD; } >> /etc/development-tools

# Enter the shell
CMD ["/bin/bash"]
