delete from SystemRightDetail where rightid = 843
/
delete from SystemRightsLanguage where id = 843
/
delete from SystemRights where id = 843
/
insert into SystemRights (id,rightdesc,righttype) values (843,'�շ���ά��','1') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (843,7,'�շ���ά��','�շ���ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (843,8,'Send or Reveive Doc Editor','Send or Reveive Doc Editor') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (843,9,'�շ���ά��','�շ���ά��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4358,'�շ���ά��','SRDoc:Edit',843) 
/
