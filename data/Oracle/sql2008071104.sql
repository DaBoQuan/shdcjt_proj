delete from SystemRights where id = 790
/
delete from SystemRightsLanguage where id = 790
/
delete from SystemRightDetail where id = 4300
/
insert into SystemRights (id,rightdesc,righttype) values (790,'���������ɫ����','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (790,7,'���������ɫ����','���������ɫ����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (790,8,'set color of leave type','set color of leave type') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4300,'���������ɫ����','LeaveTypeColor:All',790) 
/
