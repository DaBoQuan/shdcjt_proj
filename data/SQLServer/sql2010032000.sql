delete from SystemRightDetail where rightid =916
GO
delete from SystemRightsLanguage where id =916
GO
delete from SystemRights where id =916
GO
insert into SystemRights (id,rightdesc,righttype) values (916,'Ӧ�÷�Ȩ����','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (916,7,'Ӧ�÷�Ȩ����','Ӧ�÷�Ȩ����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (916,8,'Ӧ�÷�Ȩ����','Ӧ�÷�Ȩ����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (916,9,'���÷֙��O��','���÷֙��O��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4441,'Ӧ�÷�Ȩ����','AppDetach:All',916) 
GO
