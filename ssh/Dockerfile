FROM centos:latest

RUN yum install -y iputils && \
yum install -y net-tools && \
yum install -y iproute && \
yum install -y tree && \
yum install -y lsof && \
yum install -y expect && \
yum install -y openssh-server && \
yum install -y openssh-clients && \
yum install -y epel-release && \
yum install -y parallel

RUN groupadd -g 1001 serena
RUN useradd -m -g serena -u 1000 python

RUN echo 'python_pwd' | passwd --stdin python
RUN echo 'root_pwd' | passwd --stdin root

EXPOSE 22
CMD ["/sbin/init"]
