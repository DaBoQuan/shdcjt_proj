ALTER TABLE HrmPerformanceGoal ADD beExported CHAR(1)
GO
UPDATE HrmPerformanceGoal SET beExported='0'
GO

INSERT INTO HtmlLabelIndex values(18082,'�ظ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18082,'�ظ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18082,'REPEAT',8) 
GO