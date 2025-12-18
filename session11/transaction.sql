-- Cú pháp transaction
-- Tạo bảng accounts
CREATE TABLE accounts
(
    account_id   SERIAL PRIMARY KEY, -- ID tài khoản tự tăng
    account_name VARCHAR(255),       -- Tên chủ tài khoản
    balance      NUMERIC(10, 2)      -- Số dư tài khoản
);

alter table accounts
add constraint ck_01 check ( balance >=0 );

-- Tạo bảng transactions để lưu lịch sử giao dịch
CREATE TABLE transactions
(
    transaction_id   SERIAL PRIMARY KEY,                   -- ID giao dịch tự tăng
    from_account     INT REFERENCES accounts (account_id), -- Tài khoản nguồn
    to_account       INT REFERENCES accounts (account_id), -- Tài khoản đích
    amount           NUMERIC(10, 2),                       -- Số tiền chuyển
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP   -- Thời gian giao dịch
);
-- Thêm dữ liệu mẫu vào bảng accounts
INSERT INTO accounts (account_name, balance)
VALUES ('Alice', 1000.00),
       ('Bob', 500.00);

-- tạo giao dịch chuển 250 $ từ account 1 => account 2
-- BEGIN ;
-- --  kiểm tra số dư tài khoản gửi
--     if (select balance from accounts where account_id = 1) < 250 then
--         RAISE EXCEPTION 'Insufficient funds';
--     end if;

-- COMMIT / ROLLBACK

create or replace procedure send_money(from_acc int, to_acc int, amt numeric)
    language plpgsql
as $$
    declare balance_in numeric;
begin
--         select balance into balance_in from accounts where account_id = from_acc;
--         if balance_in <amt then
--             raise EXCEPTION 'so du ko du';
--         end if;
        -- chuyen tien
        update accounts set balance = balance + amt where account_id = to_acc;   -- cong tiền tai khoan nhan
        update accounts set balance = balance - amt where account_id = from_acc; -- tru tien tai khoan gui
        -- lưu lịch sử
        insert into transactions(from_account, to_account, amount) VALUES (from_acc, to_acc, amt);

     Exception
        when others then
        rollback ;
        raise EXCEPTION 'Giao dich that bai';
end;
$$ ;


call send_money(1, 2, 250);

-- Begin;
-- set autocommit = 0;
-- update accounts set balance = balance + 250 where account_id = 2;   -- cong tiền tai khoan nhan
-- update accounts set balance = balance - 250 where account_id = 1; -- tru tien tai khoan gui
-- -- lưu lịch sử
-- insert into transactions(from_account, to_account, amount) VALUES (1, 2, 250);
-- commit ;

