/*��ģ��*/
CREATE TABLE workflow_formmode ( 
    id int not null IDENTITY (1,1),	/*������ID*/
    formid int,	/*��id*/
    isbill varchar(1),	/*�Ƿ�Ϊ����*/
    isprint varchar(1),	/*�Ƿ��ӡģ��*/
    modename varchar(200),/*ģ������*/
    modedesc text	/*ģ������*/
)
GO
/*�ڵ�ģ��*/
CREATE TABLE workflow_nodemode ( 
    id int not null IDENTITY (1,1),	/*������ID*/
    workflowid int,/*������id*/
    formid int,/*��id*/
    nodeid int,	/*�ڵ�id*/
    isprint varchar(1),	/*�Ƿ��ӡģ��*/
    modename varchar(200),/*ģ������*/
    modedesc text	/*ģ������*/
)
GO
/*��ʾ����*/
alter table workflow_flownode add ismode varchar(1)
go
/*��������ʾģ��*/
alter table workflow_flownode add showdes varchar(1)
go
/*�����ô�ӡģ��*/
alter table workflow_flownode add printdes varchar(1)
go

INSERT INTO HtmlLabelIndex values(18016,'��ͨģʽ') 
GO
INSERT INTO HtmlLabelIndex values(18017,'ģ��ģʽ') 
GO
INSERT INTO HtmlLabelInfo VALUES(18016,'��ͨģʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18016,'generic mode',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18017,'ģ��ģʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18017,'templet mode',8) 
GO
INSERT INTO HtmlLabelIndex values(18018,'�ɱ༭') 
GO
INSERT INTO HtmlLabelIndex values(18019,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18018,'�ɱ༭',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18018,'can be edited',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18019,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18019,'must input',8) 
GO
INSERT INTO HtmlLabelIndex values(18020,'�����ֶ�') 
GO
INSERT INTO HtmlLabelIndex values(18021,'��ϸ���ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18020,'�����ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18020,'main table field',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18021,'��ϸ���ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18021,'detail table field',8) 
GO
INSERT INTO HtmlLabelIndex values(18023,'�Ƿ�ʹ��ģ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18023,'�Ƿ�ʹ��ģ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18023,'use mode or not',8) 
GO

INSERT INTO HtmlLabelIndex values(17139,'��ʾ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17139,'��ʾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17139,'show type',8) 
GO
INSERT INTO HtmlLabelIndex values(18015,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18015,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18015,'Workflow',8) 
GO
INSERT INTO HtmlLabelIndex values(18173,'��ʾ/���ر�ͷ') 
GO
INSERT INTO HtmlLabelInfo VALUES(18173,'��ʾ/���ر�ͷ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18173,'show or hidden system head',8) 
go