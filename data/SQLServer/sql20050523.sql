/*dongping �޸�iconͼƬ����ʾ��ʱ��������*/
update workflow_filetypeicon set iconpath ='excel.gif' where extendName='xls'
go
update workflow_filetypeicon set iconpath ='word.gif' where extendName='doc'
go
update workflow_filetypeicon set iconpath ='html.gif' where extendName='html' or extendName='htm'
go
insert into workflow_filetypeicon (extendName,iconpath,describe) values('other','other.gif','�����ļ�')
go
