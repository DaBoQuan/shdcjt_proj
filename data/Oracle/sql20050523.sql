/*dongping �޸�iconͼƬ����ʾ��ʱ��������*/
update workflow_filetypeicon set iconpath ='excel.gif' where extendName='xls'
/
update workflow_filetypeicon set iconpath ='word.gif' where extendName='doc'
/
update workflow_filetypeicon set iconpath ='html.gif' where extendName='html' or extendName='htm'
/
insert into workflow_filetypeicon (extendName,iconpath,describe) values('other','other.gif','�����ļ�')
/
