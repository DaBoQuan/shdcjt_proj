delete from HtmlLabelIndex where id=20063 
/
delete from HtmlLabelInfo where indexid=20063 
/
INSERT INTO HtmlLabelIndex values(20063,'������뵥') 
/
INSERT INTO HtmlLabelInfo VALUES(20063,'������뵥',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20063,'Leave Bill',8) 
/

delete from HtmlLabelIndex where id=21624 
/
delete from HtmlLabelInfo where indexid=21624 
/
INSERT INTO HtmlLabelIndex values(21624,'��������������������û�����������������޸����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(21624,'��������������������û�����������������޸����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21624,'The annual leave days requested by the user may request more than a few days of annual leave,please modify the leave time',8) 
/
delete from HtmlLabelIndex where id=21620 
/
delete from HtmlLabelInfo where indexid=21620 
/
INSERT INTO HtmlLabelIndex values(21620,'��ٵ���ɹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(21620,'��ٵ���ɹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21620,'Annual leave loaded success!',8) 
/
delete from HtmlLabelIndex where id=21600 
/
delete from HtmlLabelInfo where indexid=21600 
/
INSERT INTO HtmlLabelIndex values(21600,'�������') 
/
INSERT INTO HtmlLabelInfo VALUES(21600,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21600,'Set annual leave',8) 
/

delete from HtmlLabelIndex where id=21598 
/
delete from HtmlLabelInfo where indexid=21598 
/
INSERT INTO HtmlLabelIndex values(21598,'�����Ч������') 
/
INSERT INTO HtmlLabelInfo VALUES(21598,'�����Ч������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21598,'Set Annual leave period',8) 
/
delete from HtmlLabelIndex where id=21590 
/
delete from HtmlLabelInfo where indexid=21590 
/
INSERT INTO HtmlLabelIndex values(21590,'��ٹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(21590,'��ٹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21590,'Management of annual leave',8) 
/

delete from HtmlLabelIndex where id=21599 
/
delete from HtmlLabelInfo where indexid=21599 
/
INSERT INTO HtmlLabelIndex values(21599,'���������������') 
/
INSERT INTO HtmlLabelInfo VALUES(21599,'���������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21599,'Annual Batch processing settings',8) 
/

delete from HtmlLabelIndex where id=21614 
/
delete from HtmlLabelInfo where indexid=21614 
/
INSERT INTO HtmlLabelIndex values(21614,'��һ������������') 
/
delete from HtmlLabelIndex where id=21615 
/
delete from HtmlLabelInfo where indexid=21615 
/
INSERT INTO HtmlLabelIndex values(21615,'����ʣ���������') 
/
delete from HtmlLabelIndex where id=21616 
/
delete from HtmlLabelInfo where indexid=21616 
/
INSERT INTO HtmlLabelIndex values(21616,'��ǰ�����������') 
/
INSERT INTO HtmlLabelInfo VALUES(21614,'��һ������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21614,'The previous year may request annual leave days',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21615,'����ʣ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21615,'This year the number of days remaining annual leave',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21616,'��ǰ�����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21616,'Is currently available in a few days annual leave',8) 
/

delete from HtmlLabelIndex where id=21612 
/
delete from HtmlLabelInfo where indexid=21612 
/
INSERT INTO HtmlLabelIndex values(21612,'�����������ʧ�ܣ���Ϊ��û�ж��������������г�ʼ�����ã������ã�') 
/
INSERT INTO HtmlLabelInfo VALUES(21612,'�����������ʧ�ܣ���Ϊ��û�ж��������������г�ʼ�����ã������ã�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21612,'Annual leave batch processing failure,Because you do not have the bulk of annual leave to deal with initialization settings, set up!',8) 
/

delete from HtmlLabelIndex where id=21611 
/
delete from HtmlLabelInfo where indexid=21611 
/
INSERT INTO HtmlLabelIndex values(21611,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(21611,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21611,'Batch processing',8) 
/
delete from HtmlLabelIndex where id=21609 
/
delete from HtmlLabelInfo where indexid=21609 
/
INSERT INTO HtmlLabelIndex values(21609,'���������ɫ����') 
/
INSERT INTO HtmlLabelInfo VALUES(21609,'���������ɫ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21609,'set color of leave type',8) 
/

delete from HtmlLabelIndex where id=21602 
/
delete from HtmlLabelInfo where indexid=21602 
/
INSERT INTO HtmlLabelIndex values(21602,'���') 
/
INSERT INTO HtmlLabelInfo VALUES(21602,'���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21602,'Annual leave',8) 
/
delete from SystemRights where id = 790
/
delete from SystemRightsLanguage where id = 790
/
delete from SystemRightDetail where id = 4300
/
insert into SystemRights (id,rightdesc,righttype) values (790,'���������ɫ����','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (790,7,'���������ɫ����','���������ɫ����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (790,8,'set color of leave type','set color of leave type') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4300,'���������ɫ����','LeaveTypeColor:all',790) 
/

delete from SystemRights where id = 789
/
delete from SystemRightsLanguage where id = 789
/
delete from SystemRightDetail where id = 4299
/
insert into SystemRights (id,rightdesc,righttype) values (789,'���������������','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (789,8,'Annual Batch processing settings','Annual Batch processing settings') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (789,7,'���������������','���������������') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4299,'���������������','AnnualBatch:All',789) 
/

delete from SystemRights where id = 788
/
delete from SystemRightsLanguage where id = 788
/
delete from SystemRightDetail where id = 4298
/
insert into SystemRights (id,rightdesc,righttype) values (788,'�����Ч������','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (788,8,'Set Annual leave period','Set Annual leave period') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (788,7,'�����Ч������','�����Ч������') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4298,'�����Ч������','AnnualPeriod:All',788) 
/

delete from SystemRights where id = 787
/
delete from SystemRightsLanguage where id = 787
/
delete from SystemRightDetail where id = 4297
/
insert into SystemRights (id,rightdesc,righttype) values (787,'��ٹ���','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (787,7,'��ٹ���','��ٹ���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (787,8,'Management of annual leave','Management of annual leave') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4297,'��ٹ���','AnnualLeave:All',787) 
/
delete from HtmlLabelIndex where id=19517 
/
delete from HtmlLabelInfo where indexid=19517 
/
INSERT INTO HtmlLabelIndex values(19517,'�������') 
/
INSERT INTO HtmlLabelInfo VALUES(19517,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19517,'Annual Days',8) 
/

delete from HtmlLabelIndex where id=21669 
/
delete from HtmlLabelInfo where indexid=21669 
/
INSERT INTO HtmlLabelIndex values(21669,'��ȷ��������ͬ�����¼���λ�𣿴˲��������������¼���λ�����ã�') 
/
INSERT INTO HtmlLabelInfo VALUES(21669,'��ȷ��������ͬ�����¼���λ�𣿴˲��������������¼���λ�����ã�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21669,'Are you sure this setting simultaneously to the lower level units? This will cover all subordinate units set up!',8) 
/
delete from HtmlLabelIndex where id=21670 
/
delete from HtmlLabelInfo where indexid=21670 
/
INSERT INTO HtmlLabelIndex values(21670,'��ȷ��Ҫɾ���𣿲�ͬ�����¼���λ���˲�����ɾ�������¼���λ�����ã�') 
/
INSERT INTO HtmlLabelInfo VALUES(21670,'��ȷ��Ҫɾ���𣿲�ͬ�����¼���λ���˲�����ɾ�������¼���λ�����ã�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21670,'Are you sure you want to delete it &raquo; And simultaneously to the lower-level units, this action will remove all lower-level units set up!',8) 
/
delete from HtmlLabelIndex where id=21671 
/
delete from HtmlLabelInfo where indexid=21671 
/
INSERT INTO HtmlLabelIndex values(21671,'ͬ���¼���λ') 
/
INSERT INTO HtmlLabelInfo VALUES(21671,'ͬ���¼���λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21671,'Synchronization subordinate units',8) 
/

delete from HtmlLabelIndex where id=21677 
/
delete from HtmlLabelInfo where indexid=21677 
/
INSERT INTO HtmlLabelIndex values(21677,'û��ѡ��Ҫͬ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(21677,'û��ѡ��Ҫͬ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21677,'Did not choose to synchronize the items!',8) 
/


delete from HtmlLabelIndex where id=21720 
/
delete from HtmlLabelInfo where indexid=21720 
/
INSERT INTO HtmlLabelIndex values(21720,'�����������Ϊ0����������٣�') 
/
INSERT INTO HtmlLabelInfo VALUES(21720,'�����������Ϊ0����������٣�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21720,'The annual leave you left is zero, you can not take annual leave!',8) 
/
delete from HtmlLabelIndex where id=21721 
/
delete from HtmlLabelInfo where indexid=21721 
/
INSERT INTO HtmlLabelIndex values(21721,'����������������������Ŀ���������������޸����ʱ�䣡') 
/
INSERT INTO HtmlLabelInfo VALUES(21721,'����������������������Ŀ���������������޸����ʱ�䣡',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21721,'The number of the annual leave you request is more than you left��please modify the time!',8) 
/

