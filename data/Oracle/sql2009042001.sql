delete from SystemRights where id =840
/
delete from SystemRightsLanguage where id =840
/
delete from SystemRightDetail where id =4355
/

insert into SystemRights (id,rightdesc,righttype) values (840,'����ȡ��Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (840,7,'����ȡ��Ȩ��','����ȡ��Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (840,9,'���hȡ������','���hȡ������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (840,8,'Canceled permissions','Canceled permissions') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4355,'����ȡ��Ȩ��','Canceledpermissions:Edit',840) 
/