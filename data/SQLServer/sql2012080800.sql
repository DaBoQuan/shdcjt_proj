delete from SystemRightDetail where rightid =1297
GO
delete from SystemRightsLanguage where id =1297
GO
delete from SystemRights where id =1297
GO
insert into SystemRights (id,rightdesc,righttype) values (1297,'ģ������','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1297,7,'ģ������','ģ������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1297,8,'Mode Setting','Mode Setting') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1297,9,'ģ�K�O��','ģ�K�O��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42573,'ģ������','ModeSetting:All',1297) 
GO