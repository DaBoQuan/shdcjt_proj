delete from HtmlLabelIndex where id=21723 
GO
delete from HtmlLabelInfo where indexid=21723 
GO
INSERT INTO HtmlLabelIndex values(21723,'ͶƱ�󲻿ɲ鿴���') 
GO
INSERT INTO HtmlLabelInfo VALUES(21723,'ͶƱ�󲻿ɲ鿴���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21723,'After the voting results can not be read',8) 
GO
delete from HtmlLabelIndex where id=21724 
GO
delete from HtmlLabelInfo where indexid=21724 
GO
INSERT INTO HtmlLabelIndex values(21724,'ͶƱ�ѳɹ���лл���룡') 
GO
INSERT INTO HtmlLabelInfo VALUES(21724,'ͶƱ�ѳɹ���лл���룡',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21724,'Vote has been successful, thank you participate!',8) 
GO
delete from HtmlLabelIndex where id=21725 
GO
delete from HtmlLabelInfo where indexid=21725 
GO
INSERT INTO HtmlLabelIndex values(21725,'��ѡ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(21725,'��ѡ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21725,'Can be few options',8) 
GO
delete from HtmlLabelIndex where id=21726 
GO
delete from HtmlLabelInfo where indexid=21726 
GO
INSERT INTO HtmlLabelIndex values(21726,'��ѡȡ����涨,������ѡȡ') 
GO
INSERT INTO HtmlLabelInfo VALUES(21726,'��ѡȡ����涨,������ѡȡ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21726,'You can select the items over, please re-select',8) 
GO
delete from HtmlLabelIndex where id=21727 
GO
delete from HtmlLabelInfo where indexid=21727 
GO
INSERT INTO HtmlLabelIndex values(21727,'��ͶƱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(21727,'��ͶƱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21727,'Voters have',8) 
GO
delete from HtmlLabelIndex where id=21728 
GO
delete from HtmlLabelInfo where indexid=21728 
GO
INSERT INTO HtmlLabelIndex values(21728,'δͶƱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(21728,'δͶƱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21728,'People did not vote',8) 
GO

delete from SystemRights where id=792
go
insert into SystemRights (id,rightdesc,righttype) values (792,'����ɾ��Ȩ��','1') 
GO
delete from SystemRightsLanguage where id=792
go
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (792,7,'����ɾ��Ȩ��','����ɾ��Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (792,8,'votingDelete','votingDelete') 
GO
delete from SystemRightDetail where id=4302
go
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4302,'����ɾ��Ȩ��','voting:delete',792) 
GO
delete from SystemRights where id=793
GO
insert into SystemRights (id,rightdesc,righttype) values (793,'������ϸ��Ϣ�鿴Ȩ��','1') 
GO
delete from SystemRightsLanguage where id=793
go
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (793,7,'������ϸ��Ϣ�鿴Ȩ��','������ϸ��Ϣ�鿴Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (793,8,'votingParticular','votingParticular') 
GO
delete from SystemRightDetail where id=4303
go
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4303,'������ϸ��Ϣ�鿴Ȩ��','voting:particular',793) 
GO

delete from HtmlLabelIndex where id=21765 
GO
delete from HtmlLabelInfo where indexid=21765 
GO
INSERT INTO HtmlLabelIndex values(21765,'���������0������!') 
GO
INSERT INTO HtmlLabelInfo VALUES(21765,'���������0������!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21765,'Please enter the number greater than 0!',8) 
GO