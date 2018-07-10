FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    cmake \
    build-essential \
    libc6-dev \
    make \
    pkg-config \
    git \
    wget \
    libssl-dev

COPY xargo.sh /
RUN bash /xargo.sh

COPY build_musl.sh /

RUN bash build_musl.sh
ENV PATH="/usr/local/musl/bin:${PATH}"

ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_LINKER=aarch64-linux-musl-gcc \
    CC_aarch64_unknown_linux_musl=aarch64-linux-musl-gcc \
    RUST_TEST_THREADS=1 
