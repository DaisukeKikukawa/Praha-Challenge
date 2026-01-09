-- users
INSERT INTO users (name, email, password) VALUES ("大谷翔平", "test@example.com", "123456");
INSERT INTO users (name, email, password) VALUES ("鈴木一郎", "test@example.com", "123456");

-- workspaces
INSERT INTO workspaces (name) VALUES ("プラハチャレンジ");

-- user_workspace_belongings
INSERT INTO user_workspace_belongings (user_id, workspace_id) VALUES (1, 1);
INSERT INTO user_workspace_belongings (user_id, workspace_id) VALUES (2, 1);

-- channels
INSERT INTO channels (workspace_id, name) VALUES (1, "team-a");
INSERT INTO channels (workspace_id, name) VALUES (1, "質問チャンネル");
INSERT INTO channels (workspace_id, name) VALUES (1, "雑談チャンネル");

-- user_channel_belongings
INSERT INTO user_channel_belongings (user_id, channel_id) VALUES (1,1);
INSERT INTO user_channel_belongings (user_id, channel_id) VALUES (2,1);

-- messages
INSERT INTO messages (user_id, channel_id, created_at, message) VALUES (1,1,now(),"よろしくお願いします！");
INSERT INTO messages (user_id, channel_id, created_at, message) VALUES (2,1,now(),"よろしくお願いします！");
INSERT INTO messages (user_id, channel_id, created_at, message) VALUES (1,1,now(),"次のミーティングいつにしますか？");
INSERT INTO messages (user_id, channel_id, created_at, message) VALUES (1,2,now(),"質問したいです");
INSERT INTO messages (user_id, channel_id, created_at, message) VALUES (1,3,now(),"雑談したいです");

-- thread_messages
INSERT INTO thread_messages (message_id, user_id, created_at, thread_message) VALUES (1,2,now(),"こちらこそよろしくお願いします！");
INSERT INTO thread_messages (message_id, user_id, created_at, thread_message) VALUES (2,2,now(),"質問どうぞー");
INSERT INTO thread_messages (message_id, user_id, created_at, thread_message) VALUES (3,2,now(),"雑談どうぞー");
