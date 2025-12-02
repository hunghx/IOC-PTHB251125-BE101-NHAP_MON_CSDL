CREATE TABLE Employee (
                          id SERIAL PRIMARY KEY,
                          full_name VARCHAR(50) NOT NULL,
                          department VARCHAR(30),
                          position VARCHAR(30),
                          salary INT,
                          bonus INT,
                          join_year INT
);

INSERT INTO Employee (full_name, department, position, salary, bonus, join_year) VALUES
                                                                                     ('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
                                                                                     ('Trần Thị Mai', 'HR', 'Recruiter', 12000000, NULL, 2020),
                                                                                     ('Lê Quốc Trung', 'IT', 'Tester', 15000000, 800000, 2023),
                                                                                     ('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
                                                                                     ('Phạm Ngọc Hân', 'Finance', 'Accountant', 14000000, NULL, 2019),
                                                                                     ('Bùi Thị Lan', 'HR', 'HR Manager', 20000000, 3000000, 2018),
                                                                                     ('Đặng Hữu Tài', 'IT', 'Developer', 17000000, NULL, 2022);


-- Lấy tất cả nhân viên có số lượng bản ghi trung  = 2
-- DELETE From Employee
-- where id in (SELECT id from Employee
--             where full_name = (SELECT full_name
--                                From Employee
--                                GROUP BY full_name,department,position
--                                HAVING  count(id) >=2)
--             limit 1)
-- ;