delete from HtmlLabelIndex where id=22353 
GO
delete from HtmlLabelInfo where indexid=22353 
GO
INSERT INTO HtmlLabelIndex values(22353,'���ڱ�����Ƹ��λ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22353,'���ڱ�����Ƹ��λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22353,'General insurance recruitment posts',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22353,'�󱊱��U��Ƹ��λ',9) 
GO

delete from HtmlLabelIndex where id=22324 
GO
delete from HtmlLabelInfo where indexid=22324 
GO
INSERT INTO HtmlLabelIndex values(22324,'��Ƹ��λ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22324,'��Ƹ��λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22324,'Recruitment units',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22324,'��Ƹ��λ',9) 
GO

delete from HtmlLabelIndex where id=22327 
GO
delete from HtmlLabelInfo where indexid=22327 
GO
INSERT INTO HtmlLabelIndex values(22327,'��Ƹ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22327,'��Ƹ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22327,'recruitmentcounts',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22327,'��Ƹ�˔�',9) 
GO

delete from HtmlLabelIndex where id=22325 
GO
delete from HtmlLabelInfo where indexid=22325 
GO
INSERT INTO HtmlLabelIndex values(22325,'��Ƹְλ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22325,'��Ƹְλ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22325,'Recruitment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22325,'��Ƹλ',9) 
GO


delete from HtmlLabelIndex where id=22326 
GO
delete from HtmlLabelInfo where indexid=22326 
GO
INSERT INTO HtmlLabelIndex values(22326,'��ֹ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22326,'��ֹ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22326,'Deadline',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22326,'��ֹ����',9) 
GO


delete from HtmlLabelIndex where id=17883 
GO
delete from HtmlLabelInfo where indexid=17883 
GO
INSERT INTO HtmlLabelIndex values(17883,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17883,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17883,'PublishDate',8) 
GO

delete from HtmlLabelIndex where id=22328 
GO
delete from HtmlLabelInfo where indexid=22328 
GO
INSERT INTO HtmlLabelIndex values(22328,'ӦƸ�ʸ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(22328,'ӦƸ�ʸ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22328,'Qualified candidates',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22328,'��Ƹ�Y��',9) 
GO

delete from HtmlLabelIndex where id=22329 
GO
delete from HtmlLabelInfo where indexid=22329 
GO
INSERT INTO HtmlLabelIndex values(22329,'��Ƹ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22329,'��Ƹ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22329,'Recruitment of the type of',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22329,'��Ƹ���',9) 
GO

delete from HtmlLabelIndex where id=22330 
GO
delete from HtmlLabelInfo where indexid=22330 
GO
INSERT INTO HtmlLabelIndex values(22330,'�ܲ���Ƹ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22330,'�ܲ���Ƹ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22330,'Headquarters recruitment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22330,'������Ƹ',9) 
GO

delete from HtmlLabelIndex where id=22331 
GO
delete from HtmlLabelInfo where indexid=22331 
GO
INSERT INTO HtmlLabelIndex values(22331,'�ֹ�˾��Ƹ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22331,'�ֹ�˾��Ƹ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22331,'Branch Recruitment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22331,'�ֹ�˾��Ƹ',9) 
GO

delete from HtmlLabelIndex where id=22332 
GO
delete from HtmlLabelInfo where indexid=22332 
GO
INSERT INTO HtmlLabelIndex values(22332,'У԰��Ƹ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22332,'У԰��Ƹ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22332,'Campus Recruitment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22332,'У�@��Ƹ',9) 
GO

delete from HtmlLabelIndex where id=22346 
GO
delete from HtmlLabelInfo where indexid=22346 
GO
INSERT INTO HtmlLabelIndex values(22346,'��ѡ��Ҫɾ������Ϣ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22346,'��ѡ��Ҫɾ������Ϣ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22346,'Please select the information you want to delete',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22346,'Ո�x��Ҫ�h�����YӍ',9) 
GO

delete from SystemRights where id = 814
GO
delete from SystemRightsLanguage where id = 814
GO
delete from SystemRightDetail where id = 4325
GO

insert into SystemRights (id,rightdesc,righttype) values (814,'��Ƹ��λ','3') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (814,9,'��Ƹ?λ','��Ƹ?λ') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (814,7,'��Ƹ��λ','��Ƹ��λ') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (814,8,'Recruitment job','Recruitment job') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4325,'��Ƹ��λ_�༭','ResourcesInformationSystem:ALL',814) 
GO