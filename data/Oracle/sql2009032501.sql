delete from HtmlLabelIndex where id=22517 
/
delete from HtmlLabelInfo where indexid=22517 
/
INSERT INTO HtmlLabelIndex values(22517,'���·�Ŀ¼����Ŀ¼����') 
/
delete from HtmlLabelIndex where id=22518 
/
delete from HtmlLabelInfo where indexid=22518 
/
INSERT INTO HtmlLabelIndex values(22518,'������Ŀ¼����') 
/
INSERT INTO HtmlLabelInfo VALUES(22517,'���·�Ŀ¼����Ŀ¼����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22517,'Refresh the Setting of Subcategory and Seccategory',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22517,'���·�Ŀ䛺���Ŀ��O��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22518,'������Ŀ¼����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22518,'Refresh the Setting of Seccategory',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22518,'������Ŀ��O��',9) 
/


delete from HtmlLabelIndex where id=22580 
/
delete from HtmlLabelInfo where indexid=22580 
/
INSERT INTO HtmlLabelIndex values(22580,'�����ĵ���Ŀ¼�����˸�FTP����������') 
/
delete from HtmlLabelIndex where id=22578 
/
delete from HtmlLabelInfo where indexid=22578 
/
INSERT INTO HtmlLabelIndex values(22578,'�����ĵ���Ŀ¼�����˸�FTP����������') 
/
delete from HtmlLabelIndex where id=22579 
/
delete from HtmlLabelInfo where indexid=22579 
/
INSERT INTO HtmlLabelIndex values(22579,'�����ĵ���Ŀ¼�����˸�FTP����������') 
/
delete from HtmlLabelIndex where id=22581 
/
delete from HtmlLabelInfo where indexid=22581 
/
INSERT INTO HtmlLabelIndex values(22581,'�����ļ������˸�FTP����������') 
/
INSERT INTO HtmlLabelInfo VALUES(22578,'�����ĵ���Ŀ¼�����˸�FTP����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22578,'Those Doc Main Categories call the FTP Server Config',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22578,'�����ęn��Ŀ��{����ԓFTP�ŷ����O��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22579,'�����ĵ���Ŀ¼�����˸�FTP����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22579,'Those Doc Sub Categories call the FTP Server Config',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22579,'�����ęn��Ŀ��{����ԓFTP�ŷ����O��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22580,'�����ĵ���Ŀ¼�����˸�FTP����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22580,'Those Doc Sec Categories call the FTP Server Config',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22580,'�����ęn��Ŀ��{����ԓFTP�ŷ����O��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22581,'�����ļ������˸�FTP����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22581,'Those Files call the FTP Server Config',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22581,'���n�{����ԓFTP�ŷ����O��',9) 
/



delete from SystemRightDetail where rightid=824
/

delete from SystemRightsLanguage where id=824
/

delete from SystemRights where id=824
/

insert into SystemRights (id,rightdesc,righttype) values (824,'FTP����������','1') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (824,8,'FTP Server Config','FTP Server Config') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (824,9,'FTP�ŷ����O��','FTP�ŷ����O��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (824,7,'FTP����������','FTP����������') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4335,'FTP�������������','DocFTPConfigAdd:Add',824) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4336,'FTP���������ñ༭','DocFTPConfigEdit:Edit',824) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4337,'FTP����������ɾ��','DocFTPConfigEdit:Delete',824) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4338,'FTP������������־�鿴','DocFTPConfig:Log',824) 
/
