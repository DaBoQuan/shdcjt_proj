delete from SystemRights where id=687
GO
delete from SystemRightsLanguage where id=687
GO
delete from SystemRightDetail where id=4195
GO
insert into SystemRights (id,rightdesc,righttype) values (687,'Ԥ�㼶��ά��','2') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (687,8,'Budget Level Maintain','Budget Level Maintain') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (687,7,'Ԥ�㼶��ά��','Ԥ�㼶��ά��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4195,'Ԥ�㼶��ά��','BudgetLevel:Maint',687) 
GO
delete from SystemRights where id=688
GO
delete from SystemRightsLanguage where id=688
GO
delete from SystemRightDetail where id=4196
GO

insert into SystemRights (id,rightdesc,righttype) values (688,'Ԥ��Ȩ��ά��','2') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (688,8,'Budget Rights Maintain','Budget Rights Maintain') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (688,7,'Ԥ��Ȩ��ά��','Ԥ��Ȩ��ά��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4196,'Ԥ��Ȩ��ά��','BudgetRights:Maint',688) 
GO
delete from SystemRights where id=689
GO
delete from SystemRightsLanguage where id=689
GO
delete from SystemRightDetail where id=4197
GO

insert into SystemRights (id,rightdesc,righttype) values (689,'���õ���','2') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (689,7,'���õ���','���õ���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (689,8,'Fee Data Import','Fee Data Import') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4197,'���õ���','FeeDataImport:Maint',689) 
GO

delete from HtmlLabelIndex where id=19856
GO
delete from HtmlLabelInfo where indexid=19856
GO

INSERT INTO HtmlLabelIndex values(19856,'Ԥ�㼶��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19856,'Ԥ�㼶��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19856,'Budget Level',8) 
GO
delete from HtmlLabelIndex where id=19857
GO
delete from HtmlLabelInfo where indexid=19857
GO
INSERT INTO HtmlLabelIndex values(19857,'���¼�Ԥ��ֵ��С�Ƿ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19857,'���¼�Ԥ��ֵ��С�Ƿ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19857,'Budget Value is connected by level',8) 
GO
 delete from HtmlLabelIndex where id=19858
GO
delete from HtmlLabelInfo where indexid=19858
GO
INSERT INTO HtmlLabelIndex values(19858,'�Ƿ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19858,'�Ƿ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19858,'Is Connected',8) 
GO
delete from HtmlLabelIndex where id=19880
GO
delete from HtmlLabelInfo where indexid=19880
GO 
INSERT INTO HtmlLabelIndex values(19880,'Ԥ��Ȩ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19880,'Ԥ��Ȩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19880,'Budget Rights',8) 
GO
delete from HtmlLabelIndex where id=19912
GO
delete from HtmlLabelInfo where indexid=19912
GO
INSERT INTO HtmlLabelIndex values(19912,'ά����Χ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19912,'ά����Χ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19912,'Maintenance Scope',8) 
GO
 delete from HtmlLabelIndex where id=19914
GO
delete from HtmlLabelInfo where indexid=19914
GO
INSERT INTO HtmlLabelIndex values(19914,'������ά��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19914,'������ά��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19914,'Maintenance Self',8) 
GO
delete from HtmlLabelIndex where id=19915
GO
delete from HtmlLabelInfo where indexid=19915
GO
INSERT INTO HtmlLabelIndex values(19915,'ָ������ά��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19915,'ָ������ά��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19915,'Maintenance By Other',8) 
GO
delete from HtmlLabelIndex where id=19966
GO
delete from HtmlLabelInfo where indexid=19966
GO
INSERT INTO HtmlLabelIndex values(19966,'���õ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19966,'���õ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19966,'Fee Data Import',8) 
GO
delete from HtmlLabelIndex where id=19968
GO
delete from HtmlLabelInfo where indexid=19968
GO
INSERT INTO HtmlLabelIndex values(19968,'��ѡ����ÿ�Ŀ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19968,'��ѡ����ÿ�Ŀ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19968,'Please Select Fee Subject To Import',8) 
GO
delete from HtmlLabelIndex where id=19970
GO
delete from HtmlLabelInfo where indexid=19970
GO 
INSERT INTO HtmlLabelIndex values(19970,'������ģ���ļ���������ֵ����!') 
GO
INSERT INTO HtmlLabelInfo VALUES(19970,'������ģ���ļ���������ֵ����!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19970,'Please Download Templet , Filled it to Import',8) 
GO
delete from HtmlLabelIndex where id=19971
GO
delete from HtmlLabelInfo where indexid=19971
GO
INSERT INTO HtmlLabelIndex values(19971,'ģ���ļ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19971,'ģ���ļ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19971,'Templet File',8) 
GO
 delete from HtmlLabelIndex where id=19984
GO
delete from HtmlLabelInfo where indexid=19984
GO
INSERT INTO HtmlLabelIndex values(19984,'���õ���ɹ�!')
GO
INSERT INTO HtmlLabelInfo VALUES(19984,'���õ���ɹ�!',7)
GO
INSERT INTO HtmlLabelInfo VALUES(19984,'Fee Data Import Successfull!',8)
GO
 