
-- Cú pháp tạo thủ tục

CREATE OR REPLACE PROCEDURE proc_get_all_patients()
language plpgsql
AS $$ -- đổi dấu keets thúc câu lệnh thành đô la
-- variable declaration
BEGIN
    select * from patients;
    -- Thủ tục ko áp dụng cho truy vấn select
-- stored procedure body
END;
$$;

-- gọi/ thực thi thủ tục
call proc_get_all_patients();

CREATE OR REPLACE PROCEDURE proc_inset_patient(full_name_in varchar(100),phone_in varchar(20), city_in varchar(50), symptoms_in text[])
    language plpgsql
AS $$ -- đổi dấu keets thúc câu lệnh thành đô la
-- variable declaration
BEGIN
    insert into patients(full_name, phone, city, symptoms)
    values (full_name_in,phone_in,city_in,symptoms_in);
    -- Thủ tục ko áp dụng cho truy vấn select
-- stored procedure body
END;
$$;
CREATE OR REPLACE PROCEDURE proc_update_patient(full_name_in varchar(100),phone_in varchar(20), city_in varchar(50), symptoms_in text[], patients_id_in int)
    language plpgsql
AS $$ -- đổi dấu keets thúc câu lệnh thành đô la
-- variable declaration
BEGIN
    update patients set full_name = full_name_in, phone = phone_in,
                        city = city_in, symptoms = symptoms_in
    where patient_id = patients_id_in;
    -- Thủ tục ko áp dụng cho truy vấn select
-- stored procedure body
END;
$$;
CREATE OR REPLACE PROCEDURE proc_delete_patient(patients_id_in int)
    language plpgsql
AS $$ -- đổi dấu keets thúc câu lệnh thành đô la
-- variable declaration
BEGIN
    delete  from  patients
    where patient_id = patients_id_in;
    -- Thủ tục ko áp dụng cho truy vấn select
-- stored procedure body
END;
$$;


-- Tạo 3 thủ tục :
-- Thêm mới
-- Cập nhật tất cả thông tin theo khóa chính
-- Xóa theo khóa chính

call proc_inset_patient('Nguyen Van AB','09893475864','Ha noi','{name}');
call proc_update_patient('Nguyen Van C','09893473464','Ha noi 1','{name1}',6);
call proc_delete_patient(6);




