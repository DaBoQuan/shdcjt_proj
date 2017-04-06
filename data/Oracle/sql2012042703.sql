alter table workflow_nodefieldattr add transtype integer null
/

alter table workflow_crmcssfile add type integer
/
alter table workflow_crmcssfile add detailid integer
/

update workflow_crmcssfile set type=1
/

create table workflow_cssdetail(
	detailid integer,
	outerbordercolor varchar2(10),
	outerbordersize integer,
	requestnamesize integer,
	requestnamecolor varchar2(10),
	requestnamefont varchar2(20),
	requestnamestyle0 integer,
	requestnamestyle1 integer,
	maintablecolor varchar2(10),
	maintablesize integer,
	mainfieldsize integer,
	mainfieldcolor varchar2(10),
	mainfieldnamecolor varchar2(10),
	mainfieldvaluecolor varchar2(10),
	mainfieldheight integer,
	detailtablecolor varchar2(10),
	detailtablesize integer,
	detailfieldheight integer,
	detailfieldsize integer,
	detailfieldcolor varchar2(10),
	detailfieldnamecolor varchar2(10),
	detailfieldvaluecolor varchar2(10)
)
/

create sequence workflowcssdetail_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger workflowcssdetail_id_Tri
before insert on workflow_cssdetail
for each row
begin
select workflowcssdetail_id.nextval into :new.id from dual;
end;
/

insert into workflow_crmcssfile(cssname, realfilename, realpath, type, detailid)
values
('���̷��', 'lanlv.css', '/css/crmcss/lanlv.css', 2, 0)
/

insert into workflow_crmcssfile(cssname, realfilename, realpath, type, detailid)
values
('���ķ��', 'gongwen.css', '/css/crmcss/gongwen.css', 2, 0)
/

insert into workflow_crmcssfile(cssname, realfilename, realpath, type, detailid)
values
('�����ɫ���', 'huise.css', '/css/crmcss/huise.css', 2, 0)
/

create table workflow_fieldtrans(
	id integer,
	typename varchar2(100),
	classname varchar2(200)
)
/

insert into workflow_fieldtrans(id, typename, classname)
values
(1, '���ת��', 'weaver.workflow.html.MoneyTrans4FieldTrans')
/

insert into workflow_fieldtrans(id, typename, classname)
values
(2, '���ǧ��λ', 'weaver.workflow.html.MoneySpilt4FieldTrans')
/