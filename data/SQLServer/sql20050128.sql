insert into SystemRights (id,rightdesc,righttype) values (457,'֪ʶ���۴��±���鿴Ȩ��','1') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (457,7,'֪ʶ���۴��±���鿴Ȩ��','֪ʶ���۴��±���鿴Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (457,8,'֪ʶ���۴��±���鿴Ȩ��','doccreativereport') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3148,'֪ʶ���۴��±���鿴Ȩ��','docactiverep:View',457) 
GO 
insert into SystemRightToGroup (groupid, rightid) values (2,457)
GO
insert into systemrightroles(rightid,roleid,rolelevel) values (457,3,2)
GO
