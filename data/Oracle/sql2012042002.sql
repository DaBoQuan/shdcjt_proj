update MainMenuInfo set linkAddress='' where id=989
/
Delete from MainMenuInfo where id=1135
/
CALL MMConfig_U_ByInfoInsert (989,1)
/
CALL MMInfo_Insert (1135,28057,'���������½�','/workflow/request/RequestTypeByTest.jsp','mainFrame',989,2,1,0,'',0,'',0,'','',0,'','',3)
/
Delete from MainMenuInfo where id=1136
/
CALL MMConfig_U_ByInfoInsert (989,2)
/
CALL MMInfo_Insert (1136,28056,'��������ɾ��','/workflow/search/RequestTestList.jsp','mainFrame',989,2,2,0,'',0,'',0,'','',0,'','',3)
/