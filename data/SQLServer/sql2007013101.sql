

INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('��������', 6, '#FF0000', '1', 0)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('�����ճ�', 6, '#00FF00', '1', 1)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('��Ŀ�ճ�', 6, '#0000FF', '1', 2)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('�ͻ���ϵ', 6, '#FFFF00', '1', 3)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('���˱�ǩ', 6, '#00FFFF', '1', 4)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('Ŀ�꼨Ч', 6, '#999999', '1', 5)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('Ŀ��ƻ�', 6, '#FF00FF', '1', 6)
GO


DELETE FROM HtmlLabelIndex WHERE id = 20210
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20210
GO
INSERT INTO HtmlLabelIndex values(20210,'���ճ����ͱ����ã��޷�ɾ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20210,'���ճ����ͱ����ã��޷�ɾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20210,'The Work Plan Type can not be deleted because it has been refered!',8) 
GO