delete from SystemRightDetail where rightid = 873
/
delete from SystemRightsLanguage where id = 873
/
delete from SystemRights where id = 873
/

insert into SystemRights (id,rightdesc,righttype) values (873,'�ĵ���־�鿴','7') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (873,7,'�ĵ���־�鿴','�ĵ���־�鿴') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (873,8,'File log view','File log view') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (873,9,'��?��?�鿴','��?��?�鿴') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4395,'�ĵ���־�鿴Ȩ��','FileLogView:View',873) 
/
