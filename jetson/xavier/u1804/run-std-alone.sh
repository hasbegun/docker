#!/bin/sh
HOST_IP=`hostname -I | awk '{print $1}'`
REPOSITORY='jetson-agx/opengl'
JETPACK_VERSION='4.2.2'
#CODE_NAME='bionic'
CODE_NAME='18.04'
TAG="jetpack-$JETPACK_VERSION-$CODE_NAME"
UID='1002'
# setup pulseaudio cookie
if [ x"$(pax11publish -d)" = x ]; then
    start-pulseaudio-x11;
    echo `pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'`
fi

# run container
xhost +local:root
docker run -it \
  --device /dev/nvhost-as-gpu \
  --device /dev/nvhost-ctrl \
  --device /dev/nvhost-ctrl-gpu \
  --device /dev/nvhost-ctxsw-gpu \
  --device /dev/nvhost-dbg-gpu \
  --device /dev/nvhost-gpu \
  --device /dev/nvhost-prof-gpu \
  --device /dev/nvhost-sched-gpu \
  --device /dev/nvhost-tsg-gpu \
  --device /dev/nvmap \
  --device /dev/snd \
  --net=host \
  -e DISPLAY \
  -e PULSE_SERVER=tcp:$HOST_IP:4713 \
  -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
  -e QT_GRAPHICSSYSTEM=native \
  -e QT_X11_NO_MITSHM=1 \
  -v /dev/shm:/dev/shm \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /usr/local/cuda/lib64:/usr/local/cuda/lib64 \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
  -v ${XDG_RUNTIME_DIR}/pulse/native:/run/user/$UID/pulse/native \
  # -v ~/mount/backup:/backup \
  # -v ~/mount/data:/data \
  # -v ~/mount/project:/project \
  # -v ~/mount/tool:/tool \
  --rm \
  --name jetson-agx-opengl-${TAG} \
  ${REPOSITORY}:${TAG}
xhost -local:root
