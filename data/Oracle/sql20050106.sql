/*label����*/
INSERT INTO HtmlLabelIndex values(17564,'���̴���˵�') 
/
INSERT INTO HtmlLabelInfo VALUES(17564,'���̴���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17564,'WorkflowAgent',8)
/
INSERT INTO HtmlLabelIndex values(17565,'��������') 
/
INSERT INTO HtmlLabelIndex values(17566,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(17565,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17565,'beAgenter',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17566,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17566,'Agenter',8) 
/
INSERT INTO HtmlLabelIndex values(17577,'�������̴���') 
/
INSERT INTO HtmlLabelInfo VALUES(17577,'�������̴���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17577,'creater agenter',8) 
/

/*Ȩ������*/
insert into SystemRights (id,rightdesc,righttype) values (455,'���̴�����Ȩ��','5') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (455,7,'�������̴���ά��','���������˵����̴���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (455,8,'WrokflowAgentAll','set workflow agent info for all') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3146,'���̴�����Ȩ��','WorkflowAgent:All',455) 
/

insert into SystemRights (id,rightdesc,righttype) values (456,'���̴������Ȩ��','5') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (456,7,'�������̴���ά��','���������˵����̴���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (456,8,'WrokflowAgentSelf','set workflow agent info for self') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3147,'���̴������Ȩ��','WorkflowAgent:Self',456) 
/

/*���id��������*/
INSERT INTO SequenceIndex VALUES('workflowagentid',1)
/


/*������*/

CREATE TABLE Workflow_Agent 
(
    agentId         integer             NOT NULL PRIMARY KEY,
    workflowId      integer             NULL,
    beagenterId     integer             NULL,
    agenterId       integer             NULL,
    beginDate       char(10)        NULL,
    beginTime       char(8)         NULL,
    endDate         char(10)        NULL,
    endTime         char(8)         NULL,
    isCreateAgenter integer             NULL
)
/

/*�޸�workflow_createrlist��ṹ����¼����Ȩ����Դ*/
ALTER TABLE workflow_createrlist ADD isAgenter integer NULL
/

DROP PROCEDURE workflow_createrlist_Insert 
/
CREATE OR REPLACE PROCEDURE workflow_createrlist_Insert 
(workflowid_1  integer,
 userid_2  integer,
 usertype_3    integer,
 usertype_4    integer,        /* ��Ϊ�����˺����пͻ���ʱ��Ϊ���ȫ���𣬷���Ϊ0 */
 isagenter     integer,        /* ��¼����Ȩ����Դ*/
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor)
AS 
begin
INSERT INTO workflow_createrlist 
(   workflowid,
    userid,
    usertype,
    usertype2,
    isAgenter )
 VALUES 
(   workflowid_1,
    userid_2,
    usertype_3,
    usertype_4,
    isagenter );
end;
/