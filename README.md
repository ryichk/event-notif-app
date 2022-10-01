# README

* Ruby version: 3.1.2

* Rails version: 6.0.6

* Elasticsearch version: 7.16.3

## Bundle install

```sh
bundle install
```

## DB及びテーブルの作成

```sh
bin/rails db:migrate
```

## Railsサーバー起動

```sh
bin/rails s
```

## Elasticsearch起動

```sh
docker-compose up
```

## 自動テストの実行

```sh
bundle exec rspec
```

## 静的解析

```sh
bundle exec rubocop
```
