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


