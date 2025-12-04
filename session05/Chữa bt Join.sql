-- JOIN cơ bản

-- 1. Liệt kê tất cả đơn hàng cùng tên khách hàng.
    SELECT o.*, c.customername
        FROM customers c JOIN orders o
    ON c.customerid = o.customerid;

-- 2. Liệt kê đơn hàng kèm tên nhân viên xử lý.
    SELECT  o.* , e.employeename
        FROM orders o JOIN employees e
    ON o.employeeid = e.employeeid;
-- 3. Liệt kê chi tiết đơn hàng (OrderID, ProductName, Quantity).
    SELECT  od.orderid,p.productname, od.quantity
        FROM products p JOIN orderdetails od
    ON p.productid = od.productid;
-- 4. Liệt kê khách hàng và sản phẩm họ đã mua.
    SELECT c.*, p.productname, od.quantity,p.price
    FROM customers c JOIN orders o on c.customerid = o.customerid
    JOIN orderdetails od ON o.orderid = od.orderid
    JOIN products p ON od.productid = p.productid;

-- 5. Liệt kê nhân viên và khách hàng mà họ phục vụ.
-- 6. Liệt kê khách hàng ở Hà Nội và sản phẩm họ mua.
SELECT c.*, p.productname, od.quantity,p.price
FROM customers c JOIN orders o on c.customerid = o.customerid
                 JOIN orderdetails od ON o.orderid = od.orderid
                 JOIN products p ON od.productid = p.productid
WHERE c.city = 'Hanoi';
-- 7. Liệt kê tất cả đơn hàng cùng tên khách hàng và nhân viên.
-- 8. Liệt kê sản phẩm và số lượng bán ra trong từng đơn hàng.
-- 9. Liệt kê khách hàng và số lượng sản phẩm họ đã mua.
    SELECT  c.* , od.quantity
        FROM customers c join orders o ON c.customerid = o.customerid
    JOIN orderdetails od ON o.orderid = od.orderid;
-- 10. Liệt kê nhân viên và tổng số đơn hàng họ xử lý.
SELECT e.*, COUNT(o.orderid)
    FROM employees e JOIN orders o ON e.employeeid = o.employeeid
GROUP BY e.employeeid;


--
(SELECT o.*, c.customername
FROM customers c left JOIN orders o
                      ON c.customerid = o.customerid where c.customerid>=2)
INTERSECT
(SELECT o.*, c.customername
FROM customers c  JOIN orders o
                      ON c.customerid = o.customerid where c.customerid<=2);