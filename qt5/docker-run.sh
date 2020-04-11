#!/bin/bash

IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
echo "Host IP: $IP"

/usr/X11/bin/xhost +$IP
exec docker run \
    -it \
    --rm \
    --name u18-ocv3-qt5_dev \
    --net=host \
    -e DISPLAY=$IP:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v ${HOME}/.Xauthority:/home/user/.Xauthority \
    u18-ocv3-qt5 \
    "$@"
