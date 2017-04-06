CREATE OR REPLACE PROCEDURE SystemSet_DftSCUpdate(
	 dftsubcomid_1 integer ,
	 flag out integer ,
	 msg out varchar2,
	 thecursor IN OUT cursor_define.weavercursor)
AS 
begin
update HrmRoles set subcompanyid = dftsubcomid_1 where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany);
update workflow_formdict set subcompanyid = dftsubcomid_1 where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany);
update workflow_formdictdetail set subcompanyid = dftsubcomid_1 where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany);
update workflow_formbase set subcompanyid= dftsubcomid_1 where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany);
update workflow_base set subcompanyid= dftsubcomid_1 where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 or subcompanyid not in (select id from hrmsubcompany);
END;
/

INSERT INTO HtmlNoteIndex values(88,'�޷�ɾ�����ֲ����ڽ�ɫ��ʹ�ã�') 
/
INSERT INTO HtmlNoteInfo VALUES(88,'�޷�ɾ�����ֲ����ڽ�ɫ��ʹ�ã�',7) 
/
INSERT INTO HtmlNoteInfo VALUES(88,'Unable to delete:Used in roles!',8) 
/

INSERT INTO HtmlNoteIndex values(89,'Ĭ�Ϸֲ��޷���ɾ����') 
/
INSERT INTO HtmlNoteInfo VALUES(89,'Ĭ�Ϸֲ��޷���ɾ����',7) 
/
INSERT INTO HtmlNoteInfo VALUES(89,'Default subcompany can not be deleted!',8) 
/
