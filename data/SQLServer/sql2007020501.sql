update hpextelement set extshow='Rss.jsp' where id=1
GO


delete from  HtmlLabelIndex where id=20173
GO
delete from  HtmlLabelInfo where indexId=20173
GO
delete from  HtmlLabelIndex where id=20174
GO
delete from  HtmlLabelInfo where indexId=20174
GO
delete from  HtmlLabelIndex where id=20175
GO
delete from  HtmlLabelInfo where indexId=20175
GO
delete from  HtmlLabelIndex where id=20176
GO
delete from  HtmlLabelInfo where indexId=20176
GO
INSERT INTO HtmlLabelIndex values(20174,'��һ��:��IE�ġ�����->Internetѡ�') 
GO
INSERT INTO HtmlLabelIndex values(20176,'������:�Ѵ�վ����ӵ�������վ��') 
GO
INSERT INTO HtmlLabelIndex values(20175,'�ڶ���:��"��ȫѡ�"') 
GO
INSERT INTO HtmlLabelInfo VALUES(20174,'��һ��:��IE�ġ�����->Internetѡ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20174,'First Step: Open IE "Tools->Internet option"',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20175,'�ڶ���:��"��ȫѡ�"',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20175,'Second Step: Open "safe option page"',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20176,'������:�Ѵ�վ����ӵ�������վ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20176,'Third Setp:Add this web address to setting that can be confide',8) 
GO
INSERT INTO HtmlLabelIndex values(20173,'����ӵ�������վ��󣬲���Ҫ����IE�İ�ȫ���ã�') 
GO
INSERT INTO HtmlLabelInfo VALUES(20173,'����ӵ�������վ��󣬲���Ҫ����IE�İ�ȫ���ã�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20173,'No need low the IE''s setting when you add this web address into the setting that can confide',8) 
GO