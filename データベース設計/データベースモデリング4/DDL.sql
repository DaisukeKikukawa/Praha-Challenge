CREATE TABLE workspaces (
  id int AUTO_INCREMENT PRIMARY KEY,
  team_id varchar(50),
  team_name varchar(100)
);

CREATE TABLE schedule_types (
  id int AUTO_INCREMENT PRIMARY KEY,
  name varchar(50)
);

CREATE TABLE users (
  id int AUTO_INCREMENT PRIMARY KEY,
  workspace_id int,
  slack_user_id varchar(50),
  name varchar(50),
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id)
);

CREATE TABLE reminders (
  id int AUTO_INCREMENT PRIMARY KEY,
  created_by int,
  schedule_type_id int,
  channel_id varchar(50),
  message text,
  schedule_value int NULL,
  next_send_at timestamp,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (created_by) REFERENCES users(id),
  FOREIGN KEY (schedule_type_id) REFERENCES schedule_types(id)
);

CREATE TABLE reminder_recipients (
  id int AUTO_INCREMENT PRIMARY KEY,
  reminder_id int,
  user_id int,
  completed_at timestamp NULL,
  FOREIGN KEY (reminder_id) REFERENCES reminders(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
