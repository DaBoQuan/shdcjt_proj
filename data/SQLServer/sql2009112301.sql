delete from HtmlLabelIndex where id=23930 
GO
delete from HtmlLabelInfo where indexid=23930 
GO
delete from HtmlLabelIndex where id=23931 
GO
delete from HtmlLabelInfo where indexid=23931 
GO
INSERT INTO HtmlLabelIndex values(23930,'是否包含文档历史版本') 
GO
INSERT INTO HtmlLabelIndex values(23931,'是否包含附件历史版本') 
GO
INSERT INTO HtmlLabelInfo VALUES(23930,'是否包含文档历史版本',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23930,'Include Doc Historical Version Or Not',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23930,'是否包含文檔歷史版本',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(23931,'是否包含附件历史版本',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23931,'Include Accessory Historical Version Or Not',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23931,'是否包含附件歷史版本',9) 
GO
