delete from ErrorMsgIndex where id=62
GO
delete from ErrorMsgInfo where indexid=62
GO
insert into ErrorMsgIndex(id, indexdesc) values (62, '������¼U-Key')
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (62, '������¼U-Key', 7)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (62, 'Please insert the usb-key', 8)
GO
insert into ErrorMsgInfo(indexid, msgname, languageid) values (62, 'Ո������U-Key', 9)
GO
