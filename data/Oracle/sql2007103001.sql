delete from SystemRights where id=725
/
delete from SystemRightsLanguage where id=725
/
delete from SystemRightDetail where rightid=725
/
insert into SystemRights (id,rightdesc,righttype) values (725,'Э���������','1') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (725,7,'Э���������','Э���������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (725,8,'set collaboration type','set collaboration type') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4233,'Э���������','collaborationtype:edit',725) 
/

delete from SystemRights where id=726
/
delete from SystemRightsLanguage where id=726
/
delete from SystemRightDetail where rightid=726
/
insert into SystemRights (id,rightdesc,righttype) values (726,'Э��������','1') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (726,7,'Э��������','Э��������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (726,8,'set collaboration area','set collaboration area') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4235,'Э��������','collaborationarea:edit',726) 
/

delete from SystemRights where id=727
/
delete from SystemRightsLanguage where id=727
/
delete from SystemRightDetail where rightid=727
/
insert into SystemRights (id,rightdesc,righttype) values (727,'Э�����','1') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (727,7,'Э�����','Э�����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (727,8,'collaboration Manage','collaboration Manage') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4234,'Э�����','collaborationmanager:edit',727) 
/