ALTER TABLE HrmPerformanceGoal ADD beExported CHAR(1)
/
UPDATE HrmPerformanceGoal SET beExported='0'
/

INSERT INTO HtmlLabelIndex values(18082,'�ظ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18082,'�ظ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18082,'REPEAT',8) 
/