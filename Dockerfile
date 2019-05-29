FROM ruby:2.6-stretch

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    python3 \
    python3-pip \
    rsync

# PIP Installation
RUN pip3 install awscli
