DELETE FROM MainMenuInfo WHERE id = 549
GO
DELETE FROM MainMenuInfo WHERE id = 548
GO
DELETE FROM MainMenuInfo WHERE id = 491
GO

EXECUTE MMConfig_U_ByInfoInsert 546,2
GO
EXECUTE MMInfo_Insert 580,19793,'�ճ̼������','/system/systemmonitor/workplan/WorkPlanMonitorStatic.jsp','mainFrame',546,2,2,0,'',0,'',0,'','',0,'','',2
GO

EXECUTE MMConfig_U_ByInfoInsert 546,3
GO
EXECUTE MMInfo_Insert 581,19792,'�ճ̼��','/system/systemmonitor/workplan/WorkPlanMonitor.jsp','mainFrame',546,2,3,0,'',0,'',0,'','',0,'','',2
GO

EXECUTE MMConfig_U_ByInfoInsert 546,4
GO
EXECUTE MMInfo_Insert 582,19042,'�ճ�ͳ������','/workplan/config/WorkPlanReportSet.jsp','mainFrame',546,2,4,0,'',0,'',0,'','',0,'','',2
GO