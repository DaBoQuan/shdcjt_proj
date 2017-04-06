/*label����*/
INSERT INTO HtmlLabelIndex values(17564,'���̴���˵�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17564,'���̴���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17564,'WorkflowAgent',8) 
GO
INSERT INTO HtmlLabelIndex values(17565,'��������') 
GO
INSERT INTO HtmlLabelIndex values(17566,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17565,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17565,'beAgenter',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17566,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17566,'Agenter',8) 
GO
INSERT INTO HtmlLabelIndex values(17577,'�������̴���') 
GO
INSERT INTO HtmlLabelInfo VALUES(17577,'�������̴���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17577,'creater agenter',8) 
GO

/*Ȩ������*/
delete from SystemRights where id=455
GO
insert into SystemRights (id,rightdesc,righttype) values (455,'���̴�����Ȩ��','5') 
GO
delete from SystemRightsLanguage where id=455
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (455,7,'�������̴���ά��','���������˵����̴���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (455,8,'WrokflowAgentAll','set workflow agent info for all') 
GO
delete from SystemRightDetail where id=3146
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3146,'���̴�����Ȩ��','WorkflowAgent:All',455) 
GO

delete from SystemRights where id=456
GO
insert into SystemRights (id,rightdesc,righttype) values (456,'���̴������Ȩ��','5') 
GO
delete from SystemRightsLanguage where id=456
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (456,7,'�������̴���ά��','���������˵����̴���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (456,8,'WrokflowAgentSelf','set workflow agent info for self') 
GO
delete from SystemRightDetail where id=3147
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3147,'���̴������Ȩ��','WorkflowAgent:Self',456) 
GO

/*���id��������*/
DELETE FROM SequenceIndex WHERE indexdesc='workflowagentid';
INSERT INTO SequenceIndex VALUES('workflowagentid',1);


/*������*/

CREATE TABLE Workflow_Agent 
(
    agentId         int             NOT NULL PRIMARY KEY,
    workflowId      int             NULL,
    beagenterId     int             NULL,
    agenterId       int             NULL,
    beginDate       char(10)        NULL,
    beginTime       char(8)         NULL,
    endDate         char(10)        NULL,
    endTime         char(8)         NULL,
    isCreateAgenter int             NULL
)
GO

/*�޸�workflow_createrlist��ṹ����¼����Ȩ����Դ*/
ALTER TABLE workflow_createrlist
ADD isAgenter int NULL
GO

DROP PROCEDURE workflow_createrlist_Insert 
GO
CREATE PROCEDURE workflow_createrlist_Insert 
(@workflowid_1  int,
 @userid_2  int,
 @usertype_3    int, 
 @usertype_4    int,        /* ��Ϊ�����˺����пͻ���ʱ��Ϊ���ȫ���𣬷���Ϊ0 */
 @isagenter     int,        /* ��¼����Ȩ����Դ*/
 @flag integer output , 
 @msg varchar(80) output )

AS INSERT INTO workflow_createrlist 
( workflowid, userid, usertype, usertype2, isAgenter ) 
 
VALUES 
( @workflowid_1, @userid_2, @usertype_3, @usertype_4, @isagenter )

GO