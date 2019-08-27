## dockerホストマシンにkomodoユーザー作成

```
[root@centos komodo]# useradd komodo
[root@centos komodo]# usermod -aG docker komodo
[root@centos komodo]# echo 'komodo_pwd' | passwd --stdin komodo
ユーザー komodo のパスワードを変更。
passwd: すべての認証トークンが正しく更新できました。
```


<!--https://www.activestate.com/products/komodo-ide/downloads/edit/-->

<!--https://www.activestate.com/blog/building-komodo-docker/-->

#ローカルホストではkomodoはインストールできた模様

```
curl -LO https://downloads.activestate.com/Komodo/releases/11.1.1/Komodo-IDE-11.1.1-91089-linux-x86_64.tar.gz
tar -zxvf Komodo-IDE-11.1.1-91089-linux-x86_64.tar.gz
[rstudio@centos ~/unko/script_scratch/perl/komodo/Komodo-IDE-11.1.1-91089-linux-x86_64]$ls
INSTALLDIR  install.sh  support
[rstudio@centos ~/unko/script_scratch/perl/komodo/Komodo-IDE-11.1.1-91089-linux-x86_64]$sudo ./install.sh
[sudo] rstudio のパスワード:
Enter directory in which to install Komodo. Leave blank and
press 'Enter' to use the default [~/Komodo-IDE-11].
Install directory: 


==============================================================================
Komodo IDE 11 has been successfully installed to:
    /root/Komodo-IDE-11
    
You might want to add 'komodo' to your PATH by adding the 
install dir to you PATH. Bash users can add the following
to their ~/.bashrc file:

    export PATH="/root/Komodo-IDE-11/bin:$PATH"

Or you could create a symbolic link to 'komodo', e.g.:

    ln -s "/root/Komodo-IDE-11/bin/komodo" /usr/local/bin/komodo

Documentation is available in Komodo or on the web here:
    http://docs.activestate.com/komodo

Please send us any feedback you have through one of the
channels below:
    komodo-feedback@activestate.com
    irc://irc.mozilla.org/komodo
    https://github.com/Komodo/KomodoEdit/issues

Thank you for using Komodo.
==============================================================================
[rstudio@centos ~/unko/script_scratch/perl/komodo]$echo export PATH="/root/Komodo-IDE-11/bin:$PATH" >>~/.bashrc
[rstudio@centos ~/unko/script_scratch/perl/komodo]$tail ~/.bashrc
[rstudio@centos ~/unko/script_scratch/perl/komodo]$sudo ln -s "/root/Komodo-IDE-11/bin/komodo" /usr/local/bin/komodo
[rstudio@centos ~/unko/script_scratch/perl/komodo]$ll /usr/local/bin/komodo
lrwxrwxrwx. 1 root root 30  8月 27 06:51 /usr/local/bin/komodo -> /root/Komodo-IDE-11/bin/komodo

[rstudio@centos ~/unko/script_scratch/perl/komodo]$komodo
bash: komodo: コマンドが見つかりませんでした...
[rstudio@centos ~/unko/script_scratch/perl/komodo]$su root
パスワード:
[root@centos komodo]# echo export PATH="/root/Komodo-IDE-11/bin:$PATH" >>~/.bashrc
[root@centos komodo]# tail ~/.bashrc
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/root/perl5";
export PERL_MB_OPT="--install_base /root/perl5";
export PERL_MM_OPT="INSTALL_BASE=/root/perl5";
export PERL5LIB="/root/perl5/lib/perl5:$PERL5LIB";
export PATH="/root/perl5/bin:$PATH";
export PATH=/root/Komodo-IDE-11/bin:/root/perl5/bin:/root/Komodo-IDE-11/bin:/home/rstudio/perl5/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/rstudio/.local/bin:/home/rstudio/bin


```



