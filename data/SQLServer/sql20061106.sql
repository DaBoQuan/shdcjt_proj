alter PROCEDURE SystemSet_DftSCUpdate(
	@dftsubcomid int ,
	@flag int output , 
	@msg varchar(80) output) 
AS 

update HrmRoles set subcompanyid=@dftsubcomid where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany)
update workflow_formdict set subcompanyid=@dftsubcomid where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany)
update workflow_formdictdetail set subcompanyid=@dftsubcomid where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany)
update workflow_formbase set subcompanyid=@dftsubcomid where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany)
update workflow_base set subcompanyid=@dftsubcomid where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany)
GO

INSERT INTO HtmlNoteIndex values(88,'�޷�ɾ�����ֲ����ڽ�ɫ��ʹ�ã�') 
GO
INSERT INTO HtmlNoteInfo VALUES(88,'�޷�ɾ�����ֲ����ڽ�ɫ��ʹ�ã�',7) 
GO
INSERT INTO HtmlNoteInfo VALUES(88,'Unable to delete:Used in roles!',8) 
GO

INSERT INTO HtmlNoteIndex values(89,'Ĭ�Ϸֲ��޷���ɾ����') 
GO
INSERT INTO HtmlNoteInfo VALUES(89,'Ĭ�Ϸֲ��޷���ɾ����',7) 
GO
INSERT INTO HtmlNoteInfo VALUES(89,'Default subcompany can not be deleted!',8) 
GO
