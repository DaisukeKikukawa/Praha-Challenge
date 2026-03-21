-- 最新状態の記事を一覧表示する
SELECT a.id, a.title, a.content, u.name AS author, a.updated_at
FROM articles a
JOIN users u ON a.created_by = u.id
ORDER BY a.updated_at DESC;

-- 記事を新規作成する
INSERT INTO articles (created_by, title, content, created_at, updated_at)
VALUES (1, '新しい記事', 'これは新しい記事の本文です。', NOW(), NOW());

-- 記事を更新する（更新前の状態を履歴に保存してから更新）
INSERT INTO article_histories (article_id, edited_by, title, content, created_at)
SELECT id, created_by, title, content, updated_at
FROM articles
WHERE id = 1;

UPDATE articles
SET title = 'Dockerの基本（改訂版）',
    content = '改訂された内容です。',
    updated_at = NOW()
WHERE id = 1;

-- 特定の記事の編集履歴を一覧表示する
SELECT ah.id, ah.title, ah.content, u.name AS edited_by, ah.created_at
FROM article_histories ah
JOIN users u ON ah.edited_by = u.id
WHERE ah.article_id = 1
ORDER BY ah.created_at DESC;

-- 履歴を選択して過去の記事状態に戻す（履歴ID=1の状態に復元）
INSERT INTO article_histories (article_id, edited_by, title, content, created_at)
SELECT id, created_by, title, content, updated_at
FROM articles
WHERE id = 1;

UPDATE articles
SET title = (SELECT title FROM article_histories WHERE id = 1),
    content = (SELECT content FROM article_histories WHERE id = 1),
    updated_at = NOW()
WHERE id = 1;
