INSERT INTO HtmlLabelIndex values(18987,'��������') 
/
INSERT INTO HtmlLabelIndex values(18988,'����������') 
/
INSERT INTO HtmlLabelInfo VALUES(18987,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18987,'in',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18988,'����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18988,'not in',8) 
/

INSERT INTO HtmlLabelIndex values(17892,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(17892,'����',7) 
/
INSERT INTO HtmlLabelIndex values(19008,'����') 
/
INSERT INTO HtmlLabelIndex values(19009,'��') 
/
INSERT INTO HtmlLabelInfo VALUES(19008,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19008,'not in',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19009,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19009,'',8) 
/
INSERT INTO HtmlLabelIndex values(18805,'��') 
/
INSERT INTO HtmlLabelInfo VALUES(18805,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18805,'in',8) 
/

INSERT INTO HtmlLabelIndex values(19012,'��ͬһ������ȡ�ò����ߵ�ʱ�򣬿��Ը������õ�����ѡ���������ߣ���������������Ϊ���е������ֶκ�һЩ��ʼ��Ϣ(������,�����˾���,�����˱�����,�����˱��ֲ�)��') 
/
INSERT INTO HtmlLabelInfo VALUES(19012,'��ͬһ������ȡ�ò����ߵ�ʱ�򣬿��Ը������õ�����ѡ���������ߣ���������������Ϊ���е������ֶκ�һЩ��ʼ��Ϣ(������,�����˾���,�����˱�����,�����˱��ֲ�)��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19012,'Obtains operator''s time in the identical raid, may act according to the condition choice concrete operator which establishes, the establishment condition basis for form in all fields and some initial information (the founder,Founder manager,Founder this',8) 
/

INSERT INTO HtmlLabelIndex values(19013,'������������ѡ������ߵ�ִ��˳�򣬰����δ�С����ѡ��ͬһ���εĲ����ߣ���һ�������û�з������������������������һ���εĲ����ߣ������һ�����з������������ߣ�����������һ���Ρ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19013,'������������ѡ������ߵ�ִ��˳�򣬰����δ�С����ѡ��ͬһ���εĲ����ߣ���һ�������û�з������������������������һ���εĲ����ߣ������һ�����з������������ߣ�����������һ���Ρ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19013,'The raid is in the flow chooses the operator to carry out the order, chooses the identical raid of operator from infancy to maturity according to the raid, on a raid if has not conformed to the condition operator then continues the search next raid of ope',8) 
/


INSERT INTO HtmlLabelIndex values(19011,'�����͹鵵�ڵ㲻��Ҫ�������κ�������') 
/
INSERT INTO HtmlLabelInfo VALUES(19011,'�����͹鵵�ڵ㲻��Ҫ�������κ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19011,'the node of create or process is not set conditions and order��',8) 
/
alter table workflow_groupdetail add conditions varchar2(1000)
/
alter table workflow_groupdetail add conditioncn varchar2(1000)
/
alter table workflow_groupdetail add orders varchar2(5)
/
update  workflow_groupdetail set orders='0'
/

create or replace  PROCEDURE workflow_groupdetail_Insert 
(groupid_1 	integer, 
type_2 	integer, 
objid_3 	integer, 
level_4 	integer, 
level2_5 	integer,
conditions_6 varchar2,
conditioncn_7 varchar2,
orders_8 varchar2, 
flag out integer ,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor )
AS 
begin
INSERT INTO workflow_groupdetail ( groupid, type, objid, level_n, level2_n,conditions,conditioncn,orders)  VALUES ( groupid_1, type_2, objid_3, level_4, level2_5,conditions_6,conditioncn_7,orders_8);
end;
/