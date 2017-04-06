CREATE TABLE Workflow_SubwfSet (
	id integer  NOT NULL ,
	mainWorkflowId integer NULL ,
	subWorkflowId  integer NULL ,  
	triggerNodeId  integer NULL , 
    triggerTime char(1)    NULL,
    subwfCreatorType char(1)    NULL,
    subwfCreatorFieldId integer NULL 
)
/

create sequence Workflow_SubwfSet_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Workflow_SubwfSet_Trigger
before insert on Workflow_SubwfSet
for each row
begin
select Workflow_SubwfSet_Id.nextval into :new.id from dual;
end;
/

CREATE TABLE Workflow_SubwfSetDetail (
	id integer  NOT NULL ,
	subwfSetId  integer NULL ,  
	subWorkflowFieldId  integer NULL ,  
    mainWorkflowFieldId  integer NULL ,  
    ifSplitField char(1)    NULL
)
/
create sequence Workflow_SubwfSetDetail_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Workflow_SubwfSetDetail_Tri
before insert on Workflow_SubwfSetDetail
for each row
begin
select WWorkflow_SubwfSetDetail_Id.nextval into :new.id from dual;
end;
/




ALTER TABLE workflow_requestbase ADD mainRequestId integer NULL
/

delete from  SequenceIndex where indexdesc='Workflow_SubwfSetId'
/

insert into SequenceIndex(indexdesc,currentid) values('Workflow_SubwfSetId',1)
/


INSERT INTO HtmlLabelIndex values(19347,'����ʱ��') 
/
INSERT INTO HtmlLabelIndex values(19348,'����ڵ�') 
/
INSERT INTO HtmlLabelIndex values(19352,'�����̴�����') 
/
INSERT INTO HtmlLabelIndex values(19353,'�����̵�ǰ������') 
/
INSERT INTO HtmlLabelIndex values(19349,'�뿪�ڵ�') 
/
INSERT INTO HtmlLabelIndex values(19350,'�������б�') 
/
INSERT INTO HtmlLabelIndex values(19351,'����������') 
/
INSERT INTO HtmlLabelIndex values(19354,'�����̴�����') 
/
INSERT INTO HtmlLabelIndex values(19355,'�����̵�������Դ�ֶ�') 
/
INSERT INTO HtmlLabelIndex values(19357,'�������ֶ�') 
/
INSERT INTO HtmlLabelIndex values(19358,'�������ֶ�') 
/
INSERT INTO HtmlLabelIndex values(19359,'�ֶ�ֵ���') 
/
INSERT INTO HtmlLabelIndex values(19361,'ÿ������Դ��������������') 
/
INSERT INTO HtmlLabelIndex values(19362,'�����̲�ѯ') 
/
INSERT INTO HtmlLabelIndex values(19363,'������״��') 
/
INSERT INTO HtmlLabelIndex values(19343,'���ݳ���') 
/
INSERT INTO HtmlLabelIndex values(19345,'���������') 
/
INSERT INTO HtmlLabelIndex values(19356,'���������ݵ���') 
/
INSERT INTO HtmlLabelIndex values(19346,'�����ڵ�') 
/
INSERT INTO HtmlLabelIndex values(19344,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(19343,'���ݳ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19343,'Data Exit',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19344,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19344,'SubWorkflow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19345,'���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19345,'Add SubWorkflow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19346,'�����ڵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19346,'Trigger Node',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19347,'����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19347,'Trigger Time',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19348,'����ڵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19348,'Reach Node',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19349,'�뿪�ڵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19349,'Leave Node',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19350,'�������б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19350,'SubWorkflow List',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19351,'����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19351,'SubWorkflow Name',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19352,'�����̴�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19352,'SubWorkflow Creator',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19353,'�����̵�ǰ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19353,'MainWorkflow CurrentOperator',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19354,'�����̴�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19354,'MainWorkflow Creator',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19355,'�����̵�������Դ�ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19355,'MainWorkflow Single HR Field',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19356,'���������ݵ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19356,'SubWorkflow Data Import',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19357,'�������ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19357,'SubWorkflow Field',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19358,'�������ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19358,'MainWorkflow Field',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19359,'�ֶ�ֵ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19359,'Field Value Split',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19361,'ÿ������Դ��������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19361,'New Single SubWorkflow For Per HR',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19362,'�����̲�ѯ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19362,'MainWorkflow Search',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19363,'������״��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19363,'SubWorkflow Status',8) 
/


update HtmlLabelIndex set indexdesc='������������Դ����ֶ�'  where id=19355
/
update HtmlLabelInfo set labelname='������������Դ����ֶ�' where indexid=19355 and languageid=7
/
update HtmlLabelInfo set labelname='MainWorkflow HR Related Field' where indexid=19355 and languageid=8
/

INSERT INTO HtmlLabelIndex values(19455,'�����̴�������ֵ�����������̴��������á�') 
/
INSERT INTO HtmlLabelInfo VALUES(19455,'�����̴�������ֵ�����������̴��������á�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19455,'The subWorkflow creator is null,check the setting of the subWorkflow creator please.',8) 
/
