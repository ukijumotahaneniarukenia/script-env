RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-default-user.sh 1000 aine 1000 aine aine_pwd

USER aine
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-vim-user.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-vim_plug.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-dotfile.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-env.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-font-RictyDiminished.sh

COPY env-run.sh /etc/init/env-run.sh
ENTRYPOINT ["/etc/init/env-run.sh","ubuntu"]

