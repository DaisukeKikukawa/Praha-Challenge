## テーブル一覧

### schedule_types

リマインダーの周期のマスタ。今後新しい周期が追加されてもレコード追加できるように。


| カラム  | 型            | 説明                      |
| ---- | ------------ | ----------------------- |
| id   | INTEGER (PK) | 主キー                     |
| name | VARCHAR(50)  | 周期名（毎日、X日おき、毎週X曜日、毎月X日） |


### users

Slackのユーザー情報。リマインダーの作成者・受信者を判別できるように。


| カラム           | 型            | 説明           |
| ------------- | ------------ | ------------ |
| id            | INTEGER (PK) | 主キー          |
| slack_user_id | VARCHAR(50)  | SlackのユーザーID |
| name          | VARCHAR(50)  | ユーザー名        |


### reminders

リマインダー本体。


| カラム              | 型                             | 説明                                                                               |
| ---------------- | ----------------------------- | -------------------------------------------------------------------------------- |
| id               | INTEGER (PK)                  | 主キー                                                                              |
| created_by       | INTEGER (FK → users)          | リマインダー作成者                                                                        |
| schedule_type_id | INTEGER (FK → schedule_types) | 周期の種別                                                                            |
| message          | TEXT                          | リマインダーの文面                                                                        |
| schedule_value   | INTEGER NULL                  | 周期の具体値（X日おきのX、毎週X曜日のX、毎月X日のX。毎日の場合はNULL）                                         |
| next_send_at     | TIMESTAMP                     | 次回送信予定日時バッチが1時間ごとに動くので、このカラムを見て「現在時刻 >= next_send_at のリマインダー」を配信対象として抽出すればよさそう？ |
| created_at       | TIMESTAMP                     | 作成日時                                                                             |
| updated_at       | TIMESTAMP                     | 更新日時                                                                             |


### reminder_recipients

リマインダーと送信先ユーザーの中間テーブル。1つのリマインダーに複数の宛先を設定できる。受信者ごとにタスク完了状態を管理する。


| カラム          | 型                        | 説明                 |
| ------------ | ------------------------ | ------------------ |
| id           | INTEGER (PK)             | 主キー                |
| reminder_id  | INTEGER (FK → reminders) | 対象リマインダー           |
| user_id      | INTEGER (FK → users)     | 送信先ユーザー            |
| completed_at | TIMESTAMP NULL           | タスク完了日時（NULLなら未完了） |


