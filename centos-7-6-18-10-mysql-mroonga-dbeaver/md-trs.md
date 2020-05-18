# トラシュー

- 事象

```
ERROR 1026 (HY000) at line 100 in file: 'centos-7-6-18-10-healthcheck-mysql-8-X-X-mroonga-X-X-X.sql': [plugin][register] cannot find plugin file: </usr/lib64/groonga/plugins/token_filters/stem.so>
```

- 原因
  stem.soダイナミックリンクファイルがない たしかにない

```
$find /usr/lib64/groonga/plugins
/usr/lib64/groonga/plugins
/usr/lib64/groonga/plugins/sharding.rb
/usr/lib64/groonga/plugins/sharding
/usr/lib64/groonga/plugins/sharding/logical_enumerator.rb
/usr/lib64/groonga/plugins/sharding/logical_parameters.rb
/usr/lib64/groonga/plugins/sharding/keys_parsable.rb
/usr/lib64/groonga/plugins/sharding/range_expression_builder.rb
/usr/lib64/groonga/plugins/sharding/logical_shard_list.rb
/usr/lib64/groonga/plugins/sharding/logical_table_remove.rb
/usr/lib64/groonga/plugins/sharding/parameters.rb
/usr/lib64/groonga/plugins/sharding/dynamic_columns.rb
/usr/lib64/groonga/plugins/sharding/logical_count.rb
/usr/lib64/groonga/plugins/sharding/logical_select.rb
/usr/lib64/groonga/plugins/sharding/logical_range_filter.rb
/usr/lib64/groonga/plugins/tokenizers
/usr/lib64/groonga/plugins/normalizers
/usr/lib64/groonga/plugins/normalizers/mysql.so
/usr/lib64/groonga/plugins/token_filters
/usr/lib64/groonga/plugins/token_filters/stop_word.so
/usr/lib64/groonga/plugins/ruby
/usr/lib64/groonga/plugins/ruby/eval.rb
/usr/lib64/groonga/plugins/query_expanders
/usr/lib64/groonga/plugins/query_expanders/tsv.so
/usr/lib64/groonga/plugins/functions
/usr/lib64/groonga/plugins/functions/number.so
/usr/lib64/groonga/plugins/functions/string.so
/usr/lib64/groonga/plugins/functions/time.so
/usr/lib64/groonga/plugins/functions/math.so
/usr/lib64/groonga/plugins/functions/vector.so
/usr/lib64/groonga/plugins/functions/index_column.so
```

- 対応

  - 

- 予防

  - 
