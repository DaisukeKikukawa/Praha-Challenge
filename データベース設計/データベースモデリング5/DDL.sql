CREATE TABLE users (
  id int AUTO_INCREMENT PRIMARY KEY,
  name varchar(50),
  email varchar(100)
);

CREATE TABLE articles (
  id int AUTO_INCREMENT PRIMARY KEY,
  created_by int,
  title varchar(255),
  content text,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE article_histories (
  id int AUTO_INCREMENT PRIMARY KEY,
  article_id int,
  edited_by int,
  title varchar(255),
  content text,
  created_at timestamp,
  FOREIGN KEY (article_id) REFERENCES articles(id),
  FOREIGN KEY (edited_by) REFERENCES users(id)
);
