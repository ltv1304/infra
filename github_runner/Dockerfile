FROM ubuntu:24.04

# Required build-time variables (passed via --build-arg):
#   - DOCKER_GID - GID host docker group
#   - RUNNER_GID - GID host runner group
#   - RUNNER_ARCH - CPU architecture for the runner(x64, ARM64, ARM32 supported)   

# Required runtime environment variables:
#   - GIT_REPOSITORY: GitHub repo name in format owner/repo_name
#   - ACCESS_TOKEN: GitHub PAT (no default, must be set)

ARG DOCKER_GID
ARG RUNNER_GID

# Static environment variables
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author="eugeny"
LABEL Email="ltv1303@yandex.ru"
LABEL GitHub="https://github.com/ltv1304"
LABEL BaseImage="ubuntu:24.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    wget \
    unzip \
    git \
    jq \
    build-essential \
    libssl-dev \
    libicu-dev \
    libffi-dev \
    python3 \
    python3-pip \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# Create a runner user
RUN groupadd -g ${RUNNER_GID} runner && \
    groupadd -g ${DOCKER_GID} docker && \
    useradd -g ${RUNNER_GID} -G docker -m -s /bin/bash runner

# RUN useradd -m -s /bin/bash runner \
    # && usermod -aG sudo runner \
    # && echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Используем настройки хоста (группа runner имеет доступ к папке)
# Create GitHub-compatible workspace structure as root
#  mkdir -p /github/workspace && \
    # chown -R runner:runner /github /github/workspace


USER runner

# Download and install GitHub Actions runner
ARG RUNNER_ARCH=x64
ARG TARGET_DIR=/home/runner/runner/
RUN mkdir -p ${TARGET_DIR} \
    && cd ${TARGET_DIR} \
    && RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | grep '"tag_name"' | cut -d'"' -f4 | sed 's/v//') \
    && echo "Installing GitHub Actions Runner version: $RUNNER_VERSION" \
    && curl -o actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz \
    && rm actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz

USER root
RUN cd ${TARGET_DIR} && ./bin/installdependencies.sh
USER runner

WORKDIR /github/workspace
CMD ["/github/workspace/start.sh"]
