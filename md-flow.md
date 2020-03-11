|OPE|ACTION|
|--:|--:|


- 各環境ディレクトリで既存DockerfileをDockerfile.asisにリネーム

- 各環境ディレクトリでDockerfileを編集

- 日次でDockerfile.subを作成

- 日次でDockerfile.autoを作成

- Dockerfile.subを作成

- Dockerfile.subをメンテ。メンテ完了後、doneする

- Dockerfile.autoにDockerfile.sub.doneをマージし、Dockerfile.doneを作成

- Dockerfile.doneに対してリグレッション

- Dockerfile.doneをDockerfileにリネーム

- Dockerfileに対して動作確認

- script-repoを修正する際に、env-build.mdファイルを修正するようにする

- script-repoに格納しているスクリプトはエントリ実行ユーザーがroot
