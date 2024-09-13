# Dockerfile for Story Consensus
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    make \
    jq \
    build-essential \
    gcc \
    unzip \
    wget \
    lz4 \
    aria2

# Set environment variables
ENV PATH="/root/go/bin:${PATH}"

# Create the directory for go/bin
RUN mkdir -p /root/go/bin

# Download and install Story
WORKDIR /root
RUN wget https://story-geth-binaries.s3.us-west-1.amazonaws.com/story-public/story-linux-amd64-0.9.12-9ae4a63.tar.gz && \
    tar -xzvf story-linux-amd64-0.9.12-9ae4a63.tar.gz && \
    cp story-linux-amd64-0.9.12-unstable-9ae4a63/story /root/go/bin/story && \
    chmod +x /root/go/bin/story && \
    ls -l /root/go/bin/

# Expose necessary ports
EXPOSE 26656 26657

# Command to run the Story Consensus node
CMD ["/root/go/bin/story", "run"]
