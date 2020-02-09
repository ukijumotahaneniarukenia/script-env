- https://qiita.com/api/v2/docs

- https://qiita.com/wakudar/items/8c594c8cc7bda9b93b4e

item全体から記事取得

ACCESS_TOKENはマイページより取得

6件取得
```
curl -s -H 'Authorization: Bearer ACCESS_TOKEN' https://qiita.com/api/v2/tags?page=1\&per_page=6 | jq
```

```
[
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "clj-slack",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "Venn.Diagram",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "#ArduinoIDE",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "#M5Camera",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "firebaseau",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "とびしまハッカソン",
    "items_count": 0
  }
]
```

```
curl -s -H 'Authorization: Bearer ACCESS_TOKEN' https://qiita.com/api/v2/tags?page=1\&per_page=3 | jq
```

```
[
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "clj-slack",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "Venn.Diagram",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "#ArduinoIDE",
    "items_count": 1
  }
]
```

```
curl -s -H 'Authorization: Bearer ACCESS_TOKEN' https://qiita.com/api/v2/tags?page=2\&per_page=3 | jq
```

```
[
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "#M5Camera",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "firebaseau",
    "items_count": 1
  },
  {
    "followers_count": 0,
    "icon_url": null,
    "id": "とびしまハッカソン",
    "items_count": 0
  }
]
```

```
curl -s https://qiita.com/ukijumotahaneniarukenia/like?page={1..25} | grep -o "\<a class=\"u-link-no-underline\" .*" | grep -o "href.*" | grep -oP ".*(?=</a)" | sed -e 's/href="//' -e 's/\">/\t/' | awk '{print "https://qiita.com"$1"\t"}{$1="";print $0" ""UNKO"}' | sed ':a;N;/UNKO/!ba;s/\n\{1,\}/ /g;s/UNKO//g;' | nl
```

articleタグで始まってarticleタグでおわる

```
curl -s https://qiita.com/ukijumotahaneniarukenia/like?page={1..1} | sed -r 's;<article;\n<article;g' | grep article | nl | grep article
```

各記事を一行に集約

```
curl -s https://qiita.com/ukijumotahaneniarukenia/like?page={1..1}|sed -r 's;<article;\n<article;g'|tr -d ' '| grep -P '^<(?:article|ul)(?=class=)' | xargs -n2 | grep -n article
```


```
#!/bin/bash

while read tgt;do
  TAGS=$(echo $tgt | sed -r 's;<ulclass=pagination>|</div><divclass=text-center>;;;' | grep -Po 'href=(/[a-zA-Z%0-9]+){1,}' | sort | uniq)
  DTM=$(echo $tgt | sed -r 's;<ulclass=pagination>|</div><divclass=text-center>;;;' | \
    grep -Po '(?<=postedon)(Apr|Aug|Dec|Feb|Jan|Jul|Jun|Mar|May|Nov|Oct|Sep)[0-9]{2},[0-9]{4}' | \
    sed -r 's;([0-9]{2}); \1;;s;,; ;' | \
    tr ' ' '-'
  )
  TITLE=$(echo $tgt | sed -r 's;<ulclass=pagination>|</div><divclass=text-center>;;;'| sed -r 's;</a>;\n;g' | grep -v img | grep -Po 'href=(/[a-zA-Z%0-9]+){1,}.*' | tr '>' ' ' | grep -P '[0-9a-z]{20}' | grep -vP '[0-9a-z]{20} [0-9]{1,}')
 echo $TAGS $(date -d  "$(tr "-" " " <<<$DTM)" "+%Y-%m-%d") $TITLE
done < <(curl -s https://qiita.com/ukijumotahaneniarukenia/like?page={1..14}|sed -r 's;<article;\n<article;g'|tr -d ' '| grep -P '^<(?:article|ul)(?=class=)' | xargs -n2) | sed '$d'
```
