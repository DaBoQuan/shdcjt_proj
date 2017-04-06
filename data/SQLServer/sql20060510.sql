update FnaYearsPeriods set status = 0 where status is null
go
ALTER TABLE FnaBudgetInfo ADD
	createdate1 char(10) NULL
GO

UPDATE FnaBudgetInfo SET createdate1 = createdate
GO

ALTER TABLE FnaBudgetInfo DROP COLUMN createdate
GO

ALTER TABLE FnaBudgetInfo ADD
	createdate char(20) NULL
GO

UPDATE FnaBudgetInfo SET createdate = createdate1 + ' 00:00:00'
GO

ALTER TABLE FnaBudgetInfo DROP COLUMN createdate1
GO



INSERT INTO HtmlLabelIndex values(18872,'������ʾ')
GO
INSERT INTO HtmlLabelInfo VALUES(18872,'������ʾ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18872,'Wrap Show',8)
GO

INSERT INTO HtmlLabelIndex values(18878,'�Ƿ��Զ�����?')
GO
INSERT INTO HtmlLabelInfo VALUES(18878,'�Ƿ��Զ�����?',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18878,'should it automatic calculated ?',8)
GO

INSERT INTO HtmlLabelIndex values(18879,'���������')
GO
INSERT INTO HtmlLabelInfo VALUES(18879,'���������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18879,'average by organization',8)
GO

