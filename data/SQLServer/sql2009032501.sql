delete from HtmlLabelIndex where id=22517 
GO
delete from HtmlLabelInfo where indexid=22517 
GO
INSERT INTO HtmlLabelIndex values(22517,'���·�Ŀ¼����Ŀ¼����') 
GO
delete from HtmlLabelIndex where id=22518 
GO
delete from HtmlLabelInfo where indexid=22518 
GO
INSERT INTO HtmlLabelIndex values(22518,'������Ŀ¼����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22517,'���·�Ŀ¼����Ŀ¼����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22517,'Refresh the Setting of Subcategory and Seccategory',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22517,'���·�Ŀ䛺���Ŀ��O��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22518,'������Ŀ¼����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22518,'Refresh the Setting of Seccategory',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22518,'������Ŀ��O��',9) 
GO


delete from HtmlLabelIndex where id=22580 
GO
delete from HtmlLabelInfo where indexid=22580 
GO
INSERT INTO HtmlLabelIndex values(22580,'�����ĵ���Ŀ¼�����˸�FTP����������') 
GO
delete from HtmlLabelIndex where id=22578 
GO
delete from HtmlLabelInfo where indexid=22578 
GO
INSERT INTO HtmlLabelIndex values(22578,'�����ĵ���Ŀ¼�����˸�FTP����������') 
GO
delete from HtmlLabelIndex where id=22579 
GO
delete from HtmlLabelInfo where indexid=22579 
GO
INSERT INTO HtmlLabelIndex values(22579,'�����ĵ���Ŀ¼�����˸�FTP����������') 
GO
delete from HtmlLabelIndex where id=22581 
GO
delete from HtmlLabelInfo where indexid=22581 
GO
INSERT INTO HtmlLabelIndex values(22581,'�����ļ������˸�FTP����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22578,'�����ĵ���Ŀ¼�����˸�FTP����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22578,'Those Doc Main Categories call the FTP Server Config',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22578,'�����ęn��Ŀ��{����ԓFTP�ŷ����O��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22579,'�����ĵ���Ŀ¼�����˸�FTP����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22579,'Those Doc Sub Categories call the FTP Server Config',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22579,'�����ęn��Ŀ��{����ԓFTP�ŷ����O��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22580,'�����ĵ���Ŀ¼�����˸�FTP����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22580,'Those Doc Sec Categories call the FTP Server Config',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22580,'�����ęn��Ŀ��{����ԓFTP�ŷ����O��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22581,'�����ļ������˸�FTP����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22581,'Those Files call the FTP Server Config',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22581,'���n�{����ԓFTP�ŷ����O��',9) 
GO



delete from SystemRightDetail where rightid=824
GO

delete from SystemRightsLanguage where id=824
GO

delete from SystemRights where id=824
GO

insert into SystemRights (id,rightdesc,righttype) values (824,'FTP����������','1') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (824,8,'FTP Server Config','FTP Server Config') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (824,9,'FTP�ŷ����O��','FTP�ŷ����O��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (824,7,'FTP����������','FTP����������') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4335,'FTP�������������','DocFTPConfigAdd:Add',824) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4336,'FTP���������ñ༭','DocFTPConfigEdit:Edit',824) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4337,'FTP����������ɾ��','DocFTPConfigEdit:Delete',824) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4338,'FTP������������־�鿴','DocFTPConfig:Log',824) 
GO