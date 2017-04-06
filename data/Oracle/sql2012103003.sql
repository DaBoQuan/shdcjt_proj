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
values(1, '�����ı���', 688, 'weaver.formmode.field.InputElement', 1, 4, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(2, '�����ı���', 689, 'weaver.formmode.field.TextareaElement', 1, 8, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(3, '�����ť', 695, 'weaver.formmode.field.ButtonElement', 1, 12, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(4, 'Check��', 691, 'weaver.formmode.field.CheckElement', 1, 16, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(5, 'ѡ���', 690, 'weaver.formmode.field.SelectElement', 1, 20, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(6, '�����ϴ�', 17616, 'weaver.formmode.field.FileElement', 0, 24, 1)
/
insert into mode_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(7, '�����ֶ�', 21691, 'weaver.formmode.field.EspecialElement', 0, 28, 1)
/

alter table modeinfo modify modedesc varchar2(1200)
/