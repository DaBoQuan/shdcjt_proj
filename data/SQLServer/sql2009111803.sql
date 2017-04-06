create table workflow_fieldtype(
	id int,
	typename varchar(100),
	namelabel int,
	classname varchar(200),
	ifdetailuse int,
	orderid int,
	status int
)
GO
delete from workflow_fieldtype
GO
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(1, '�����ı���', 688, 'weaver.workflow.field.InputElement', 1, 4, 1)
GO
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(2, '�����ı���', 689, 'weaver.workflow.field.TextareaElement', 1, 8, 1)
GO
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(3, '�����ť', 695, 'weaver.workflow.field.ButtonElement', 1, 12, 1)
GO
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(4, 'Check��', 691, 'weaver.workflow.field.CheckElement', 1, 16, 1)
GO
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(5, 'ѡ���', 690, 'weaver.workflow.field.SelectElement', 1, 20, 1)
GO
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(6, '�����ϴ�', 17616, 'weaver.workflow.field.FileElement', 0, 24, 1)
GO
insert into workflow_fieldtype(id, typename, namelabel, classname, ifdetailuse, orderid, status)
values(7, '�����ֶ�', 21691, 'weaver.workflow.field.EspecialElement', 0, 28, 1)
GO
delete from SysPubRef where masterCode='WorkflowShowModeType'
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) values ('WorkflowShowModeType', '������ʾģʽ', 0, '��ͨģʽ', 18016, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) values ('WorkflowShowModeType', '������ʾģʽ', 1, 'ģ��ģʽ', 18017, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) values ('WorkflowShowModeType', '������ʾģʽ', 2, 'Htmlģʽ', 23682, 1)
GO

create table workflow_flownodehtml(
	workflowid int,
	nodeid int,
	colsperrow int
)
GO
create table workflow_nodehtmllayout(
	id int IDENTITY,
	workflowid int,
	formid int,
	isbill int,
	nodeid int,
	type int,
	layoutname varchar(200),
	syspath varchar(1000)
)
GO

create table workflow_nodefieldattr(
	id int IDENTITY,
	fieldid int,
	formid int,
	isbill int,
	nodeid int,
	attrcontent varchar(4000)
)
GO

alter table workflow_nodeform add orderid decimal(10,2) null
GO

update n set n.orderid=f.fieldorder from workflow_nodeform n, workflow_formfield f where n.fieldid=f.fieldid and n.nodeid in (select fn.nodeid from workflow_flownode fn left join workflow_base b on b.id=fn.workflowid where b.isbill<>'1')
GO
update n set n.orderid=f.dsporder from workflow_nodeform n, workflow_billfield f where n.fieldid=f.id and n.nodeid in (select fn.nodeid from workflow_flownode fn left join workflow_base b on b.id=fn.workflowid where b.isbill='1')
GO
update workflow_nodeform set orderid=0 where fieldid<0
GO

insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 6, '���˼ƻ�', 786, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 7, '���ñ�����', 788, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 11, '�Ӱ�����', 849, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 13, '�������', 862, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 14, '�ʲ��깺��', 872, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 15, '�ʲ�����', 878, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 17, 'һ�ܹ��������', 875, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 18, '�ʲ�����', 883, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 19, '�ʲ�����', 886, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 21, '�¹����ܽ���ƻ�', 6167, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 22, '¼��֪ͨ��', 890, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 23, '��ְ֪ͨ��', 891, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 28, '������ת��', 1004, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 29, '��������', 1020, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 38, '���۽���', 6009, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 39, '��������', 6150, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 40, 'ְλ����', 6110, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 41, '��ְ����', 6119, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 42, 'ת������', 6121, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 45, '�Ӱ�', 6151, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 46, '���', 670, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 47, '�ù�����', 6131, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 48, '��ѵ����', 6155, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 49, 'ҵ���ͬ', 6160, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 50, '������ٵ�', 16676, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 66, '�շ�����ת��', 16974, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 67, 'ϵͳ�ڲ�������ת��', 17005, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 68, '����ע��', 17059, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 74, '��Ŀ��������', 17159, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 79, '�ͻ�������ת��', 17180, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 85, '����������', 17219, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 145, 'Ŀ�꼨Ч�ƻ�����', 18197, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 146, 'Ŀ�꼨ЧĿ������', 18198, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 147, 'Ŀ�꼨Ч��������', 18199, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 152, '��Ŀģ��������', 18396, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 154, 'Ԥ��������ת��', 18432, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 156, '�������뵥', 18591, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 157, '������뵥', 18520, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 158, '�������뵥', 18670, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 159, 'Ԥ�������뵥', 18747, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 161, '�Ӱ����뵥��', 18832, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 162, '��ٵ���', 18855, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 163, '�ó�������������', 19047, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 180, '����������ٵ���', 20063, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 192, '�ͻ���ϵ��������ת��', 20868, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 201, '�ʲ����ϵ���', 21541, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 220, '�ʲ�����', 6051, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 221, '�ʲ�����', 6054, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 222, '�ʲ�����', 22459, 1)
GO
insert into SysPubRef (masterCode,masterName,detailCode,detailName,detailLabel,flag) 
values ('SpecialBillID', '��֧����ģʽ�ĵ���ID', 224, '�ʲ��黹', 15305, 1)
GO
