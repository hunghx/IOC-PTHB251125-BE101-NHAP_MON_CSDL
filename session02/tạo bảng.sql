-- Tạo Schema
create schema customer_manager;
-- chuyển đường dẫn về schema chỉ định
set search_path To customer_manager;

CREATE TYPE enum_sex AS ENUM('Nam','Nu', 'Khac');
create table Customer(
    -- Liệt kê các cột
--                              + Mã khách hàng
    customer_id char(5) PRIMARY KEY ,
--                              + Họ và tên
    full_name varchar(25) NOT NULL ,
--                              + Số điện thoại
    phone_number char(10) NOT NULL UNIQUE ,
--                              + Email
    email varchar(30) NOT NULL UNIQUE ,
--                              + Giới tính
    sex enum_sex default ('Khac'),
--                              + Địa chỉ
    address TEXT
);