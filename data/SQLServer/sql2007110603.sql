ALTER PROCEDURE FnaCurrency_SelectAll (@flag                             integer output, @msg                             varchar(80) output ) AS select * from FnaCurrency order by id asc if @@error<>0 begin set @flag=1 set @msg='��ѯ������Ϣ�ɹ�' return end else begin set @flag=0 set @msg='��ѯ������Ϣʧ��' return end

GO