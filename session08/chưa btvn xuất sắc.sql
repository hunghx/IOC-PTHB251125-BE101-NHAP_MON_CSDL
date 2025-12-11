CREATE TABLE patients (
                          patient_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          phone VARCHAR(20),
                          city VARCHAR(50),
                          symptoms TEXT[]
);

CREATE TABLE doctors (
                         doctor_id SERIAL PRIMARY KEY,
                         full_name VARCHAR(100),
                         department VARCHAR(50)
);

CREATE TABLE appointments (
                              appointment_id SERIAL PRIMARY KEY,
                              patient_id INT REFERENCES patients(patient_id),
                              doctor_id INT REFERENCES doctors(doctor_id),
                              appointment_date DATE,
                              diagnosis VARCHAR(200),
                              fee NUMERIC(10,2)
);
INSERT INTO patients (full_name, phone, city, symptoms) VALUES
                                                            ('Nguyễn Văn A', '0901234567', 'Hà Nội', ARRAY['Sốt', 'Ho']),
                                                            ('Trần Thị B', '0912345678', 'Đà Nẵng', ARRAY['Đau đầu']),
                                                            ('Lê Văn C', '0923456789', 'TP.HCM', ARRAY['Mệt mỏi', 'Khó thở']),
                                                            ('Phạm Thị D', '0934567890', 'Huế', ARRAY['Đau bụng']),
                                                            ('Hoàng Văn E', '0945678901', 'Cần Thơ', ARRAY['Sốt cao', 'Nôn']);
INSERT INTO doctors (full_name, department) VALUES
                                                ('BS. Nguyễn Văn Hùng', 'Nội tổng quát'),
                                                ('BS. Trần Thị Mai', 'Nhi khoa'),
                                                ('BS. Lê Văn Phúc', 'Tim mạch'),
                                                ('BS. Phạm Thị Lan', 'Tiêu hóa'),
                                                ('BS. Hoàng Văn Minh', 'Hô hấp');
INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis, fee) VALUES
                                                                                       (1, 1, '2025-12-12', 'Cảm cúm nhẹ', 200000),
                                                                                       (2, 2, '2025-12-13', 'Đau đầu do căng thẳng', 250000),
                                                                                       (3, 3, '2025-12-14', 'Thiếu máu nhẹ', 300000),
                                                                                       (4, 4, '2025-12-15', 'Viêm dạ dày', 350000),
                                                                                       (5, 5, '2025-12-16', 'Viêm phổi nhẹ', 400000),
                                                                                       (1, 2, '2025-12-17', 'Ho kéo dài', 220000),
                                                                                       (2, 3, '2025-12-18', 'Rối loạn tiền đình', 280000),
                                                                                       (3, 4, '2025-12-19', 'Đau bụng cấp', 330000),
                                                                                       (4, 5, '2025-12-20', 'Viêm phế quản', 370000),
                                                                                       (5, 1, '2025-12-21', 'Sốt siêu vi', 410000);

-- Chèn ít nhất 5 bệnh nhân, 5 bác sĩ và 10 cuộc hẹn
-- Tạo Index để tăng tốc truy vấn:
-- B-tree: tìm bệnh nhân theo số điện thoại (phone)
    create index idx_btree_phone on patients (phone);

-- Hash: tìm bệnh nhân theo city
    create index idx_hash_city on patients using hash (city);
CREATE EXTENSION pg_trgm;
CREATE EXTENSION btree_gin;
-- GIN: tìm bệnh nhân theo từ khóa trong mảng symptoms
    create index idx_gin_symptoms on patients using gin (symptoms);
-- GiST: tìm cuộc hẹn theo khoảng phí (fee)
-- Source - https://stackoverflow.com/a
-- Posted by icyerasor
-- Retrieved 2025-12-11, License - CC BY-SA 4.0

CREATE EXTENSION btree_gist;
create index idx_gist_fee on appointments using gist (fee);
-- Tạo Clustered Index trên bảng appointments theo ngày khám
    create index idx_appointment_date on appointments (appointment_date);
-- Thực hiện các truy vấn trên View:
-- Tìm top 3 bệnh nhân có tổng phí khám cao nhất
    create view v_top3_fee
as
    select p.*, sum(a.fee)
        from patients p join appointments a on p.patient_id = a.patient_id
    group by p.patient_id
    order by sum(a.fee) desc limit 3;
-- Tính tổng số lượt khám theo bác sĩ
    create view v_total_appiontment_by_doctors
as
    select d.*,count(a.appointment_id) from doctors d join appointments a on d.doctor_id = a.doctor_id
group by d.doctor_id;
-- Tạo View có thể cập nhật để thay đổi city của bệnh nhân: // ko cho nếu join
-- Thử cập nhật thành phố của 1 bệnh nhân qua View và kiểm tra lại bảng patients // ko làm view vs join

select * from v_top3_fee;
select * from v_total_appiontment_by_doctors;



