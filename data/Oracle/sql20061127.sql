INSERT INTO HtmlLabelIndex values(19947,'Ĭ�ϵ����ĵ�Ŀ¼') 
/
INSERT INTO HtmlLabelIndex values(19948,'�ͻ���ϵ�������Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19947,'Ĭ�ϵ����ĵ�Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19947,'Default Document Cate/ry',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19948,'�ͻ���ϵ�������Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19948,'CRM Contact Cate/ry',8) 
/
INSERT INTO HtmlLabelIndex values(19949,'���ڵ����ͻ���ϵ�����Ժ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19949,'���ڵ����ͻ���ϵ�����Ժ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19949,'Exporting to CRM contract, please wait',8) 
/
INSERT INTO HtmlLabelIndex values(19950,'���ڵ����ĵ������Ժ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19950,'���ڵ����ĵ������Ժ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19950,'Exporting to document, please wait',8) 
/
INSERT INTO HtmlLabelIndex values(19951,'ȷ������ɾ����ѡ���ʼ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19951,'ȷ������ɾ����ѡ���ʼ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19951,'if confirm delete mails in the folder?',8) 
/


alter table MailSetting add crmSecId integer
/


create or replace procedure Mail2CRMContact(
userid_1 integer,
crmid_2 integer,
mailid_3 integer,
flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor
)
as
begin

INSERT INTO WorkPlan (type_n,begindate,begintime,resourceid,description,name,status,urgentLevel,createrid,createrType,crmid)
SELECT '3',substr(senddate,0,10),substr(senddate,10,8),userid_1,content,subject,'2','1',userid_1,'1',crmid_2 FROM MailResource WHERE id=mailid_3;
open thecursor for
select max(id) from WorkPlan;


end;
/