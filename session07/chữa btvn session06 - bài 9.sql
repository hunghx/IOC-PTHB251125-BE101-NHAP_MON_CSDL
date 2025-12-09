create database session6_bt9;

-- Tạo bảng Product
CREATE TABLE Product (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         category VARCHAR(50),
                         price NUMERIC(10,2)
);

-- Tạo bảng OrderDetail
CREATE TABLE OrderDetail (
                             id SERIAL PRIMARY KEY,
                             order_id INT,
                             product_id INT,
                             quantity INT
);

-- Tính tổng doanh thu từng sản phẩm, hiển thị product_name, total_sales (SUM(price * quantity))
    SELECT p.name, sum(p.price * od.quantity)
    FROM Product p JOIN OrderDetail od ON p.id = od.product_id
    GROUP BY p.id;

-- Tính doanh thu trung bình theo từng loại sản phẩm (GROUP BY category)
SELECT p.category, avg(p.price * od.quantity)
FROM Product p JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.category;

-- Chỉ hiển thị các loại sản phẩm có doanh thu trung bình > 20 triệu (HAVING)
SELECT p.category
FROM Product p JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.category
HAVING avg(p.price * od.quantity) > 20000000
;
-- Hiển thị tên sản phẩm của những đơn hàng có doanh thu cao hơn doanh thu trung bình toàn bộ đơn hàng (dùng Subquery)
    -- Tính doanh thu trung bình theo từng sản phẩm
   select p.*
       from product p join OrderDetail od ON p.id = od.product_id
   WHERE p.price * od.quantity > (
    select avg(p.price *od.quantity)
    FROM product p join OrderDetail od ON p.id = od.product_id
    );
-- Liệt kê toàn bộ sản phẩm và số lượng bán được (nếu có) – kể cả sản phẩm chưa có đơn hàng (LEFT JOIN)
select p.* , sum(case when od.quantity is null then 0 else od.quantity end) as "Số lượng"
    from Product p LEFT JOIN OrderDetail od on p.id = od.product_id
Group By p.id;