FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install curl
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get -y install git git-lfs make nasm build-essential
RUN git lfs install
RUN apt-get -y install texlive-full noweb
