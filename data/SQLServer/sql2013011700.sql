delete from SystemRightDetail where rightid =1431
GO
delete from SystemRightsLanguage where id =1431
GO
delete from SystemRights where id =1431
GO
insert into SystemRights (id,rightdesc,righttype) values (1431,'���ɹ���','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1431,8,'Integrated management','Integrated management') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1431,7,'���ɹ���','���ɹ���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1431,9,'���ɹ���','���ɹ���') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42686,'���ɹ���','IntegratedManagement:Maint',1431) 
GO 