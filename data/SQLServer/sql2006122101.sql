delete from HtmlLabelIndex where id in(20032,20033,20034,20035,20036,20037,20038,20039,20044,20045)
GO
delete from HtmlLabelInfo where indexId in(20032,20033,20034,20035,20036,20037,20038,20039,20044,20045)
GO
INSERT INTO HtmlLabelIndex values(20032,'ǩ��') 
GO
INSERT INTO HtmlLabelIndex values(20036,'������ԭ��ٵ����������ύ��Ӧ����') 
GO
INSERT INTO HtmlLabelIndex values(20034,'���ѳɹ�ǩ��') 
GO
INSERT INTO HtmlLabelIndex values(20035,'ǩ��ʱ��') 
GO
INSERT INTO HtmlLabelIndex values(20038,'���ѳɹ�ǩ��') 
GO
INSERT INTO HtmlLabelIndex values(20033,'ǩ��') 
GO
INSERT INTO HtmlLabelIndex values(20037,'ǩ����ǩ�ˣ�ʱ��') 
GO
INSERT INTO HtmlLabelIndex values(20039,'ǩ��ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20032,'ǩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20032,'sign in',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20033,'ǩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20033,'sign out',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20034,'���ѳɹ�ǩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20034,'You have signed in successfully',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20035,'ǩ��ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20035,'sign in time',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20036,'������ԭ��ٵ����������ύ��Ӧ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20036,'Please submit related workflow if be late or leave early because of work reason',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20037,'ǩ����ǩ�ˣ�ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20037,'sign in(sign out) time',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20038,'���ѳɹ�ǩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20038,'You have signed out successfully',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20039,'ǩ��ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20039,'sign out time',8) 
GO

INSERT INTO HtmlLabelIndex values(20044,'ǩ��ǩ������') 
GO
INSERT INTO HtmlLabelIndex values(20045,'ǩ��ǩ��ip') 
GO
INSERT INTO HtmlLabelInfo VALUES(20044,'ǩ��ǩ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20044,'sign in or sign out set',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20045,'ǩ��ǩ��ip',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20045,'sign in or sign out ip',8) 
GO