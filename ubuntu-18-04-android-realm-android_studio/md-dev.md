android_studioの起動
```
and
```

環境変数等の設定

```
export ANDROID_STUDIO_HOME=/usr/local/src/android-studio
export PATH=$ANDROID_STUDIO_HOME/bin:$PATH
alias and=studio.sh 1>launch-android-studio.log 2>&1 &
```

エミュレータ起動の際に必要だったライブラリ
```
apt install -y libpulse-dev
apt install -y libasound2-dev
```

kvm上でqtライブラリ等を経由していろいろうごくぽい。結構楽しい。


設定ファイル等はすべてxmlファイルなので、json変換してjq等で整形後、
json2xml処理して元に戻せれば、ハンディになりそう。


そんな複雑でもなかったので、元に戻せる必要はなさそう。


kvmでguiに詰まったら、使用しているライブラリ等は参考になりそう。予測が付きそう。
