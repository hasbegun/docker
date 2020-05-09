FROM u18-ocv3-qt5

WORKDIR /home/developer/projects
RUN mkdir /home/developer/.ssh && chown developer:developer /home/developer/.ssh

# install 3rd party lib

# add 3rd-lib
# 1. install spdlog lib v.1.5.0
# most recent
# RUN git clone https://github.com/gabime/spdlog.git && \
#     cd spdlog && mkdir build && cd build && \
#     cmake .. && make -j
RUN wget https://github.com/gabime/spdlog/archive/v1.5.0.tar.gz -O spdlog-1.5.0.tar.gz && \
	tar zxvf spdlog-1.5.0.tar.gz && \
	cd spdlog-1.5.0 && mkdir build && cd build && \
	cmake .. && make -j $(nproc) && make install

# 2. install yaml-cpp v.0.6.3
RUN wget https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.6.3.tar.gz && \
	tar zxvf yaml-cpp-0.6.3.tar.gz && cd yaml-cpp-yaml-cpp-0.6.3 && \
	mkdir build && cd build && \
	cmake .. && make -j $(nproc) && make install


RUN wget https://github.com/jarro2783/cxxopts/archive/v2.2.0.tar.gz -O cxxopts-2.2.0.tar.gz && \
	tar zxvf cxxopts-2.2.0.tar.gz && cd cxxopts-2.2.0 && \
	mkdir build && cd build && \
	cmake .. && make -j $(nproc) && make install

RUN rm -rf /home/developer/projects/*

# add basic files
ADD res/gitconfig /home/developer/.gitconfig
ADD res/commit_template.txt /home/developer/.commit_template.txt
ADD res/bashrc /home/developer/.bashrc
ADD res/docker_dev /home/developer/.ssh/docker_dev
ADD res/docker_dev.pub /home/developer/.ssh/docker_dev.pub
RUN chown developer:developer \
    /home/developer/.gitconfig \
    /home/developer/.commit_template.txt \
    /home/developer/.bashrc \
    /home/developer/.ssh/docker_dev \
    /home/developer/.ssh/docker_dev.pub

# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV HOME /home/developer
ENV USER developer
USER developer
ENV PATH /home/developer/.local/bin:$PATH
# Avoid first use of sudo warning. c.f. https://askubuntu.com/a/22614/781671
RUN touch $HOME/.sudo_as_admin_successful

# Add key to ssh known hosts.
# Keep this line as a line. If split, the key will be lost and will not work.
RUN eval "$(ssh-agent)" && \
    ssh-keyscan github.com >> /home/developer/.ssh/known_hosts && \
    ssh-add -k /home/developer/.ssh/docker_dev && \
    git clone git@github.com:hasbegun/BiometricLib.git && \
	cd BiometricLib && ./build.sh && \
    rm -rf /home/developer/projects/BiometricLib

CMD ["/bin/bash"]
