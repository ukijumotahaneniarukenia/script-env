# cpanmでインストールされたパッケージの場所
```
[root@90e1b125786c ~]$cpanm Test::More
[root@90e1b125786c ~]$find / -cmin -6 | grep More
/usr/local/share/man/man3/Test::More.3pm
/usr/local/share/perl5/Test/More.pm

/usr/local/lib64/perl5/DBI/SQL
/usr/local/lib64/perl5/DBI/SQL/Nano.pm


/usr/lib64/perl5/perllocal.pod
/root/.cpanm/work/1567001283.4380/version-0.9924/t/survey_locales
/root/.cpanm/work/1567001283.4380/version-0.9924/t/07locale.t
/root/.cpanm/work/1567001283.4380/CPAN-Meta-YAML-0.018/t/tml-local
/root/.cpanm/work/1567001283.4380/CPAN-Meta-YAML-0.018/t/tml-local/load-warning
/root/.cpanm/work/1567001283.4380/CPAN-Meta-YAML-0.018/t/tml-local/load-warning/document.tml
/root/.cpanm/work/1567001283.4380/CPAN-Meta-YAML-0.018/t/tml-local/dump-error
/root/.cpanm/work/1567001283.4380/CPAN-Meta-YAML-0.018/t/tml-local/dump-error/circular.tml

```



# cpanm関連の参考文献

```
http://www.omakase.org/perl/cpanm.html
https://codeday.me/jp/qa/20190817/1461604.html
https://perlmaven.com/min-max-sum-using-list-util
https://rpms.remirepo.net/rpmphp/all.php?what=jplesnik
https://papix.hatenablog.com/entry/2018/03/10/160838
```
docker run --privileged -v /etc/localtime:/etc/localtime --name padre -itd ubuntu_padre
