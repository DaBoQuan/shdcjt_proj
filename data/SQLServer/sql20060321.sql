/*ɾ����Ϣ��������ⲿ�鱨�����˵�*/
DELETE FROM LeftMenuInfo WHERE id=117
GO


/*Label*/
INSERT INTO HtmlLabelIndex values(18482,'��ѯ�ճ�') 
GO
INSERT INTO HtmlLabelIndex values(18484,'�ճ��ܱ�') 
GO
INSERT INTO HtmlLabelIndex values(18485,'�ճ��±�') 
GO
INSERT INTO HtmlLabelIndex values(18486,'�ճ̼���') 
GO
INSERT INTO HtmlLabelIndex values(18487,'�ճ��걨') 
GO
INSERT INTO HtmlLabelIndex values(18480,'�ҵ��ճ�') 
GO
INSERT INTO HtmlLabelIndex values(18488,'��̬����') 
GO
INSERT INTO HtmlLabelIndex values(18489,'�ճ̱���') 
GO
INSERT INTO HtmlLabelIndex values(18481,'�½��ճ�') 
GO
INSERT INTO HtmlLabelIndex values(18483,'�ճ��ձ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18480,'�ҵ��ճ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18480,'My Schedule',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18481,'�½��ճ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18481,'New Schedule',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18482,'��ѯ�ճ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18482,'Search Schedule',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18483,'�ճ��ձ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18483,'Schedule Daily Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18484,'�ճ��ܱ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18484,'Schedule Weekly Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18485,'�ճ��±�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18485,'Schedule Monthly Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18486,'�ճ̼���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18486,'Schedule Season Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18487,'�ճ��걨',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18487,'Schedule Yearly Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18488,'��̬����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18488,'Dynamic Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18489,'�ճ̱���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18489,'Schedule Report',8) 
GO




/*����ҵ��ճ̶����˵�*/
EXECUTE LMConfig_U_ByInfoInsert 1,NULL,15
GO
EXECUTE LMInfo_Insert 140,18480,NULL,NULL,1,NULL,15,2
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyPlan.gif' WHERE id=140
GO

/*�����ҵ��ճ̶��������˵�*/
UPDATE LeftMenuInfo SET labelId=18480,iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyPlan.gif',parentId=140 WHERE id=97
GO
UPDATE LeftMenuInfo SET labelId=18481 WHERE id=59
GO
UPDATE LeftMenuInfo SET labelId=18480 WHERE id=60
GO
UPDATE LeftMenuInfo SET labelId=18482 WHERE id=61
GO

/*�����ճ̱�����������˵�*/
UPDATE LeftMenuInfo SET labelId=18489,iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyReport.gif',parentId=140 WHERE id=98
GO
UPDATE LeftMenuInfo SET labelId=18483,parentId=98 WHERE id=62
GO
UPDATE LeftMenuInfo SET labelId=18484,parentId=98 WHERE id=63
GO
UPDATE LeftMenuInfo SET labelId=18485,parentId=98 WHERE id=64
GO
UPDATE LeftMenuInfo SET labelId=18486,parentId=98 WHERE id=65
GO
UPDATE LeftMenuInfo SET labelId=18487,parentId=98 WHERE id=66
GO
UPDATE LeftMenuInfo SET labelId=18488,parentId=98 WHERE id=67
GO

UPDATE LeftMenuInfo SET linkAddress='javascript:void(0)' WHERE id=97 OR id=98
GO