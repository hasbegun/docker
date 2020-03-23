FROM alphablocks/base

LABEL maintainer="hasbegun hasbegun@gmail.com"

# RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
#   @edge http://nl.alpinelinux.org/alpine/edge/main\n\
#   @testing http://nl.alpinelinux.org/alpine/edge/testing\n\
#   @community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
#   >> /etc/apk/repositories

RUN apk add --update --no-cache py3-qt5 \
    jasper \
    libwebp \
    libjpeg \
    openjpeg \
    jpeg \
    libpng \
    tiff \
    openexr \
    ffmpeg

RUN apk add --update --no-cache --virtual build-deps \
  ninja \
  #Intel® TBB, a widely used C++ template library for task parallelism'
  # libtbb@testing  \
  # libtbb-dev@testing   \
  freetype-dev \
  lcms2-dev \
  libffi-dev \
  libxml2-dev \
  libxslt-dev \
  libjpeg-turbo-dev \
  jasper-dev \
  tiff-dev \
  tesseract-ocr \
  openssl-dev \
  libpng-dev \
  libjpeg-dev \
  libwebp-dev \
  jpeg-dev \
  zlib-dev \
  clang-dev \
  python3-dev
  
# Install Python dependencies
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && pip install -U Pillow pytesseract numpy

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++

ENV OPENCV_VERSION=3.4.6

RUN cd /opt && \
  wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
  unzip ${OPENCV_VERSION}.zip && \
  rm -rf ${OPENCV_VERSION}.zip && \
  wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
  unzip ${OPENCV_VERSION}.zip && \
  rm -rf ${OPENCV_VERSION}.zip

RUN mkdir -p /opt/opencv-${OPENCV_VERSION}/build && \
  cd /opt/opencv-${OPENCV_VERSION}/build && \
  cmake \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr \
  -D WITH_FFMPEG=ON \
  -D WITH_IPP=NO \
  -D WITH_OPENEXR=NO \
  -D BUILD_EXAMPLES=NO \
  -D BUILD_ANDROID_EXAMPLES=NO \
  -D INSTALL_PYTHON_EXAMPLES=NO \
  -D BUILD_DOCS=NO \
  -D BUILD_opencv_python2=NO \
  -D BUILD_opencv_python3=ON \
  -D PYTHON3_EXECUTABLE=/usr/bin/python \
  -D PYTHON3_INCLUDE_DIR=/usr/include/python3.6m/ \
  -D PYTHON3_LIBRARY=/usr/lib/libpython3.so \
  -D PYTHON_LIBRARY=/usr/lib/libpython3.so \
  -D PYTHON3_PACKAGES_PATH=/usr/lib/python3.6/site-packages/ \
  -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/lib/python3.6/site-packages/numpy/core/include/ \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPENCV_VERSION}/modules \
  .. && \
  make VERBOSE=1 && \
  make -j4 && \
  make -j4 install

# clean up
RUN rm -rf /opt/opencv-${OPENCV_VERSION} && \
  apk del build-deps

