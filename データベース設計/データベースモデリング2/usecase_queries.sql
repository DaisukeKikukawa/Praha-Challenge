-- あるチャンネルに投稿された メッセージ一覧を時系列で取得
select * from db_modeling_2.messages where db_modeling_2.messages.channel_id = 1  order by created_at asc;
-- 特定ユーザが投稿した メッセージだけを取得
select * from db_modeling_2.messages where db_modeling_2.messages.user = 1;
-- ワークスペース内の特定チャネルのメッセージを取得
SELECT * FROM messages
INNER JOIN channels
  ON messages.channel_id = channels.id
INNER JOIN workspaces
  ON channels.workspace_id = workspaces.id
WHERE workspaces.id = 1
  AND channels.id = 1;

-- あるメッセージに紐づく スレッドメッセージ一覧を取得
select * from db_modeling_2.thread_messages where message_id = 1;
-- スレッド内の投稿を 時系列で表示
select * from db_modeling_2.thread_messages where message_id = 1 order by created_at asc;
-- あるユーザがスレッドに投稿した内容を取得
select * from db_modeling_2.thread_messages where message_id = 1 AND user_id = 1;

-- 自分が参加しているチャネルだけのメッセージを取得
SELECT * FROM db_modeling_2.messages inner join user_channel_belongings on messages.channel_id = user_channel_belongings.channel_id WHERE user_channel_belongings.user_id = 1;

-- あるワークスペース（id = 1）に属するすべてのチャネルのメッセージを取得
SELECT message,workspace_id FROM db_modeling_2.messages inner join channels on messages.channel_id = channels.id inner join workspaces on channels.workspace_id = workspaces.id where workspace_id = 1;

-- あるチャネル（id = 1）に投稿された「どのユーザが」「いつ」「どんなメッセージを」投稿したかを取得
SELECT users.name,messages.created_at,messages.message FROM db_modeling_2.messages inner join channels on messages.channel_id = channels.id inner join users on messages.user_id = users.id where messages.channel_id = 1;

-- あるチャネル（id = 1）のスレッドメッセージをすべて取得
SELECT * FROM db_modeling_2.thread_messages inner join messages on thread_messages.message_id = messages.id where messages.channel_id = 1;

-- あるワークスペース（id = 1）に属するスレッドメッセージのみを取得
SELECT * FROM db_modeling_2.thread_messages inner join messages on thread_messages.message_id = messages.id inner join channels on messages.channel_id = channels.id inner join workspaces on channels.workspace_id = workspaces.id where workspaces.id = 1;
