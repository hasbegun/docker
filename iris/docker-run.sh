#!/bin/bash

BIO_SRC=/Users/inho.choi/devel/alphablocks/projects/iris/BiometricLib
BIO_DST=/home/developer/projects/Biometriclib
FACE_RECOG_SRC=/Users/inho.choi/devel/alphablocks/projects/iris/face_recognition
FACE_RECOG_DST=/home/developer/projects/face_recognition
IRIS_UX_SRC=/Users/inho.choi/devel/alphablocks/projects/iris/IrisAnalysis
IRIS_UX_DST=/home/developer/projects/IrisAnalysis
DATA_SRC=/Users/inho.choi/devel/alphablocks/datasets
DATA_DST=/home/developer/projects/datastes

CONTAINER_IP=192.168.0.50

IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
echo "Host IP: $IP"

# the following arg is optional. this is for vnc access.
#  -v ${HOME}/.Xauthority:/home/developer/.Xauthority \
#################################

/usr/X11/bin/xhost +$IP
exec docker run -it \
    -v $BIO_SRC:$BIO_DST:rw \
    -v $FACE_RECOG_SRC:$FACE_RECOG_DST:rw \
    -v $IRIS_UX_SRC:$IRIS_UX_DST:rw \
    -v $DATA_SRC:$DATA_DST:rw \
    -e DISPLAY=$IP:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v ${HOME}/.Xauthority:/home/developer/.Xauthority \
    --name iris-ocv3-qt5_dev \
    --ip $CONTAINER_IP \
    iris-ocv3-qt5:latest \
    "$@"
