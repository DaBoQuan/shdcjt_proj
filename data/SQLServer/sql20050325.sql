/*����ɾ������ԭ���û�ɾ��������*/
delete workflow_currentoperator where requestid in (select requestid from workflow_requestbase where deleted=1) 
go
delete workflow_form where requestid in (select requestid from workflow_requestbase where deleted=1) 
go
delete workflow_requestLog where requestid in (select requestid from workflow_requestbase where deleted=1 ) 
go
delete workflow_requestViewLog where id in (select requestid from workflow_requestbase where deleted=1) 
go
delete workflow_requestbase where deleted=1
go



/*������鵵�Ĳ�����״̬����Ϊ4������������ܲ鿴�������ǹ浵��*/
update  workflow_currentoperator  set isremark='4'  where  requestid in (select requestid  from workflow_requestbase where currentnodetype = '3' )
go