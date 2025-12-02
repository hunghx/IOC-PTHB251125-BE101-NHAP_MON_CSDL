-- DML
-- INSERT - chèn dữ liệu vào bảng

-- Chèn dữ liệu vào bảng customer
SET SEARCH_PATH to customer_manager;

INSERT INTO customer(customer_id,phone_number,sex,email,address,category_id)
VALUES ('KH100','0934895783','Khac','abc@gmail.com','HCM',null);

INSERT INTO customer(customer_id,phone_number,sex,email)
VALUES ('KH101','0934834783','Khac','sdvc@gmail.com');


-- UPDATE - cập nhật bản ghi - Lưu ý khuyến cáo cập nhật dựa trên khóa chính
UPDATE customer
SET phone_number = '0923857944', address = 'Hanoi'
WHERE customer_id = 'KH100';

-- DELETE - Xóa dữ liệu - Lưu ý khuyến cáo xóa dựa trên khóa chính
DELETE FROM customer
WHERE customer_id = 'KH100'
;


-- Bai tập thực hành
create table Product(
                        product_id serial primary key ,
                        product_name varchar(30) not null ,
                        category varchar(20),
                        price decimal(10,2),
                        stock_quantity int
);
-- Thêm dữ liệu vào bảng
INSERT INTO Product (product_name, category, price, stock_quantity) VALUES
          ('Bluetooth Speaker 1', NULL, 49.99, 120),
          ('Wireless Mouse', 'Electronics', 25.50, 200),
          ('LED Monitor 24"', 'Electronics', 159.99, 75),
          ('USB-C Charger', 'Electronics', 18.00, 300),
          ('The Alchemist Book', 'Books', 12.99, 150),
          ('Atomic Habits Book', 'Books', 14.50, 100),
          ('Clean Code Book', 'Books', 29.99, 80),
          ('Harry Potter Vol.1', 'Books', 10.99, 200),
          ('Men''s T-Shirt', 'Clothing', 9.99, 250),
          ('Women''s Jeans', 'Clothing', 29.99, 180),
          ('Hoodie Unisex', 'Clothing', 35.00, 90),
          ('Summer Dress', 'Clothing', 24.99, 130),
          ('Air Fryer', 'Home Appliances', 89.99, 60),
          ('Electric Kettle', 'Home Appliances', 39.50, 100),
          ('Vacuum Cleaner', 'Home Appliances', 129.99, 40);

-- Cập nhật giá sản phẩm thuộc category 'Electronics' tăng 10%
UPDATE Product set price = price*1.1
WHERE category = 'Electronics';
-- Xóa các sản phẩm có số lượng tồn kho = 0
DELETE FROM Product
WHERE stock_quantity =0;
-- SELECT  - Truy vấn dữ liệu
-- Truy vấn cơ bản
SELECT current_date as date_now;
SELECT product_name, price, stock_quantity from Product;
-- Mệnh đề WHERE
-- Lấy ra tất cả sản phẩm có giá > 30 $
SELECT product_name, price, stock_quantity
from Product
WHERE price > 30;
-- Danh sách điều kiện của mệnh đề where : = ,> ,<, >=, <= , <>, AND, OR, NOT, BETWEEN (AND) , IN, LIKE, ILIKE,IS NULL...
-- Lọc các sản phẩm có giá > 30 hoặc danh mục là Electronics
SELECT *
from Product
WHERE price > 30 OR category = 'Electronics';

-- Lấy tất cả sản phẩm có danh mục thuộc : Clothing, Electronics, Books
SELECT *
from Product
WHERE category NOT IN ('Clothing','Electronics','Books');
-- Lấy tất cả sản phẩm có gi từ 30 - 90
SELECT *
from Product
WHERE price BETWEEN 30 AND 90;

-- LIKE và ILIKE : tìm kiếm tương đối dựa trên 1 mẫu
-- Tìm tất cả sản phẩm có tên bắt đầu bằng kí tự B
SELECT *
from Product
WHERE product_name LIKE 'b%';

SELECT *
from Product
WHERE product_name ILIKE 'b_ue%';

SELECT *
from Product
WHERE category IS NOT NULL;

-- Giới hạn bản ghi (Phân trang) - LIMIT và OFFSET
SELECT * FROM Product
LIMIT 3
OFFSET 5;


-- Sắp xếp : ORDER BY
SELECT * FROM Product
ORDER BY price DESC, stock_quantity ;

-- Thứ tự viết mệnh đề trong SELECT đầy đủ
-- SELECT  (DISTINCT)
-- FROM [(JOIN)]
-- WHERE
-- [GROUP BY]
-- [HAVING]
-- ORDER BY
-- LIMIT
-- OFFSET

-- Loại bỏ giá trị trùng lặp : sử dụng DISTINCT
SELECT distinct category from Product;
