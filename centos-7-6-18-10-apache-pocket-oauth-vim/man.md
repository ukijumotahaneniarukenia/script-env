この手順はやりなおしができる

# Step 0:ローカルホストでHTTPサーバたてる

dockerで作成。リダイレクト先を自前で準備

- 以下のURLにブラウザからアクセスしてTesting 123..のレスポンスページが表示されたらOK
  - http://localhost:8080


# Step 1: Obtain a platform consumer key


以下のページからコンシューマーキーを取得する
- https://getpocket.com/developer/apps/new

Create an Application

以下の通り入力する
|key|value|
|:-:|:-:|
|Application Name|test|
|Application Description|test|
|Permissions-Add|check|
|Permissions-Modify|check|
|Permissions-Retreive|check|
|Platforms-Desktop(other)|check|

最後にチェック
I accept the Terms of Service.

画面遷移先にアプリケーション単位でコンシューマーキーが作成されるので、
控えておく

# Step 2: Obtain a request token

dockerコンテナ側から実行

リクエストトークンを取得する

```
curl -X POST -F "consumer_key=89770-372ba6d8a571aa0ecc82d71a" -F "redirect_uri=http://localhost:8080/" https://getpocket.com/v3/oauth/request
```

dockerコンテナ側から実行

keyがcodeのvalue値がリクエストトークン

```
$curl -X POST -F "consumer_key=89770-372ba6d8a571aa0ecc82d71a" -F "redirect_uri=http://localhost:8080/" https://getpocket.com/v3/oauth/request
code=b649c90d-0ad8-91ba-1ab1-4a9480
```

# Step 3: Redirect user to Pocket to continue authorization

自身のデータを操作するためにアプリケーションを作成したが、
そのアプリケーション単位での操作を許可するために、以下のコマンドを実行

表示されたページで、本人であることを確認し、認可ボタンをおす

xdg-openコマンドがありかつX環境があるコンテナの場合、dockerコンテナ側から実行可能

コマンドラインから実行
```
xdg-open https://getpocket.com/auth/authorize?request_token=b649c90d-0ad8-91ba-1ab1-4a9480&redirect_uri=http://localhost:8080/
```

dockerホスト側から実行

ブラウザからアクセス
```
https://getpocket.com/auth/authorize?request_token=b649c90d-0ad8-91ba-1ab1-4a9480&redirect_uri=http://localhost:8080/
```

# Step 4: Receive the callback from Pocket

リダイレクト画面が表示されたらOK
今回の場合はTesting 123..のレスポンスページが表示されたらOK


# Step 5: Convert a request token into a Pocket access token

Step1のコンシューマキーとStep2のリクエストトークンを引数に渡して以下のコマンドを実行

dockerコンテナ側から実行

コマンドラインから実行
```
curl -X POST -F "consumer_key=89770-372ba6d8a571aa0ecc82d71a" -F "code=b649c90d-0ad8-91ba-1ab1-4a9480" https://getpocket.com/v3/oauth/authorize
```

アクセストークンが取得できる

```
$curl -X POST -F "consumer_key=89770-372ba6d8a571aa0ecc82d71a" -F "code=b649c90d-0ad8-91ba-1ab1-4a9480" https://getpocket.com/v3/oauth/authorize
access_token=9f03752d-2133-f72d-312d-869305&username=mrchildrenkh1008%40gmail.com
```

# Step 6: Make authenticated requests to Pocket

Step5のアクセストークンを引数に渡してポケットAPIの規約に従い、コマンドを実行。

dockerコンテナ側からでも行ける。dockerホストがプロキシサーバーとして振舞っているから。

以下の例は全件fetch
```
curl -X POST -F "consumer_key=89770-372ba6d8a571aa0ecc82d71a" -F "access_token=9f03752d-2133-f72d-312d-869305" https://getpocket.com/v3/get
```

# Step 99:取得結果を保存し、アプリケーションを削除

以下のURLからStep1で作成したアプリケーションを削除しておく。

- https://getpocket.com/developer/apps/
