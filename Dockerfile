FROM ubuntu:24.04

# Updates and installs essentials
RUN apt-get -y update && apt-get install -y \
  sudo \
  software-properties-common \
  ca-certificates \
  vim \
  git \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash testuser && \
  echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

# Gets the linuxtools repo
RUN git clone https://github.com/RoPedro/linuxtools.git \
  && cd linuxtools && git checkout alpha2/desktopUpdate \
  ./zsh_config.sh

# Starts bash for debugging
CMD ["bash"]
