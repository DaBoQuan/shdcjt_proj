/*�˵��Զ��� label*/
INSERT INTO HtmlLabelIndex values(17721,'�˵��Զ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(17721,'�˵��Զ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17721,'custom menu',8) 
GO

/*�������� label*/
INSERT INTO HtmlLabelIndex values(17722,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17722,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17722,'SysPhrase setting',8) 
GO

/*Э�������� label*/
INSERT INTO HtmlLabelIndex values(17717,'Э��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17717,'Э��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17717,'Cowork set',8) 
GO

/*Э�������� label*/
INSERT INTO HtmlLabelIndex values(17718,'Э��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17718,'Э��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17718,'Cowork Management',8) 
GO

/*�ҵ�Э�� label*/
INSERT INTO HtmlLabelIndex values(17716,'�ҵ�Э��') 
GO
INSERT INTO HtmlLabelInfo VALUES(17716,'�ҵ�Э��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17716,'My cowork',8) 
GO

/*������ʷ label*/
INSERT INTO HtmlLabelIndex values(17713,'������ʷ') 
GO
INSERT INTO HtmlLabelInfo VALUES(17713,'������ʷ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17713,'Sub History',8) 
GO

/*������׼ label*/
INSERT INTO HtmlLabelIndex values(17714,'������׼') 
GO
INSERT INTO HtmlLabelInfo VALUES(17714,'������׼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17714,'Sub Approve',8) 
GO

/*�����ջ� label*/
INSERT INTO HtmlLabelIndex values(17715,'�����ջ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17715,'�����ջ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17715,'Subscribe Reback',8) 
GO

/*���̴��� label*/
INSERT INTO HtmlLabelIndex values(17723,'���̴���') 
GO
INSERT INTO HtmlLabelInfo VALUES(17723,'���̴���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17723,'workflow agent',8) 
GO

/*�Ϸ��ĸ����ĵ�Ҫ������ʧ ����(11)�ϲ�ѯ�������ĵ��˵���id ������SQL��mainmenuinfo�в��� �����ĵ���id �� 25 ���� MainMenuInfo �и����ĵ��˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 25
GO

/*������Դ���Զ�����(˽����)ȥ�� ����(11)�ϲ�ѯ��˽����˵���id ������SQL��mainmenuinfo�в��� ˽�����id �� 53 ���� MainMenuInfo ��˽����˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 53
GO

/*֪ʶ�ĵ����û��Զ���Ҳȥ�� ����(11)�ϲ�ѯ��֪ʶ�ĵ����û��Զ���˵���id ������SQL��mainmenuinfo�в��� ֪ʶ�ĵ����û��Զ����id �� 16 ���� MainMenuInfo ��֪ʶ�ĵ����û��Զ���˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 16
GO

/*�������̵��û����塢�������á��Լ����̴���ȫ��ȥ��*/
UPDATE MainMenuInfo SET relatedModuleId = 11 WHERE id = 124 or id = 126 or id = 127
GO

/*���� Э�������� �˵�*/
EXECUTE MainMenuConfig_U_ByInfoInsert 11,7,'',''
GO
EXECUTE MainMenuInfo_Insert 359,17717,'','','mainFrame',11,1,7,0,'',0,'',0,'','',0,'','',10,'',''
GO

/*���� ������� �˵�*/
EXECUTE MainMenuConfig_U_ByInfoInsert 364,1,'',''
GO
EXECUTE MainMenuInfo_Insert 360,16493,'','/cowork/type/CoworkMainType.jsp','mainFrame',359,2,1,0,'',0,'',0,'','',0,'','',10,'',''
GO

/*���� Э�������� �˵�*/
EXECUTE MainMenuConfig_U_ByInfoInsert 364,2,'',''
GO
EXECUTE MainMenuInfo_Insert 361,17718,'','/cowork/type/CoworkType.jsp','mainFrame',359,2,2,0,'',0,'',0,'','',0,'','',10,'',''
GO

/*���˵����� Э���� һ���˵�*/
EXECUTE LeftMenuConfig_U_ByInfoInsert 1,NULL,1,'',''
GO
EXECUTE LeftMenuInfo_Insert 80,17694,NULL,NULL,1,NULL,1,10,'',''
GO

/*���˵� Э���� һ���˵� �� ���� �ҵ�Э�� ���ڲ˵� id ��ͳһ Ҫע��*/
EXECUTE LeftMenuConfig_U_ByInfoInsert 2,80,0,'',''
GO
EXECUTE LeftMenuInfo_Insert 81,17716,'/images_face/ecologyFace_1/LeftMenuIcon/WF_1.gif','/cowork/coworkview.jsp',2,80,0,9,'', '' 
GO

/*���˵� �ҵ�֪ʶ ���� �����ĵ�*/
EXECUTE LeftMenuConfig_U_ByInfoInsert 2,2,3,'',''
GO
EXECUTE LeftMenuInfo_Insert 82,17600,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_2.gif','/docs/docs/PersonalDocMain.jsp',2,2,3,9,'', '' 
GO

/*���˵� �ҵ�֪ʶ ���� ������ʷ*/
EXECUTE LeftMenuConfig_U_ByInfoInsert 2,2,4,'',''
GO
EXECUTE LeftMenuInfo_Insert 83,17713,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_3.gif','/docs/docsubscribe/DocSubscribeHistory.jsp',2,2,4,9,'', '' 
GO

/*���˵� �ҵ�֪ʶ ���� ������׼*/
EXECUTE LeftMenuConfig_U_ByInfoInsert 2,2,5,'',''
GO
EXECUTE LeftMenuInfo_Insert 84,17714,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_3.gif','/docs/docsubscribe/DocSubscribeApprove.jsp',2,2,5,9,'', '' 
GO

/*���˵� �ҵ�֪ʶ ���� �����ջ�*/
EXECUTE LeftMenuConfig_U_ByInfoInsert 2,2,6,'',''
GO
EXECUTE LeftMenuInfo_Insert 85,17715,'/images_face/ecologyFace_1/LeftMenuIcon/DOC_3.gif','/docs/docsubscribe/DocSubscribeBack.jsp',2,2,6,9,'', '' 
GO

/*���˵� �ҵ�֪ʶ ȥ������֪ʶ ����(11)�ϲ�ѯ������֪ʶ�˵���id ������SQL��leftmenuinfo�в��� ����֪ʶ��id �� 18 ���� LeftMenuInfo �ж���֪ʶ�˵�������ģ��id �ǲ�����ģ���id 11 */
UPDATE LeftMenuInfo SET relatedModuleId = 11 WHERE id = 18
GO

/*���˵� �ҵ����� ���� ���̴���*/
EXECUTE LeftMenuConfig_U_ByInfoInsert 2,1,4,'',''
GO
EXECUTE LeftMenuInfo_Insert 86,17723,'/images_face/ecologyFace_1/LeftMenuIcon/PLAN_3.gif','/workflow/workflow/WfAgentList.jsp',2,1,4,3,'', '' 
GO

/*�Ϸ��˵����������̵�����֪ʶ�ĵ�ǰ��*/
UPDATE MainMenuInfo set defaultIndex = 3 where id = 2
GO
UPDATE MainMenuInfo set defaultIndex = 4 where id = 3
GO
UPDATE MainMenuInfo set defaultIndex = 2 where id = 4
GO

/*����˳�����Ϊ��
Э�������ҵ����̡��ҵ�֪ʶ���ҵ����¡��ҵĿͻ����ҵ���Ŀ���ҵ��ʲ���
�ҵĻ��顢�ҵļƻ����ҵı��桢�ҵ��ʼ����ҵĶ���*/
UPDATE LeftMenuInfo set defaultIndex = 4 where id = 5
GO
UPDATE LeftMenuInfo set defaultIndex = 5 where id = 3
GO
UPDATE LeftMenuInfo set defaultIndex = 6 where id = 4
GO
UPDATE LeftMenuInfo set defaultIndex = 7 where id = 7
GO
DROP TABLE LeftMenuConfig
GO
CREATE TABLE LeftMenuConfig ( 
    id int NOT NULL IDENTITY (1, 1),
    userId int,
    infoId int,
    visible char(1),
    viewIndex int) 
GO

/*ִ�� LeftMenuConfig_Insert_All �Ĵ洢����*/
EXEC LeftMenuConfig_Insert_All '',''

GO

/*�Ϸ��Ĳ˵��ı�������˳�����Ϊ��
���̱���֪ʶ�������±������ʱ�����������±����±ߡ�
�ͻ�������Ŀ�������񱨱��ʲ������������ġ����鱨�����ű���͵�¼��־*/
UPDATE MainMenuInfo SET defaultIndex = 1 WHERE id = 203
GO
UPDATE MainMenuInfo SET defaultIndex = 2 WHERE id = 207
GO
UPDATE MainMenuInfo SET defaultIndex = 3 WHERE id = 200
GO
UPDATE MainMenuInfo SET defaultIndex = 4 WHERE id = 204
GO
UPDATE MainMenuInfo SET defaultIndex = 5 WHERE id = 202
GO
UPDATE MainMenuInfo SET defaultIndex = 6 WHERE id = 205
GO
UPDATE MainMenuInfo SET defaultIndex = 7 WHERE id = 206
GO
UPDATE MainMenuInfo SET defaultIndex = 8 WHERE id = 209
GO
UPDATE MainMenuInfo SET defaultIndex = 9 WHERE id = 208
GO
UPDATE MainMenuInfo SET defaultIndex = 10 WHERE id = 210
GO
UPDATE MainMenuInfo SET defaultIndex = 11 WHERE id = 211
GO

UPDATE MainMenuInfo SET defaultParentId = 200 ,defaultIndex = 12 ,defaultLevel = 2 WHERE id = 201
GO
UPDATE MainMenuInfo SET defaultLevel = 3 WHERE defaultparentid = 201
GO

DROP TABLE MainMenuConfig 
GO

CREATE TABLE MainMenuConfig ( 
    id int NOT NULL IDENTITY (1, 1),
    userId int,
    infoId int,
    visible char(1),
    parentId int,
    viewIndex int,
    menuLevel int) 
GO

EXEC MainMenuConfig_Insert_All

GO

/*���˵� ���� �ͻ���ء��ͻ�����Excel����*/
EXECUTE MainMenuConfig_U_ByInfoInsert 5,9,'',''
GO
EXECUTE MainMenuInfo_Insert 362,17648,'','/system/systemmonitor/crm/CustomerMonitor.jsp','mainFrame',5,1,9,0,'',0,'',0,'','',0,'','',4,'',''
GO

EXECUTE MainMenuConfig_U_ByInfoInsert 5,10,'',''
GO
EXECUTE MainMenuInfo_Insert 363,17678,'','/CRM/CrmExcelToDB.jsp','mainFrame',5,1,10,0,'',0,'',0,'','',0,'','',4,'',''
GO
