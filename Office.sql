
create or replace type office_T as object 
(bld_id varchar2(10),
off_no varchar2(10),
off_phone varchar2(12),
member procedure show_office)
/
create table office of office_T 
(bld_id not null,
off_no not null,
primary key(bld_id, off_no),
foreign key(bld_id) references 
build(bld_id))
cluster build_cluster(bld_id);

create or replace type body office_T as
member procedure show_office is
cursor c_office is
select c.pers_name, b.off_no, b.off_phone
from build bb, office oo, person pp, staff ss
where bb.bld_id = self.bld_id and bb.bld_id =
oo.bld_id
and pp.pers_id = ss.pers_id and ss.in_office = ref
(oo);
begin
dbms_output.put_line
(‘name’||’ ‘||’office no’||’ ‘||‘office
phone’);

for v_office in c_office loop
dbms_output.put_line
(v_office.pers_name||’ ‘||
v_office.off_no||’ ‘||
v_office.off_phone);
end loop;
end show_office;
end;
/
