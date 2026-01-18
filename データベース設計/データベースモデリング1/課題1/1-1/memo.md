// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

//①
//一旦シンプルにそのまま描き出す
//ordersにproduct_idを持たせている
//これだと1注文につき1商品になってしまう

// Table orders {
//   id integer [primary key]
//   customer_id integer
//   product_id integer
//   total_plate_count integer
//   is_paid boolean
// }

// Ref: customers.id < orders.customer_id
// Ref: products.id < orders.product_id

// Table customers {
//   id integer [primary key]
//   name varchar
//   phone_number varchar
// }

// Table products {
//   id integer [primary key]
//   product_category_id integer
//   name varchar
//   price integer
//   price_including_tax integer
//   has_wasabi boolean
// }

// Ref: products.product_category_id - products_category.id

// Table products_category {
//   id integer [primary key]
//   name varchar
// }

//②
//商品テーブルはマスタのようなイメージで商品情報のみを持たせる
//1注文票につき複数の商品を注文できるように
//products_orderテーブルを追加
//set_menu_quantityとplate_quantity

Table orders {
  id integer [primary key]
  customer_id integer
  total_plate_quantity integer
  is_paid boolean
}

Ref: customers.id < orders.customer_id

Table customers {
  id integer [primary key]
  name varchar
  phone_number varchar
}

Table products {
  id integer [primary key]
  product_category_id integer
  name varchar
  price_excluded_tax integer
}

Ref: products.product_category_id - products_category.id

Table products_category {
  id integer [primary key]
  name varchar
}

Table products_order {
  id integer [primary key]
  product_id integer
  order_id integer
  without_wasabi boolean
  quantity integer
}

Ref: products.id < products_order.product_id
Ref: orders.id < products_order.order_id
