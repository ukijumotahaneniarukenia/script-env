# Mojoアプリ
以下がチュートリアル
/home/perl/perl5/lib/perl5/Mojolicious/Guides/Tutorial.pod
```
cpanm Mojolicious
```
# 参考文献
https://gihyo.jp/dev/serial/01/perl-hackers-hub/003301
https://www.toumasu-program.net/entry/2019/03/21/174836
# mojoコマンド
```
[perl@6b21ad52aa2e ~/IdeaProjects/untitled1]$/home/perl/perl5/bin/mojo --help
Usage: APPLICATION COMMAND [OPTIONS]

  mojo version
  mojo generate lite_app
  ./myapp.pl daemon -m production -l http://*:8080
  ./myapp.pl get /foo
  ./myapp.pl routes -v

Tip: CGI and PSGI environments can be automatically detected very often and
     work without commands.

Options (for all commands):
  -h, --help          Get more information on a specific command
      --home <path>   Path to home directory of your application, defaults to
                      the value of MOJO_HOME or auto-detection
  -m, --mode <name>   Operating mode for your application, defaults to the
                      value of MOJO_MODE/PLACK_ENV or "development"

Commands:
 cgi       Start application with CGI
 cpanify   Upload distribution to CPAN
 daemon    Start application with HTTP and WebSocket server
 eval      Run code against application
 generate  Generate files and directories from templates
 get       Perform HTTP request
 inflate   Inflate embedded files to real files
 prefork   Start application with pre-forking HTTP and WebSocket server
 psgi      Start application with PSGI
 routes    Show available routes
 version   Show versions of available modules

See 'APPLICATION help COMMAND' for more information on a specific command.
```
