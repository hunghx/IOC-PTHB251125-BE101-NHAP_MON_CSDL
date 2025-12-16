-- Trigger (Trình tự kích hoạt) và Function (Hàm / chức năng) ,Stored Procedure (thủ tục)

-- Function : hàm bào gồm các câu lệnh SQL thực hiện 1 chức năng và có thể trả về giá trị
-- -- Tạo thủ tục
-- drop function get_list_employees();

drop function get_list_employees();
create or replace function get_list_employees ()
returns TABLE(salary1 numeric(10,2), bonus1 numeric(10,2))
    as $$
begin
    return query
        select salary, bonus
        from employees;
end;
    $$ language plpgsql;

-- select id, name, salary, bonus from employees;

-- Tạo hàm tính tổng 2 số thực
create function sum(a decimal(10,2), b decimal(10,2))
returns decimal(10,2) as $$
begin
    return a+b;
end;
$$ language plpgsql;

select * from get_list_employees();

select sum(10.5, 7.2);


-- Lấy ra thông tin khách hàng và đơn mua

create view cus_order as select c.customer_id, c.full_name, o.customer_id cus_id, o.product_id,o.total_amount,o.order_date from customers c join orders o
on c.customer_id = o.customer_id;

create or replace function abc()
returns setof cus_order as $$
    declare abc int ;
begin
    return query select c.customer_id, c.full_name, o.customer_id cus_id, o.product_id,o.total_amount,o.order_date from customers c join orders o                                                                                                                  on c.customer_id = o.customer_id
    where total_amount > 1000;
end;
$$ language plpgsql;

select abc();


-- Bài tập áp dụng
-- Bài tập logic :
-- 1.1 Xây dựng hàm nhận vào 3 gia trị là độ dài 3 cạnh của 1 tam giac
-- Kiểm tra tính hợp lệ của 3 giá trị nhập vào
-- Nếu 1 trong 3 cạnh là số âm thì trả về 'Các cạnh phải lớn hơn 0'
-- Nếu 2 cạnh mà <= cạnh còn lại thi trả về 'Tổng 2 cạnh bất kì phải lớn hơn cạnh còn lại'
-- Còn lại thì trả về '3 cạnh hợp lệ'

-- 1.2 Tạo hàm tính tổng tiền của hóa đơn truyền vào
-- Truyền vào order_id
-- Thực hiện tính tổng tiền theo mã hóa đơn vaf trả về giá trị tính được

-- 1.3 Tạo hàm thống kê số lượng sản phẩm mua theo từng hóa đơn
-- yêu cầu trả về Table(ma hóa đơn , tổng số lượng)



-- Trigger
-- OLD(UPDATE và DELETE) và NEW(INSERT , UPDATE) là các đối tượng đại diện cho bản ghi cũ và mới (Record)
-- Khi tạo đơn hàng thì tiến hành trừ số lượng trong kho
-- B1 : tạo trigger function
-- tạo mới order (NEW)
-- alter table orders
-- add column quantity int;

create or replace function update_stock_product()
returns TRIGGER as $$
begin
   -- trừ số lượng
   update products set stock_quantity = stock_quantity - NEW.quantity where product_id = NEW.product_id;
   select price*new.quantity into new.total_amount from products where  product_id = new.product_id;
   return new;
   end;

$$ language plpgsql;
-- Lưu ý : khi trigger đc kích hoạt trên 1 bảng thì ko đc thay đổi dữ liệu của bảng đó
-- Ví dụ : Tạo trigger tự động cập nhật số lượng sản phẩm về 0 sau khi thêm mới 1 sản phẩm vào bảng;

-- tạo trigger để kich hoạt
create or replace trigger trigger_after_create_order
before insert on orders
for each row
execute function update_stock_product();

-- Trong qua trình thay đổi dữ liệu trigger can thiệp vào trước hoặc sau quá trình thay đổi dữ liệu xảy ra

-- tạo trigger khi xóa 1 đơn hàng, nếu số lượng bằng 0 thì hủy lệnh xóa
create function trigger_function_before_delete()
returns trigger as $$
begin
    if old.quantity = 0
        then
        raise exception 'ko the xoa don hang có 0 san pham';
    end if;
end;
$$ language plpgsql;

create trigger abc
before delete on orders
    for each  row
    execute function trigger_function_before_delete();







