DELETE FROM HtmlLabelIndex WHERE id = 19772
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19772
/
INSERT INTO HtmlLabelIndex values(19772,'�ճ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19772,'�ճ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19772,'Work Plan Set',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19773
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19773
/
INSERT INTO HtmlLabelIndex values(19773,'�ճ���������') 
/
INSERT INTO HtmlLabelInfo VALUES(19773,'�ճ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19773,'Work Plan Type Set',8) 
/


DELETE FROM HtmlLabelIndex WHERE id = 19774
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19774
/
INSERT INTO HtmlLabelIndex values(19774,'�ճ���������') 
/
INSERT INTO HtmlLabelInfo VALUES(19774,'�ճ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19774,'Name of Work Plan Type',8) 
/

INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('��������', 6, '#FF0000', '1', 2)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('�����ճ�', 6, '#00FF00', '1', 3)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('��Ŀ�ճ�', 6, '#0000FF', '1', 4)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('�ͻ���ϵ', 6, '#FFFF00', '1', 5)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('���˱�ǩ', 6, '#00FFFF', '1', 6)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('Ŀ�꼨Ч', 6, '#999999', '1', 7)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('Ŀ��ƻ�', 6, '#FF00FF', '1', 8)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('Ĭ���ճ�����', 7, '#FFCCCC', '1', 0)
/
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('��Ȩ�鿴����', 7, '#CCCCCC', '1', 1)
/

DELETE FROM HtmlLabelIndex WHERE id = 19777
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19777
/
INSERT INTO HtmlLabelIndex values(19777,'�����ʽ����ȷ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19777,'�����ʽ����ȷ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19777,'The Input Format is invalid!',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19778
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19778
/
INSERT INTO HtmlLabelIndex values(19778,'����ɫ�Ѿ���ʹ�á�') 
/
INSERT INTO HtmlLabelInfo VALUES(19778,'����ɫ�Ѿ���ʹ�ã�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19778,'The Colour is Applied!',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19781
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19781
/
INSERT INTO HtmlLabelIndex values(19781,'�ճ����ѷ�ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(19781,'�ճ����ѷ�ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19781,'Mode of the Work Plan Remind',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19782
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19782
/
INSERT INTO HtmlLabelIndex values(19782,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(19782,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19782,'Do not Remind',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19783
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19783
/
INSERT INTO HtmlLabelIndex values(19783,'�ճ�����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19783,'�ճ�����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19783,'Time of Work Plan Remind',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19784
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19784
/
INSERT INTO HtmlLabelIndex values(19784,'��ʼǰ') 
/
INSERT INTO HtmlLabelInfo VALUES(19784,'��ʼǰ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19784,'Before Start',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19785
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19785
/
INSERT INTO HtmlLabelIndex values(19785,'����ǰ') 
/
INSERT INTO HtmlLabelInfo VALUES(19785,'����ǰ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19785,'Before End',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19788
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19788
/
INSERT INTO HtmlLabelIndex values(19788,'�ճ̿�ʼ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19788,'�ճ̿�ʼ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19788,'Work Plan Begin Remind',8) 
/

INSERT INTO SysPoppupInfo(type, link, description, statistic, typeDescription)
VALUES(12, '/system/SysRemindWorkPlan.jsp', '19788', 'y' , '19788')
/
DELETE FROM HtmlLabelIndex WHERE id = 19792
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19792
/
INSERT INTO HtmlLabelIndex values(19792,'�ճ̼��') 
/
INSERT INTO HtmlLabelInfo VALUES(19792,'�ճ̼��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19792,'Work Plan Monitor',8) 
/


DELETE FROM HtmlLabelIndex WHERE id = 19793
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19793
/
INSERT INTO HtmlLabelIndex values(19793,'�ճ̼������') 
/
INSERT INTO HtmlLabelInfo VALUES(19793,'�ճ̼������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19793,'Work Plan Monitor Setting',8) 
/



DELETE FROM HtmlLabelIndex WHERE id = 19794
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19794
/
INSERT INTO HtmlLabelIndex values(19794,'�ճ̼����') 
/
INSERT INTO HtmlLabelInfo VALUES(19794,'�ճ̼����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19794,'Work Plan Control Men',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19795
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19795
/
INSERT INTO HtmlLabelIndex values(19795,'�ճ�������') 
/
INSERT INTO HtmlLabelInfo VALUES(19795,'�ճ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19795,'Work Plan Type Amount',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19796
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19796
/
INSERT INTO HtmlLabelIndex values(19796,'����˲���Ϊ��!') 
/
INSERT INTO HtmlLabelInfo VALUES(19796,'����˲���Ϊ��!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19796,'You must choose the Work Plan Control Men!',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 19798
/
DELETE FROM HtmlLabelInfo WHERE indexId = 19798
/
INSERT INTO HtmlLabelIndex values(19798,'����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19798,'����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19798,'Persistence Time',8) 
/

insert into SystemRights (id,rightdesc,righttype) values (700,'�ճ���������','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (700,7,'�ճ���������','�ճ���������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (700,8,'Work Plan Type Setting','Work Plan Type Setting') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4208,'�ճ���������','WorkPlanTypeSet:Set',700) 
/


DELETE FROM HtmlLabelIndex WHERE id = 20168
/
DELETE FROM HtmlLabelInfo WHERE indexId = 20168
/
INSERT INTO HtmlLabelIndex values(20168,'��ʱ����ʾ') 
/
INSERT INTO HtmlLabelInfo VALUES(20168,'��ʱ����ʾ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20168,'View Through Time',8) 
/

DELETE FROM HtmlLabelIndex WHERE id = 20169
/
DELETE FROM HtmlLabelInfo WHERE indexId = 20169
/
INSERT INTO HtmlLabelInfo VALUES(20169,'���¼���ʾ',7) 
/
INSERT INTO HtmlLabelIndex values(20169,'���¼���ʾ') 
/
INSERT INTO HtmlLabelInfo VALUES(20169,'View Through Event',8) 
/
