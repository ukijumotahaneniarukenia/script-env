# 参考文献

公式マニュアル
- https://ja.nuxtjs.org/guide/installation/

Web Components
- https://html5experts.jp/shumpei-shiraishi/24239/

Custom Elements
HTML に新しい要素を定義する
- https://www.html5rocks.com/ja/tutorials/webcomponents/customelements/


HTML Imports - Web Components を構成する技術
- https://blog.agektmr.com/2015/01/html-imports-web-components.html


私がscriptタグについて知っていること全て : 知られていない属性や実行順序など
- https://postd.cc/everything-i-know-about-the-script-tag/


Web標準だけでHTMLを部品化するWeb Componentsを試してみる
- http://albatrosary.hateblo.jp/entry/2014/07/23/221839

【続】Web標準だけでHTMLを部品化するWeb Componentsを試してみる
- http://albatrosary.hateblo.jp/entry/2014/07/24/134928

Shadow DOM v1: 自己完結型ウェブ コンポーネント
- https://developers.google.com/web/fundamentals/web-components/shadowdom?hl=ja#stylefromoutside

# スクラッチから開発

アプリディレクトリ作成
```
mkdir test
```

設定ファイル修正
```
cd test
cat <<EOS>package.json
{
  "name": "test",
  "scripts": {
    "dev": "nuxt"
  }
}
EOS
```

```
cd test
sed -i 's;"dev": "nuxt";"dev": "HOST=0.0.0.0 PORT=3000 nuxt";' package.json
```

NUXTフレームワークインストール
```
cd test
npm install --save nuxt
```

テストページ作成
a``
cat <<EOS>pages/index.vue
<template>
  <h1>Hello world!</h1>
</template>
EOS
```

# プロセス起動

フォアグラウンド起動
```
cd test
npm run dev

> test@ dev /home/kuraine/test
> HOST=0.0.0.0 PORT=3000 nuxt


   ╭─────────────────────────────────────────────╮
   │                                             │
   │   Nuxt.js v2.11.0                           │
   │   Running in development mode (universal)   │
   │                                             │
   │   Listening on: http://172.17.0.6:3000/     │
   │                                             │
   ╰─────────────────────────────────────────────╯

ℹ Preparing project for development                                                                                                                                                                      00:34:21
ℹ Initial build may take a while                                                                                                                                                                         00:34:21
✔ Builder initialized                                                                                                                                                                                    00:34:21
✔ Nuxt files generated                                                                                                                                                                                   00:34:21

✔ Client
  Compiled successfully in 1.30s

✔ Server
  Compiled successfully in 1.07s

ℹ Waiting for file changes                                                                                                                                                                               00:34:23
ℹ Memory usage: 160 MB (RSS: 229 MB)                                                                                                                                                                     00:34:23

```

バッググラウンド起動
```
npm run dev 1>launch-nuxtjs.log 2>&1 &
[1] 804
```

ログ確認
```
tail -f launch-nuxtjs.log
ℹ Preparing project for development
ℹ Initial build may take a while
✔ Builder initialized
✔ Nuxt files generated
ℹ Compiling Client
ℹ Compiling Server
✔ Server: Compiled successfully in 1.06s
✔ Client: Compiled successfully in 1.29s
ℹ Waiting for file changes
ℹ Memory usage: 166 MB (RSS: 225 MB)
```

# 待受ポート確認

```
lsof -P -i:3000
COMMAND PID    USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
node     93 kuraine   21u  IPv4 1658094      0t0  TCP localhost:3000 (LISTEN)
```


# URLアクセス


ブラウザ
```
http://172.17.0.6:3000/
```

コマンドライン
```
curl http://localhost:3000/
```
