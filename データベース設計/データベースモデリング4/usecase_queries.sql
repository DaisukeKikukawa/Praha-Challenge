-- リマインダーを新規作成する（田中が佐藤と鈴木に3日おきでリマインド）
INSERT INTO reminders (created_by, schedule_type_id, channel_id, message, schedule_value, next_send_at, created_at, updated_at)
VALUES (1, 2, 'C002DEV', 'PRレビューお願いします', 3, '2026-03-25 10:00:00', NOW(), NOW());

INSERT INTO reminder_recipients (reminder_id, user_id, completed_at)
VALUES
  (LAST_INSERT_ID(), 2, NULL),
  (LAST_INSERT_ID(), 3, NULL);

-- バッチ：配信対象のリマインダーを取得（channel_idも含む）
SELECT r.id, r.message, r.channel_id, r.next_send_at,
       u.slack_user_id, u.name
FROM reminders r
JOIN reminder_recipients rr ON r.id = rr.reminder_id
JOIN users u ON rr.user_id = u.id
WHERE r.next_send_at <= NOW()
  AND rr.completed_at IS NULL;

-- バッチ送信後：next_send_atを次回に更新（例：3日おきの場合）
UPDATE reminders
SET next_send_at = DATE_ADD(next_send_at, INTERVAL schedule_value DAY),
    updated_at = NOW()
WHERE id = 2;

-- 受信者がタスクを完了する（「終わった」ボタン押下）
UPDATE reminder_recipients
SET completed_at = NOW()
WHERE reminder_id = 1 AND user_id = 2;

-- 完了時にリマインダー作成者へ通知するため、作成者情報を取得
SELECT u.slack_user_id, u.name
FROM reminders r
JOIN users u ON r.created_by = u.id
WHERE r.id = 1;

-- 全受信者が完了したリマインダーを確認（不要になったリマインダーの特定）
SELECT r.id, r.message
FROM reminders r
WHERE NOT EXISTS (
  SELECT 1 FROM reminder_recipients rr
  WHERE rr.reminder_id = r.id AND rr.completed_at IS NULL
);

-- 自分宛の未完了リマインダー一覧（/penpen-list コマンド）
SELECT r.message, st.name AS schedule, r.schedule_value, creator.name AS created_by
FROM reminder_recipients rr
JOIN reminders r ON rr.reminder_id = r.id
JOIN schedule_types st ON r.schedule_type_id = st.id
JOIN users creator ON r.created_by = creator.id
WHERE rr.user_id = 2
  AND rr.completed_at IS NULL;

-- 自分が作成したリマインダー一覧
SELECT r.message, st.name AS schedule, r.schedule_value, r.next_send_at
FROM reminders r
JOIN schedule_types st ON r.schedule_type_id = st.id
WHERE r.created_by = 1;

-- ワークスペースの全ユーザーを取得
SELECT u.slack_user_id, u.name
FROM users u
WHERE u.workspace_id = 1;
