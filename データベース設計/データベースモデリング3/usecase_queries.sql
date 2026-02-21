-- あるディレクトリ（id = 2）内のドキュメント一覧をpos順で取得
SELECT * FROM documents WHERE directory_id = 2 ORDER BY pos ASC;

-- 特定ユーザ（id = 1）が作成したドキュメント一覧を取得
SELECT * FROM documents WHERE created_by = 1;

-- あるドキュメントの「誰が」「いつ」「どんな内容を」保存したかを取得
SELECT users.name, documents.created_at, documents.title, documents.content FROM documents INNER JOIN users ON documents.created_by = users.id WHERE documents.id = 1;

-- あるディレクトリ（id = 1）のサブディレクトリ一覧を取得
SELECT * FROM directories WHERE parent_directory_id = 1;

-- ルートディレクトリ一覧を取得
SELECT * FROM directories WHERE parent_directory_id IS NULL;

-- ディレクトリを別のディレクトリ（id = 3）の配下に移動する
UPDATE directories SET parent_directory_id = 3, updated_at = now() WHERE id = 2;

-- ディレクトリ内のドキュメントの並び順を変更する（id=2のドキュメントを先頭に移動）
UPDATE documents SET pos = 0 WHERE id = 2 AND directory_id = 2;
UPDATE documents SET pos = pos + 1 WHERE directory_id = 2 AND id != 2;

-- ドキュメントを更新する
UPDATE documents SET content = "更新されたコンテンツ", updated_by = 2, updated_at = now() WHERE id = 1;

-- ドキュメントを削除する
DELETE FROM documents WHERE id = 1;

-- ディレクトリを削除する
DELETE FROM directories WHERE id = 3;
