```
$cd $HOME/script-env
$ls P[0-1][0-9]* R07* | xargs -n1 -I@ echo "bash @ script-env" | bash
```
- リグレッション
