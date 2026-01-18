SELECT
  SUM(products.price_excluded_tax * order_products.quantity * 1.1) AS total_price_including_tax
FROM orders
JOIN order_products
  ON orders.id = order_products.order_id
JOIN products
  ON order_products.product_id = products.id
WHERE orders.customer_id = 1
  AND orders.is_paid = false;
