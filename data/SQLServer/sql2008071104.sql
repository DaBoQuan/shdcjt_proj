delete from SystemRights where id = 790
go
delete from SystemRightsLanguage where id = 790
go
delete from SystemRightDetail where id = 4300
go
insert into SystemRights (id,rightdesc,righttype) values (790,'���������ɫ����','3') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (790,7,'���������ɫ����','���������ɫ����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (790,8,'set color of leave type','set color of leave type') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4300,'���������ɫ����','LeaveTypeColor:All',790) 
GO
