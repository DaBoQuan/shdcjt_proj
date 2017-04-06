alter PROCEDURE HrmResource_SelectAll 
 (@flag integer output, @msg   varchar(80) output ) 
AS select 
  id,
  loginid,  
  lastname,
  sex,
  resourcetype,
  email,
  locationid,
  workroom, 
  departmentid,
  costcenterid,
  jobtitle,
  managerid,
  assistantid ,
  seclevel,
  joblevel,
  status,
  account,
  mobile
from HrmResource  
if @@error<>0 begin set @flag=1 set @msg='��ѯ������Դ��Ϣ�ɹ�' return end else begin set @flag=0 set @msg='��ѯ������Դ��Ϣʧ��' return end 

GO