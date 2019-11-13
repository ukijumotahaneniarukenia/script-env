FROM centos:7.6.1810

#ユーザー作成
RUN groupadd -g 1001 tcl
RUN useradd -m -g tcl -u 1001 tcl
RUN chsh -s /bin/bash tcl
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'tcl_pwd' | passwd --stdin tcl

#epelレポ登録
RUN yum -y install epel-release



USER tcl

WORKDIR /home/tcl
