CREATE TABLE [Workflow_SubwfSet] (
	[id] [int]  NOT NULL ,
        [mainWorkflowId] int NULL , 
        [subWorkflowId] int NULL ,
        [triggerNodeId] int NULL ,
        [triggerTime] [char] (1) NULL ,
        [subwfCreatorType] [char] (1) NULL ,
        [subwfCreatorFieldId] int NULL 
) 
GO

CREATE TABLE [Workflow_SubwfSetDetail] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
        [subwfSetId] int NULL , 
        [subWorkflowFieldId] int NULL ,
        [mainWorkflowFieldId] int NULL ,
        [ifSplitField] char(1) NULL 
) 
GO

ALTER TABLE workflow_requestbase ADD mainRequestId INT NULL
GO

delete from  SequenceIndex where indexdesc='Workflow_SubwfSetId'
GO

insert into SequenceIndex(indexdesc,currentid) values('Workflow_SubwfSetId',1)
GO


INSERT INTO HtmlLabelIndex values(19347,'����ʱ��') 
GO
INSERT INTO HtmlLabelIndex values(19348,'����ڵ�') 
GO
INSERT INTO HtmlLabelIndex values(19352,'�����̴�����') 
GO
INSERT INTO HtmlLabelIndex values(19353,'�����̵�ǰ������') 
GO
INSERT INTO HtmlLabelIndex values(19349,'�뿪�ڵ�') 
GO
INSERT INTO HtmlLabelIndex values(19350,'�������б�') 
GO
INSERT INTO HtmlLabelIndex values(19351,'����������') 
GO
INSERT INTO HtmlLabelIndex values(19354,'�����̴�����') 
GO
INSERT INTO HtmlLabelIndex values(19355,'�����̵�������Դ�ֶ�') 
GO
INSERT INTO HtmlLabelIndex values(19357,'�������ֶ�') 
GO
INSERT INTO HtmlLabelIndex values(19358,'�������ֶ�') 
GO
INSERT INTO HtmlLabelIndex values(19359,'�ֶ�ֵ���') 
GO
INSERT INTO HtmlLabelIndex values(19361,'ÿ������Դ��������������') 
GO
INSERT INTO HtmlLabelIndex values(19362,'�����̲�ѯ') 
GO
INSERT INTO HtmlLabelIndex values(19363,'������״��') 
GO
INSERT INTO HtmlLabelIndex values(19343,'���ݳ���') 
GO
INSERT INTO HtmlLabelIndex values(19345,'���������') 
GO
INSERT INTO HtmlLabelIndex values(19356,'���������ݵ���') 
GO
INSERT INTO HtmlLabelIndex values(19346,'�����ڵ�') 
GO
INSERT INTO HtmlLabelIndex values(19344,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19343,'���ݳ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19343,'Data Exit',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19344,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19344,'SubWorkflow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19345,'���������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19345,'Add SubWorkflow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19346,'�����ڵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19346,'Trigger Node',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19347,'����ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19347,'Trigger Time',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19348,'����ڵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19348,'Reach Node',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19349,'�뿪�ڵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19349,'Leave Node',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19350,'�������б�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19350,'SubWorkflow List',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19351,'����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19351,'SubWorkflow Name',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19352,'�����̴�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19352,'SubWorkflow Creator',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19353,'�����̵�ǰ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19353,'MainWorkflow CurrentOperator',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19354,'�����̴�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19354,'MainWorkflow Creator',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19355,'�����̵�������Դ�ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19355,'MainWorkflow Single HR Field',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19356,'���������ݵ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19356,'SubWorkflow Data Import',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19357,'�������ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19357,'SubWorkflow Field',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19358,'�������ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19358,'MainWorkflow Field',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19359,'�ֶ�ֵ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19359,'Field Value Split',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19361,'ÿ������Դ��������������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19361,'New Single SubWorkflow For Per HR',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19362,'�����̲�ѯ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19362,'MainWorkflow Search',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19363,'������״��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19363,'SubWorkflow Status',8) 
GO


update HtmlLabelIndex set indexdesc='������������Դ����ֶ�'  where id=19355
GO
update HtmlLabelInfo set labelname='������������Դ����ֶ�' where indexid=19355 and languageid=7
GO
update HtmlLabelInfo set labelname='MainWorkflow HR Related Field' where indexid=19355 and languageid=8
GO

INSERT INTO HtmlLabelIndex values(19455,'�����̴�������ֵ�����������̴��������á�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19455,'�����̴�������ֵ�����������̴��������á�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19455,'The subWorkflow creator is null,check the setting of the subWorkflow creator please.',8) 
GO
