insert into SystemRights (id,rightdesc,righttype) values (416,'������Դ��ʾ˳��','3') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (416,7,'������Դ��ʾ˳��ά��','������Դ��ʾ˳��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (416,8,'Display Order of Human Resource','Display Order of Human Resource') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3105,'������Դ��ʾ˳��鿴','Hrmdsporder:Add',416) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3106,'������Դ��ʾ˳���޸�','HrmdsporderEdit:Edit',416) 
GO
