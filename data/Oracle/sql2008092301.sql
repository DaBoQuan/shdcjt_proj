delete from HtmlLabelIndex where id=21899 
/
delete from HtmlLabelInfo where indexid=21899 
/
INSERT INTO HtmlLabelIndex values(21899,'���̰������ͳ�Ʊ�') 
/
INSERT INTO HtmlLabelInfo VALUES(21899,'���̰������ͳ�Ʊ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21899,'Workflow deal report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21899,'',9) 
/
delete from HtmlLabelIndex where id=21904 
/
delete from HtmlLabelInfo where indexid=21904 
/
INSERT INTO HtmlLabelIndex values(21904,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(21904,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21904,'This season',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21904,'',9) 
/
delete from HtmlLabelIndex where id=21906 
/
delete from HtmlLabelInfo where indexid=21906 
/
INSERT INTO HtmlLabelIndex values(21906,'�����������') 
/
delete from HtmlLabelIndex where id=21907 
/
delete from HtmlLabelInfo where indexid=21907 
/
INSERT INTO HtmlLabelIndex values(21907,'�Ѱ�������') 
/
delete from HtmlLabelIndex where id=21908 
/
delete from HtmlLabelInfo where indexid=21908 
/
INSERT INTO HtmlLabelIndex values(21908,'δ��������') 
/
delete from HtmlLabelIndex where id=21909 
/
delete from HtmlLabelInfo where indexid=21909 
/
INSERT INTO HtmlLabelIndex values(21909,'�ڰ�������') 
/
delete from HtmlLabelIndex where id=21911 
/
delete from HtmlLabelInfo where indexid=21911 
/
INSERT INTO HtmlLabelIndex values(21911,'�Ѱ���') 
/
delete from HtmlLabelIndex where id=21905 
/
delete from HtmlLabelInfo where indexid=21905 
/
INSERT INTO HtmlLabelIndex values(21905,'������������') 
/
delete from HtmlLabelIndex where id=21910 
/
delete from HtmlLabelInfo where indexid=21910 
/
INSERT INTO HtmlLabelIndex values(21910,'���������') 
/
delete from HtmlLabelIndex where id=21912 
/
delete from HtmlLabelInfo where indexid=21912 
/
INSERT INTO HtmlLabelIndex values(21912,'�����') 
/
INSERT INTO HtmlLabelInfo VALUES(21905,'������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21905,'All workflow count',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21905,'',9) 
/
INSERT INTO HtmlLabelInfo VALUES(21906,'�����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21906,'Create workflow count',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21906,'',9) 
/
INSERT INTO HtmlLabelInfo VALUES(21907,'�Ѱ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21907,'Handled workflow count',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21907,'',9) 
/
INSERT INTO HtmlLabelInfo VALUES(21908,'δ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21908,'Unread workflow count',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21908,'',9) 
/
INSERT INTO HtmlLabelInfo VALUES(21909,'�ڰ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21909,'Handling workflow count',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21909,'',9) 
/
INSERT INTO HtmlLabelInfo VALUES(21910,'���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21910,'Complete workflow count',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21910,'',9) 
/
INSERT INTO HtmlLabelInfo VALUES(21911,'�Ѱ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21911,'Handled rate',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21911,'',9) 
/
INSERT INTO HtmlLabelInfo VALUES(21912,'�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21912,'Complete rate',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21912,'',9) 
/
delete from HtmlLabelIndex where id=21913 
/
delete from HtmlLabelInfo where indexid=21913 
/
INSERT INTO HtmlLabelIndex values(21913,'�����б�') 
/
INSERT INTO HtmlLabelInfo VALUES(21913,'�����б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21913,'Workflow List',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21913,'',9) 
/



insert into SystemRights (id,rightdesc,righttype) values (802,'���ı���','5') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (802,7,'���ı���','���ı���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (802,8,'Workflow Report','Workflow Report') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (802,9,'','') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4312,'���ı���','Docwf:Report',802) 
/


