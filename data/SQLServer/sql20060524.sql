EXECUTE MMConfig_U_ByInfoInsert 11,0
GO
EXECUTE MMInfo_Insert 492,16484,'��������','','mainFrame',11,1,0,0,'',0,'',0,'','',0,'','',9
GO



delete from mainmenuinfo where id>=348 and id<=351
go

delete from mainmenuconfig where infoid>=348 and infoid<=351
go



EXECUTE MMConfig_U_ByInfoInsert 492,3
GO
EXECUTE MMInfo_Insert 348,16524,'','/hrm/city/HrmCity.jsp','mainFrame',492,2,3,0,'',0,'',0,'','',0,'','',9
GO

EXECUTE MMConfig_U_ByInfoInsert 492,4
GO
EXECUTE MMInfo_Insert 349,16525,'','/fna/maintenance/FnaCurrencies.jsp','mainFrame',492,2,4,0,'',0,'',0,'','',0,'','',9
GO

EXECUTE MMConfig_U_ByInfoInsert 492,5
GO
EXECUTE MMInfo_Insert 350,16526,'','/systeminfo/systemright/SystemRightGroup.jsp','mainFrame',492,2,5,0,'',0,'',0,'','',0,'','',9
GO

EXECUTE MMConfig_U_ByInfoInsert 492,6
GO
EXECUTE MMInfo_Insert 351,16527,'','/hrm/roles/HrmRoles.jsp','mainFrame',492,2,6,0,'',0,'',0,'','',0,'','',9
GO













INSERT INTO HtmlLabelIndex values(19174,'Ȩ�޹���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19174,'Ȩ�޹���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19174,'Rights Manager',8) 
GO
INSERT INTO HtmlLabelIndex values(19175,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19175,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19175,'Meeting Settings',8) 
GO

EXECUTE MMConfig_U_ByInfoInsert 11,1
GO
EXECUTE MMInfo_Insert 500,19174,'Ȩ�޹���','','mainFrame',11,1,1,0,'',0,'',0,'','',0,'','',9
GO

update mainmenuinfo set defaultparentid=500 where id=352 or id=353 or id=354 or id=383 or id=414 or id=472
go
update mainmenuinfo set defaultlevel=2 where id=352 or id=353 or id=354 or id=383 or id=414 or id=472
go
update mainmenuinfo set defaultparentid=11 where id=500
go


EXECUTE MMConfig_U_ByInfoInsert 11,8
GO
EXECUTE MMInfo_Insert 501,17632,'��������','','mainFrame',11,1,8,0,'',0,'',0,'','',0,'','',9
GO

update mainmenuinfo set defaultparentid=501 where id=428 or id=429 or id=355 or id=478
go
update mainmenuinfo set defaultlevel=2 where id=428 or id=429 or id=355 or id=478
go
update mainmenuinfo set defaultparentid=11 where id=501
go

EXECUTE MMConfig_U_ByInfoInsert 11,9
GO
EXECUTE MMInfo_Insert 502,19175,'��������','','mainFrame',11,1,9,0,'',0,'',0,'','',0,'','',9
GO
update mainmenuinfo set defaultparentid=502 where id=356 or id=357 or id=358
go
update mainmenuinfo set defaultlevel=2 where id=356 or id=357 or id=358
go
update mainmenuinfo set defaultparentid=11 where id=502
go
EXECUTE MMConfig_U_ByInfoInsert 11,10
GO
EXECUTE MMInfo_Insert 503,15804,'ϵͳ��Ϣ','','mainFrame',11,1,10,0,'',0,'',0,'','',0,'','',9
GO
update mainmenuinfo set defaultparentid=503 where id=368 or id=426
go
update mainmenuinfo set defaultlevel=2 where id=368 or id=426
go
update mainmenuinfo set defaultparentid=11 where id=503
go


update mainmenuconfig set parentid=503 where infoid=368 or infoid=426
go
update mainmenuconfig set parentid=502 where infoid=356 or infoid=357 or infoid=358
go
update mainmenuconfig set parentid=501 where infoid=428 or infoid=429 or infoid=355 or infoid=478
go
update mainmenuconfig set parentid=500 where infoid=352 or infoid=353 or infoid=354 or infoid=383 or infoid=414 or infoid=472
go