delete from HtmlLabelIndex where id in (20267, 20266, 20265)
/
delete from HtmlLabelInfo where indexid in (20267, 20266, 20265)
/

INSERT INTO HtmlLabelIndex values(20267,'�����ҵ��ʼ���ȡ') 
/
INSERT INTO HtmlLabelIndex values(20266,'�������������ʼ��ʻ����á�') 
/
INSERT INTO HtmlLabelIndex values(20265,'���ڶ�ȡ�ʼ��������ϵ����ʼ�') 
/
INSERT INTO HtmlLabelInfo VALUES(20265,'���ڶ�ȡ�ʼ��������ϵ����ʼ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20265,'Searching unread mails',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20266,'�������������ʼ��ʻ����á�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20266,'Error! Please check your setting.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20267,'�����ҵ��ʼ���ȡ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20267,'Get',8) 
/

update hpextElement set extshow='Mail.jsp' where id=16
/


delete from HtmlLabelIndex where id in (20265)
/
delete from HtmlLabelInfo where indexid in (20265)
/
INSERT INTO HtmlLabelIndex values(20265,'�ʼ��������ϵ����ʼ�') 
/
INSERT INTO HtmlLabelInfo VALUES(20265,'�ʼ��������ϵ����ʼ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20265,'Unread mails',8) 
/