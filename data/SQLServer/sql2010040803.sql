ALTER PROCEDURE CptCapital_SelectByDataType (@datatype 	int, @departmentid  int, @flag                             integer output, @msg                             varchar(80) output ) AS select * from CptCapital where datatype = @datatype and blongdepartment = @departmentid if @@error<>0 begin set @flag=1 set @msg='��ѯ�ʲ���Ϣ�ɹ�' return end else begin set @flag=0 set @msg='��ѯ�ʲ���Ϣʧ��' return end

GO
