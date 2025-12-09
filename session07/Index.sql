-- Chỉ mục :

-- B-TREE :
create index idx_pro_name on product(name);
-- Hash table
create index idx_hash_quantity on orderdetail using hash (quantity);

-- Xóa chỉ mục
drop index idx_pro_name;
