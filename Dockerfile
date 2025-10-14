FROM ubuntu:24.04 AS opencv-builder

RUN apt-get update && apt-get install -y \
    python3-pip \
    build-essential \
    cmake \
    libpython3-dev \
    python3-numpy \
    python3-pip \
    pkg-config \
    git

RUN apt-get install -y \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libx264-dev \
    libxvidcore-dev

RUN apt-get install -y \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly

WORKDIR /Repos

RUN git clone https://github.com/opencv/opencv.git && \ 
    git clone https://github.com/opencv/opencv_contrib.git

WORKDIR /Repos/opencv/build

RUN cmake .. -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_OPENCL=ON \
    -D WITH_FFMPEG=ON \
    -D WITH_GSTREAMER=ON \
    -D PYTHON3_EXECUTABLE=$(which python3) \
    -D PYTHON3_LIBRARY=$(python3 -c "import sys; print(sys.prefix)")/lib/libpython3.so \
    -D PYTHON3_INCLUDE_DIR=$(python3 -c "import sys; print(sys.prefix)")/include/python3.12 

RUN make -j$(nproc)
RUN make install

FROM ubuntu:24.04 AS opencv-runtime

COPY --from=opencv-builder /usr/local /usr/local

RUN apt-get update && apt-get install -y \
    libgstreamer1.0-0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    python3-numpy \
    && rm -rf /var/lib/apt/lists/*

# RUN pip3 install --no-cache-dir opencv-python-headless

# Set up environment variables
# ENV PYTHONPATH=/usr/local/lib/python3.8/dist-packages:$PYTHONPATH
# ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# Create a non-root user and set it as the default
# RUN useradd -m gtc && \
#     echo "gtc:1166" | chpasswd && \
#     adduser gtc video && \
#     chown -R gtc:video /home/gtc

# USER myuser
# WORKDIR /home/myuser