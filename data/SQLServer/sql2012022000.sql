delete from SystemRightDetail where rightid =1184
GO
delete from SystemRightsLanguage where id =1184
GO
delete from SystemRights where id =1184
GO
insert into SystemRights (id,rightdesc,righttype) values (1184,'ͼ��Ԫ��ʹ��Ȩ��','0') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1184,7,'ͼ��Ԫ��ʹ��Ȩ��','ͼ��Ԫ��ʹ��Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1184,9,'�D��Ԫ��ʹ���S�ə�','�D��Ԫ��ʹ���S�ə�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1184,8,'ReportFormRight','ReportFormRight') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42400,'ͼ��Ԫ��ʹ��Ȩ��','ReportFormElement',1184) 
GO
