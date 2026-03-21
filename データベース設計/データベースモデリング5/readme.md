## テーブル一覧

### users

記事の作成者・編集者。


| カラム   | 型            | 説明      |
| ----- | ------------ | ------- |
| id    | INTEGER (PK) | 主キー     |
| name  | VARCHAR(50)  | ユーザー名   |
| email | VARCHAR(100) | メールアドレス |


### articles

記事の最新状態。一覧表示はこのテーブルをSELECTするだけで済む。


| カラム        | 型                    | 説明           |
| ---------- | -------------------- | ------------ |
| id         | INTEGER (PK)         | 主キー          |
| created_by | INTEGER (FK → users) | 記事作成者        |
| title      | VARCHAR(255)         | 記事タイトル       |
| content    | TEXT                 | 本文（1000文字程度） |
| created_at | TIMESTAMP            | 作成日時         |
| updated_at | TIMESTAMP            | 最終更新日時       |


### article_histories

記事の編集履歴。記事を更新する際、更新前の状態をここに保存する。過去の状態に戻すときはこのテーブルから選んでarticlesにコピーする。


| カラム        | 型                       | 説明         |
| ---------- | ----------------------- | ---------- |
| id         | INTEGER (PK)            | 主キー        |
| article_id | INTEGER (FK → articles) | 対象の記事      |
| edited_by  | INTEGER (FK → users)    | 編集したユーザー   |
| title      | VARCHAR(255)            | その時点のタイトル  |
| content    | TEXT                    | その時点の本文    |
| created_at | TIMESTAMP               | 履歴が保存された日時 |


## 課題2-1

分析のみの用途であれば、アプリケーションのRDBに履歴データを保存する必要はない。

- アプリの機能として履歴を使う（一覧表示・復元）→ RDBに保存が必要
- 分析のみの用途 → S3 + Athena、BigQuery、Redshiftなど分析に適したストアに保存すべき

理由：

- 履歴データは際限なく増え、RDBの容量・パフォーマンスに影響する
- 本番DBに分析クエリを投げるとユーザー向けの処理に影響が出る可能性？

## 課題2-2：

### 課題1-1：2テーブルで分離

`articles`（最新状態）+ `article_histories`（過去の履歴）

ER図: `er_diagram.dio`

### 課題2-2：1テーブル統合型

全バージョンを `article_versions` 1テーブルで管理。`is_current` フラグで最新を区別する。

ER図: `er_diagram_v2.dio`


| カラム        | 型                    | 説明            |
| ---------- | -------------------- | ------------- |
| id         | INTEGER (PK)         | 主キー           |
| edited_by  | INTEGER (FK → users) | 編集したユーザー      |
| article_id | INTEGER              | 記事のグループID     |
| version    | INTEGER              | バージョン番号       |
| title      | VARCHAR(255)         | タイトル          |
| content    | TEXT                 | 本文            |
| is_current | BOOLEAN              | 最新バージョンならtrue |
| created_at | TIMESTAMP            | 作成日時          |


レコードイメージ:


| id  | article_id | version | title                | is_current |
| --- | ---------- | ------- | -------------------- | ---------- |
| 1   | 1          | 1       | Dockerの基本            | false      |
| 2   | 1          | 2       | Dockerの基本（改訂版ver1-1） | false      |
| 3   | 1          | 3       | Dockerの基本（改訂版ver1-2） | true       |
| 4   | 2          | 1       | Git入門                | true       |


article_idは同じ記事のバージョンをグルーピングするためのID。FKではなく、ただの整数カラム。

### 複数テーブルのメリット・デメリット

メリット:

- 最新記事の一覧取得が `articles` をSELECTするだけで高速
- `articles` に必ず最新が1件あるため、データ整合性を保ちやすい

デメリット:

- 記事の更新・復元時に2テーブルを操作する必要がある（履歴にINSERT + articlesをUPDATE）
- 最新と履歴でスキーマが重複しており、カラム変更時に両テーブルを修正する必要がある

### 1テーブルのメリット・デメリット

メリット:

- 最新の記事にしたい場合に、`is_current` フラグの切り替えだけで済ませられる
- テーブルが1つで完結するのでスキーマ管理がシンプル

デメリット:

- 最新記事の取得に `WHERE is_current = true` が必要で、データ量が増えるとパフォーマンスに影響するかも？
- `is_current = true` が各記事に1件だけであることをアプリ側で保証する必要がある（不整合リスク）
  - 「旧バージョンのis_currentをfalse」と「新バージョンをis_current =
      trueでINSERT」が必要

