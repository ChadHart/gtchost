FROM ubuntu:25.10

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    python3-dev \
    python3-numpy \
    python3-opencv \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    vim \
    v4l-utils \
    usbutils \ 
    tftp-hpa 

RUN apt update && apt install -y \
    iputils-ping 

WORKDIR /Repos/gtchost

COPY . . 
# COPY ../GTClash .
