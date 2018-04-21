FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install git make nasm build-essential
RUN apt-get -y install texlive-full noweb
