alter PROCEDURE HrmResource_SelectByManagerID 
 (@id_1 [int], 
  @flag integer output, @msg varchar(80) output ) 
  AS select * from HrmResource 
  where 
    managerid = @id_1 
    and (status =0 or status = 1 or status =2 or status =3) order by dsporder
  if @@error<>0 begin set @flag=1 set @msg='��ѯ������Դ��Ϣ�ɹ�' return end else begin set @flag=0 set @msg='��ѯ������Դ��Ϣʧ��' return end 

GO
