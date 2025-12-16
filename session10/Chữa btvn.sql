-- Tạo bảng employees
CREATE TABLE employees (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           department VARCHAR(50),
                           salary NUMERIC(10,2),
                           bonus NUMERIC(10,2) DEFAULT 0
);

-- Chèn dữ liệu vào bảng employees
INSERT INTO employees (name, department, salary) VALUES
                                                     ('Nguyen Van A', 'HR', 4000),
                                                     ('Tran Thi B', 'IT', 6000),
                                                     ('Le Van C', 'Finance', 10500),
                                                     ('Pham Thi D', 'IT', 8000),
                                                     ('Do Van E', 'HR', 12000);




-- Tạo procedure update_employee_status với yêu cầu sau:
--
-- Tham số vào:
-- p_emp_id INT — mã nhân viên
-- Tham số ra:
-- p_status TEXT — trạng thái sau khi cập nhật
-- Yêu cầu xử lý:
--
-- Nếu nhân viên không tồn tại, ném lỗi "Employee not found"
-- Nếu lương < 5000 → cập nhật status = 'Junior'
-- Nếu lương từ 5000–10000 → cập nhật status = 'Mid-level'
-- Nếu lương > 10000 → cập nhật status = 'Senior’
-- Trả ra p_status sau khi cập nhật

create procedure update_employee_status(p_emp_id INT , OUT p_status TEXT)
language plpgsql
as $$
    declare salary_var numeric(10,2);
begin
    -- khối lệnh
    IF ((Select count(*) from employees where id = p_emp_id) = 0) Then
        Raise EXCEPTION 'Employee Not Found';
    end if;
    -- tính salary
    select salary into salary_var from employees where id = p_emp_id;

    p_status:= case when salary_var < 5000 then 'Junior'
        when salary_var < 10000 then 'Mid-level'
        else 'Senior'
    end;

--         if salary_var < 5000 then
--             p_status:='Junior';
--         elseif salary_var < 10000 then
--             p_status :='Mid-level';
--         else
--             p_status:='Senior';
--         end if;
end;
$$;


call update_employee_status(10,null);