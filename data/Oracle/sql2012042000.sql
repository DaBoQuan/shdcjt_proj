delete from SystemRightDetail where rightid =1260
/
delete from SystemRightsLanguage where id =1260
/
delete from SystemRights where id =1260
/
insert into SystemRights (id,rightdesc,righttype) values (1260,'��������ɾ��','5') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1260,7,'��������ɾ��','��������ɾ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1260,9,'�yԇ����ɾ��','�yԇ����ɾ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1260,8,'Delete Test-Request','Delete Test-Request') 
/