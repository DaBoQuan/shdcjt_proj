alter PROCEDURE HrmSubCompany_Select 
 @flag integer output , @msg varchar(80) output AS select * from HrmSubCompany order by showorder,subcompanyname set  @flag = 0 set  @msg = '�����ɹ����' 
GO

alter PROCEDURE HrmDepartment_Select 
 @flag integer output , @msg varchar(80) output AS select * from HrmDepartment order by showorder,departmentname set  @flag = 0 set  @msg = '�����ɹ����' 

GO