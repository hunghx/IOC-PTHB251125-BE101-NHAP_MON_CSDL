-- Hàm Tổ hợp : SUM , AVG, MAX, MIN, COUNT
select count(productid), min(price), max(price), avg(price), sum(price) from products;
-- GROUP BY - Nhóm dữ liệu theo các cột chung
-- Nhóm tất các khách hàng có cùng thành phố
SELECT  city, count(customerid) from customers
GROUP BY city;
-- Tính tông so lượng san pham đã bán ra theo từng sản phẩm
select p.productid,p.productname, sum(quantity)
    from orderdetails o join products p on o.productid = p.productid
group by p.productid
order by p.productid;

-- HAVING : xử lí điều kiện tren từng nhóm
-- lọc ra các thành phố có từ 2 khách hàng trở lên
SELECT  city, count(customerid) from customers
GROUP BY city
HAVING count(customerid) >=2;

-- TRUY VẤN LỒNG
-- SELECT -- có
-- FROM -- Có
-- WHERE -- Có
-- GROUP BY -- Không
-- HAVING -- Có
-- ORDERBY -- Không
-- SELECT (SELECT  city, count(customerid) from customers
--           GROUP BY city
--           HAVING count(customerid) >=2) abc;
-- WHERE thường kết hợp truy vấn lồng trả về 1 hoặc 1 cột giá trị
-- HAVING tương tự where

-- Nâng cao : EXIST, ANY, ALL
-- Tìm ra sản phẩm có giá lớn nhất
SELECT * from products order by price desc limit 1;

select * from products
where  price >= ALL (select price from products);

-- Nâng cáo UNION và INTERSECT : hợp, giao
-- (select * from products limit 5)
-- --     INTERSECT
-- (select * from customers limit 5);
