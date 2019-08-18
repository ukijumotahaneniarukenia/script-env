# Dockerfileよりshinyイメージ作成
```
time docker build -t centos_shiny . | tee log
```

```
cat <(docker images | head -n1) <(docker images | awk '$1=="centos_shiny"{print $0}')
[oracle@centos shiny]$ cat <(docker images | head -n1) <(docker images | awk '$1=="centos_shiny"{print $0}')
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos_shiny        latest              cac78a083cce        5 minutes ago       4GB
```

# dockerコンテナ作成
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 3838:3838 --name shiny -itd centos_shiny /sbin/init
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
rootユーザーないし、shinyユーザー。
```
[oracle@centos shiny]$ docker exec --user root -it shiny bash
[root@d2c30f3298cd /srv/shiny-server]$su shiny
[shiny@d2c30f3298cd /srv/shiny-server]$exit
[root@d2c30f3298cd /srv/shiny-server]$exit
[oracle@centos shiny]$ docker exec --user shiny -it shiny bash
[shiny@d2c30f3298cd /srv/shiny-server]$su root
Password: 
[root@d2c30f3298cd /srv/shiny-server]$exit
[shiny@d2c30f3298cd /srv/shiny-server]$exit
```

# shiny-server起動確認
```
[root@e5f42d887d44 shiny-server]# systemctl status shiny-server                                                                                                                                                   
● shiny-server.service - ShinyServer
   Loaded: loaded (/etc/systemd/system/shiny-server.service; enabled; vendor preset: disabled)
   Active: active (running) since 土 2019-08-17 11:23:33 JST; 2min 33s ago
 Main PID: 154 (shiny-server)
   CGroup: /docker/e5f42d887d44fa32bd6c0925eb19d0a218f3d3143d24e55f1796eb1867c2c256/system.slice/shiny-server.service
           └─154 /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js
           ‣ 154 /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js

 8月 17 11:23:33 e5f42d887d44 systemd[1]: Started ShinyServer.
```

# ブラウザから起動確認

```
http://192.168.1.109:3838/
```

![](./1.png)

# バージョン情報
```
[shiny@2dd6f7f0b03e shiny-server]$ awk --version
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
[shiny@2dd6f7f0b03e shiny-server]$ bash --version
GNU bash, バージョン 5.0.0(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2019 Free Software Foundation, Inc.
ライセンス GPLv3+: GNU GPL バージョン 3 またはそれ以降 <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
[shiny@2dd6f7f0b03e shiny-server]$ vim --version
VIM - Vi IMproved 8.1 (2018 May 18, compiled Aug 18 2019 04:13:34)
適用済パッチ: 1-1879
Compiled by root@6f34d9f335a6
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
リンク: gcc -std=gnu99   -L/usr/local/lib -Wl,--as-needed -o vim   -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lgobject-2.0 -lglib-2.0 -lfreetype   -lSM -lICE -lXt -lX11 -lSM -lICE  -lm -ltinfo -lnsl  -lselinux -ldl           
[shiny@2dd6f7f0b03e shiny-server]$ vi --version
VIM - Vi IMproved 8.1 (2018 May 18, compiled Aug 18 2019 04:13:34)
適用済パッチ: 1-1879
Compiled by root@6f34d9f335a6
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
リンク: gcc -std=gnu99   -L/usr/local/lib -Wl,--as-needed -o vim   -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lgobject-2.0 -lglib-2.0 -lfreetype   -lSM -lICE -lXt -lX11 -lSM -lICE  -lm -ltinfo -lnsl  -lselinux -ldl           
[shiny@2dd6f7f0b03e shiny-server]$ python --version
Python 3.6.8
[shiny@2dd6f7f0b03e shiny-server]$ pip --version
pip 19.2.2 from /usr/local/lib/python3.6/site-packages/pip (python 3.6)
```

# ブラウザから起動確認
```
http://192.168.1.109:3838/
```

![](./1.png)
