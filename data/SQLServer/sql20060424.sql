INSERT INTO HtmlLabelIndex values(18866,'��ѡ����Ҫ����������λ��!') 
GO
INSERT INTO HtmlLabelIndex values(18865,'��������Ҳ����ɾ��,�Ƿ����?') 
GO
INSERT INTO HtmlLabelInfo VALUES(18865,'��������Ҳ����ɾ��,�Ƿ����?',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18865,'Its children task will be deleted yet,are you sure?',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18866,'��ѡ����Ҫ����������λ��!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18866,'select the location you will add!',8) 
GO
INSERT INTO HtmlLabelIndex values(18876,'��ѵ�̲�')
GO
INSERT INTO HtmlLabelInfo VALUES(18876,'��ѵ�̲�',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18876,'training stuff',8)
GO
alter table HrmTrainPlanDay add starttime char(5)
go
alter table HrmTrainPlanDay add endtime char(5)
go
alter table HrmTrainPlan add traindocs varchar(2000)
go

