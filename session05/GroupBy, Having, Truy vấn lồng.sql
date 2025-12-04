-- 1. Tính tổng số lượng sản phẩm bán ra theo từng sản phẩm.
    SELECT p.productid,
           p.productname, sum(CASE
                                  WHEN quantity isnull THEN 0
                                  ELSE quantity
                            END)
        FROM products p LEFT JOIN orderdetails o ON o.productid = p.productid
    group by p.productid
    ;
-- 2. Tính tổng doanh thu theo từng sản phẩm.
    SELECT p.productid, p.productname, SUM(p.price * (CASE
                                                          WHEN od.quantity isnull THEN 0
                                                          ELSE od.quantity
        END)) "Tổng doanh thu"
        FROM products p left join orderdetails od on od.productid = p.productid
    GROUP BY p.productid;
-- 3. Tính tổng doanh thu theo từng khách hàng.

-- 4. Tính tổng doanh thu theo từng nhân viên.
-- 5. Liệt kê sản phẩm có doanh thu > 1000.
-- 6. Liệt kê khách hàng có tổng số lượng mua > 5.
-- 7. Liệt kê nhân viên có doanh thu trung bình > 500.
-- 8. Liệt kê thành phố có nhiều khách hàng nhất.
-- 9. Liệt kê loại sản phẩm có tổng doanh thu cao nhất.
--     B1 : lấy doanh thu cao nhất (MAX)
--     B2 : Lấy đc những sẩn có doanh thu = doanh thu cao nhất

SELECT p.* , SUM(p.price * od.quantity)
FROM products p join orderdetails od on od.productid = p.productid
GROUP BY p.productid
HAVING  SUM(p.price * od.quantity) = (SELECT SUM(p.price * od.quantity)
                                      FROM products p join orderdetails od on od.productid = p.productid
                                      GROUP BY p.productid
                                      order by SUM(p.price * od.quantity) desc
                                      LIMIT 1);
-- Hướng 2 : doanh thu của sản phầm cao nhất luôn >= tất cả các doanh thu còn lại


-- 10. Liệt kê khách hàng có nhiều đơn hàng nhất.
