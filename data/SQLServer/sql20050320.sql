/*�������� label*/
INSERT INTO HtmlLabelIndex values(17627,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17627,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17627,'user setting',8) 
GO

/*RTX�Ƿ��Զ���½ label*/
INSERT INTO HtmlLabelIndex values(17628,'RTX�Ƿ��Զ���½') 
GO
INSERT INTO HtmlLabelInfo VALUES(17628,'RTX�Ƿ��Զ���½',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17628,'RTX AutoOnload',8) 
GO

/* �û��Զ�������ñ� */
CREATE TABLE HrmUserSetting ( 
    id int NOT NULL IDENTITY (1, 1),
    resourceId int,
    rtxOnload char(1)) 
GO