INSERT INTO HtmlLabelIndex values(19947,'Ĭ�ϵ����ĵ�Ŀ¼') 
GO
INSERT INTO HtmlLabelIndex values(19948,'�ͻ���ϵ�������Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(19947,'Ĭ�ϵ����ĵ�Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19947,'Default Document Category',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19948,'�ͻ���ϵ�������Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19948,'CRM Contact Category',8) 
GO
INSERT INTO HtmlLabelIndex values(19949,'���ڵ����ͻ���ϵ�����Ժ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19949,'���ڵ����ͻ���ϵ�����Ժ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19949,'Exporting to CRM contract, please wait',8) 
GO
INSERT INTO HtmlLabelIndex values(19950,'���ڵ����ĵ������Ժ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19950,'���ڵ����ĵ������Ժ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19950,'Exporting to document, please wait',8) 
GO
INSERT INTO HtmlLabelIndex values(19951,'ȷ������ɾ����ѡ���ʼ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19951,'ȷ������ɾ����ѡ���ʼ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19951,'if confirm delete mails in the folder?',8) 
GO


alter table MailSetting add crmSecId int
go


create procedure Mail2CRMContact
@userid int,
@crmid int,
@mailid int,
@flag int output, 
@msg varchar(80) output
as
INSERT INTO WorkPlan (type_n,begindate,begintime,resourceid,description,name,status,urgentLevel,createrid,createrType,crmid)
SELECT '3',LEFT(senddate,10),RIGHT(senddate,8),@userid,content,subject,'2','1',@userid,'1',@crmid FROM MailResource WHERE id=@mailid
select ident_current('WorkPlan')
go