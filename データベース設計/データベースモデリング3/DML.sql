-- users
INSERT INTO users (name, email) VALUES ("大谷翔平", "ohtani@example.com");
INSERT INTO users (name, email) VALUES ("鈴木一郎", "suzuki@example.com");

-- directories
INSERT INTO directories (parent_directory_id, created_by, name, created_at, updated_at) VALUES (null, 1, "プロジェクト", now(), now());
INSERT INTO directories (parent_directory_id, created_by, name, created_at, updated_at) VALUES (1, 1, "設計", now(), now());
INSERT INTO directories (parent_directory_id, created_by, name, created_at, updated_at) VALUES (1, 2, "議事録", now(), now());

-- documents
INSERT INTO documents (directory_id, created_by, updated_by, title, content, pos, created_at, updated_at) VALUES (2, 1, 1, "DB設計", "テーブル定義について", 1, now(), now());
INSERT INTO documents (directory_id, created_by, updated_by, title, content, pos, created_at, updated_at) VALUES (2, 1, 2, "API設計", "エンドポイント一覧", 2, now(), now());
INSERT INTO documents (directory_id, created_by, updated_by, title, content, pos, created_at, updated_at) VALUES (3, 2, 2, "第1回ミーティング", "議題：キックオフ", 1, now(), now());
