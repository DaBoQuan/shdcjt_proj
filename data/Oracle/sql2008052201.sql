delete from HtmlLabelIndex where id=20221 
/
delete from HtmlLabelInfo where indexid=20221 
/
INSERT INTO HtmlLabelIndex values(20221,'�ճ̹�������') 
/
INSERT INTO HtmlLabelInfo VALUES(20221,'�ճ̹�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20221,'Work Plan Share Setting',8) 
/

delete from HtmlLabelIndex where id=21503 
/
delete from HtmlLabelInfo where indexid=21503 
/
INSERT INTO HtmlLabelIndex values(21503,'�����ճ�') 
/
INSERT INTO HtmlLabelInfo VALUES(21503,'�����ճ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21503,'share calendar',8) 
/

delete from HtmlLabelIndex where id=21504 
/
delete from HtmlLabelInfo where indexid=21504 
/
INSERT INTO HtmlLabelIndex values(21504,'���������') 
/
INSERT INTO HtmlLabelInfo VALUES(21504,'���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21504,'shared object',8) 
/
delete from HtmlLabelIndex where id=19117 
/
delete from HtmlLabelInfo where indexid=19117 
/
INSERT INTO HtmlLabelIndex values(19117,'�������') 
/
INSERT INTO HtmlLabelInfo VALUES(19117,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19117,'Share Object',8) 
/

delete from SystemRights where id=784
/
insert into SystemRights (id,rightdesc,righttype) values (784,'�ճ̹���','7') 
/
delete from SystemRightsLanguage where id=784
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (784,8,'clander share','clander share') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (784,7,'�ճ̹���','�ճ̹���') 
/
delete from SystemRightDetail where id=4294
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4294,'�ճ̹���','SHARERIGHT:WORKPLAN',784) 
/
