delete from ErrorMsgIndex where id=58
GO
delete from ErrorMsgInfo where indexid=58
GO
insert into ErrorMsgIndex(id, indexdesc) values (58, '��֤�ͻ���ǩ������')
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (58, '��֤�ͻ���ǩ������', 7)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (58, 'Check customer sign error', 8)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (58, '��C�͑��˺����e�`', 9)
GO