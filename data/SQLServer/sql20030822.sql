
/*һ�������ϵġ�Ecology��Ʒ����-������Դ����BUG�޸�V1.0�ύ���Ա���2003-08-15���Ľű�*/




alter PROCEDURE HrmSalaryPaydetail_Update
	(@payid_1 	int,
	 @itemid_2 	varchar(6),
	 @hrmid_3 	int,
	 @salary_4 	decimal(10,2),
     @flag          integer output, 
     @msg           varchar(80) output)

AS 
declare @count int

select @count = count(payid) from HrmSalaryPaydetail where 
( payid	 = @payid_1 AND itemid	 = @itemid_2 AND hrmid	 = @hrmid_3)

if @count is null or @count = 0
    INSERT INTO HrmSalaryPaydetail 
	 ( payid,
	 itemid,
	 hrmid,
	 salary) 
 
    VALUES 
        ( @payid_1,
         @itemid_2,
         @hrmid_3,
         @salary_4)
else 
    UPDATE HrmSalaryPaydetail 
    SET  salary	 = @salary_4 
    WHERE 
        ( payid	 = @payid_1 AND
         itemid	 = @itemid_2 AND
         hrmid	 = @hrmid_3)
GO


update SystemRightDetail set rightdetail='HrmJobCallAdd:Add' where id = 418
GO
update SystemRightDetail set rightdetail='HrmJobCallEdit:Edit' where id = 419
GO
update SystemRightDetail set rightdetail='HrmJobCallEdit:Delete' where id = 420
GO
update SystemRightDetail set rightdetail='HrmJobCall:Log' where id = 421
GO


insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (382,7,'ѧ��ά��','ѧ��ά��')
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (382,8,'','')
GO