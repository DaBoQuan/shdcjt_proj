delete from SystemRightDetail where rightid = 935
/
delete from SystemRightsLanguage where id = 935
/
delete from SystemRights where id = 935
/

insert into SystemRights (id,rightdesc,righttype) values (935,'�ĵ��ö�Ȩ��','1') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (935,7,'�ĵ��ö�Ȩ��','�ĵ��ö�Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (935,8,'Document Top Permissions','Document Top Permissions') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (935,9,'�ęn��픙���','�ęn��픙���') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4462,'�ĵ��ö�Ȩ��','Document:Top',935) 
/
