FROM nvidia/cuda:12.4.0-base-ubuntu20.04

# 设置非交互式安装，防止在安装过程中出现提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新软件包并安装基本工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    build-essential \
    wget \
    curl \
    git \
    ca-certificates && \
    # 清理缓存以减小镜像大小
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 安装CUDA Toolkit (根据需要选择组件)
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
    apt-get update && \
    apt-get install -y --no-install-recommends cuda-minimal-build-12-4 cuda-libraries-12-4 cuda-libraries-dev-12-4 && \
    # 清理缓存以减小镜像大小
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:${LD_LIBRARY_PATH}

# 将您的应用复制到容器中
COPY . /app

# 设置工作目录
WORKDIR /app

# 编译您的应用程序（示例）
RUN make

# 设置默认运行命令
CMD ["./your-application"]