create or replace PROCEDURE SystemSet_DftSCUpdate
(
	dftsubcomid_1 integer ,
	flag out integer  , 
	msg out varchar2,
	thecursor IN OUT cursor_define.weavercursor
) 
AS 
begin

UPDATE MeetingRoom 
SET subcompanyId = dftsubcomid_1 
WHERE subcompanyId IS null 
OR subcompanyId = 0 
OR subcompanyId = -1 
OR subcompanyid NOT IN (SELECT id FROM hrmSubcompany);

UPDATE Meeting_Type 
SET subcompanyId = dftsubcomid_1 
WHERE subcompanyId IS null 
OR subcompanyId = 0 
OR subcompanyId = -1 
OR subcompanyid NOT IN (SELECT id FROM hrmSubcompany);


update HrmRoles 
set subcompanyid=dftsubcomid_1 
where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 
or subcompanyid not in (select id from hrmsubcompany);

update workflow_formdict 
set subcompanyid=dftsubcomid_1 
where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 
or subcompanyid not in (select id from hrmsubcompany);

update workflow_formdictdetail 
set subcompanyid=dftsubcomid_1 
where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 
or subcompanyid not in (select id from hrmsubcompany);

update workflow_formbase 
set subcompanyid=dftsubcomid_1 
where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 
or subcompanyid not in (select id from hrmsubcompany);

update workflow_base 
set subcompanyid=dftsubcomid_1 
where subcompanyid is null or subcompanyid=0 or subcompanyid=-1 
or subcompanyid not in (select id from hrmsubcompany);
end;
/

