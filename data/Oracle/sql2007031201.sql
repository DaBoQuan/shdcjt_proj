delete from HtmlLabelIndex where id=20245
/
delete from HtmlLabelInfo where indexid=20245
/

INSERT INTO HtmlLabelIndex values(20245,'�ʻ��ѱ��ʼ��������ã�����ɾ����ת����Ӧ���ʼ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(20245,'�ʻ��ѱ��ʼ��������ã�����ɾ����ת����Ӧ���ʼ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20245,'Mail account has been referred, Please first remove or move the rules!',8) 
/
delete from HtmlLabelIndex where id in (20250,20251,20252)
/
delete from HtmlLabelInfo where indexid in (20250,20251,20252)
/

INSERT INTO HtmlLabelIndex values(20250,'����ѡ����ϵ��') 
/
INSERT INTO HtmlLabelInfo VALUES(20250,'����ѡ����ϵ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20250,'Please first select contacter',8) 
/
INSERT INTO HtmlLabelIndex values(20252,'ȷ������ѡ����ϵ������') 
/
INSERT INTO HtmlLabelIndex values(20251,'ȷ������ѡ���ʼ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(20251,'ȷ������ѡ���ʼ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20251,'Do you confirm moving the mail to',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20252,'ȷ������ѡ����ϵ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20252,'Do you confirm moving the contacter to',8) 
/
