delete from SystemRights where id=806
/
insert into SystemRights (id,rightdesc,righttype) values (806,'�ͻ��Ż������޸�Ȩ��','1') 
/
delete from SystemRightsLanguage where id=806
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (806,7,'�ͻ��Ż������޸�Ȩ��',' �ͻ��Ż������޸�Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (806,9,'�ͻ��Ż������޸�Ȩ��','�ͻ��Ż������޸�Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (806,8,'Customer portal password authority to amend','Customer portal password authority to amend') 
/
delete from SystemRightDetail where id=4317
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4317,'�ͻ��Ż������޸�Ȩ��','CRM:CusPassWord',806) 
/
delete from HtmlLabelIndex where id=17993 
/
delete from HtmlLabelInfo where indexid=17993 
/
INSERT INTO HtmlLabelIndex values(17993,'�޸�����') 
/
INSERT INTO HtmlLabelInfo VALUES(17993,'�޸�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17993,'Edit Password',8) 
/
