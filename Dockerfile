FROM ubuntu:16.04
RUN apt update &&  apt install -y iproute2 iputils-ping iperf3 traceroute curl 
