FROM tensorflow/tensorflow:2.0.1-py3-jupyter

RUN apt update && apt install -y \
	build-essential \
    python3-pip python3-dev \
	cmake git \
    sudo vim wget

RUN pip3 install keras

RUN useradd -m developer && \
    usermod -aG sudo developer && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    cp /root/.bashrc /home/developer/ && \
    mkdir /home/developer/projects && \
    chown -R --from=root developer:developer /home/developer

# # Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV HOME /home/developer
ENV USER developer
USER developer
ENV PATH /home/developer/.local/bin:$PATH
# Avoid first use of sudo warning. c.f. https://askubuntu.com/a/22614/781671
RUN touch $HOME/.sudo_as_admin_successful
WORKDIR /home/developer/projects

# CMD ["/bin/bash"]
# CMD ["jupyter notebook"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
