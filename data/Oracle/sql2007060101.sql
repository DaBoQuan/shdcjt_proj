delete from HtmlLabelIndex where id=19870
/
delete from HtmlLabelInfo where indexid=19870
/

INSERT INTO HtmlLabelIndex values(19870,'��Ŀ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19870,'��Ŀ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19870,'',8) 
/

insert into SystemRights (id,rightdesc,righttype) values (98,'��Ŀά��','6') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (98,8,'Project maintenance','Project maintenance') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (98,7,'��Ŀά��','��Ŀά��') 
/