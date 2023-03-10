FROM amd64/ubuntu:18.04 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        git \
        make \
        ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y --no-install-recommends \
        software-properties-common \
 && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
 && apt update && apt install -y --no-install-recommends \
        gcc-11 g++-11 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-11 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/
RUN apt-get update && apt-get install -y wget \
 && rm -rf /var/lib/apt/lists/* \
 && wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.22.3/cmake-3.22.3-Linux-x86_64.sh \
 && sh cmake-linux.sh -- --skip-license --prefix=/usr/local \
 && rm -rf /tmp/*

WORKDIR /tmp/
RUN git clone -b release-1.11.0 https://github.com/google/googletest.git \
 && cd googletest \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && rm -rf /tmp/*

WORKDIR /tmp/
RUN git clone -b v1.6.1 https://github.com/google/benchmark.git \
 && cd benchmark \
 && cmake -E make_directory "build" \
 && cmake -DCMAKE_BUILD_TYPE=Release -DBENCHMARK_DOWNLOAD_DEPENDENCIES=on -S . -B "build" \
 && cmake --build "build" --config Release \
 && cmake -E chdir "build" ctest --build-config Release \
 && cmake --build "build" --config Release --target install \
 && rm -rf /tmp/*

WORKDIR /tmp/
COPY . /tmp/
RUN cmake . -DIN_DOCKER=TRUE -DCMAKE_BUILD_TYPE=Release \
 && make -j$(nproc) \
 && ./test/ndvector/ndvector_test \
 && ./benchmark/ndvector/ndvector_benchmark \
 && rm -rf /tmp/*

