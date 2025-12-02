-- Bảng khách hàng
CREATE TABLE customers (
                           customer_id serial PRIMARY KEY,
                           full_name VARCHAR(100) NOT NULL,
                           email VARCHAR(100) UNIQUE NOT NULL,
                           phone VARCHAR(20),
                           city VARCHAR(50),
                           join_date DATE
);

-- Bảng sản phẩm
CREATE TABLE products (
                          product_id serial PRIMARY KEY,
                          product_name VARCHAR(100) NOT NULL,
                          category VARCHAR(50),
                          price DECIMAL(10,2) NOT NULL,
                          stock_quantity INT DEFAULT 0
);

-- Bảng đơn hàng
CREATE TABLE orders (
                        order_id serial PRIMARY KEY,
                        customer_id INT NOT NULL,
                        product_id INT not null ,
                        order_date DATE NOT NULL,
                        total_amount DECIMAL(10,2) NOT NULL,
                        status VARCHAR(20),
                        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers (full_name, email, phone, city, join_date) VALUES
                                                                     ('Nguyen Van A', 'vana@example.com', '0901234567', 'Hanoi', '2023-01-15'),
                                                                     ('Tran Thi B', 'thib@example.com', '0912345678', 'Ho Chi Minh City', '2023-02-10'),
                                                                     ('Le Van C', 'vanc@example.com', '0923456789', 'Da Nang', '2023-03-05'),
                                                                     ('Pham Thi D', 'thid@example.com', '0934567890', 'Hai Phong', '2023-04-20'),
                                                                     ('Hoang Van E', 'vane@example.com', '0945678901', 'Can Tho', '2023-05-12'),
                                                                     ('Do Thi F', 'thif@example.com', '0956789012', 'Hue', '2023-06-18'),
                                                                     ('Bui Van G', 'vang@example.com', '0967890123', 'Nha Trang', '2023-07-25'),
                                                                     ('Dang Thi H', 'thih@example.com', '0978901234', 'Quang Ninh', '2023-08-30'),
                                                                     ('Vo Van I', 'vani@example.com', '0989012345', 'Vinh', '2023-09-14'),
                                                                     ('Nguyen Thi J', 'thij@example.com', '0990123456', 'Hanoi', '2023-10-01');

INSERT INTO products (product_name, category, price, stock_quantity) VALUES
-- Điện tử
('Laptop Dell Inspiron', 'Electronics', 1500.00, 20),
('Smartphone iPhone 14', 'Electronics', 1200.00, 15),
('Tablet Samsung Galaxy Tab', 'Electronics', 600.00, 25),
('Tai nghe Sony WH-1000XM4', 'Electronics', 350.00, 30),
('Camera Canon EOS M50', 'Electronics', 800.00, 10),

-- Thời trang
('Áo sơ mi nam', 'Fashion', 25.00, 100),
('Quần jeans nữ', 'Fashion', 40.00, 80),
('Giày thể thao Adidas', 'Fashion', 90.00, 50),
('Túi xách nữ', 'Fashion', 70.00, 60),
('Áo khoác mùa đông', 'Fashion', 120.00, 40),

-- Gia dụng
('Máy xay sinh tố Philips', 'Home Appliances', 55.00, 35),
('Nồi cơm điện Sharp', 'Home Appliances', 75.00, 20),
('Quạt điện Panasonic', 'Home Appliances', 45.00, 50),
('Bếp từ Sunhouse', 'Home Appliances', 150.00, 15),
('Máy hút bụi Electrolux', 'Home Appliances', 200.00, 12);
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
                                                                       (1, '2023-11-01', 1500.00, 'Completed'),
                                                                       (2, '2023-11-05', 1200.00, 'Pending'),
                                                                       (3, '2023-11-10', 600.00, 'Shipped'),
                                                                       (4, '2023-11-12', 350.00, 'Cancelled'),
                                                                       (5, '2023-11-15', 800.00, 'Completed'),
                                                                       (6, '2023-11-18', 90.00, 'Processing'),
                                                                       (7, '2023-11-20', 70.00, 'Pending'),
                                                                       (8, '2023-11-25', 200.00, 'Completed');

-- Tìm khách hàng theo tên (sử dụng ILIKE)
    ALTER  table orders
    add column product_id int references products(product_id);
--
    SELECT * from customers WHERE full_name ILIKE '%thi%';
-- Lọc sản phẩm theo khoảng giá (sử dụng BETWEEN)
--
    SELECT  * from products where price between 1000000 AND 100000000;
-- Tìm khách hàng chưa có số điện thoại (IS NULL)
--
select *
from customers where phone is null;
-- Top 5 sản phẩm có giá cao nhất (ORDER BY + LIMIT)
--
    select * from products
    order by price desc
    limit 5;
-- Phân trang danh sách đơn hàng (LIMIT + OFFSET)
-- số trang và số phần tử trên 1 trang : lấy ra trang thứ 2 và lấy 5 phần tử : limit = size_per_page , offset = (page_number - 1)*size_per_page
select * from orders
limit 5
offset 5;
-- Đếm số khách hàng theo thành phố (DISTINCT + COUNT)
--
    select count(distinct city) from customers;
-- Tìm đơn hàng trong khoảng thời gian (BETWEEN với DATE)
--
SELECT  * from orders where order_date between '2025-10-10' AND '2025-12-12';
-- Sản phẩm chưa được bán (NOT EXISTS)

select * from products
where product_id not in (
select orders.product_id from orders);

