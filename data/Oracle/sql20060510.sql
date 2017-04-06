update FnaYearsPeriods set status = 0 where status is null
/
ALTER TABLE FnaBudgetInfo ADD
	createdate1 char(10) NULL
/

UPDATE FnaBudgetInfo SET createdate1 = createdate
/

ALTER TABLE FnaBudgetInfo DROP COLUMN createdate
/

ALTER TABLE FnaBudgetInfo ADD
	createdate char(20) NULL
/

UPDATE FnaBudgetInfo SET createdate = concat(createdate1,' 00:00:00')
/

ALTER TABLE FnaBudgetInfo DROP COLUMN createdate1
/



INSERT INTO HtmlLabelIndex values(18872,'������ʾ')
/
INSERT INTO HtmlLabelInfo VALUES(18872,'������ʾ',7)
/
INSERT INTO HtmlLabelInfo VALUES(18872,'Wrap Show',8)
/

INSERT INTO HtmlLabelIndex values(18878,'�Ƿ��Զ�����?')
/
INSERT INTO HtmlLabelInfo VALUES(18878,'�Ƿ��Զ�����?',7)
/
INSERT INTO HtmlLabelInfo VALUES(18878,'should it automatic calculated ?',8)
/

INSERT INTO HtmlLabelIndex values(18879,'���������')
/
INSERT INTO HtmlLabelInfo VALUES(18879,'���������',7)
/
INSERT INTO HtmlLabelInfo VALUES(18879,'average by organization',8)
/

