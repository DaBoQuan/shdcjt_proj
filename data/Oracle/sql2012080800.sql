delete from SystemRightDetail where rightid =1297
/
delete from SystemRightsLanguage where id =1297
/
delete from SystemRights where id =1297
/
insert into SystemRights (id,rightdesc,righttype) values (1297,'ģ������','7') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1297,7,'ģ������','ģ������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1297,8,'Mode Setting','Mode Setting') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1297,9,'ģ�K�O��','ģ�K�O��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42573,'ģ������','ModeSetting:All',1297) 
/