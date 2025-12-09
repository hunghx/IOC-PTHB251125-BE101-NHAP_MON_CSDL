-- VIEW
-- Tao view thông thường
create view view_product_with_quantity
as
    SELECT p.id,p.name, sum(od.quantity)
        FROM product p join orderdetail od
        ON p.id = od.product_id
group by p.id, p.name;

-- alter table product
-- drop column name;

--  Tạo view với check option : khi thêm sửa xóa dữ liệu phải thỏa mãn where
create view view_pro_greater_than_1000
as
select * from product
WHERE price > 1000
with check option ;
-- truy vấn trên view
select * from view_pro_greater_than_1000;
-- cập nhật dữ liệu qua view
update view_pro_greater_than_1000
    set price = 14000
WHERE id = 1;
-- tạo materialized view
create materialized view view_pro_less_than_500
as
select * from product
WHERE price < 500;
-- cập nhật dữ liệu của materialized view
refresh materialized view view_pro_less_than_500;

select * from view_pro_less_than_500;

-- xóa dữ liệu
delete from product where id in (4,6,7);

-- Lưu ý : có thể thao tác như 1 bảng thông thường, tuy nhiên không nên sử dụng để chỉnh sửa dữ liệu


-- Dữ liệu mẫu cho bảng Product
INSERT INTO Product (name, category, price) VALUES
                                                ('Laptop Dell Inspiron', 'Electronics', 1500.00),
                                                ('iPhone 14', 'Electronics', 999.00),
                                                ('Samsung Galaxy S23', 'Electronics', 899.00),
                                                ('Sony Headphones', 'Electronics', 199.00),
                                                ('MacBook Air', 'Electronics', 1200.00),
                                                ('Nike Running Shoes', 'Fashion', 120.00),
                                                ('Adidas Hoodie', 'Fashion', 80.00),
                                                ('Levi’s Jeans', 'Fashion', 60.00),
                                                ('Casio Watch', 'Accessories', 150.00),
                                                ('Ray-Ban Sunglasses', 'Accessories', 200.00),
                                                ('Wooden Desk', 'Furniture', 300.00),
                                                ('Office Chair', 'Furniture', 250.00),
                                                ('Bookshelf', 'Furniture', 180.00),
                                                ('Dining Table', 'Furniture', 400.00),
                                                ('Refrigerator LG', 'Appliances', 700.00),
                                                ('Microwave Oven', 'Appliances', 150.00),
                                                ('Vacuum Cleaner', 'Appliances', 220.00),
                                                ('Electric Kettle', 'Appliances', 50.00),
                                                ('Gaming Mouse', 'Electronics', 75.00),
                                                ('Bluetooth Speaker', 'Electronics', 130.00);

-- Dữ liệu mẫu cho bảng OrderDetail
INSERT INTO OrderDetail (order_id, product_id, quantity) VALUES
                                                             (1, 1, 2),
                                                             (1, 5, 1),
                                                             (2, 2, 1),
                                                             (2, 6, 3),
                                                             (3, 3, 2),
                                                             (3, 7, 1),
                                                             (4, 4, 4),
                                                             (4, 8, 2),
                                                             (5, 9, 1),
                                                             (5, 10, 2),
                                                             (6, 11, 1),
                                                             (6, 12, 2),
                                                             (7, 13, 1),
                                                             (7, 14, 1),
                                                             (8, 15, 1),
                                                             (8, 16, 2),
                                                             (9, 17, 1),
                                                             (9, 18, 3),
                                                             (10, 19, 2),
                                                             (10, 20, 1);