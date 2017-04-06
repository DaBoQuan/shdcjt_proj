/*�ͻ�����*/

alter table CRM_CustomerType add workflowid integer
/

CREATE or replace PROCEDURE CRM_CustomerType_Insert 
(fullname varchar2, 
description varchar2,
workflowid integer, 
 flag out integer,
 msg out varchar2, 
 thecursor IN OUT cursor_define.weavercursor) 
AS
begin
INSERT INTO CRM_CustomerType 
( fullname, description,workflowid) 
VALUES ( fullname, description,workflowid);
end;
/

CREATE or replace PROCEDURE CRM_CustomerType_Update 
(id_1	integer, 
fullname_1 varchar2, 
description_1 varchar2,
workflowid_1 integer, 
flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
UPDATE CRM_CustomerType SET  fullname = fullname_1, 
description	 = description_1,
workflowid = workflowid_1
WHERE ( id	 = id_1);
end;
/

CREATE or replace PROCEDURE CRM_CustomerType_SelectByID 
(id_1 integer, 
flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor) 
AS
begin
open thecursor for
SELECT t1.*, t2.workflowname AS workflowname 
FROM CRM_CustomerType t1 LEFT OUTER JOIN workflow_base t2 
ON t1.workflowid = t2.id WHERE (t1.id = id_1);
end;
/

/*�ͻ�����������*/
CREATE TABLE bill_ApproveCustomer ( 
    id integer,
    managerid integer,
    requestid integer,
    approveid integer,
    approvevalue integer,
    approvedesc varchar2(50),
    status char(1),
    approvetype integer) 
/
create sequence bill_ApproveCustomer_id
start with 1
increment by 1
nomaxvalue
nocycle
/                           


create or replace trigger bill_ApproveCustomer_Tri
before insert on bill_ApproveCustomer
for each row
begin
select bill_ApproveCustomer_id.nextval into :new.id from dual;
end;
/

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(79,17180,'bill_ApproveCustomer','AddBillApproveCustomer.jsp','ManageBillApproveCustomer.jsp','ViewBillApproveCustomer.jsp','','','BillApproveCustomerOperation.jsp') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (79,'managerid',1278,'integer',3,1,3,0)
/ 
  

INSERT INTO HtmlLabelIndex values(17181,'�������') 
/
INSERT INTO HtmlLabelInfo VALUES(17181,'�������',7) 
/

INSERT INTO HtmlLabelIndex values(17180,'�ͻ�������ת��') 
/
INSERT INTO HtmlLabelInfo VALUES(17180,'�ͻ�������ת��',7) 
/
 
/*�¿ͻ�*/
CREATE TABLE CRM_ViewLog2 ( 
    customerid integer,
    oldmanager integer,
    newmanager integer,
    movedate char(10),
    movetime char(8)) 
/

/*���ӽڵ������*/
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 87,780,'','/systeminfo/BrowserMain.jsp?url=/meeting/Maint/MeetingRoomBrowser.jsp','MeetingRoom','name','id','/meeting/Maint/MeetingRoom.jsp?id=')
/
INSERT INTO HtmlLabelIndex values(17204,'�ͻ��ֶξ���ľ���') 
/
INSERT INTO HtmlLabelInfo VALUES(17204,'�ͻ��ֶξ���ľ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17204,'manager''s manager',8) 
/



/*�ظ��Զ�����*/

alter table DocDetail add canremind char(1)
/

/*�ĵ���������*/

INSERT INTO HtmlLabelIndex values(17220,'�ĵ���������') 
/
INSERT INTO HtmlLabelInfo VALUES(17220,'�ĵ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17220,'Muti Document Share',8) 
/

/*�ͻ���������*/

INSERT INTO HtmlLabelIndex values(17221,'�ͻ���������') 
/
INSERT INTO HtmlLabelInfo VALUES(17221,'�ͻ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17221,'Customer Muti Share',8) 
/

/*Ⱥ���ʼ�*/
CREATE TABLE MailSendRecord ( 
    id integer,
    sendfrom varchar2(200),
    sendcc varchar2(200),
    sendbcc varchar2(200),
    sendto varchar2(200),
    subject varchar2(200),
    body Varchar2(4000),
    charset char(1),
    priority char(1),
    senddate char(10),
    sendtime char(8),
    isfinished char(1),
    sender integer,
    sendcount integer,
    isdeleted char(1),
    sendtotype char(1),
    sendtoid integer) 
/
create sequence MailSendRecord_id
start with 1
increment by 1
nomaxvalue
nocycle
/                           


create or replace trigger MailSendRecord_Tri
before insert on bill_ApproveCustomer
for each row
begin
select MailSendRecord_id.nextval into :new.id from dual;
end;
/

create or replace PROCEDURE MailSendRecord_Insert
	(sendfrom_2 	varchar2,
	 sendcc_3 	varchar2,
	 sendbcc_4 	varchar2,
	 sendto_5 	varchar2,
	 subject_6 	varchar2,
	 body_7 	varchar2,
	 charset_8 	char,
	 priority_9 	char,
	 senddate_10 	char,
	 sendtime_11 	char,
	 isfinished_12 	char,
	 sender_13 	integer,
	 sendcount_14 	integer,
     isdeleted_15 char,
     sendtotype_16 char,
     sendtoid_17 integer,
 flag out integer,
 msg out varchar2, 
 thecursor IN OUT cursor_define.weavercursor)
AS 
begin
INSERT INTO MailSendRecord 
	 (sendfrom,
	 sendcc,
	 sendbcc,
	 sendto,
	 subject,
	 body,
	 charset,
	 priority,
	 senddate,
	 sendtime,
	 isfinished,
	 sender,
	 sendcount,
     isdeleted,
     sendtotype,
     sendtoid) 
 
VALUES 
	(sendfrom_2,
	 sendcc_3,
	 sendbcc_4,
	 sendto_5,
	 subject_6,
	 body_7,
	 charset_8,
	 priority_9,
	 senddate_10,
	 sendtime_11,
	 isfinished_12,
	 sender_13,
	 sendcount_14,
     isdeleted_15,
     sendtotype_16,
     sendtoid_17);
end;

/*���湤������ǩ*/
INSERT INTO HtmlLabelIndex values(17288,'��������') 
/
INSERT INTO HtmlLabelIndex values(17289,'��������') 
/
INSERT INTO HtmlLabelIndex values(17290,'�����ͻ�') 
/
INSERT INTO HtmlLabelIndex values(17292,'�ɹ��ͻ�') 
/
INSERT INTO HtmlLabelIndex values(17293,'�Ե�ͻ�') 
/
INSERT INTO HtmlLabelIndex values(17294,'���Ϳͻ�') 
/
INSERT INTO HtmlLabelIndex values(17297,'��Ҫ�����Ż��Ŀͻ�') 
/
INSERT INTO HtmlLabelIndex values(17296,'��Ҫ��������Ŀͻ�') 
/
INSERT INTO HtmlLabelIndex values(17291,'Ǳ�ڿͻ�') 
/
INSERT INTO HtmlLabelIndex values(17295,'��Ч�ͻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(17288,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17288,'level apply',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17289,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17289,'reset password',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17290,'�����ͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17290,'base customer',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17291,'Ǳ�ڿͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17291,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17292,'�ɹ��ͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17292,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17293,'�Ե�ͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17293,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17294,'���Ϳͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17294,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17295,'��Ч�ͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17295,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17296,'��Ҫ��������Ŀͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17296,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17297,'��Ҫ�����Ż��Ŀͻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17297,'',8) 
/
