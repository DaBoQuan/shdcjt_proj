
/*һ�������ϵġ�Ecology��Ʒ����-������Դ����BUG�޸�V1.0�ύ���Ա���2003-08-15���Ľű�*/




CREATE or replace PROCEDURE HrmSalaryPaydetail_Update
	(payid_1 	integer,
	 itemid_2 	varchar2,
	 hrmid_3 	integer,
	 salary_4 	number,
     flag	out integer,
     msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor)

AS 
count_1 integer;
begin
select count(payid) into count_1 from HrmSalaryPaydetail where 
( payid	 = payid_1 AND itemid = itemid_2 AND hrmid = hrmid_3);
if count_1 is null or count_1 = 0
then
    INSERT INTO HrmSalaryPaydetail 
	 ( payid,
	 itemid,
	 hrmid,
	 salary) 
     VALUES 
        ( payid_1,
         itemid_2,
         hrmid_3,
         salary_4);
else 
    UPDATE HrmSalaryPaydetail 
    SET  salary=salary_4 
    WHERE 
        ( payid	= payid_1 AND
         itemid	= itemid_2 AND
         hrmid	= hrmid_3) ;
end if;
end;
/


update SystemRightDetail set rightdetail='HrmJobCallAdd:Add' where id = 418
/
update SystemRightDetail set rightdetail='HrmJobCallEdit:Edit' where id = 419
/
update SystemRightDetail set rightdetail='HrmJobCallEdit:Delete' where id = 420
/
update SystemRightDetail set rightdetail='HrmJobCall:Log' where id = 421
/


insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (382,7,'ѧ��ά��','ѧ��ά��')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (382,8,'','')
/