delete from HtmlLabelIndex where id=22353 
/
delete from HtmlLabelInfo where indexid=22353 
/
INSERT INTO HtmlLabelIndex values(22353,'���ڱ�����Ƹ��λ') 
/
INSERT INTO HtmlLabelInfo VALUES(22353,'���ڱ�����Ƹ��λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22353,'General insurance recruitment posts',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22353,'�󱊱��U��Ƹ��λ',9) 
/

delete from HtmlLabelIndex where id=22324 
/
delete from HtmlLabelInfo where indexid=22324 
/
INSERT INTO HtmlLabelIndex values(22324,'��Ƹ��λ') 
/
INSERT INTO HtmlLabelInfo VALUES(22324,'��Ƹ��λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22324,'Recruitment units',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22324,'��Ƹ��λ',9) 
/

delete from HtmlLabelIndex where id=22327 
/
delete from HtmlLabelInfo where indexid=22327 
/
INSERT INTO HtmlLabelIndex values(22327,'��Ƹ����') 
/
INSERT INTO HtmlLabelInfo VALUES(22327,'��Ƹ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22327,'recruitmentcounts',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22327,'��Ƹ�˔�',9) 
/

delete from HtmlLabelIndex where id=22325 
/
delete from HtmlLabelInfo where indexid=22325 
/
INSERT INTO HtmlLabelIndex values(22325,'��Ƹְλ') 
/
INSERT INTO HtmlLabelInfo VALUES(22325,'��Ƹְλ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22325,'Recruitment',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22325,'��Ƹλ',9) 
/


delete from HtmlLabelIndex where id=22326 
/
delete from HtmlLabelInfo where indexid=22326 
/
INSERT INTO HtmlLabelIndex values(22326,'��ֹ����') 
/
INSERT INTO HtmlLabelInfo VALUES(22326,'��ֹ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22326,'Deadline',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22326,'��ֹ����',9) 
/


delete from HtmlLabelIndex where id=17883 
/
delete from HtmlLabelInfo where indexid=17883 
/
INSERT INTO HtmlLabelIndex values(17883,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17883,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17883,'PublishDate',8) 
/

delete from HtmlLabelIndex where id=22328 
/
delete from HtmlLabelInfo where indexid=22328 
/
INSERT INTO HtmlLabelIndex values(22328,'ӦƸ�ʸ�') 
/
INSERT INTO HtmlLabelInfo VALUES(22328,'ӦƸ�ʸ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22328,'Qualified candidates',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22328,'��Ƹ�Y��',9) 
/

delete from HtmlLabelIndex where id=22329 
/
delete from HtmlLabelInfo where indexid=22329 
/
INSERT INTO HtmlLabelIndex values(22329,'��Ƹ����') 
/
INSERT INTO HtmlLabelInfo VALUES(22329,'��Ƹ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22329,'Recruitment of the type of',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22329,'��Ƹ���',9) 
/

delete from HtmlLabelIndex where id=22330 
/
delete from HtmlLabelInfo where indexid=22330 
/
INSERT INTO HtmlLabelIndex values(22330,'�ܲ���Ƹ') 
/
INSERT INTO HtmlLabelInfo VALUES(22330,'�ܲ���Ƹ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22330,'Headquarters recruitment',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22330,'������Ƹ',9) 
/

delete from HtmlLabelIndex where id=22331 
/
delete from HtmlLabelInfo where indexid=22331 
/
INSERT INTO HtmlLabelIndex values(22331,'�ֹ�˾��Ƹ') 
/
INSERT INTO HtmlLabelInfo VALUES(22331,'�ֹ�˾��Ƹ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22331,'Branch Recruitment',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22331,'�ֹ�˾��Ƹ',9) 
/

delete from HtmlLabelIndex where id=22332 
/
delete from HtmlLabelInfo where indexid=22332 
/
INSERT INTO HtmlLabelIndex values(22332,'У԰��Ƹ') 
/
INSERT INTO HtmlLabelInfo VALUES(22332,'У԰��Ƹ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22332,'Campus Recruitment',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22332,'У�@��Ƹ',9) 
/

delete from HtmlLabelIndex where id=22346 
/
delete from HtmlLabelInfo where indexid=22346 
/
INSERT INTO HtmlLabelIndex values(22346,'��ѡ��Ҫɾ������Ϣ') 
/
INSERT INTO HtmlLabelInfo VALUES(22346,'��ѡ��Ҫɾ������Ϣ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22346,'Please select the information you want to delete',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22346,'Ո�x��Ҫ�h�����YӍ',9) 
/

delete from SystemRights where id = 814
/
delete from SystemRightsLanguage where id = 814
/
delete from SystemRightDetail where id = 4325
/

insert into SystemRights (id,rightdesc,righttype) values (814,'��Ƹ��λ','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (814,9,'��Ƹ?λ','��Ƹ?λ') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (814,7,'��Ƹ��λ','��Ƹ��λ') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (814,8,'Recruitment job','Recruitment job') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4325,'��Ƹ��λ_�༭','ResourcesInformationSystem:ALL',814) 
/