CREATE TABLE customers (
  id integer AUTO_INCREMENT PRIMARY KEY,
  name text,
  phone_number text
);

CREATE TABLE orders(
  id integer AUTO_INCREMENT PRIMARY KEY,
  customer_id integer,
  total_plate_quantity integer,
  is_paid boolean DEFAULT false,
  ordered_at datetime,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE product_categories(
  id integer AUTO_INCREMENT PRIMARY KEY,
  name text
);

CREATE TABLE product_category_subtypes(
  id integer AUTO_INCREMENT PRIMARY KEY,
  name text
);


CREATE TABLE products(
  id integer AUTO_INCREMENT PRIMARY KEY,
  product_category_subtype_id integer,
  product_category_id integer,
  name text,
  price_excluded_tax integer,
  FOREIGN KEY (product_category_subtype_id) REFERENCES product_category_subtypes(id),
  FOREIGN KEY (product_category_id) REFERENCES product_categories(id)
);

CREATE TABLE order_products(
  id integer AUTO_INCREMENT PRIMARY KEY,
  product_id integer,
  order_id integer,
  syari_size varchar(20) DEFAULT "普通",
  without_wasabi boolean DEFAULT false,
  quantity integer,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);
