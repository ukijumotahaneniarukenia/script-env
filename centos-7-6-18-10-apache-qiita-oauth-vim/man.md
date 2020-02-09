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
