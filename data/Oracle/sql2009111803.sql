create table workflow_fieldtype(
	id integer,
	typename varchar(100),
	namelabel integer,
	classname varchar(200),
	ifdetailuse integer,
	orderid integer,
	status integer
)
/
delete from workflow_fieldtype
/
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(1, '�����ı���', 688, 'weaver.workflow.field.InputElement', 1, 4, 1)
/
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(2, '�����ı���', 689, 'weaver.workflow.field.TextareaElement', 1, 8, 1)
/
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(3, '�����ť', 695, 'weaver.workflow.field.ButtonElement', 1, 12, 1)
/
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(4, 'Check��', 691, 'weaver.workflow.field.CheckElement', 1, 16, 1)
/
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(5, 'ѡ���', 690, 'weaver.workflow.field.SelectElement', 1, 20, 1)
/
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(6, '�����ϴ�', 17616, 'weaver.workflow.field.FileElement', 0, 24, 1)
/
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(7, '�����ֶ�', 21691, 'weaver.workflow.field.EspecialElement', 0, 28, 1)
/
delete from SysPubRef where masterCode='WorkflowShowModeType'
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) values ('WorkflowShowModeType', '������ʾģʽ', 0, '��ͨģʽ', 18016, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) values ('WorkflowShowModeType', '������ʾģʽ', 1, 'ģ��ģʽ', 18017, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) values ('WorkflowShowModeType', '������ʾģʽ', 2, 'Htmlģʽ', 23682, 1)
/

create table workflow_flownodehtml(
	workflowid integer,
	nodeid integer,
	colsperrow integer
)
/
create table workflow_nodehtmllayout(
	id integer,
	workflowid integer,
	formid integer,
	isbill integer,
	nodeid integer,
	type integer,
	layoutname varchar(200),
	syspath varchar(1000)
)
/

create sequence wf_nodehtmllayout_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger wf_nodehtmllayout_id_Tri
before insert on workflow_nodehtmllayout
for each row
begin
select wf_nodehtmllayout_id.nextval into :new.id from dual;
end;
/

create table workflow_nodefieldattr(
	id integer,
	fieldid integer,
	formid integer,
	isbill integer,
	nodeid integer,
	attrcontent varchar(4000)
)
/

create sequence wf_nodefieldattr_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger wf_nodefieldattr_id_Tri
before insert on workflow_nodefieldattr
for each row
begin
select wf_nodefieldattr_id.nextval into :new.id from dual;
end;
/

alter table workflow_nodeform add orderid number(10,2) null
/

update workflow_nodeform n
set n.orderid=(select f.fieldorder from workflow_formfield f where n.fieldid=f.fieldid and f.formid = (select b.formid from workflow_flownode fn left join workflow_base b on b.id=fn.workflowid where fn.nodeid=n.nodeid and b.isbill<>'1'))
/

update workflow_nodeform n
set n.orderid=(select f.dsporder from workflow_billfield f where n.fieldid=f.id and f.billid = (select b.formid from workflow_flownode fn left join workflow_base b on b.id=fn.workflowid where fn.nodeid=n.nodeid and b.isbill<>'1'))
/

update workflow_nodeform set orderid=0 where fieldid<0
/

insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 6, '���˼ƻ�', 786, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 7, '���ñ�����', 788, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 11, '�Ӱ�����', 849, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 13, '�������', 862, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 14, '�ʲ��깺��', 872, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 15, '�ʲ�����', 878, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 17, 'һ�ܹ��������', 875, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 18, '�ʲ�����', 883, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 19, '�ʲ�����', 886, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 21, '�¹����ܽ���ƻ�', 6167, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 22, '¼��֪ͨ��', 890, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 23, '��ְ֪ͨ��', 891, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 28, '������ת��', 1004, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 29, '��������', 1020, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 38, '���۽���', 6009, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 39, '��������', 6150, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 40, 'ְλ����', 6110, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 41, '��ְ����', 6119, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 42, 'ת������', 6121, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 45, '�Ӱ�', 6151, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 46, '���', 670, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 47, '�ù�����', 6131, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 48, '��ѵ����', 6155, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 49, 'ҵ���ͬ', 6160, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 50, '������ٵ�', 16676, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 66, '�շ�����ת��', 16974, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 67, 'ϵͳ�ڲ�������ת��', 17005, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 68, '����ע��', 17059, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 74, '��Ŀ��������', 17159, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 79, '�ͻ�������ת��', 17180, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 85, '����������', 17219, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 145, 'Ŀ�꼨Ч�ƻ�����', 18197, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 146, 'Ŀ�꼨ЧĿ������', 18198, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 147, 'Ŀ�꼨Ч��������', 18199, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 152, '��Ŀģ��������', 18396, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 154, 'Ԥ��������ת��', 18432, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 156, '�������뵥', 18591, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 157, '������뵥', 18520, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 158, '�������뵥', 18670, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 159, 'Ԥ�������뵥', 18747, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 161, '�Ӱ����뵥��', 18832, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 162, '��ٵ���', 18855, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 163, '�ó�������������', 19047, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 180, '����������ٵ���', 20063, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 192, '�ͻ���ϵ��������ת��', 20868, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 201, '�ʲ����ϵ���', 21541, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 220, '�ʲ�����', 6051, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 221, '�ʲ�����', 6054, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 222, '�ʲ�����', 22459, 1)
/
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 224, '�ʲ��黹', 15305, 1)
/
