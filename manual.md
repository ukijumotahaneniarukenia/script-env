# docker内でもgit使うための手順

## 対象レポジトリをローカルにコピー
```
git clone https://github.com/user_name/XXX.git
```

## gitサービスを利用するユーザーの事前設定
git config --listで設定がファイルに書き込まれていることを確認する。
```
git config --list
git config --global user.name "user_name"
git config --global user.email "user_email"
```

## git管理下のフォルダ内で成果物コミット

```
git add manual.md
git commit -m "docker内でのgit運用。"
git push -u origin master
```

## 参考文献

[使い始める - 最初のGitの構成](https://git-scm.com/book/ja/v1/%E4%BD%BF%E3%81%84%E5%A7%8B%E3%82%81%E3%82%8B-%E6%9C%80%E5%88%9D%E3%81%AEGit%E3%81%AE%E6%A7%8B%E6%88%90)
