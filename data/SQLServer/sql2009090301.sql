delete from ErrorMsgIndex where id=60
GO
delete from ErrorMsgInfo where indexid=60
GO
insert into ErrorMsgIndex(id, indexdesc) values (60, '��ȡ�������½������')
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (60, '��ȡ�������½������', 7)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (60, 'Get Domain Name or Login ID Error !', 8)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (60, '�@ȡ�����������e�`��', 9)
GO

delete from ErrorMsgIndex where id=61
GO
delete from ErrorMsgInfo where indexid=61
GO
insert into ErrorMsgIndex(id, indexdesc) values (61, '�㻹û�е�½��')
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (61, '�㻹û�е�½��', 7)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (61, 'Demain Name Error !', 8)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (61, '��߀�]�е����', 9)
GO
