- レポジトリ構成
	- script-template
		- プログラム単位のテンプーレトファイルを管理
		- ディレクトリ構成はscript-sketchと同じ
	- script-sketch
		- プログラムないしアプリ単位にディレクトリを切って運用
		- ディレクトリ名は単一アプリ名
	- script-env
		- os名-バージョン-アプリないしソフト名とそのバージョン単一ないし複数-エディタ単一
		- エディタデフォルトはvim
	- script-repo
		- プログラムのインストーラーシェル
		- プログラムのローンチシェル
		- プログラムのコンフィグシェル
		- プログラムのプレパッチシェル
		- プログラムのポストパッチシェル
		- プログラムのヘルスチェックシェル
		- プログラムの実行ユーザー登録シェル
		- プログラムのデフォルトシステムシェル
		- プログラムのデフォルトユーザーシェル
	- script-cmd
		- 実行コマンドとして仕込ませるなど
	- script-ci
		- 自動実行してみるなど
	- script-search
		- 上記レポジトリ全てを全文検索など

- script-envの構成
    - 環境ファイル構成
    	都度、ダイナミックに管理したいものがあれば追加
        - env-build-arg.env
            - ビルド環境引数
        - env-env.env
            - 環境変数
        - env-expose.env
            - 公開ポートと非公開ポート
        - env-image.env
            - ベンダーイメージ
        - env-shm-size.env
            - メモリ
        - env-user.env
            - 登録ユーザー

    - 環境ファイル以外の構成
	    script-sketchに移植するようの元ネタ程度になればいいので、ざっくりでいいや
        - md-doc.md
            - dockerコンテナ操作を記載
        - md-dev.md
            - 開発マニュアルを記載
        - md-ref.md
            - 参考文献を記載
        - md-trs.md
            - 環境構築の際のトラブルシュートを記載
        - md-man.md
            - 上記マークダウンファイル以外に該当する内容を記載

- レポジトリライフサイクル

```
env-->sketch-->repo
remove env

or

env-->sketch-->template
remove env

or

env-->sketch-->cmd
remove env

or

env-->sketch-->ci
remove env

or

env-->sketch-->search
remove env
```

- crontabで定期実行スクリプト作成
    - http://dqn.sakusakutto.jp/2012/06/cron_crontab9.html
    - https://zenpou.hatenadiary.org/entry/20080715/1216133151
    - https://qiita.com/mazgi/items/15e1fe7e130584343810
    - https://qiita.com/onomame/items/71646c5517a39bcd01cc

バックアップ

```
$crontab -l>~/script_env/docker-build-crontab
```

編集
```
$vi ~/script_env/docker-build-crontab
```

反映
```
crontab < ~/script_env/docker-build-crontab
```

確認

```
$crontab -l
```

プロセス確認

```
$ps aux | grep cron
```

起動ログの確認

```
$sudo less /var/log/cron
```

強制終了

```
su root

ps aux  | grep 'docker build' | awk '{print $2}' | xargs kill
```

- 環境構築スクリプト

	- 環境ディレクトリに移動して実行
	- メンテスクリプトはREPOをダイナミックに管理しておく

```
cd $HOME/script-env
ls D[0][1]* D[0][6]* D[0][9]* P[0-1][0-9]* R07* | xargs -n1 -I@ echo "bash @ script-env" | bash
```