/*
BUG 399 ��������Ӷ���ͻ��Ͳ��ܱ�����
����һ���ֶδ�ͻ�ID�ַ��� crmids
ԭ����crmid����
*/
ALTER TABLE Meeting_topic 
	ADD crmids VARCHAR2(4000) null
/
create or replace  PROCEDURE Meeting_Topic_Insert 
(meetingid integer , hrmid integer , subject varchar2 , 
hrmids varchar2, projid integer, crmid  varchar2, isopen smallint,
flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
INSERT INTO Meeting_Topic ( meetingid ,hrmid ,subject,hrmids, isopen,projid,crmids) 
VALUES ( meetingid , hrmid, subject , hrmids, isopen,projid,crmid) ;
end;
/
create or replace  PROCEDURE Meeting_Topic_Update 
(id_1 integer, hrmid_1 integer , subject_1 varchar2 , 
hrmids_1 varchar2 , projid_1 integer, 
crmid_1  varchar2, isopen_1 smallint, 
flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
update Meeting_Topic set hrmid=hrmid_1 ,subject=subject_1,
hrmids=hrmids_1,projid=projid_1,crmids=crmid_1,isopen=isopen_1 where id=id_1;
end;
/
