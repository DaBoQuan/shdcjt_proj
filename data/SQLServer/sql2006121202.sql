DELETE FROM MainMenuConfig WHERE infoid = 545
GO
DELETE FROM MainMenuInfo WHERE id = 545
GO
EXECUTE MMConfig_U_ByInfoInsert 2,2
GO
EXECUTE MMInfo_Insert 560,19456,'Ŀ¼ģ��','/docs/category/DocSecCategoryTmplList.jsp','mainFrame',2,1,2,0,'',0,'',0,'','',0,'','',1
GO
