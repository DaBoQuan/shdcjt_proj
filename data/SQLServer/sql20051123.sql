/*0:pop3 , 1:imap*/
alter table SystemSet add receiveProtocolType char(1) 
go


update SystemSet set receiveProtocolType='0'
go

INSERT INTO HtmlLabelIndex values(18005,'���µ�¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(18005,'���µ�¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18005,'ReLogin',8) 
GO