delete from SystemRightDetail where rightid = 909
/
delete from SystemRightsLanguage where id = 909
/
delete from SystemRights where id = 909
/

insert into SystemRights (id,rightdesc,righttype) values (909,'������־Ȩ��','5') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (909,7,'������־Ȩ��','������־Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (909,8,'right for log of agent','right for log of agent') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (909,9,'�������I����','�������I����') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4435,'������־Ȩ��','AgentLog:View',909) 
/
