CREATE TABLE users (
  id int AUTO_INCREMENT PRIMARY KEY,
  name varchar(50),
  email varchar(100)
);

CREATE TABLE directories (
  id int AUTO_INCREMENT PRIMARY KEY,
  parent_directory_id int,
  created_by int,
  name varchar(100),
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (parent_directory_id) REFERENCES directories(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE documents (
  id int AUTO_INCREMENT PRIMARY KEY,
  directory_id int,
  created_by int,
  updated_by int,
  title varchar(255),
  content text,
  pos int,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (directory_id) REFERENCES directories(id),
  FOREIGN KEY (created_by) REFERENCES users(id),
  FOREIGN KEY (updated_by) REFERENCES users(id)
);
