# 参考文献
https://www.slideshare.net/mobile/rakutentech/egison-44189985
https://www.egison.org/getting-started/getting-started-linux.html
https://www.haskell.org/platform/#linux-redhat
https://qiita.com/waddlaw/items/49874f4cf9b680e4b015


haskellを動かすにはghc環境が必要

https://www.haskell.org/ghc/download_ghc_8_8_1.html

https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/ghci.html

ghcとは
https://ja.wikipedia.org/wiki/Glasgow_Haskell_Compiler


# stackコマンドインストール
https://haskell.e-bigmoon.com/stack/intro/stack-install.html


# haskellチュートリアル

https://wiki.haskell.org/Haskell%E5%85%A5%E9%96%80_5%E3%82%B9%E3%83%86%E3%83%83%E3%83%97

```
[sqlite💗b64e746d9822 (金 10月 18 23:45:29) ~]$echo "main=putStrLn \"hello\"" > hello.hs
[sqlite💗b64e746d9822 (金 10月 18 23:46:10) ~]$cat hello.hs 
main=putStrLn "hello"
[sqlite💗b64e746d9822 (金 10月 18 23:46:15) ~]$ghc -o hello hello.hs
[1 of 1] Compiling Main             ( hello.hs, hello.o )
Linking hello ...
[sqlite💗b64e746d9822 (金 10月 18 23:46:30) ~]$ll
total 192264
drwxrwxr-x 14 sqlite sqlite      4096 10月 18 23:25 ghc-8.8.1
-rw-rw-r--  1 sqlite sqlite 194601024 10月 18 23:20 ghc-8.8.1-x86_64-centos7-linux.tar.xz
-rwxrwxr-x  1 sqlite sqlite   2255992 10月 18 23:46 hello
-rw-rw-r--  1 sqlite sqlite       842 10月 18 23:46 hello.hi
-rw-rw-r--  1 sqlite sqlite        22 10月 18 23:46 hello.hs
-rw-rw-r--  1 sqlite sqlite      3184 10月 18 23:46 hello.o
[sqlite💗b64e746d9822 (金 10月 18 23:46:35) ~]$./hello
hello

```

# ghcインストール
```
[sqlite💚b64e746d9822 (金 10月 18 23:19:43) ~]$curl -LO https://downloads.haskell.org/~ghc/8.8.1/ghc-8.8.1-x86_64-centos7-linux.tar.xz
[sqlite💚b64e746d9822 (金 10月 18 23:21:21) ~]$tar -xvf ghc-8.8.1-x86_64-centos7-linux.tar.xz 
[sqlite💚b64e746d9822 (金 10月 18 23:21:53) ~]$cd ghc-8.8.1
[sqlite💚b64e746d9822 (金 10月 18 23:21:58) ~/ghc-8.8.1]$./configure --help
`configure' configures The Glorious Glasgow Haskell Compilation System 8.8.1 to adapt to many kinds of systems.

Usage: ./configure [OPTION]... [VAR=VALUE]...

To assign environment variables (e.g., CC, CFLAGS...), specify them as
VAR=VALUE.  See below for descriptions of some of the useful variables.

Defaults for the options are specified in brackets.

Configuration:
  -h, --help              display this help and exit
      --help=short        display options specific to this package
      --help=recursive    display the short help of all the included packages
  -V, --version           display version information and exit
  -q, --quiet, --silent   do not print `checking ...' messages
      --cache-file=FILE   cache test results in FILE [disabled]
  -C, --config-cache      alias for `--cache-file=config.cache'
  -n, --no-create         do not create output files
      --srcdir=DIR        find the sources in DIR [configure dir or `..']

Installation directories:
  --prefix=PREFIX         install architecture-independent files in PREFIX
                          [/usr/local]
  --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
                          [PREFIX]

By default, `make install' will install all the files in
`/usr/local/bin', `/usr/local/lib' etc.  You can specify
an installation prefix other than `/usr/local' using `--prefix',
for instance `--prefix=$HOME'.

For better control, use the options below.

Fine tuning of the installation directories:
  --bindir=DIR            user executables [EPREFIX/bin]
  --sbindir=DIR           system admin executables [EPREFIX/sbin]
  --libexecdir=DIR        program executables [EPREFIX/libexec]
  --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
  --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
  --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
  --libdir=DIR            object code libraries [EPREFIX/lib]
  --includedir=DIR        C header files [PREFIX/include]
  --oldincludedir=DIR     C header files for non-gcc [/usr/include]
  --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
  --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
  --infodir=DIR           info documentation [DATAROOTDIR/info]
  --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
  --mandir=DIR            man documentation [DATAROOTDIR/man]
  --docdir=DIR            documentation root [DATAROOTDIR/doc/ghc-8.8.1]
  --htmldir=DIR           html documentation [DOCDIR]
  --dvidir=DIR            dvi documentation [DOCDIR]
  --pdfdir=DIR            pdf documentation [DOCDIR]
  --psdir=DIR             ps documentation [DOCDIR]

System types:
  --build=BUILD     configure for building on BUILD [guessed]
  --host=HOST       cross-compile to build programs to run on HOST [BUILD]
  --target=TARGET   configure for building compilers for TARGET [HOST]

Optional Features:
  --disable-option-checking  ignore unrecognized --enable/--with options
  --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
  --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
  --disable-ld-override   Prevent GHC from overriding the default linker used
                          by gcc. If ld-override is enabled GHC will try to
                          tell gcc to use whichever linker is selected by the
                          LD environment variable. [default=override enabled]

Optional Packages:
  --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  --with-gmp-includes     directory containing gmp.h
  --with-gmp-libraries    directory containing gmp library
  --with-intree-gmp       force using the in-tree GMP
  --with-gmp-framework-preferred
                          on OSX, prefer the GMP framework to the gmp lib
  --with-hs-cpp=ARG       Path to the (C) preprocessor for Haskell files
                          [default=autodetect]
  --with-hs-cpp-flags=ARG Flags to the (C) preprocessor for Haskell files
                          [default=autodetect]

Some influential environment variables:
  CC          C compiler command
  CFLAGS      C compiler flags
  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
              nonstandard directory <lib dir>
  LIBS        libraries to pass to the linker, e.g. -l<library>
  CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
              you have headers in a nonstandard directory <include dir>
  CPP         C preprocessor

Use these variables to override the choices made by `configure' or to help
it to find libraries and programs with nonstandard names/locations.

Report bugs to <glasgow-haskell-bugs@haskell.org>.
[sqlite💚b64e746d9822 (金 10月 18 23:23:48) ~/ghc-8.8.1]$./configure --prefix=/usr/local | tee log
[sqlite💚b64e746d9822 (金 10月 18 23:26:09) ~/ghc-8.8.1]$sudo make -j12 install | tee logg
[sqlite💚b64e746d9822 (金 10月 18 23:26:09) ~/ghc-8.8.1]$which ghc
/usr/local/bin/ghc
[sqlite💚b64e746d9822 (金 10月 18 23:26:49) ~/ghc-8.8.1]$/usr/local/bin/ghc --version
The Glorious Glasgow Haskell Compilation System, version 8.8.1
[sqlite💚b64e746d9822 (金 10月 18 23:26:57) ~/ghc-8.8.1]$/usr/local/bin/ghc --help
Usage:

    ghc [command-line-options-and-input-files]

To compile and link a complete Haskell program, run the compiler like
so:

    ghc Main

where the module Main is in a file named Main.hs (or Main.lhs) in the
current directory.  The other modules in the program will be located
and compiled automatically, and the linked program will be placed in
the file `Main' (or `Main.exe' on Windows).

Alternatively, ghc can be used to compile files individually.  Each
input file is guided through (some of the) possible phases of a
compilation:

    - unlit:	extract code from a "literate program"
    - hscpp:	run code through the C pre-processor (if -cpp flag given)
    - hsc:	run the Haskell compiler proper
    - gcc:	run the C compiler (if compiling via C)
    - as:	run the assembler
    - ld:	run the linker

For each input file, the phase to START with is determined by the
file's suffix:

    - .lhs	literate Haskell		 unlit
    - .hs	plain Haskell			 ghc
    - .hc	C from the Haskell compiler	 gcc
    - .c	C not from the Haskell compiler  gcc
    - .s	assembly language		 as
    - other	passed directly to the linker	 ld

The phase at which to STOP processing is determined by a command-line
option:

    -E		stop after generating preprocessed, de-litted Haskell
		     (used in conjunction with -cpp)
    -C		stop after generating C (.hc output)
    -S		stop after generating assembler (.s output)
    -c		stop after generating object files (.o output)

Other commonly-used options are:

    -v[n]	    Control verbosity (n is 0--5, normal verbosity level is 1,
	              -v alone is equivalent to -v3)

    -O		    An `optimising' package of compiler flags, for faster code

    -prof	    Compile for cost-centre profiling
		     (add -fprof-auto for automagic cost-centres on all
		      top-level functions)

    -H14m	    Increase compiler's heap size (might make compilation
		    faster, especially on large source files).

    -M              Output Makefile rules recording the
		    dependencies of a list of Haskell files.

Given the above, here are some TYPICAL invocations of ghc:

    # compile a Haskell module to a .o file, optimising:
    % ghc -c -O Foo.hs
    # link three .o files into an executable called "test":
    % ghc -o test Foo.o Bar.o Baz.o
    # compile a Haskell module to C (a .hc file), using a bigger heap:
    % ghc -C -H16m Foo.hs
    # compile Haskell-produced C (.hc) to assembly language:
    % ghc -S Foo.hc

The User's Guide has more information about GHC's *many* options.  An
online copy can be found here:

   http://www.haskell.org/ghc/docs/latest/html/users_guide/

If you *really* want to see every option, then you can pass
'--show-options' to the compiler.

------------------------------------------------------------------------

```

# 動作確認

やった！

```
[sqlite💚b64e746d9822 (金 10月 18 23:27:43) ~/ghc-8.8.1]$ghci
GHCi, version 8.8.1: https://www.haskell.org/ghc/  :? for help
Prelude> 1+2
3
Prelude> let x=42 in x/9
4.666666666666667
Prelude> x=42
Prelude> x
42
Prelude> 
Leaving GHCi.
```
