-- customers
INSERT INTO customers (name, phone_number) VALUES ("本田圭佑", "080-1234-5678");
INSERT INTO customers (name, phone_number) VALUES ("大谷翔平", "070-9876-5432");

-- product_categories
INSERT INTO product_categories (name) VALUES ("セットメニュー");
INSERT INTO product_categories (name) VALUES ("お好みすし");

-- product_category_subtypes
INSERT INTO product_category_subtypes (name) VALUES ("盛り込み");
INSERT INTO product_category_subtypes (name) VALUES ("にぎり");
INSERT INTO product_category_subtypes (name) VALUES ("鮨やの丼&おすすめ");
INSERT INTO product_category_subtypes (name) VALUES ("地元に生まれた味");

-- products
INSERT INTO products (product_category_id, product_category_subtype_id, name, price_excluded_tax) VALUES (1,1,"はな",8650);
INSERT INTO products (product_category_id, product_category_subtype_id, name, price_excluded_tax) VALUES (1,1,"わだつみ",5680);
INSERT INTO products (product_category_id, product_category_subtype_id, name, price_excluded_tax) VALUES (1,2,"みさき",1940);
INSERT INTO products (product_category_id, product_category_subtype_id, name, price_excluded_tax) VALUES (1,3,"海鮮ちらし",1280);
INSERT INTO products (product_category_id, product_category_subtype_id, name, price_excluded_tax) VALUES (1,4,"鮨八宝巻",1280);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"ゆでげそ",150);
INSERT INTO products (product_category_id, name, price_excluded_tax)  VALUES (1,"たまご",100);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"えび",180);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"生サーモン",220);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"あじ",260);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"いくら",360);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"活ひらめ",400);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"中トロ",460);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"あなご一本すし",520);
INSERT INTO products (product_category_id, name, price_excluded_tax) VALUES (1,"うに",600);

-- orders
-- order_id取得のため先に情報だけを作っておく
INSERT INTO orders (customer_id) VALUES (1);
INSERT INTO orders (customer_id) VALUES (2);

-- order_products
-- customer_idが1のデータで注文情報を作成
INSERT INTO order_products (product_id,order_id,quantity) VALUES (1,1,1);
INSERT INTO order_products (product_id,order_id,quantity) VALUES (15,1,2);
INSERT INTO order_products (syari_size,product_id,order_id,quantity,without_wasabi) VALUES ("大",10,1,3,true);

-- orders
-- お会計時のデータ更新
UPDATE orders
SET
  is_paid = true,
  total_plate_quantity = (
    SELECT
      SUM(order_products.quantity)
    FROM order_products
    WHERE order_products.order_id = orders.id
  )
WHERE orders.id = 1;
