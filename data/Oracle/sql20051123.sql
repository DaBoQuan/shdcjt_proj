/*0:pop3 , 1:imap*/
alter table SystemSet add receiveProtocolType char(1) 
/


update SystemSet set receiveProtocolType='0'
/

INSERT INTO HtmlLabelIndex values(18005,'���µ�¼') 
/
INSERT INTO HtmlLabelInfo VALUES(18005,'���µ�¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18005,'ReLogin',8) 
/