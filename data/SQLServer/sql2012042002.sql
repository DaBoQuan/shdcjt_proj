update MainMenuInfo set linkAddress='' where id=989
go
Delete from MainMenuInfo where id=1135
GO
EXECUTE MMConfig_U_ByInfoInsert 989,1
GO
EXECUTE MMInfo_Insert 1135,28057,'���������½�','/workflow/request/RequestTypeByTest.jsp','mainFrame',989,2,1,0,'',0,'',0,'','',0,'','',3
GO
Delete from MainMenuInfo where id=1136
GO
EXECUTE MMConfig_U_ByInfoInsert 989,2
GO
EXECUTE MMInfo_Insert 1136,28056,'��������ɾ��','/workflow/search/RequestTestList.jsp','mainFrame',989,2,2,0,'',0,'',0,'','',0,'','',3
GO