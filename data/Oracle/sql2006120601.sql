delete from SystemRights where id=687
/
delete from SystemRightsLanguage where id=687
/
delete from SystemRightDetail where id=4195
/
insert into SystemRights (id,rightdesc,righttype) values (687,'Ԥ�㼶��ά��','2') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (687,8,'Budget Level Maintain','Budget Level Maintain') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (687,7,'Ԥ�㼶��ά��','Ԥ�㼶��ά��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4195,'Ԥ�㼶��ά��','BudgetLevel:Maint',687) 
/
delete from SystemRights where id=688
/
delete from SystemRightsLanguage where id=688
/
delete from SystemRightDetail where id=4196
/

insert into SystemRights (id,rightdesc,righttype) values (688,'Ԥ��Ȩ��ά��','2') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (688,8,'Budget Rights Maintain','Budget Rights Maintain') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (688,7,'Ԥ��Ȩ��ά��','Ԥ��Ȩ��ά��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4196,'Ԥ��Ȩ��ά��','BudgetRights:Maint',688) 
/
delete from SystemRights where id=689
/
delete from SystemRightsLanguage where id=689
/
delete from SystemRightDetail where id=4197
/

insert into SystemRights (id,rightdesc,righttype) values (689,'���õ���','2') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (689,7,'���õ���','���õ���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (689,8,'Fee Data Import','Fee Data Import') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4197,'���õ���','FeeDataImport:Maint',689) 
/

delete from HtmlLabelIndex where id=19856
/
delete from HtmlLabelInfo where indexid=19856
/

INSERT INTO HtmlLabelIndex values(19856,'Ԥ�㼶��') 
/
INSERT INTO HtmlLabelInfo VALUES(19856,'Ԥ�㼶��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19856,'Budget Level',8) 
/
delete from HtmlLabelIndex where id=19857
/
delete from HtmlLabelInfo where indexid=19857
/
INSERT INTO HtmlLabelIndex values(19857,'���¼�Ԥ��ֵ��С�Ƿ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19857,'���¼�Ԥ��ֵ��С�Ƿ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19857,'Budget Value is connected by level',8) 
/
 delete from HtmlLabelIndex where id=19858
/
delete from HtmlLabelInfo where indexid=19858
/
INSERT INTO HtmlLabelIndex values(19858,'�Ƿ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19858,'�Ƿ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19858,'Is Connected',8) 
/
delete from HtmlLabelIndex where id=19880
/
delete from HtmlLabelInfo where indexid=19880
/ 
INSERT INTO HtmlLabelIndex values(19880,'Ԥ��Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19880,'Ԥ��Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19880,'Budget Rights',8) 
/
delete from HtmlLabelIndex where id=19912
/
delete from HtmlLabelInfo where indexid=19912
/
INSERT INTO HtmlLabelIndex values(19912,'ά����Χ') 
/
INSERT INTO HtmlLabelInfo VALUES(19912,'ά����Χ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19912,'Maintenance Scope',8) 
/
 delete from HtmlLabelIndex where id=19914
/
delete from HtmlLabelInfo where indexid=19914
/
INSERT INTO HtmlLabelIndex values(19914,'������ά��') 
/
INSERT INTO HtmlLabelInfo VALUES(19914,'������ά��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19914,'Maintenance Self',8) 
/
delete from HtmlLabelIndex where id=19915
/
delete from HtmlLabelInfo where indexid=19915
/
INSERT INTO HtmlLabelIndex values(19915,'ָ������ά��') 
/
INSERT INTO HtmlLabelInfo VALUES(19915,'ָ������ά��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19915,'Maintenance By Other',8) 
/
delete from HtmlLabelIndex where id=19966
/
delete from HtmlLabelInfo where indexid=19966
/
INSERT INTO HtmlLabelIndex values(19966,'���õ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19966,'���õ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19966,'Fee Data Import',8) 
/
delete from HtmlLabelIndex where id=19968
/
delete from HtmlLabelInfo where indexid=19968
/
INSERT INTO HtmlLabelIndex values(19968,'��ѡ����ÿ�Ŀ') 
/
INSERT INTO HtmlLabelInfo VALUES(19968,'��ѡ����ÿ�Ŀ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19968,'Please Select Fee Subject To Import',8) 
/
delete from HtmlLabelIndex where id=19970
/
delete from HtmlLabelInfo where indexid=19970
/ 
INSERT INTO HtmlLabelIndex values(19970,'������ģ���ļ���������ֵ����!') 
/
INSERT INTO HtmlLabelInfo VALUES(19970,'������ģ���ļ���������ֵ����!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19970,'Please Download Templet , Filled it to Import',8) 
/
delete from HtmlLabelIndex where id=19971
/
delete from HtmlLabelInfo where indexid=19971
/
INSERT INTO HtmlLabelIndex values(19971,'ģ���ļ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19971,'ģ���ļ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19971,'Templet File',8) 
/
 delete from HtmlLabelIndex where id=19984
/
delete from HtmlLabelInfo where indexid=19984
/
INSERT INTO HtmlLabelIndex values(19984,'���õ���ɹ�!')
/
INSERT INTO HtmlLabelInfo VALUES(19984,'���õ���ɹ�!',7)
/
INSERT INTO HtmlLabelInfo VALUES(19984,'Fee Data Import Successfull!',8)
/
 