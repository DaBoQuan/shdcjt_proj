/*���� �˵��Զ��� Ȩ��*/
insert into SystemRights (id,rightdesc,righttype) values (460,'�˵��Զ���','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (460,7,'�˵��Զ���','�˵��Զ���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (460,8,'menuCustom','menuCustom') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3152,'�˵��Զ���','MenuCustom:Maintenance',460) 
GO

insert into SystemRightToGroup (groupid, rightid) values (1,419)
GO