INSERT INTO schedule_types (name) VALUES
  ('毎日'),
  ('X日おき'),
  ('毎週X曜日'),
  ('毎月X日');

INSERT INTO users (slack_user_id, name) VALUES
  ('U001ABC', '田中太郎'),
  ('U002DEF', '佐藤花子'),
  ('U003GHI', '鈴木一郎');

INSERT INTO reminders (created_by, schedule_type_id, message, schedule_value, next_send_at, created_at, updated_at) VALUES
  (1, 1, 'デイリーレポートを提出してください', NULL, '2026-03-22 09:00:00', '2026-03-20 10:00:00', '2026-03-20 10:00:00'),
  (1, 2, 'デザイン確認お願いします', 3, '2026-03-24 10:00:00', '2026-03-21 10:00:00', '2026-03-21 10:00:00'),
  (2, 3, '週次ミーティングの議事録を共有してください', 1, '2026-03-23 09:00:00', '2026-03-19 14:00:00', '2026-03-19 14:00:00'),
  (3, 4, '月次レポートを提出してください', 1, '2026-04-01 09:00:00', '2026-03-01 09:00:00', '2026-03-01 09:00:00');

INSERT INTO reminder_recipients (reminder_id, user_id, completed_at) VALUES
  (1, 2, NULL),
  (1, 3, NULL),
  (2, 2, NULL),
  (3, 1, '2026-03-21 11:00:00'),
  (3, 3, NULL),
  (4, 1, NULL),
  (4, 2, NULL);
