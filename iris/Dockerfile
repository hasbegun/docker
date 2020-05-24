FROM u18-ocv3-qt5

WORKDIR /workspace

# install Libs
# add 3rd-lib
# 1. install spdlog lib v.1.5.0
RUN wget https://github.com/gabime/spdlog/archive/v1.5.0.tar.gz -O spdlog-1.5.0.tar.gz && \
	tar zxvf spdlog-1.5.0.tar.gz && \
	cd spdlog-1.5.0 && mkdir build && cd build && \
	cmake .. && make -j $(nproc) && make install

# 2. install yaml-cpp v.0.6.3
RUN wget https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.6.3.tar.gz && \
	tar zxvf yaml-cpp-0.6.3.tar.gz && cd yaml-cpp-yaml-cpp-0.6.3 && \
	mkdir build && cd build && \
	cmake .. && make -j $(nproc) && make install

# 3. cxxopts
RUN wget https://github.com/jarro2783/cxxopts/archive/v2.2.0.tar.gz -O cxxopts-2.2.0.tar.gz && \
	tar zxvf cxxopts-2.2.0.tar.gz && cd cxxopts-2.2.0 && \
	mkdir build && cd build && \
	cmake .. && make -j $(nproc) && make install

RUN pip3 install pyyaml jinja2

RUN rm -rf /workspace

CMD ["/bin/bash"]
