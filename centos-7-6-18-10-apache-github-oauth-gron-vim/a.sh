#!/usr/bin/env bash

Q="$@"

curl -s "https://github.com/search?p=1&q=$Q" | grep -oPi 'https?://github\.com(/[0-9a-z\-]{1,}){1,}' | \
grep -vP '(about|contact|events|fluidicon|pricing|search|search/count|security|site/privacy|site/terms)$'
