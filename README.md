# index-digest action for database performance regression testing

![actions_output](https://user-images.githubusercontent.com/1929317/107210174-12a2ba80-6a04-11eb-9958-f127521a03d8.png)

GitHub Action for running [`index-digest`](https://github.com/macbre/index-digest) that **analyses your MySQL queries and schema** and suggests indices and schema improvements.

With this Action you can easily **implement database performance regression testing in your continuos integration pipeline**.

## How to use it

We assume that you have a MySQL up and running in your CI pipeline. Your tests suite runs using this database and SQL queries log is collected.

Given your MySQL test instance (and the optional SQL queries log) you can simply add this Action to your pipeline:

```yaml
    - name: Install and run index-digest
      uses: macbre/actions-index-digest@...
      with:
        index-digest-version: "1.4.0"
        index-digest-dsn: "mysql://test_user:test_password@127.0.0.1:3306/test_db"
        index-digest-report-file: "./report.yml"
```

> Here we assume that MySQL uses `test_user` with `test_password` credential for `test_db` database. And that the MySQL server runs locally listening on a default port (3306).

`index-digest` inmage will be fetched and run with the provided options. The YAML report file will be stored in the location specified by `index-digest-report-file`. You can use it for additional assertions and to raise an error in your CI pipeline if there's something wrong.

## An example result file

```yaml
---
meta:
  version: index-digest v1.4.0
  database_name: index_digest
  database_host: eeae7273a00a
  database_version: MySQL v8.0.22
reports:
- type: redundant_indices
  table: 0001_redundant_indices
  message: '"idx_foo" index can be removed as redundant (covered by "idx_foo_2")'
  context:
    redundant: UNIQUE KEY idx_foo (foo)
    covered_by: UNIQUE KEY idx_foo_2 (foo)
    schema: "CREATE TABLE `0001_redundant_indices` (\n  `item_id` int NOT NULL AUTO_INCREMENT,\n\
      \  `foo` varbinary(16) NOT NULL DEFAULT '',\n  PRIMARY KEY (`item_id`),\n  UNIQUE\
      \ KEY `idx_foo` (`foo`),\n  UNIQUE KEY `idx_foo_2` (`foo`)\n) ENGINE=InnoDB\
      \ DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci"
    table_data_size_mb: 0.015625
    table_index_size_mb: 0.03125
...
```
