
delete from HtmlLabelIndex where id=20158
/
delete from HtmlLabelInfo where indexid=20158
/

INSERT INTO HtmlLabelIndex values(20158,'�ƻ�ɾ����־') 
/
INSERT INTO HtmlLabelInfo VALUES(20158,'�ƻ�ɾ����־',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20158,'delte plan log',8) 
/


insert into SystemRights (id,rightdesc,righttype) values (703,'�ƻ�ɾ����־�鿴','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (703,8,'view delete plan log','view delete plan log') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (703,7,'�ƻ�ɾ����־�鿴','�ƻ�ɾ����־�鿴') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4211,'ɾ���ƻ���־�鿴','VIEW PLAN LOG',703) 
/