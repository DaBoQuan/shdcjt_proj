delete from SystemRightDetail where rightid = 843
GO
delete from SystemRightsLanguage where id = 843
GO
delete from SystemRights where id = 843
GO
insert into SystemRights (id,rightdesc,righttype) values (843,'�շ���ά��','1') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (843,7,'�շ���ά��','�շ���ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (843,8,'Send or Reveive Doc Editor','Send or Reveive Doc Editor') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (843,9,'�շ���ά��','�շ���ά��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4358,'�շ���ά��','SRDoc:Edit',843) 
GO
