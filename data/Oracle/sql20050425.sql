/*�˵��Զ��� label*/
INSERT INTO HtmlLabelIndex values(17721,'�˵��Զ���') 
/
INSERT INTO HtmlLabelInfo VALUES(17721,'�˵��Զ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17721,'custom menu',8) 
/

/*�������� label*/
INSERT INTO HtmlLabelIndex values(17722,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17722,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17722,'SysPhrase setting',8) 
/

/*Э�������� label*/
INSERT INTO HtmlLabelIndex values(17717,'Э��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17717,'Э��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17717,'Cowork set',8) 
/

/*Э�������� label*/
INSERT INTO HtmlLabelIndex values(17718,'Э��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17718,'Э��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17718,'Cowork Management',8) 
/

/*�ҵ�Э�� label*/
INSERT INTO HtmlLabelIndex values(17716,'�ҵ�Э��') 
/
INSERT INTO HtmlLabelInfo VALUES(17716,'�ҵ�Э��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17716,'My cowork',8) 
/

/*������ʷ label*/
INSERT INTO HtmlLabelIndex values(17713,'������ʷ') 
/
INSERT INTO HtmlLabelInfo VALUES(17713,'������ʷ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17713,'Sub History',8) 
/

/*������׼ label*/
INSERT INTO HtmlLabelIndex values(17714,'������׼') 
/
INSERT INTO HtmlLabelInfo VALUES(17714,'������׼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17714,'Sub Approve',8) 
/

/*�����ջ� label*/
INSERT INTO HtmlLabelIndex values(17715,'�����ջ�') 
/
INSERT INTO HtmlLabelInfo VALUES(17715,'�����ջ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17715,'Subscribe Reback',8) 
/

/*���̴��� label*/
INSERT INTO HtmlLabelIndex values(17723,'���̴���') 
/
INSERT INTO HtmlLabelInfo VALUES(17723,'���̴���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17723,'workflow agent',8) 
/

/*�Ϸ��ĸ����ĵ�Ҫ������ʧ ����(11)�ϲ�ѯ�������ĵ��˵���id ������SQL��mainmenuinfo�в��� �����ĵ���id �� 25 ���� MainMenuInfo �и����ĵ��˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 25
/

/*������Դ���Զ�����(˽����)ȥ�� ����(11)�ϲ�ѯ��˽����˵���id ������SQL��mainmenuinfo�в��� ˽�����id �� 53 ���� MainMenuInfo ��˽����˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 53
/

/*֪ʶ�ĵ����û��Զ���Ҳȥ�� ����(11)�ϲ�ѯ��֪ʶ�ĵ����û��Զ���˵���id ������SQL��mainmenuinfo�в��� ֪ʶ�ĵ����û��Զ����id �� 16 ���� MainMenuInfo ��֪ʶ�ĵ����û��Զ���˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 16
/

/*�������̵��û����塢�������á��Լ����̴���ȫ��ȥ��*/
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 124 or id = 126 or id = 127
/

/*���� Э�������� �˵�*/
call MMConfig_U_ByInfoInsert(11,7)
/
call MMInfo_Insert(359,17717,'','','mainFrame',11,1,7,0,'',0,'',0,'','',0,'','',10)
/

/*���� ������� �˵�*/
call MMConfig_U_ByInfoInsert(364,1)
/
call MMInfo_Insert( 360,16493,'','/cowork/type/CoworkMainType.jsp','mainFrame',359,2,1,0,'',0,'',0,'','',0,'','',10)
/

/*���� Э�������� �˵�*/
call MMConfig_U_ByInfoInsert(364,2)
/
call MMInfo_Insert( 361,17718,'','/cowork/type/CoworkType.jsp','mainFrame',359,2,2,0,'',0,'',0,'','',0,'','',10)
/

/*���˵� ���� �ͻ���ء��ͻ�����Excel����*/
call MMConfig_U_ByInfoInsert(5,9)
/
call MMInfo_Insert(362,17648,'','/system/systemmonitor/crm/CustomerMonitor.jsp','mainFrame',5,1,9,0,'',0,'',0,'','',0,'','',4)
/

call MMConfig_U_ByInfoInsert(5,10)
/
call MMInfo_Insert(363,17678,'','/CRM/CrmExcelToDB.jsp','mainFrame',5,1,10,0,'',0,'',0,'','',0,'','',4)
/

/*���˵����� Э���� һ���˵�*/
call LMConfig_U_ByInfoInsert(1,NULL,1)
/
call LMInfo_Insert(80,17694,NULL,NULL,1,NULL,1,10)
/

/*���˵� Э���� һ���˵� �� ���� �ҵ�Э�� ���ڲ˵� id ��ͳһ Ҫע��*/
call LMConfig_U_ByInfoInsert(2,80,0)
/
call LMInfo_Insert(81,17716,'/images_face/ecologyFace_1/LeftMenuIcon/WF_1.gif','/cowork/coworkview.jsp',2,80,0,9)
/

/*���˵� �ҵ�֪ʶ ���� �����ĵ�*/
call LMConfig_U_ByInfoInsert (2,2,3)
/
call LMInfo_Insert(82,17600,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_2.gif','/docs/docs/PersonalDocMain.jsp',2,2,3,9)
/

/*���˵� �ҵ�֪ʶ ���� ������ʷ*/
call LMConfig_U_ByInfoInsert (2,2,4)
/
call LMInfo_Insert(83,17713,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_3.gif','/docs/docsubscribe/DocSubscribeHistory.jsp',2,2,4,9)
/

/*���˵� �ҵ�֪ʶ ���� ������׼*/
call LMConfig_U_ByInfoInsert(2,2,5)
/
call LMInfo_Insert(84,17714,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_3.gif','/docs/docsubscribe/DocSubscribeApprove.jsp',2,2,5,9)
/

/*���˵� �ҵ�֪ʶ ���� �����ջ�*/
call LMConfig_U_ByInfoInsert(2,2,6)
/
call LMInfo_Insert(85,17715,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_3.gif','/docs/docsubscribe/DocSubscribeBack.jsp',2,2,6,9)
/

/*���˵� �ҵ�֪ʶ ȥ������֪ʶ ����(11)�ϲ�ѯ������֪ʶ�˵���id ������SQL��leftmenuinfo�в��� ����֪ʶ��id �� 18 ���� LeftMenuInfo �ж���֪ʶ�˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE LeftMenuInfo SET relatedModuleId = 11 WHERE id = 18
/

/*���˵� �ҵ����� ���� ���̴���*/
call LMConfig_U_ByInfoInsert(2,1,4)
/
call LMInfo_Insert(86,17723,'/images_face/ecologyFace_1/LeftMenuIcon/PLAN_3.gif','/workflow/workflow/WfAgentList.jsp',2,1,4,3)
/

/*�Ϸ��˵����������̵�����֪ʶ�ĵ�ǰ��*/
UPDATE MainMenuInfo set defaultIndex = 3 where id = 2
/
UPDATE MainMenuInfo set defaultIndex = 4 where id = 3
/
UPDATE MainMenuInfo set defaultIndex = 2 where id = 4
/

/*����˳�����Ϊ��
Э�������ҵ����̡��ҵ�֪ʶ���ҵ����¡��ҵĿͻ����ҵ���Ŀ���ҵ��ʲ���
�ҵĻ��顢�ҵļƻ����ҵı��桢�ҵ��ʼ����ҵĶ���*/
UPDATE LeftMenuInfo set defaultIndex = 4 where id = 5
/
UPDATE LeftMenuInfo set defaultIndex = 5 where id = 3
/
UPDATE LeftMenuInfo set defaultIndex = 6 where id = 4
/
UPDATE LeftMenuInfo set defaultIndex = 7 where id = 7
/

DROP TABLE LeftMenuConfig
/
drop sequence  LeftMenuConfig_id
/

CREATE TABLE LeftMenuConfig ( 
    id integer NOT NULL ,
    userId integer,
    infoId integer,
    visible char(1),
    viewIndex integer) 
/
create sequence LeftMenuConfig_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger LeftMenuConfig_Trigger
before insert on LeftMenuConfig
for each row
begin
select LeftMenuConfig_id.nextval into :new.id from dual;
end;
/

/*ִ�� LeftMenuConfig_Insert_All �Ĵ洢����*/
call LeftMenuConfig_Insert_All()
/

/*�Ϸ��Ĳ˵��ı�������˳�����Ϊ��
���̱���֪ʶ�������±������ʱ�����������±����±ߡ�
�ͻ�������Ŀ�������񱨱��ʲ������������ġ����鱨�����ű���͵�¼��־*/
UPDATE MainMenuInfo SET defaultIndex = 1 WHERE id = 203
/
UPDATE MainMenuInfo SET defaultIndex = 2 WHERE id = 207
/
UPDATE MainMenuInfo SET defaultIndex = 3 WHERE id = 200
/
UPDATE MainMenuInfo SET defaultIndex = 4 WHERE id = 204
/
UPDATE MainMenuInfo SET defaultIndex = 5 WHERE id = 202
/
UPDATE MainMenuInfo SET defaultIndex = 6 WHERE id = 205
/
UPDATE MainMenuInfo SET defaultIndex = 7 WHERE id = 206
/
UPDATE MainMenuInfo SET defaultIndex = 8 WHERE id = 209
/
UPDATE MainMenuInfo SET defaultIndex = 9 WHERE id = 208
/
UPDATE MainMenuInfo SET defaultIndex = 10 WHERE id = 210
/
UPDATE MainMenuInfo SET defaultIndex = 11 WHERE id = 211
/

UPDATE MainMenuInfo SET defaultParentId = 200 ,defaultIndex = 12 ,defaultLevel = 2 WHERE id = 201
/
UPDATE MainMenuInfo SET defaultLevel = 3 WHERE defaultparentid = 201
/

DROP TABLE MainMenuConfig 
/
drop sequence  MainMenuConfig_id
/
CREATE TABLE MainMenuConfig ( 
    id integer NOT NULL ,
    userId integer,
    infoId integer,
    visible char(1),
    parentId integer,
    viewIndex integer,
    menuLevel integer) 
/
create sequence MainMenuConfig_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger MainMenuConfig_Trigger
before insert on MainMenuConfig
for each row
begin
select MainMenuConfig_id.nextval into :new.id from dual;
end;
/

call MainMenuConfig_Insert_All()
/


