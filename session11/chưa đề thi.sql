-- Chưa bai kiem tra mẫu
-- tạo bảng
-- Bảng Movie
CREATE TABLE Movie (
                       movie_id VARCHAR(5) PRIMARY KEY,
                       title VARCHAR(255) NOT NULL,
                       genre VARCHAR(50) NOT NULL,
                       duration_minutes INT NOT NULL,
                       release_date DATE NOT NULL
);

-- Bảng Customer
CREATE TABLE Customer (
                          customer_id VARCHAR(5) PRIMARY KEY,
                          full_name VARCHAR(100) NOT NULL,
                          email VARCHAR(100) UNIQUE NOT NULL,
                          phone_number VARCHAR(15) NOT NULL
);

-- Bảng Screening
CREATE TABLE Screening (
                           screening_id SERIAL PRIMARY KEY,
                           movie_id VARCHAR(5) NOT NULL REFERENCES Movie(movie_id),
                           screen_number INT NOT NULL,
                           show_time TIMESTAMP NOT NULL,
                           ticket_price DECIMAL(8,2) NOT NULL
);

-- Bảng Booking
CREATE TABLE Booking (
                         booking_id SERIAL PRIMARY KEY,
                         customer_id VARCHAR(5) NOT NULL REFERENCES Customer(customer_id),
                         screening_id INT NOT NULL REFERENCES Screening(screening_id),
                         booking_date DATE NOT NULL,
                         num_tickets INT NOT NULL,
                         total_amount DECIMAL(10,2) NOT NULL
);

-- Bảng Payment
CREATE TABLE Payment (
                         payment_id SERIAL PRIMARY KEY,
                         booking_id INT NOT NULL REFERENCES Booking(booking_id),
                         payment_method VARCHAR(50) NOT NULL,
                         payment_date TIMESTAMP NOT NULL,
                         amount_paid DECIMAL(10,2) NOT NULL
);

-- chen dư liệu
-- Movie
INSERT INTO Movie VALUES
                      ('M001', 'Avatar', 'Sci-Fi', 162, '2009-12-18'),
                      ('M002', 'Fast X', 'Action', 141, '2023-05-19'),
                      ('M003', 'Titanic', 'Romance', 195, '1997-12-19'),
                      ('M004', 'Inception', 'Sci-Fi', 148, '2010-07-16'),
                      ('M005', 'The Dark Knight', 'Action', 152, '2008-07-18');

-- Customer
INSERT INTO Customer VALUES
                         ('C001', 'Nguyen Van B', 'b.nguyen@test.com', '0901000001'),
                         ('C002', 'Le Thi C', 'c.le@test.com', '0902000002'),
                         ('C003', 'Tran Van D', 'd.tran@test.com', '0903000003'),
                         ('C004', 'Pham Thi E', 'e.pham@test.com', '0904000004'),
                         ('C005', 'Hoang Van F', 'f.hoang@test.com', '0905000005');

-- Screening
INSERT INTO Screening (movie_id, screen_number, show_time, ticket_price) VALUES
                                                                             ('M001', 1, '2025-12-20 19:00:00', 100000),
                                                                             ('M002', 2, '2025-12-20 20:30:00', 120000),
                                                                             ('M003', 3, '2025-12-21 18:00:00', 90000),
                                                                             ('M004', 1, '2025-12-21 21:00:00', 110000),
                                                                             ('M005', 2, '2025-12-22 19:30:00', 115000);

-- Booking
INSERT INTO Booking (customer_id, screening_id, booking_date, num_tickets, total_amount) VALUES
                                                                                             ('C001', 1, '2025-12-18', 2, 200000),
                                                                                             ('C002', 2, '2025-12-18', 3, 360000),
                                                                                             ('C003', 3, '2025-12-19', 1, 90000),
                                                                                             ('C004', 4, '2025-12-19', 4, 440000),
                                                                                             ('C005', 5, '2025-12-20', 2, 230000);

-- Payment
INSERT INTO Payment (booking_id, payment_method, payment_date, amount_paid) VALUES
                                                                                (1, 'Credit Card', '2025-12-18 10:05:00', 200000),
                                                                                (2, 'Cash', '2025-12-18 11:10:00', 360000),
                                                                                (3, 'Bank Transfer', '2025-12-19 09:00:00', 90000),
                                                                                (4, 'Credit Card', '2025-12-19 15:30:00', 440000),
                                                                                (5, 'E-Wallet', '2025-12-20 12:45:00', 230000);


-- 3. Cập nhật dữ liệu (6 điểm)
-- Viết câu lệnh UPDATE để cập nhật lại total_amount trong bảng Booking theo công thức: total_amount = num_tickets * (ticket_price * 0.9) (giảm giá 10%).
    update Booking bk set total_amount = num_tickets*(select ticket_price*0.9 from Booking b join Screening s on b.screening_id = s.screening_id where b.booking_id= bk.booking_id)
    where bk.booking_id in (select b.booking_id from Booking b join Screening sc on b.screening_id = sc.screening_id join Movie m on sc.movie_id = m.movie_id where m.genre = 'Action');

--                   Điều kiện: Chỉ áp dụng cho các booking đặt vé xem phim có thể loại 'Action'.
-- 4. Xóa dữ liệu (6 điểm)
--                   Viết câu lệnh DELETE để xóa các thanh toán trong bảng Payment nếu:
--                                     Phương thức thanh toán (payment_method) là 'Tiền mặt' (Cash).
--                                     Và số tiền thanh toán (amount_paid) nhỏ hơn 300.000.
    delete from Payment where payment_method = 'Cash' and amount_paid < 300000;
--
-- PHẦN 2: Truy vấn dữ liệu (40 điểm)
--     (3 điểm) Lấy thông tin tất cả các phim (Mã, Tên, Thể loại, Thời lượng) được sắp xếp theo Thời lượng giảm dần.
        select movie_id,title,genre,duration_minutes from Movie order by duration_minutes desc;
--     (3 điểm) Lấy thông tin các suất chiếu (Mã suất, Mã phim, Phòng chiếu, Giá vé) có giá vé trên 110.000.
        select screening_id,movie_id,screen_number,ticket_price from Screening where ticket_price > 110000;
--     (3 điểm) Lấy thông tin khách hàng và các suất chiếu họ đã đặt, gồm Tên khách hàng, Tên phim, Thời gian chiếu.
        select c.full_name,m.title,sc.show_time from Customer c
        join Booking b on c.customer_id = b.customer_id
        join Screening sc on b.screening_id = sc.screening_id
        join Movie M on sc.movie_id = M.movie_id;
--     (3 điểm) Lấy danh sách phim và tổng số tiền thu được từ việc bán vé cho phim đó, gồm Tên phim và Tổng tiền bán vé.
        select m.title, sum(b.total_amount) from Booking b join Screening sc on b.screening_id = sc.screening_id
        join Movie m on sc.movie_id = m.movie_id
        group by m.movie_id, m.title;
--     (3 điểm) Lấy thông tin khách hàng từ vị trí thứ 3 đến thứ 5 trong bảng Customer được sắp xếp theo Họ tên tăng dần.
       select * from Customer order by full_name limit 3 offset 2;
--     (5 điểm) Lấy danh sách các khách hàng đã đặt vé xem ít nhất 2 bộ phim khác nhau và
--     có tổng số tiền đã thanh toán trên 500.000, gồm Mã KH, Họ tên, Số lượng phim khác nhau đã đặt.
        select c.customer_id, c.full_name, count(distinct sc.movie_id) from Customer c join Booking b on c.customer_id = b.customer_id
        join Screening sc on b.screening_id = sc.screening_id
        join Payment P on b.booking_id = P.booking_id
        group by c.customer_id
        having count(distinct sc.movie_id) >=2 and sum(p.amount_paid) > 500000;
--     (5 điểm) Lấy danh sách các phim (Mã phim, Tên phim) có ít nhất 2 suất chiếu vào ngày hôm nay (CURRENT_DATE).
       select m.movie_id,m.title from Movie m join Screening sc on m.movie_id = sc.movie_id
       where date(sc.show_time) = current_date
       group by m.movie_id
       having count(sc.screening_id) >=2;
--     (5 điểm) Lấy danh sách các khách hàng chưa từng đặt vé xem phim thuộc thể loại 'Horror'.
       select * from Customer where Customer.customer_id not in
        (select customer_id from Booking b
            join Screening sc on b.screening_id = sc.screening_id
            join Movie m on sc.movie_id = m.movie_id where m.genre = 'Horror');
--     (6 điểm) Lấy danh sách tất cả các suất chiếu (Mã suất, Tên phim, Thời gian chiếu) của các phim có thể loại chứa chữ 'Sci-Fi' và thời lượng dưới 150 phút.
       select sc.screening_id, M.title,sc.show_time from Screening sc join Movie M on sc.movie_id = M.movie_id
       where M.genre ilike '%Sci-Fi%' and M.duration_minutes < 150;
--     (4 điểm) Lấy danh sách tất cả các phim (Mã phim, Tên phim, Ngày phát hành), sắp xếp theo ngày phát hành mới nhất.
--     Hiển thị 5 phim tiếp theo sau 5 phim đầu tiên (tức là lấy kết quả của trang thứ 2).
       select movie_id,title,release_date from Movie order by release_date desc limit 5 offset 5;
--
-- PHẦN 3: Tạo View (10 điểm)
--           (5 điểm) Hãy tạo một view có tên view_movie_schedule để lấy thông tin các suất chiếu trong 3 ngày tới (kể từ ngày hiện tại). Cần hiển thị các thông tin sau: Mã suất chiếu, Tên phim, Phòng chiếu, Thời gian chiếu.
    create view view_movie_schedule
    as
    select from Movie m join Screening S on m.movie_id = S.movie_id
    where S.show_time
    between current_timestamp and current_timestamp + Interval '3 days';
    select * from view_movie_schedule;
--           (5 điểm) Hãy tạo một view có tên view_high_value_customer để lấy thông tin khách hàng đã đặt vé có tổng số lượng vé đặt trong 1 lần booking lớn hơn 4. Cần hiển thị các thông tin sau: Mã khách hàng, Họ tên khách hàng, Số lượng vé.

-- PHẦN 4: Tạo Trigger (10 điểm)
--                                     (5 điểm) Hãy tạo một trigger check_ticket_quantity để kiểm tra dữ liệu mỗi khi chèn vào bảng Booking. Kiểm tra nếu num_tickets nhỏ hơn hoặc bằng 0 thì thông báo lỗi với nội dung "Số lượng vé phải lớn hơn 0!" và hủy thao tác chèn dữ liệu vào bảng.
    create function trg1()
    returns trigger as $$
    begin
        if new.quantity < 0 then
            raise exception 'Ko the nhap so luong am';
        end if;
    end;
    $$ language plpgsql;

create trigger check_ticket_quantity
    before insert on Booking
    execute function trg1();
--                                     (5 điểm) Hãy tạo một trigger có tên là calculate_total_amount để tự động tính toán và cập nhật cột total_amount trong bảng Booking trước khi chèn (BEFORE INSERT). Công thức: total_amount = num_tickets * ticket_price (Dùng giá vé từ bảng Screening).
--
-- PHẦN 5: Tạo Store Procedure (10 điểm)
--                                     (5 điểm) Viết store procedure có tên get_movies_by_genre để lấy danh sách phim theo thể loại được chỉ định.
--                                     Tham số đầu vào: p_genre (VARCHAR)
--                                     Kết quả: Trả về bảng gồm Mã phim, Tên phim, Thời lượng của các phim thuộc thể loại đó.
    create procedure get_movies_by_genre(p_genre varchar(50))
    language plpgsql
    as $$
    begin
        select * from Movie where genre = p_genre;
        -- sử dụng raise notice để in bảng ra console
    end;
    $$
--                                     (5 điểm) Hãy tạo một Stored Procedure có tên là process_new_booking để thực hiện việc đặt vé mới cho khách hàng.
--                                     Procedure này nhận các tham số đầu vào: p_customer_id, p_screening_id, p_num_tickets.
--                                     Logic:
--                                     Tạo một bản ghi mới trong bảng Booking với booking_date là ngày hiện tại (CURRENT_DATE). (Lưu ý: total_amount phải được tính toán chính xác hoặc để trigger ở P4 xử lý).
--                                     Thông báo thành công.

