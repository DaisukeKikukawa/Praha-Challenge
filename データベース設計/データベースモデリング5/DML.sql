INSERT INTO users (name, email) VALUES
  ('田中太郎', 'tanaka@example.com'),
  ('佐藤花子', 'sato@example.com');

INSERT INTO articles (created_by, title, content, created_at, updated_at) VALUES
  (1, 'Dockerの基本', 'Dockerはコンテナ型の仮想化技術です。最新版の内容です。', '2026-03-01 10:00:00', '2026-03-20 15:00:00'),
  (2, 'Git入門', 'Gitはバージョン管理システムです。', '2026-03-10 09:00:00', '2026-03-10 09:00:00');

INSERT INTO article_histories (article_id, edited_by, title, content, created_at) VALUES
  (1, 1, 'Dockerの基本', 'Dockerはコンテナ型の仮想化技術です。初版の内容です。', '2026-03-01 10:00:00'),
  (1, 1, 'Dockerの基本', 'Dockerはコンテナ型の仮想化技術です。2回目の編集内容です。', '2026-03-10 14:00:00'),
  (1, 2, 'Dockerの基本', 'Dockerはコンテナ型の仮想化技術です。3回目の編集内容です。', '2026-03-15 11:00:00');
