/*���� �˵��Զ��� Ȩ��*/
insert into SystemRights (id,rightdesc,righttype) values (460,'�˵��Զ���','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (460,7,'�˵��Զ���','�˵��Զ���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (460,8,'menuCustom','menuCustom') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3152,'�˵��Զ���','MenuCustom:Maintenance',460) 
/

insert into SystemRightToGroup (groupid, rightid) values (1,419)
/