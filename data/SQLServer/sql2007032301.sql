delete from HtmlLabelIndex where id in(20241,20242)
go
delete from HtmlLabelInfo where indexId in(20241,20242)
go
INSERT INTO HtmlLabelIndex values(20241,'ǩ����ϸ') 
go
INSERT INTO HtmlLabelIndex values(20242,'ǩ����ϸ') 
go
INSERT INTO HtmlLabelInfo VALUES(20241,'ǩ����ϸ',7) 
go
INSERT INTO HtmlLabelInfo VALUES(20241,'Sign In Detail',8) 
go
INSERT INTO HtmlLabelInfo VALUES(20242,'ǩ����ϸ',7) 
go
INSERT INTO HtmlLabelInfo VALUES(20242,'Sign Out Detail',8) 
go