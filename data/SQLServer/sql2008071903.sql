CREATE TABLE workflow_track (
	id int IDENTITY (1, 1) NOT NULL ,	/*�޸���־�ֶ�id��������*/
	optKind varchar(20),	/*��־��������*/
	requestId int  NULL ,		/*�����Ӧ��ID*/
	nodeId int  NULL ,		/*�ڵ�����*/
	isBill int  NULL ,		/*�Ƿ��ǵ���:0:��	1:����*/
	fieldLableId int, 	/*�����õ�LEABLE*/
	fieldId int NULL ,			/*�޸��ֶζ�Ӧ��ID*/
	fieldHtmlType char (1) NULL,		/*�޸��ֶε��������*/
	fieldType varchar (40)  NULL ,		/*�޸��ֶε�����*/
	fieldNameCn varchar (100)  NULL ,	/*�޸��ֶε��������� Lable Name*/
	fieldNameEn varchar (100)  NULL ,	/*�޸��ֶε�Ӣ������ Lable Name*/
	fieldOldText varchar (8000)  NULL ,			/*�޸��ֶε�ԭ����*/
	fieldNewText varchar (8000)  NULL ,			/*�޸��ֶε�������*/
	modifierType int NULL ,			/*�޸�������*/
	agentId	int default '-1',
	modifierId int NULL ,			/*�޸��˶�Ӧ��ID*/
	modifierIP varchar (20)  NULL ,		/*�޸��˵�IP��ַ*/
	modifyTime varchar (20)  NULL		/*�޸���ʱ��*/
)
GO

CREATE TABLE workflow_trackdetail (
	id int IDENTITY (1, 1) NOT NULL ,	/*�޸���־��ϸ�ֶ�id��������*/
	sn int 	NULL,	/*�жϼ�¼�޸�ǰ��*/
	optKind varchar(20),	/*��־��������*/
	optType int  NULL ,		/*��������:1:����; 2:�޸�; 3:ɾ��*/
	requestId int  NULL ,		/*�����Ӧ��ID*/
	nodeId int  NULL ,		/*�ڵ�����*/
	isBill int  NULL ,		/*�Ƿ��ǵ���:0:��	1:����*/
	fieldLableId int, 	/*�����õ�LEABLE*/
	fieldGroupId int  NULL ,		/*��ϸ����Ӧ����*/
	fieldId int NULL ,			/*�޸��ֶζ�Ӧ��ID*/
	fieldHtmlType char (1) NULL,		/*�޸��ֶε��������*/
	fieldType varchar (40)  NULL ,		/*�޸��ֶε�����*/
	fieldNameCn varchar (100)  NULL ,	/*�޸��ֶε��������� Lable Name*/
	fieldNameEn varchar (100)  NULL ,	/*�޸��ֶε�Ӣ������ Lable Name*/
	fieldOldText varchar (8000)  NULL ,			/*�޸��ֶε�ԭ����*/
	fieldNewText varchar (8000)  NULL ,			/*�޸��ֶε�������*/
	modifierType int NULL ,			/*�޸�������*/
	agentId	int default '-1',
	modifierId int NULL ,			/*�޸��˶�Ӧ��ID*/
	modifierIP varchar (20)  NULL ,		/*�޸��˵�IP��ַ*/
	modifyTime varchar (20)  NULL		/*�޸���ʱ��*/
)
GO

alter table workflow_base add isModifyLog char(1) default '0'
GO

