-- ALIAS - Bí danh cho cột và bảng : sử dụng từ khóa tên là AS để đặt tên
SELECT b.id "Mã sách", b.title "Tiêu đề sách" from Book b;
-- Quan hệ : 1-1, 1-n
-- JOIN là phép kết hợp dữ liệu của 2 bảng quan hệ với nhau thông qua khóa chính và khóa ngoại
-- INNER JOIN : chỉ lấy dữ liệu chung của 2 bảng
SELECT b.*, bo.reader_name
FROM book b JOIN bookorder bo
ON b.id = bo.book_id;
-- OUTJOIN : LEFT JOIN < RIGHT JOIN < FULLOUTER JOIN
SELECT b.*, bo.*
FROM book b left JOIN bookorder bo
ON b.id = bo.book_id;

-- Thống kế số lượt mượn của mỗi sách
-- SELECT b.*, count(bo.id)
-- FROM book b JOIN bookorder bo
--                  ON b.id = bo.book_id
-- GROUP BY b.id;
