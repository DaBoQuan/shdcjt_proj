
delete from HtmlLabelIndex where id=20158
go
delete from HtmlLabelInfo where indexid=20158
go

INSERT INTO HtmlLabelIndex values(20158,'�ƻ�ɾ����־') 
GO
INSERT INTO HtmlLabelInfo VALUES(20158,'�ƻ�ɾ����־',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20158,'delte plan log',8) 
GO



insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (703,8,'view delete plan log','view delete plan log') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (703,7,'�ƻ�ɾ����־�鿴','�ƻ�ɾ����־�鿴') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4211,'ɾ���ƻ���־�鿴','VIEW PLAN LOG',703) 
GO