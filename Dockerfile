# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jon Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates and some dev tools
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y znc; yum clean all; rm -rf /var/cache/yum
