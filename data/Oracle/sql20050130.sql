/*label����*/
INSERT INTO HtmlLabelIndex values(17582,'�Ƿ��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17582,'�Ƿ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17582,'is message remind',8) 
/
INSERT INTO HtmlLabelIndex values(17583,'����������') 
/
INSERT INTO HtmlLabelIndex values(17585,'���߶�������') 
/
INSERT INTO HtmlLabelIndex values(17584,'���߶�������') 
/
INSERT INTO HtmlLabelInfo VALUES(17583,'����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17583,'no message remind',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17584,'���߶�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17584,'offline message remind',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17585,'���߶�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17585,'online message remind',8) 
/
INSERT INTO HtmlLabelIndex values(17586,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17586,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17586,'message remind',8) 
/

/*�޸�workflow_base��ṹ����¼�Ƿ��ܹ���������*/
ALTER TABLE workflow_base ADD messageType integer NULL
/
/*�޸�workflow_requestbase��ṹ����¼���̵Ķ�����������*/
ALTER TABLE workflow_requestbase ADD messageType integer NULL
/
DROP PROCEDURE workflow_Requestbase_Insert 
/
CREATE or REPLACE PROCEDURE workflow_Requestbase_Insert 
(requestid_1	integer,
workflowid_2	integer,
lastnodeid_3	integer, 
lastnodetype_4	char,
currentnodeid_5	integer,
currentnodetype_6	char, 
status_7		varchar2,
passedgroups_8	integer,
totalgroups_9	integer, 
requestname_10	varchar2,
creater_11	integer,
createdate_12	char, 
createtime_13	char,
lastoperator_14	integer, 
lastoperatedate_15	char, 
lastoperatetime_16	char,
deleted_17	integer,
creatertype_18	integer, 
lastoperatortype_19	integer,
nodepasstime_20	float ,
nodelefttime_21	float , 
docids_22 		Varchar2,
crmids_23 		Varchar2, 
hrmids_24 		Varchar2,
prjids_25 		Varchar2, 
cptids_26 		Varchar2,
messageType_27 	integer, 
flag out integer ,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
insert into workflow_requestbase 
(requestid,
workflowid,
lastnodeid,
lastnodetype,
currentnodeid,
currentnodetype,
status, 
passedgroups,
totalgroups,
requestname,
creater,
createdate,
createtime,
lastoperator, 
lastoperatedate,
lastoperatetime,
deleted,
creatertype,
lastoperatortype,
nodepasstime,
nodelefttime,
docids,
crmids,
hrmids,
prjids,
cptids,
messageType) 
values
(requestid_1,
workflowid_2,
lastnodeid_3,
lastnodetype_4,
currentnodeid_5,
currentnodetype_6,
status_7, 
passedgroups_8,
totalgroups_9,
requestname_10,
creater_11,
createdate_12,
createtime_13,
lastoperator_14, 
lastoperatedate_15,
lastoperatetime_16,
deleted_17,
creatertype_18,
lastoperatortype_19,
nodepasstime_20,
nodelefttime_21,
docids_22,
crmids_23,
hrmids_24,
prjids_25,
cptids_26,
messageType_27);
end;
/