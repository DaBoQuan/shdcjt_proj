INSERT INTO HtmlLabelIndex values(18743,'�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(18743,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18743,'compute sign',8) 
GO

INSERT INTO HtmlLabelIndex values(18744,'�˸�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18744,'�˸�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18744,'back',8) 
GO

INSERT INTO HtmlLabelIndex values(18689,'����дҪ���������') 
GO
INSERT INTO HtmlLabelIndex values(18688,'���Ҫɾ������������') 
GO

INSERT INTO HtmlLabelInfo VALUES(18688,'���Ҫɾ������������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18688,'Are you sure to delete?',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18689,'����дҪ���������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18689,'please,Input number',8) 
GO

INSERT INTO HtmlLabelIndex values(18745,'�Ƿ�ϼ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18745,'�Ƿ�ϼ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18745,'wheather total',8) 
GO

INSERT INTO HtmlLabelIndex values(18746,'��ֵ�����ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18746,'��ֵ�����ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18746,'set value to mainfield',8) 
GO
 

ALTER  TABLE workflow_formdetailinfo 
ALTER  COLUMN  rowcalstr text NULL 
go
 ALTER  TABLE workflow_formdetailinfo 
ALTER  COLUMN  colcalstr text NULL 
go
 ALTER  TABLE workflow_formdetailinfo 
ALTER  COLUMN  maincalstr text NULL
go