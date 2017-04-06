/*td:1515 by zxf for ���ܴ����ظ��ķֲ�*/
 alter PROCEDURE HrmSubCompany_Insert (@subcompanyname_1 	[varchar](200), @subcompanydesc_2 	[varchar](200), @companyid_3 	[tinyint], @flag                             integer output, @msg                             varchar(80) output)  AS  
 
 declare @count int
 declare @count1 int
 select @count=count(*)  from HrmSubCompany where subcompanyname=@subcompanyname_1
 select @count1=count(*)  from HrmSubCompany where subcompanydesc=@subcompanydesc_2
 if @count>0
 begin set @flag=2 set @msg='�÷ֲ�����Ѿ����ڣ����ܱ��棡' 
 return
 end 
 if @count1>0
 begin set @flag=3 set @msg='�÷ֲ�ȫ���Ѿ����ڣ����ܱ��棡' 
 return
 end 
 INSERT INTO [HrmSubCompany] ( [subcompanyname], [subcompanydesc], [companyid])  VALUES ( @subcompanyname_1, @subcompanydesc_2, @companyid_3) 
 select (max(id)) from [HrmSubCompany] 
 if @@error<>0 
 begin set @flag=1 set @msg='	���´������ʧ��' 
 return 
 end 
 else 
 begin set @flag=0 set @msg='	���´�����̳ɹ�' 
 return 
 end
GO

 alter PROCEDURE HrmSubCompany_Update (@id_1 	[int], @subcompanyname_2 	[varchar](200), @subcompanydesc_3 	[varchar](200), @companyid_4 	[tinyint], @flag                             integer output, @msg                             varchar(80) output)  AS 
 
 declare @count int
 declare @count1 int
 select @count=count(*)   from HrmSubCompany where subcompanyname=@subcompanyname_2 and id!=@id_1
 select @count1=count(*)   from HrmSubCompany where subcompanydesc=@subcompanydesc_3 and id!=@id_1
 if @count>0
 begin set @flag=2 set @msg='�÷ֲ�����Ѿ����ڣ����ܱ��棡' 
 return
 end 
 if @count1>0
 begin set @flag=3 set @msg='�÷ֲ�ȫ���Ѿ����ڣ����ܱ��棡' 
 return
 end 
 UPDATE [HrmSubCompany]  SET  [subcompanyname]	 = @subcompanyname_2, [subcompanydesc]	 = @subcompanydesc_3, [companyid]	 = @companyid_4  WHERE ( [id]	 = @id_1) 
 if @@error<>0 begin set @flag=1 set @msg='	���´������ʧ��' 
 return 
 end 
 else 
 begin 
 set @flag=0 set @msg='	���´�����̳ɹ�' 
 return 
 end
GO

insert into ErrorMsgIndex values (40,'�ֲ�����ظ�') 
GO
insert into ErrorMsgInfo values (40,'�÷ֲ�����Ѿ����ڣ����ܱ���',7) 
GO
insert into ErrorMsgInfo values (40,'The branch name duplicated',8) 
GO

insert into ErrorMsgIndex values (43,'�ֲ�ȫ���ظ�') 
GO
insert into ErrorMsgInfo values (43,'�÷ֲ�ȫ���Ѿ����ڣ����ܱ���',7) 
GO
insert into ErrorMsgInfo values (43,'The branch name duplicated',8) 
GO

/*td:1517 by zxf for ���ܴ����ظ��Ĳ���*/
alter PROCEDURE HrmDepartment_Insert (@departmentmark_1 [varchar](60), @departmentname_2 	[varchar](200), @supdepid_3 int, @allsupdepid_4 varchar(200), @subcompanyid1_5 [int], @showorder_6 int, @flag integer output , @msg varchar(80) output ) AS  
declare @count int
declare @count1 int
 select @count=count(*)  from HrmDepartment where subcompanyid1=@subcompanyid1_5 and departmentmark=@departmentmark_1
 select @count1=count(*)  from HrmDepartment where subcompanyid1=@subcompanyid1_5 and departmentname=@departmentname_2
 if @count>0
 begin set @flag=2 set @msg='�ò��ż���Ѿ����ڣ����ܱ��棡' 
 return
 end 
 if @count1>0
 begin set @flag=3 set @msg='�ò���ȫ���Ѿ����ڣ����ܱ��棡' 
 return
 end 
INSERT INTO [HrmDepartment] ( [departmentmark], [departmentname], supdepid, allsupdepid, [subcompanyid1], showorder) VALUES ( @departmentmark_1, @departmentname_2, @supdepid_3, @allsupdepid_4, @subcompanyid1_5, @showorder_6) 
select (max(id)) from [HrmDepartment] 
if @@error<>0 
begin 
set @flag=1 set @msg='���봢�����ʧ��' 
return 
end 
else 
begin 
set @flag=0 set @msg='���봢����̳ɹ�' 
return 
end
GO


  alter PROCEDURE HrmDepartment_Update (@id_1 [int], @departmentmark_2 [varchar](60), @departmentname_3 [varchar](200), @supdepid_4 int, @allsupdepid_5 varchar(200), @subcompanyid1_6 	[int], @showorder_7 int, @flag integer output, @msg varchar(80) output  )  AS 
  declare @count int
  declare @count1 int
 select @count=count(*)  from HrmDepartment where subcompanyid1=@subcompanyid1_6 and departmentmark=@departmentmark_2 and id!=@id_1
 select @count1=count(*)  from HrmDepartment where subcompanyid1=@subcompanyid1_6 and departmentname=@departmentname_3 and id!=@id_1
 if @count>0
 begin set @flag=2 set @msg='�ò��ż���Ѿ����ڣ����ܱ��棡' 
 return
 end 
 if @count1>0
 begin set @flag=3 set @msg='�ò���ȫ���Ѿ����ڣ����ܱ��棡' 
 return
 end 
  UPDATE [HrmDepartment]  SET  [departmentmark] = @departmentmark_2, [departmentname]	= @departmentname_3, supdepid = @supdepid_4,allsupdepid = @allsupdepid_5, [subcompanyid1] = @subcompanyid1_6,  showorder = @showorder_7 WHERE ( [id]	 = @id_1) 
  IF @@error<>0 begin 
  set @flag=1 set @msg='���´������ʧ��' 
  return 
  END 
  ELSE 
  begin 
  set @flag=1 
  set @msg='���´������ʧ��' 
  return 
  END
GO

insert into ErrorMsgIndex values (41,'���ż���ظ�') 
GO
insert into ErrorMsgInfo values (41,'�ò��ż���Ѿ����ڣ����ܱ���',7) 
GO
insert into ErrorMsgInfo values (41,'The department name duplicated',8) 
GO

insert into ErrorMsgIndex values (44,'����ȫ���ظ�') 
GO
insert into ErrorMsgInfo values (44,'�ò���ȫ���Ѿ����ڣ����ܱ���',7) 
GO
insert into ErrorMsgInfo values (44,'The department name duplicated',8) 
GO

/*td:1519 by zxf for ���Ʊ����õİ칫�ص㲻�ܱ�ɾ�� */
 alter PROCEDURE HrmLocations_Delete 
 (@id_1 	[int],
 @flag integer output,
 @msg varchar(80) output ) 
 AS 
 declare @count0 int
 select @count0=count(*) from HrmLocations a join HrmResource b on a.id=b.locationid
 if @count0>0
 begin
 set @flag=2
 set @msg='�칫�ص���ʹ����'
 return
 end
 DELETE [HrmLocations]  WHERE ( [id]	 = @id_1) 
 if @@error<>0 
 begin 
 set @flag=1 
 set @msg='���봢�����ʧ��' 
 return 
 end 
 else 
 begin 
 set @flag=0 
 set @msg='���봢����̳ɹ�' 
 return 
 end
GO

insert into ErrorMsgIndex values (42,'�칫�ص���ʹ����') 
GO
insert into ErrorMsgInfo values (42,'�칫�ص���ʹ���У�����ɾ��',7) 
GO
insert into ErrorMsgInfo values (42,'the site has been used',8) 
GO
