delete from HtmlLabelIndex where id=20421 or id=18446
go
delete from HtmlLabelInfo where indexid=20421 or indexid=18446
go

delete from HtmlLabelIndex where id=20422
go
delete from HtmlLabelInfo where indexid=20422
go
delete from HtmlLabelIndex where id=20454
go
delete from HtmlLabelInfo where indexid=20454
go

delete from HtmlLabelIndex where id>=20456 and id<=20469
go
delete from HtmlLabelInfo where indexid>=20456 and indexid<=20469
go

delete from HtmlLabelIndex where id=20472 or id=20473 or id=20475 or id=20478 or  id=20479 or id=20480 or id=20488
go
delete from HtmlLabelInfo where indexid=20472 or indexid=20473 or indexid=20475 or indexid=20478 or  indexid=20479 or indexid=20480 or indexid=2048
go
INSERT INTO HtmlLabelIndex values(18446,'ȫ�ļ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18446,'ȫ�ļ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18446,'Search ALL',8) 
GO

INSERT INTO HtmlLabelIndex values(20422,'�ĵ�ȫ�ļ��������������')
GO
INSERT INTO HtmlLabelIndex values(20421,'�ĵ����ݵ�ȫ�ļ�������')
GO
INSERT INTO HtmlLabelInfo VALUES(20421,'ȫ������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20421,'docs search',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20422,'������������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20422,'Manager index of search',8)
GO

INSERT INTO HtmlLabelIndex values(20457,'�������Ϊ��')
GO
INSERT INTO HtmlLabelIndex values(20458,'��������������')
GO
INSERT INTO HtmlLabelIndex values(20462,'ɾ��ʧ��')
GO
INSERT INTO HtmlLabelIndex values(20463,'���������Ʋ���Ϊ��')
GO
INSERT INTO HtmlLabelIndex values(20467,'�������������')
GO
INSERT INTO HtmlLabelIndex values(20468,'�ֶ�������������')
GO
INSERT INTO HtmlLabelIndex values(20469,'����Դ��Χ')
GO

INSERT INTO HtmlLabelIndex values(20475,'����������')
GO
INSERT INTO HtmlLabelIndex values(20454,'�ĵ�ȫ�ļ���')
GO
INSERT INTO HtmlLabelIndex values(20456,'�ؼ��ֲ���Ϊ��!')
GO
INSERT INTO HtmlLabelIndex values(20459,'����Դ�Ѵ�����')
GO
INSERT INTO HtmlLabelIndex values(20461,'ɾ���ɹ�')
GO
INSERT INTO HtmlLabelIndex values(20464,'ȷ��ɾ������������,�޷��ָ�(Y/N)')
GO
INSERT INTO HtmlLabelIndex values(20465,'��ѡ����ʼ����')
GO
INSERT INTO HtmlLabelIndex values(20466,'�ͽ�������')
GO
INSERT INTO HtmlLabelIndex values(20472,'��������')
GO
INSERT INTO HtmlLabelIndex values(20460,'������')
GO
INSERT INTO HtmlLabelIndex values(20473,'����ϵͳ��������')
GO
INSERT INTO HtmlLabelInfo VALUES(20454,'�ĵ�ȫ�ļ���',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20454,'Document full-text search',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20456,'�ؼ��ֲ���Ϊ��!',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20456,'Keywords can not be empty!',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20457,'�ؼ���{key}�������Ϊ��,�����һҳ��!',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20457,'{key} keyword search results for the air, or the last one!',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20458,'��������������,���ڴ�����,�������������.',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20458,'Create index added completion, which is being created, please continue other operations.',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20459,'����Դ�Ѵ�����',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20459,'Index Source data has established over',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20460,'������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20460,'Index database',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20461,'ɾ���ɹ�',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20461,'delete success',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20462,'ɾ��ʧ��',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20462,'Delete failure',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20463,'���������Ʋ���Ϊ��',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20463,'Index of the name can not be empty',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20464,'ȷ��ɾ������������,�޷��ָ�(Y/N)',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20464,'Are you confirm the deletion of the index database, unable to resume(Y/N)',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20465,'��ѡ����ʼ����',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20465,'Please choose the start date',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20466,'�ͽ�������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20466,'and end date',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20467,'�������������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20467,'Index database manager and configure',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20468,'�ֶ�������������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20468,'Setup manually create indexes',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20469,'����Դ��Χ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20469,'Index Sources scope',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20472,'��������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20472,'Create index',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20473,'����ϵͳ��������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20473,'Search System properties setup',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20475,'����������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20475,'Index database name',8)
GO
INSERT INTO HtmlLabelIndex values(20478,'ָ��ĳһ�·�')
GO
INSERT INTO HtmlLabelIndex values(20479,'��ʼ���ڵ���������')
GO
INSERT INTO HtmlLabelIndex values(20480,'��ʼ����������')
GO
INSERT INTO HtmlLabelInfo VALUES(20478,'ָ��ĳһ�·�',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20478,'A month',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20479,'��ʼ���ڵ���������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20479,'Start date to the end date',8)
GO
INSERT INTO HtmlLabelInfo VALUES(20480,'��ʼ����������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20480,'Start date to yesterday',8)
GO
INSERT INTO HtmlLabelIndex values(20488,'����Դ�������Χ')
GO
INSERT INTO HtmlLabelInfo VALUES(20488,'ע��:����Դ�������ΧΪһ������.',7)
GO
INSERT INTO HtmlLabelInfo VALUES(20488,'Note : Index source of the range to the date within a month.',8)
GO
delete from HtmlLabelIndex where id>=20524 and id<=20531
GO
delete from HtmlLabelInfo where indexid>=20524 and indexid<=20531
GO
delete from HtmlLabelIndex where id=19653 or id=20534
GO
delete from HtmlLabelInfo where indexid=19653 or indexid=20534
GO
INSERT INTO HtmlLabelIndex values(19653,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19653,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19653,'Setting',8) 
GO
INSERT INTO HtmlLabelIndex values(20527,'�Ƿ������Զ���������') 
GO
INSERT INTO HtmlLabelIndex values(20528,'����ʼʱ��') 
GO
INSERT INTO HtmlLabelIndex values(20529,'����ʱ,�ڴ������Document��') 
GO
INSERT INTO HtmlLabelIndex values(20526,'�����������б�') 
GO
INSERT INTO HtmlLabelIndex values(20524,'�������������(M)') 
GO
INSERT INTO HtmlLabelIndex values(20525,'������ı���·��') 
GO
INSERT INTO HtmlLabelIndex values(20530,'һ��Segment�������ĵ�����') 
GO
INSERT INTO HtmlLabelIndex values(20531,'�������ÿҳ����¼��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20524,'�������������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20524,'Index of the maximum capacity(M)',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20525,'������ı���·��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20525,'Index database for the save path',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20526,'�����������б�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20526,'Index database list of file name',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20527,'�Ƿ������Զ���������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20527,'Whether to enabled the automatic indexing task',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20528,'����ʼʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20528,'start date of task',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20529,'����ʱ,�ڴ������Document��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20529,'The max number of Documents when Indexing in memory',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20530,'һ��Segment�������ĵ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20530,'Segment one of the max Documents',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20531,'�������ÿҳ����¼��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20531,'Search Results page recorded the max number of',8) 
GO
INSERT INTO HtmlLabelIndex values(20534,'������ʱ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20534,'��ʱ{key}��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20534,'Time {key}s',8) 
GO


delete from HtmlLabelIndex where id=18015
go
delete from HtmlLabelInfo where indexid=18015
go

INSERT INTO HtmlLabelIndex values(18015,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18015,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18015,'Workflow',8) 
GO