delete from HtmlLabelIndex where id=125 
GO
delete from HtmlLabelInfo where indexid=125 
GO
INSERT INTO HtmlLabelIndex values(125,'创建') 
GO
INSERT INTO HtmlLabelInfo VALUES(125,'Create',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(125,'创建',7) 
GO

delete from HtmlLabelIndex where id=21261 
GO
delete from HtmlLabelInfo where indexid=21261 
GO
INSERT INTO HtmlLabelIndex values(21261,'请选择需要转移权限的协作.') 
GO
INSERT INTO HtmlLabelInfo VALUES(21261,'请选择需要进行权限转移的协作.',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21261,'Please choose the cowork you want to change perview.',8) 
GO

delete from HtmlLabelIndex where id=18734 
GO
delete from HtmlLabelInfo where indexid=18734 
GO
INSERT INTO HtmlLabelIndex values(18734,'系统会更新被转移人的客户,项目,人力资源,文档,归档流程和协作的数量') 
GO
INSERT INTO HtmlLabelInfo VALUES(18734,'系统会更新被转移人的客户,项目,人力资源,文档,归档流程和协作的数量',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18734,'System will renew the amount of customers,projects,human resources,documents,archive workflow and coworks of the man transfer from',8) 
GO


