INSERT INTO HtmlLabelIndex values(18987,'��������') 
GO
INSERT INTO HtmlLabelIndex values(18988,'����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(18987,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18987,'in',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18988,'����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18988,'not in',8) 
GO

INSERT INTO HtmlLabelIndex values(17892,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17892,'����',7) 
GO
INSERT INTO HtmlLabelIndex values(19008,'����') 
GO
INSERT INTO HtmlLabelIndex values(19009,'��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19008,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19008,'not in',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19009,'��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19009,'',8) 
GO
INSERT INTO HtmlLabelIndex values(18805,'��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18805,'��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18805,'in',8) 
GO

INSERT INTO HtmlLabelIndex values(19012,'��ͬһ������ȡ�ò����ߵ�ʱ�򣬿��Ը������õ�����ѡ���������ߣ���������������Ϊ���е������ֶκ�һЩ��ʼ��Ϣ(������,�����˾���,�����˱�����,�����˱��ֲ�)��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19012,'��ͬһ������ȡ�ò����ߵ�ʱ�򣬿��Ը������õ�����ѡ���������ߣ���������������Ϊ���е������ֶκ�һЩ��ʼ��Ϣ(������,�����˾���,�����˱�����,�����˱��ֲ�)��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19012,'Obtains operator''s time in the identical raid, may act according to the condition choice concrete operator which establishes, the establishment condition basis for form in all fields and some initial information (the founder,Founder manager,Founder this',8) 
GO

INSERT INTO HtmlLabelIndex values(19013,'������������ѡ������ߵ�ִ��˳�򣬰����δ�С����ѡ��ͬһ���εĲ����ߣ���һ�������û�з������������������������һ���εĲ����ߣ������һ�����з������������ߣ�����������һ���Ρ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19013,'������������ѡ������ߵ�ִ��˳�򣬰����δ�С����ѡ��ͬһ���εĲ����ߣ���һ�������û�з������������������������һ���εĲ����ߣ������һ�����з������������ߣ�����������һ���Ρ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19013,'The raid is in the flow chooses the operator to carry out the order, chooses the identical raid of operator from infancy to maturity according to the raid, on a raid if has not conformed to the condition operator then continues the search next raid of ope',8) 
GO


INSERT INTO HtmlLabelIndex values(19011,'�����͹鵵�ڵ㲻��Ҫ�������κ�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19011,'�����͹鵵�ڵ㲻��Ҫ�������κ�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19011,'the node of create or process is not set conditions and order��',8) 
GO
alter table workflow_groupdetail add 
conditions varchar(1000),
conditioncn varchar(1000),
orders varchar(5)
Go

update  workflow_groupdetail set orders='0'
Go

alter  PROCEDURE workflow_groupdetail_Insert 
(@groupid_1 	int, 
@type_2 	int, 
@objid_3 	int, 
@level_4 	int, 
@level2_5 	int,
@conditions varchar(1000),
@conditioncn varchar(1000),
@orders varchar(5), 
@flag integer output , 
@msg varchar(80) output ) 
AS 
INSERT INTO workflow_groupdetail ( groupid, type, objid, level_n, level2_n,conditions,conditioncn,orders)  VALUES ( @groupid_1, @type_2, @objid_3, @level_4, @level2_5,@conditions,@conditioncn,@orders) 
set @flag = 0 set @msg = 'ok' 
go

