CREATE TABLE users (
  id int AUTO_INCREMENT PRIMARY KEY,
  name varchar(30),
  email varchar(50),
  password varchar(50)
);

CREATE TABLE workspaces (
  id int AUTO_INCREMENT PRIMARY KEY,
  name varchar(20)
);

CREATE TABLE channels (
  id int AUTO_INCREMENT PRIMARY KEY,
  workspace_id int,
  name varchar(30),
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id)
);

CREATE TABLE messages (
  id int AUTO_INCREMENT PRIMARY KEY,
  user_id int,
  channel_id int,
  created_at timestamp,
  message varchar(500),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channels(id)
);

CREATE TABLE thread_messages (
  id int AUTO_INCREMENT PRIMARY KEY,
  message_id int,
  user_id int,
  created_at timestamp,
  thread_message varchar(500),
  FOREIGN KEY (message_id) REFERENCES messages(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE user_channel_belongings (
  id int AUTO_INCREMENT PRIMARY KEY,
  user_id int,
  channel_id int,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channels(id)
);

CREATE TABLE user_workspace_belongings (
  id int AUTO_INCREMENT PRIMARY KEY,
  user_id int,
  workspace_id int,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id)
);
