FROM arm64v8/ubuntu:18.04

ENV LD_LIBRARY_PATH=/usr/lib/aarch64-linux-gnu/tegra
RUN mkdir /cudaSamples
COPY deviceQuery /cudaSamples/

CMD /cudaSamples/deviceQuery

