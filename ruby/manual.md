# 参考文献

https://bugs.ruby-lang.org/issues/14409

```
$sudo yum install -y bison
$git clone https://github.com/ruby/ruby.git
$cd ruby/
$autoconf
$sudo yum install -y ruby
$./configure --prefix=/usr/local --enable-shared
$make -j12
$sudo make -j12 install
$which ruby
/usr/local/bin/ruby
$ruby --version
ruby 2.7.0dev (2019-10-30T12:36:59Z master 6c3ed0d71c) [x86_64-linux]
```


# 動作確認

```
$ruby -e 'puts "unko"'
unko
$ruby -e 'puts "💩"'
💩
$seq 10 | xargs -I@ ruby -e 'puts @'
1
2
3
4
5
6
7
8
9
10
$seq 10 | xargs -I@ ruby -e 'puts @' -e 'puts @'
1
1
2
2
3
3
4
4
5
5
6
6
7
7
8
8
9
9
10
10
$seq 10 | xargs -I@ echo ruby "-e 'puts @"{,,}\'
ruby -e 'puts 1' -e 'puts 1' -e 'puts 1'
ruby -e 'puts 2' -e 'puts 2' -e 'puts 2'
ruby -e 'puts 3' -e 'puts 3' -e 'puts 3'
ruby -e 'puts 4' -e 'puts 4' -e 'puts 4'
ruby -e 'puts 5' -e 'puts 5' -e 'puts 5'
ruby -e 'puts 6' -e 'puts 6' -e 'puts 6'
ruby -e 'puts 7' -e 'puts 7' -e 'puts 7'
ruby -e 'puts 8' -e 'puts 8' -e 'puts 8'
ruby -e 'puts 9' -e 'puts 9' -e 'puts 9'
ruby -e 'puts 10' -e 'puts 10' -e 'puts 10'
$seq 10 | xargs -I@ echo ruby "-e 'puts @"{,,}\' | bash
1
1
1
2
2
2
3
3
3
4
4
4
5
5
5
6
6
6
7
7
7
8
8
8
9
9
9
10
10
```
