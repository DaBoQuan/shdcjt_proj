delete from SystemRightDetail where rightid =1141
GO
delete from SystemRightsLanguage where id =1141
GO
delete from SystemRights where id =1141
GO
insert into SystemRights (id,rightdesc,righttype) values (1141,'΢������','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1141,7,'΢������','΢������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1141,9,'΢���O��','΢���O��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1141,8,'Blog Setting','Blog Setting') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42352,'΢����������','blog:baseSetting',1141) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42353,'΢��Ӧ������','blog:appSetting',1141) 
GO