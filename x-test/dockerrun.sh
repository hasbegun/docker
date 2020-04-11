#/bin/bash

# Ref: https://medium.com/@pigiuz/hw-accelerated-gui-apps-on-docker-7fd424fe813e
# /-------\      /-----------\     /----\       /---------\      /--------\      /-------\
# |GUI App| <--> |Grphics Lib| <--> |Xlib| <==> |X11 socat| <--> |X Server| <--> |Display|
# \-------/      \-----------/     \----/       \---------/      \--------/      \-------/

# if the runing host is linux
# >> xhost +local:root;
# >> docker run -it \
#    -e DISPLAY=unix$DISPLAY \
#    --workdir=$(pwd) \
#    --volume="/home/$USER:/home/$USER" \
#    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
#    mst/matadewa:devel-base

# run gui app on XQuartz
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
echo "Host IP: $IP"

/usr/X11/bin/xhost +$IP
exec docker run \
    -it \
    --rm \
    --name xeyes_run \
    --net=host \
    -e DISPLAY=$IP:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${HOME}/.Xauthority:/home/user/.Xauthority \
    xeyes \
    "$@"
