delete from workflow_filetypeicon where extendname in('wps')
go
insert into workflow_filetypeicon (extendname, iconpath, describe)
values ('wps', 'wps.gif', 'WPS ����')
go