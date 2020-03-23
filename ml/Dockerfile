# pick tf from https://hub.docker.com/r/tensorflow/tensorflow/tags?page=2 
FROM tensorflow/tensorflow:2.0.1-py3-jupyter

MAINTAINER Inho Choi <hasbegun@gmail.com>

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential \
    git \
    cmake \
    python3-pip \
    python3-dev \
    unzip pkg-config libopenblas-dev liblapack-dev \
    python-numpy python-scipy python-matplotlib python-yaml \
    libhdf5-serial-dev python-h5py \
    bash-completion wget curl vim sudo \
    graphviz software-properties-common

RUN pip3 install matplotlib keras

# Enable tab completion by uncommenting it from /etc/bash.bashrc
# The relevant lines are those below the phrase "enable bash completion in interactive shells"
# RUN export SED_RANGE="$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+1)),$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+7))" && \
#     sed -i -e "${SED_RANGE}"' s/^#//' /etc/bash.bashrc && \
#     unset SED_RANGE

# Create user "developer" with sudo powers
RUN useradd -m developer && \
    usermod -aG sudo developer && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    cp /root/.bashrc /home/developer/ && \
    mkdir /home/developer/data && \
    chown -R --from=root developer /home/developer

# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /home/developer/projects
ENV HOME /home/developer
ENV USER developer
USER developer
ENV PATH /home/developer/.local/bin:$PATH
# Avoid first use of sudo warning. c.f. https://askubuntu.com/a/22614/781671
RUN touch $HOME/.sudo_as_admin_successful

CMD [ "/bin/bash" ]