CREATE TABLE Book (
                       id SERIAL PRIMARY KEY,
                       title TEXT NOT NULL,
                       author TEXT NOT NULL,
                       category TEXT NOT NULL,
                       publish_year INT NOT NULL,
                       price INT NOT NULL,
                       stock INT
);
INSERT INTO Book (title, author, category, publish_year, price, stock) VALUES
                                                                            ('Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
                                                                            ('Học SQL qua ví dụ', 'Trần Thị Hạnh', 'CSDL', 2020, 125000, 12),
                                                                            ('Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
                                                                            ('Phân tích dữ liệu với Python', 'Lê Quốc Bảo', 'CNTT', 2022, 180000, NULL),
                                                                            ('Quản trị cơ sở dữ liệu', 'Nguyễn Thị Minh', 'CSDL', 2021, 150000, 5),
                                                                            ('Học máy cho người mới bắt đầu', 'Nguyễn Văn Nam', 'AI', 2023, 220000, 8),
                                                                            ('Khoa học dữ liệu cơ bản', 'Nguyễn Văn Nam', 'AI', 2023, 220000, NULL);

CREATE TABLE BookOrder(
    id serial primary key,
    reader_name varchar(50),
    borrow_at date,
    return_at date,
    price decimal(10,2),
    book_id int ,
    foreign key (book_id) references Book(id)
);
INSERT INTO BookOrder (reader_name, borrow_at, return_at, price, book_id) VALUES
                                                                              ('Nguyễn Thị Lan', '2023-01-10', '2023-01-20', 95000.00, 1),
                                                                              ('Trần Văn Hùng', '2023-02-05', '2023-02-15', 125000.00, 2),
                                                                              ('Lê Minh Tuấn', '2023-03-12', '2023-03-22', 180000.00, 4),
                                                                              ('Phạm Thị Hoa', '2023-04-01', '2023-04-11', 150000.00, 5),
                                                                              ('Ngô Văn Bình', '2023-05-18', '2023-05-28', 220000.00, 6),
                                                                              ('Đặng Thị Hương', '2023-06-25', '2023-07-05', 220000.00, 7);
-- thêm dữ liệu vào