delete from HtmlLabelIndex where id=20245
go
delete from HtmlLabelInfo where indexid=20245
go

INSERT INTO HtmlLabelIndex values(20245,'�ʻ��ѱ��ʼ��������ã�����ɾ����ת����Ӧ���ʼ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20245,'�ʻ��ѱ��ʼ��������ã�����ɾ����ת����Ӧ���ʼ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20245,'Mail account has been referred, Please first remove or move the rules!',8) 
GO
delete from HtmlLabelIndex where id in (20250,20251,20252)
go
delete from HtmlLabelInfo where indexid in (20250,20251,20252)
go

INSERT INTO HtmlLabelIndex values(20250,'����ѡ����ϵ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20250,'����ѡ����ϵ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20250,'Please first select contacter',8) 
GO
INSERT INTO HtmlLabelIndex values(20252,'ȷ������ѡ����ϵ������') 
GO
INSERT INTO HtmlLabelIndex values(20251,'ȷ������ѡ���ʼ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20251,'ȷ������ѡ���ʼ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20251,'Do you confirm moving the mail to',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20252,'ȷ������ѡ����ϵ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20252,'Do you confirm moving the contacter to',8) 
GO
