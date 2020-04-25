REPOSITORY="jetson-agx/opengl"
CODE_NAME="bionic"
VERSION="4.4.1"
TAG="jetpack-$VERSION-$CODE_NAME"

nvidia-docker build - \
  --build-arg REPOSITORY=arm64v8/ubuntu \
  --build-arg TAG=$TAG \