FROM ubuntu:16.04

# First: get all the dependencies:
#
RUN apt-get update
# wget, unzip
RUN apt-get install -y wget \
    unzip \
    apt-file
# install opencv dependencies
# compiler
RUN apt-get install -y build-essential
# required dependencies
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
# optional dependencies
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
#dlib
RUN apt-get install -y libx11-dev libatlas-base-dev
RUN apt-get install -y libgtk-3-dev libboost-python-dev
RUN apt-get install -y libopenblas-dev liblapack-dev


#get dlib
ARG DLIB_VERSION='19.16'
RUN cd /root/ && \
    wget https://github.com/davisking/dlib/archive/v${DLIB_VERSION}.zip && \
    unzip v${DLIB_VERSION}.zip && \
    rm v${DLIB_VERSION}.zip && \
    cd dlib-${DLIB_VERSION} && \
    mkdir -p build && \
    cd build && \
    echo CMAKE && \
    cmake .. && \
    echo cmakebuildconfigRelease && \
    cmake --build . --config Release && \
    make install && \
    ldconfig



# get openCV
ARG OPENCV_VERSION='3.4.3'
RUN cd /root/ && \
    wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && \
    rm ${OPENCV_VERSION}.zip && \
    cd opencv-${OPENCV_VERSION} && \
    mkdir -p build && \
    cd build && \
    echo CMAKE && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    echo MAKEJ8 && \
    make -j8 && \
    echo MAKEINSTALL && \
    make install

RUN apt-file update

#get and install gitlabrunnner
RUN apt-get install curl
RUN curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash
RUN apt-get install gitlab-runner

ENTRYPOINT ["/bin/sh"]
