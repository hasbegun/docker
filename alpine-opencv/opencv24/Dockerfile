FROM iris/base

LABEL maintainer="hasbegun hasbegun@gmail.com"

# RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
#   @edge http://nl.alpinelinux.org/alpine/edge/main\n\
#   @testing http://nl.alpinelinux.org/alpine/edge/testing\n\
#   @community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
#   >> /etc/apk/repositories

RUN apk add --update --no-cache qt5-qtbase qt-dev

RUN apk add --update --no-cache --virtual build-deps \
  ninja \
  openjpeg-dev \
  openblas-dev \
  freetype-dev \
  ffmpeg \
  jpeg-dev \
  lcms2-dev \
  libffi-dev \
  libgcc \
  libxml2-dev \
  libxslt-dev \
  libjpeg \
  libjpeg-turbo-dev \
  openjpeg \
  libpng-dev \
  libwebp-dev \
  jasper-dev \
  tiff-dev \
  tesseract-ocr

# Install Python dependencies
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && pip3 install -U Pillow pytesseract numpy

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++
# ENV CC /usr/bin/gcc
# ENV CXX /usr/bin/g++

ENV OPENCV_VERSION=2.4.13.6

RUN cd /opt && \
  wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
  unzip ${OPENCV_VERSION}.zip && \
  rm -rf ${OPENCV_VERSION}.zip

RUN mkdir -p /opt/opencv-${OPENCV_VERSION}/build && \
  cd /opt/opencv-${OPENCV_VERSION}/build && \
  cmake \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr \
  -D WITH_QT=/usr/lib \
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
  # -D PYTHON3_INCLUDE_DIR=/usr/include/python3.6m/ \
  # -D PYTHON3_LIBRARY=/usr//lib/libpython3.so \
  # -D PYTHON_LIBRARY=/usr/lib/libpython3.so \
  # -D PYTHON3_PACKAGES_PATH=/usr/lib/python3.6/site-packages/ \
  # -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/lib/python3.6/site-packages/numpy/core/include/ \
  .. && \
  # make VERBOSE=1 && \
  make -j4 && \
  make -j4 install

# clean up
RUN rm -rf /opt/opencv-${OPENCV_VERSION} /usr/lib/python2.7 && \
  apk del build-deps

