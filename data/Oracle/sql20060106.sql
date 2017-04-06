/*��ģ��*/
CREATE TABLE workflow_formmode ( 
    id integer not null ,	/*������ID*/
    formid integer,	/*��id*/
    isbill varchar2(1),	/*�Ƿ�Ϊ����*/
    isprint varchar2(1),	/*�Ƿ��ӡģ��*/
    modename varchar2(200),/*ģ������*/
    modedesc clob	/*ģ������*/)

/
create sequence workflow_formmode_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger workflow_formmode_Trigger
before insert on workflow_formmode
for each row
begin
select workflow_formmode_id.nextval into :new.id from dual;
end;
/

/*�ڵ�ģ��*/
CREATE TABLE workflow_nodemode ( 
    id integer not null ,	/*������ID*/
    workflowid integer,/*������id*/
    formid integer,/*��id*/
    nodeid integer,	/*�ڵ�id*/
    isprint varchar2(1),	/*�Ƿ��ӡģ��*/
    modename varchar2(200),/*ģ������*/
    modedesc  clob		/*ģ������*/
)
/
create sequence workflow_nodemode_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger workflow_nodemode_Trigger
before insert on workflow_nodemode
for each row
begin
select workflow_nodemode_id.nextval into :new.id from dual;
end;
/
/*��ʾ����*/
alter table workflow_flownode add ismode varchar2(1)
/
/*��������ʾģ��*/
alter table workflow_flownode add showdes varchar2(1)
/
/*�����ô�ӡģ��*/
alter table workflow_flownode add printdes varchar2(1)
/

INSERT INTO HtmlLabelIndex values(18016,'��ͨģʽ') 
/
INSERT INTO HtmlLabelIndex values(18017,'ģ��ģʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(18016,'��ͨģʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18016,'generic mode',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18017,'ģ��ģʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18017,'templet mode',8) 
/
INSERT INTO HtmlLabelIndex values(18018,'�ɱ༭') 
/
INSERT INTO HtmlLabelIndex values(18019,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18018,'�ɱ༭',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18018,'can be edited',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18019,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18019,'must input',8) 
/
INSERT INTO HtmlLabelIndex values(18020,'�����ֶ�') 
/
INSERT INTO HtmlLabelIndex values(18021,'��ϸ���ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18020,'�����ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18020,'main table field',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18021,'��ϸ���ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18021,'detail table field',8) 
/
INSERT INTO HtmlLabelIndex values(18023,'�Ƿ�ʹ��ģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18023,'�Ƿ�ʹ��ģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18023,'use mode or not',8) 
/
INSERT INTO HtmlLabelIndex values(17139,'��ʾ����') 
/
INSERT INTO HtmlLabelInfo VALUES(17139,'��ʾ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17139,'show type',8) 
/
INSERT INTO HtmlLabelIndex values(18015,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18015,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18015,'Workflow',8) 
/
INSERT INTO HtmlLabelIndex values(18173,'��ʾ/���ر�ͷ') 
/
INSERT INTO HtmlLabelInfo VALUES(18173,'��ʾ/���ر�ͷ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18173,'show or hidden system head',8) 
/