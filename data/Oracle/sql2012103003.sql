create table mode_fieldtype(
	id integer,
	typename varchar(100),
	namelabel integer,
	classname varchar(200),
	ifdetailuse integer,
	orderid integer,
	status integer
)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(1, '单行文本框', 688, 'weaver.formmode.field.InputElement', 1, 4, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(2, '多行文本框', 689, 'weaver.formmode.field.TextareaElement', 1, 8, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(3, '浏览按钮', 695, 'weaver.formmode.field.ButtonElement', 1, 12, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(4, 'Check框', 691, 'weaver.formmode.field.CheckElement', 1, 16, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(5, '选择框', 690, 'weaver.formmode.field.SelectElement', 1, 20, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(6, '附件上传', 17616, 'weaver.formmode.field.FileElement', 0, 24, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(7, '特殊字段', 21691, 'weaver.formmode.field.EspecialElement', 0, 28, 1)
/

alter table modeinfo modify modedesc varchar2(1200)
/