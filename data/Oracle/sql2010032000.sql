delete from SystemRightDetail where rightid =916
/
delete from SystemRightsLanguage where id =916
/
delete from SystemRights where id =916
/
insert into SystemRights (id,rightdesc,righttype) values (916,'Ӧ�÷�Ȩ����','7') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (916,7,'Ӧ�÷�Ȩ����','Ӧ�÷�Ȩ����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (916,8,'Ӧ�÷�Ȩ����','Ӧ�÷�Ȩ����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (916,9,'���÷֙��O��','���÷֙��O��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4441,'Ӧ�÷�Ȩ����','AppDetach:All',916) 
/
