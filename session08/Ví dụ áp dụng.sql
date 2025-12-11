-- Tạo bảng khách hàng
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           full_name VARCHAR(100),
                           phone VARCHAR(20),
                           address TEXT
);

-- Tạo bảng sản phẩm
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          product_name VARCHAR(100),
                          price NUMERIC(10,2),
                          stock INT
);

-- Tạo bảng hóa đơn (mỗi hóa đơn chỉ chứa 1 sản phẩm)
CREATE TABLE invoices (
                          invoice_id SERIAL PRIMARY KEY,
                          customer_id INT REFERENCES customers(customer_id),
                          product_id INT REFERENCES products(product_id),
                          purchase_date DATE,
                          quantity INT,
                          total_amount NUMERIC(10,2)
);

-- Thêm dữ liệu mẫu khách hàng
INSERT INTO customers (full_name, phone, address) VALUES
                                                      ('Nguyễn Văn A', '0901234567', 'Hà Nội'),
                                                      ('Trần Thị B', '0912345678', 'Đà Nẵng'),
                                                      ('Lê Văn C', '0923456789', 'TP.HCM'),
                                                      ('Phạm Thị D', '0934567890', 'Huế'),
                                                      ('Hoàng Văn E', '0945678901', 'Cần Thơ');

-- Thêm dữ liệu mẫu sản phẩm
INSERT INTO products (product_name, price, stock) VALUES
                                                      ('Laptop Dell', 15000000, 10),
                                                      ('Điện thoại iPhone', 25000000, 15),
                                                      ('Tai nghe Bluetooth', 500000, 50),
                                                      ('Máy giặt LG', 7000000, 5),
                                                      ('Tủ lạnh Samsung', 12000000, 8);

-- Thêm dữ liệu mẫu hóa đơn (mỗi hóa đơn 1 sản phẩm)
INSERT INTO invoices (customer_id, product_id, purchase_date, quantity, total_amount) VALUES
                                                                                          (1, 1, '2025-12-12', 1, 15000000),
                                                                                          (2, 2, '2025-12-13', 1, 25000000),
                                                                                          (3, 3, '2025-12-14', 2, 1000000),
                                                                                          (4, 4, '2025-12-15', 1, 7000000),
                                                                                          (5, 5, '2025-12-16', 1, 12000000),
                                                                                          (1, 2, '2025-12-17', 1, 25000000),
                                                                                          (2, 3, '2025-12-18', 3, 1500000),
                                                                                          (3, 1, '2025-12-19', 1, 15000000),
                                                                                          (4, 5, '2025-12-20', 1, 12000000),
                                                                                          (5, 4, '2025-12-21', 2, 14000000);


-- Mua hàng :
-- Đng kí thông tin kahchs hàng
-- chọn sản phẩm
-- tạo đơn hàng

CREATE OR REPLACE PROCEDURE proc_create_order(full_name_in VARCHAR(100),
                                              phone_in VARCHAR(20),
                                              address_in TEXT,
                                                product_id_in int,
                                                quantity_in int
)
    language plpgsql
AS $$ -- đổi dấu keets thúc câu lệnh thành đô la
-- variable declaration
    declare customer_id int;
    total_amount decimal(10,2);
BEGIN
    -- tạo thông tin khách hàng
    insert into customers (full_name, phone, address) values (full_name_in,phone_in,address_in);
    SELECT distinct lastval() into customer_id from customers; -- lấy ra id tự tăng mới nhất

    select price*quantity_in into total_amount from products where products.product_id = product_id_in;

    -- tạo hóa đơn
    insert into invoices(customer_id, product_id, purchase_date, quantity, total_amount)
    VALUES(customer_id,product_id_in,current_date, quantity_in,total_amount);

    update products set stock = stock - quantity_in where product_id = product_id_in;

END;
$$;

call proc_create_order('ABC', '0983474386','Hanoi',4,10);
