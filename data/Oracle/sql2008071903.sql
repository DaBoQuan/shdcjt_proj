CREATE TABLE workflow_track (
	id number NOT NULL ,	/*�޸���־�ֶ�id��������*/
	optKind varchar2(20),	/*��־��������*/
	requestId number  NULL ,		/*�����Ӧ��ID*/
	nodeId number  NULL ,		/*�ڵ�����*/
	isBill number  NULL ,		/*�Ƿ��ǵ���:0:��	1:����*/
	fieldLableId number, 	/*�����õ�LEABLE*/
	fieldId number NULL ,			/*�޸��ֶζ�Ӧ��ID*/
	fieldHtmlType char (1) NULL,		/*�޸��ֶε��������*/
	fieldType varchar2(40)  NULL ,		/*�޸��ֶε�����*/
	fieldNameCn varchar2(100)  NULL ,	/*�޸��ֶε��������� Lable Name*/
	fieldNameEn varchar2(100)  NULL ,	/*�޸��ֶε�Ӣ������ Lable Name*/
	fieldOldText varchar2(4000)  NULL ,			/*�޸��ֶε�ԭ����*/
	fieldNewText varchar2(4000)  NULL ,			/*�޸��ֶε�������*/
	modifierType number NULL ,			/*�޸�������*/
	agentId	int default '-1',
	modifierId number NULL ,			/*�޸��˶�Ӧ��ID*/
	modifierIP varchar2(20)  NULL ,		/*�޸��˵�IP��ַ*/
	modifyTime varchar2(20)  NULL		/*�޸���ʱ��*/
)
/
create sequence Workflow_track_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger Workflow_track_Tri
before insert on Workflow_track
for each row
begin
select Workflow_track_id.nextval into :new.id from dual;
end;
/

CREATE TABLE workflow_trackdetail (
	id number NOT NULL ,	/*�޸���־��ϸ�ֶ�id��������*/
	sn number 	NULL,	/*�жϼ�¼�޸�ǰ��*/
	optKind varchar2(20),	/*��־��������*/
	optType number  NULL ,		/*��������:1:����; 2:�޸�; 3:ɾ��*/
	requestId number  NULL ,		/*�����Ӧ��ID*/
	nodeId number  NULL ,		/*�ڵ�����*/
	isBill number  NULL ,		/*�Ƿ��ǵ���:0:��	1:����*/
	fieldLableId number, 	/*�����õ�LEABLE*/
	fieldGroupId number  NULL ,		/*��ϸ����Ӧ����*/
	fieldId number NULL ,			/*�޸��ֶζ�Ӧ��ID*/
	fieldHtmlType char (1) NULL,		/*�޸��ֶε��������*/
	fieldType varchar2(40)  NULL ,		/*�޸��ֶε�����*/
	fieldNameCn varchar2(100)  NULL ,	/*�޸��ֶε��������� Lable Name*/
	fieldNameEn varchar2(100)  NULL ,	/*�޸��ֶε�Ӣ������ Lable Name*/
	fieldOldText varchar2(4000)  NULL ,			/*�޸��ֶε�ԭ����*/
	fieldNewText varchar2(4000)  NULL ,			/*�޸��ֶε�������*/
	modifierType number NULL ,			/*�޸�������*/
	agentId	int default '-1',
	modifierId number NULL ,			/*�޸��˶�Ӧ��ID*/
	modifierIP varchar2(20)  NULL ,		/*�޸��˵�IP��ַ*/
	modifyTime varchar2(20)  NULL		/*�޸���ʱ��*/
)
/
create sequence Workflow_trackdetail_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger Workflow_trackdetail_Tri
before insert on Workflow_trackdetail
for each row
begin
select Workflow_trackdetail_id.nextval into :new.id from dual;
end;
/

alter table workflow_base add isModifyLog char(1) default '0'
/