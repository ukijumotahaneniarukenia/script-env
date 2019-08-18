# Dockerfileよりhttpdイメージ作成
```
time docker build -t centos_httpd . | tee log
```

```
cat <(docker images | head -n1) <(docker images | awk '$1=="centos_httpd"{print $0}')
[oracle@centos apache]$ cat <(docker images | head -n1) <(docker images | awk '$1=="centos_httpd"{print $0}')
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos_httpd        latest              201c3556951a        48 seconds ago      2.41GB
```

# dockerコンテナ作成
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 80:80 --name httpd -itd centos_httpd /sbin/init
```

# dockerコンテナ削除
やり直すときはクリーンする。
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
やり直すときはクリーンする。
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ潜入
rootユーザーないし、apacheユーザー。
```
[oracle@centos apache]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                NAMES
d545e9eaf130        centos_httpd        "/sbin/init"        29 seconds ago      Up 29 seconds       0.0.0.0:80->80/tcp   httpd
[oracle@centos apache]$ docker exec --user root -it httpd bash
[root@d545e9eaf130 /var/www]$cd ~
[root@d545e9eaf130 ~]$su apache
[apache@d545e9eaf130 /root]$cd ~
[apache@d545e9eaf130 ~]$exit
[root@d545e9eaf130 ~]$exit
[oracle@centos apache]$ docker exec --user apache -it httpd bash
[apache@d545e9eaf130 /var/www]$su root
Password: 
[root@d545e9eaf130 /var/www]$exit
[apache@d545e9eaf130 /var/www]$exit
```

# httpd起動確認
```
[oracle@centos apache]$ docker exec --user apache -it httpd bash
[apache@d545e9eaf130 /var/www]$sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd(8)
           man:apachectl(8)
[apache@d545e9eaf130 /var/www]$sudo systemctl start httpd
[apache@d545e9eaf130 /var/www]$sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since 日 2019-08-18 16:35:47 JST; 2s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 2693 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/d545e9eaf130d2e9d42b79ef387ee575f599bc7489535f223ec61144ea8214ba/system.slice/httpd.service
           ├─2693 /usr/sbin/httpd -DFOREGROUND
           ├─2694 /usr/sbin/httpd -DFOREGROUND
           ├─2695 /usr/sbin/httpd -DFOREGROUND
           ├─2696 /usr/sbin/httpd -DFOREGROUND
           ├─2697 /usr/sbin/httpd -DFOREGROUND
           └─2698 /usr/sbin/httpd -DFOREGROUND
           ‣ 2693 /usr/sbin/httpd -DFOREGROUND

 8月 18 16:35:47 d545e9eaf130 systemd[1]: Starting The Apache HTTP Server...
 8月 18 16:35:47 d545e9eaf130 httpd[2693]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to su...s this message
 8月 18 16:35:47 d545e9eaf130 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
```

# バージョン情報
```
[apache@d545e9eaf130 /var/www]$awk --version
GNU Awk 5.0.0, API: 2.0
Copyright (C) 1989, 1991-2019 Free Software Foundation.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.
[apache@d545e9eaf130 /var/www]$bash --version
GNU bash, バージョン 5.0.0(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2019 Free Software Foundation, Inc.
ライセンス GPLv3+: GNU GPL バージョン 3 またはそれ以降 <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
[apache@d545e9eaf130 /var/www]$vim --version
VIM - Vi IMproved 8.1 (2018 May 18, compiled Aug 18 2019 07:27:10)
適用済パッチ: 1-1879
Compiled by root@95085e69ea84
Huge 版 with GTK2 GUI.  機能の一覧 有効(+)/無効(-)
+acl               -farsi             -mouse_sysmouse    -tag_any_white
+arabic            +file_in_path      +mouse_urxvt       -tcl
+autocmd           +find_in_path      +mouse_xterm       +termguicolors
+autochdir         +float             +multi_byte        +terminal
-autoservername    +folding           +multi_lang        +terminfo
+balloon_eval      -footer            -mzscheme          +termresponse
+balloon_eval_term +fork()            +netbeans_intg     +textobjects
+browse            +gettext           +num64             +textprop
++builtin_terms    -hangul_input      +packages          +timers
+byte_offset       +iconv             +path_extra        +title
+channel           +insert_expand     -perl              +toolbar
+cindent           +job               +persistent_undo   +user_commands
+clientserver      +jumplist          +postscript        +vartabs
+clipboard         +keymap            +printer           +vertsplit
+cmdline_compl     +lambda            +profile           +virtualedit
+cmdline_hist      +langmap           -python            +visual
+cmdline_info      +libcall           -python3           +visualextra
+comments          +linebreak         +quickfix          +viminfo
+conceal           +lispindent        +reltime           +vreplace
+cryptv            +listcmds          +rightleft         +wildignore
+cscope            +localmap          -ruby              +wildmenu
+cursorbind        -lua               +scrollbind        +windows
+cursorshape       +menu              +signs             +writebackup
+dialog_con_gui    +mksession         +smartindent       +X11
+diff              +modify_fname      -sound             -xfontset
+digraphs          +mouse             +spell             +xim
+dnd               +mouseshape        +startuptime       -xpm
-ebcdic            +mouse_dec         +statusline        +xsmp_interact
+emacs_tags        -mouse_gpm         -sun_workshop      +xterm_clipboard
+eval              -mouse_jsbterm     +syntax            -xterm_save
+ex_extra          +mouse_netterm     +tag_binary        
+extra_search      +mouse_sgr         -tag_old_static    
      システム vimrc: "$VIM/vimrc"
      ユーザー vimrc: "$HOME/.vimrc"
   第2ユーザー vimrc: "~/.vim/vimrc"
       ユーザー exrc: "$HOME/.exrc"
     システム gvimrc: "$VIM/gvimrc"
     ユーザー gvimrc: "$HOME/.gvimrc"
  第2ユーザー gvimrc: "~/.vim/gvimrc"
  デフォルトファイル: "$VIMRUNTIME/defaults.vim"
    システムメニュー: "$VIMRUNTIME/menu.vim"
       省略時の $VIM: "/usr/local/share/vim"
コンパイル: gcc -std=gnu99 -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_GTK  -pthread -I/usr/include/gtk-2.0 -I/usr/lib64/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/pango-1.0 -I/usr/include/fribidi -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/libpng15 -I/usr/include/uuid -I/usr/include/pixman-1 -I/usr/include/libdrm     -O2 -fno-strength-reduce -Wall -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1       
リンク: gcc -std=gnu99   -L/usr/local/lib -Wl,--as-needed -o vim   -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lgobject-2.0 -lglib-2.0 -lfreetype   -lSM -lICE -lXt -lX11 -lSM -lICE  -lm -ltinfo -lnsl  -ldl           
[apache@d545e9eaf130 /var/www]$vi --version
VIM - Vi IMproved 8.1 (2018 May 18, compiled Aug 18 2019 07:27:10)
適用済パッチ: 1-1879
Compiled by root@95085e69ea84
Huge 版 with GTK2 GUI.  機能の一覧 有効(+)/無効(-)
+acl               -farsi             -mouse_sysmouse    -tag_any_white
+arabic            +file_in_path      +mouse_urxvt       -tcl
+autocmd           +find_in_path      +mouse_xterm       +termguicolors
+autochdir         +float             +multi_byte        +terminal
-autoservername    +folding           +multi_lang        +terminfo
+balloon_eval      -footer            -mzscheme          +termresponse
+balloon_eval_term +fork()            +netbeans_intg     +textobjects
+browse            +gettext           +num64             +textprop
++builtin_terms    -hangul_input      +packages          +timers
+byte_offset       +iconv             +path_extra        +title
+channel           +insert_expand     -perl              +toolbar
+cindent           +job               +persistent_undo   +user_commands
+clientserver      +jumplist          +postscript        +vartabs
+clipboard         +keymap            +printer           +vertsplit
+cmdline_compl     +lambda            +profile           +virtualedit
+cmdline_hist      +langmap           -python            +visual
+cmdline_info      +libcall           -python3           +visualextra
+comments          +linebreak         +quickfix          +viminfo
+conceal           +lispindent        +reltime           +vreplace
+cryptv            +listcmds          +rightleft         +wildignore
+cscope            +localmap          -ruby              +wildmenu
+cursorbind        -lua               +scrollbind        +windows
+cursorshape       +menu              +signs             +writebackup
+dialog_con_gui    +mksession         +smartindent       +X11
+diff              +modify_fname      -sound             -xfontset
+digraphs          +mouse             +spell             +xim
+dnd               +mouseshape        +startuptime       -xpm
-ebcdic            +mouse_dec         +statusline        +xsmp_interact
+emacs_tags        -mouse_gpm         -sun_workshop      +xterm_clipboard
+eval              -mouse_jsbterm     +syntax            -xterm_save
+ex_extra          +mouse_netterm     +tag_binary        
+extra_search      +mouse_sgr         -tag_old_static    
      システム vimrc: "$VIM/vimrc"
      ユーザー vimrc: "$HOME/.vimrc"
   第2ユーザー vimrc: "~/.vim/vimrc"
       ユーザー exrc: "$HOME/.exrc"
     システム gvimrc: "$VIM/gvimrc"
     ユーザー gvimrc: "$HOME/.gvimrc"
  第2ユーザー gvimrc: "~/.vim/gvimrc"
  デフォルトファイル: "$VIMRUNTIME/defaults.vim"
    システムメニュー: "$VIMRUNTIME/menu.vim"
       省略時の $VIM: "/usr/local/share/vim"
コンパイル: gcc -std=gnu99 -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_GTK  -pthread -I/usr/include/gtk-2.0 -I/usr/lib64/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/pango-1.0 -I/usr/include/fribidi -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/libpng15 -I/usr/include/uuid -I/usr/include/pixman-1 -I/usr/include/libdrm     -O2 -fno-strength-reduce -Wall -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1       
リンク: gcc -std=gnu99   -L/usr/local/lib -Wl,--as-needed -o vim   -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lgobject-2.0 -lglib-2.0 -lfreetype   -lSM -lICE -lXt -lX11 -lSM -lICE  -lm -ltinfo -lnsl  -ldl           
[apache@d545e9eaf130 /var/www]$python --version
Python 3.6.8
[apache@d545e9eaf130 /var/www]$pip --version
pip 19.2.2 from /usr/local/lib/python3.6/site-packages/pip (python 3.6)
```

# ブラウザから起動確認
```
http://192.168.1.109:80/
```

![](./1.png)
