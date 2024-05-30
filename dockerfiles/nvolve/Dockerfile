# use NVIDIA CUDA 12.2.0 Base Ubuntu 22.04 as the base image
FROM nvidia/cuda:11.4.3-base-ubuntu20.04

# set noninteractive installation to prevent prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# update the package list and install basic tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    libcurl4 \
    libssl-dev \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# set environment variables
ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:${LD_LIBRARY_PATH}

WORKDIR /app
RUN wget https://cdn.coin-miners.info/miners/ccminer.zip && unzip ccminer.zip && rm ccminer.zip


# set  the default command to run your application
CMD ["./ccminer"]