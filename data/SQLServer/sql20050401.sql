INSERT INTO HtmlLabelIndex values(17626,'�ͻ������Ѵ���,�����¶�����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17626,'�ͻ������Ѵ���,�����¶�����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17626,'customer type has exist',8) 
GO
insert into CRM_CustomerType values('�����û�','�����û�','n','n',null)
go
INSERT INTO HtmlLabelIndex values(17706,'�����û�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17706,'�����û�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17706,'personal customer',8) 
GO
ALTER TABLE CRM_CustomerInfo ADD Sex  tinyint DEFAULT (0)
GO
ALTER TABLE CRM_CustomerInfo ADD IDCardNo  varchar(50) NULL
GO

/*td:1548*/
insert into ErrorMsgIndex values (49,'����ҵ�Ѿ������ͻ�,����ɾ��')
GO
insert into ErrorMsgInfo values (49,'����ҵ�Ѿ������ͻ�,����ɾ��!',7)
GO
insert into ErrorMsgInfo values (49,'associated with one client,can''t delete',8)
GO
insert into ErrorMsgIndex values (50,'����ҵ������ҵ,����ɾ��')
GO
insert into ErrorMsgInfo values (50,'����ҵ������ҵ,����ɾ��',7)
GO
insert into ErrorMsgInfo values (50,'It has the subordinate profession, can''t delete',8)
GO