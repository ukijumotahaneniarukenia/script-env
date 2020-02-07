
dockerの作成時刻これにする


docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2
