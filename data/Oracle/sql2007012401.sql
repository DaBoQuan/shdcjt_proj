delete from HtmlLabelIndex where id=20184
/
delete from HtmlLabelIndex where id=20185
/

delete from HtmlLabelInfo where indexid=20184
/
delete from HtmlLabelInfo where indexid=20185
/
INSERT INTO HtmlLabelIndex values(20184,'�ƻ�����') 
/
INSERT INTO HtmlLabelIndex values(20185,'дʵ����') 
/
INSERT INTO HtmlLabelInfo VALUES(20184,'�ƻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20184,'import plan',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20185,'дʵ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20185,'import not',8) 
/
delete from HtmlLabelIndex where id=20188
/

delete from HtmlLabelInfo where indexid=20188
/
INSERT INTO HtmlLabelIndex values(20188,'�ƻ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(20188,'�ƻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20188,'export plan',8) 
/

delete from HtmlLabelIndex where id=20189
/

delete from HtmlLabelInfo where indexid=20189
/
INSERT INTO HtmlLabelIndex values(20189,'дʵ����') 
/
INSERT INTO HtmlLabelInfo VALUES(20189,'дʵ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20189,'export not',8) 
/
 

insert into SystemRights (id,rightdesc,righttype) values (705,'�ƻ�����','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (705,7,'�ƻ�����','�ƻ�����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (705,8,'import plan','import plan') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4213,'�ƻ�����','PlanImport',705) 
/

insert into SystemRights (id,rightdesc,righttype) values (704,'�ƻ�����','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (704,7,'�ƻ�����','�ƻ�����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (704,8,'export plan','export plan') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4212,'�ƻ�����','EXPORTPLAN',704) 
/