INSERT INTO HtmlLabelIndex values(19758,'������׼������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19758,'������׼������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19758,'Open Confirm Workflow',8) 
GO

update DocSecCategory set isOpenApproveWf='2' where approveWorkflowId>0
GO

update DocDetail set approveType='1' where docStatus='3'
GO

INSERT INTO HtmlLabelIndex values(19761,'��׼����') 
GO
INSERT INTO HtmlLabelIndex values(19762,'��׼����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19761,'��׼����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19761,'Confirm Type',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19762,'��׼����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19762,'Confirm Workflow',8) 
GO
