delete from HtmlLabelIndex where id in (20029,20030)
go
delete from HtmlLabelInfo where indexid in (20029,20030)
go

INSERT INTO HtmlLabelIndex values(20029,'����ѡ���ʼ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(20029,'����ѡ���ʼ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20029,'please select mail.',8) 
GO
INSERT INTO HtmlLabelIndex values(20030,'��ʱͨѶ(IM)') 
GO
INSERT INTO HtmlLabelInfo VALUES(20030,'��ʱͨѶ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20030,'Instant Messaging',8) 
GO