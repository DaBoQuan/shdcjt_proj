EXECUTE MMConfig_U_ByInfoInsert 11,8
GO
EXECUTE MMInfo_Insert 546,19772,'�ճ�����','','mainFrame',11,1,8,0,'',0,'',0,'','',0,'','',9
GO

EXECUTE MMConfig_U_ByInfoInsert 546,1
GO
EXECUTE MMInfo_Insert 547,19773,'�ճ���������','/workplan/config/global/WorkPlanTypeSet.jsp','mainFrame',546,2,1,0,'',0,'',0,'','',0,'','',9
GO


EXECUTE MMConfig_U_ByInfoInsert 3,15
GO
EXECUTE MMInfo_Insert 548,19792,'�ճ̼��','/system/systemmonitor/workplan/WorkPlanMonitor.jsp','mainFrame',3,1,15,0,'',0,'',0,'','',0,'','',2
GO

EXECUTE MMConfig_U_ByInfoInsert 3,16
GO
EXECUTE MMInfo_Insert 549,19793,'�ճ̼������','/system/systemmonitor/workplan/WorkPlanMonitorStatic.jsp','mainFrame',3,1,16,0,'',0,'',0,'','',0,'','',2
GO

UPDATE LeftMenuInfo SET linkAddress = '/hrm/performance/targetPlan/PlanModulList.jsp?target=workplan' WHERE id = 209
GO
