delete workflow_browserurl where id in(226,227)
GO
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES (226,30312,'varchar(1000)','/systeminfo/BrowserMain.jsp?url=/integration/sapSingleBrowser.jsp','','','','')
GO
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES (227,30313,'varchar(1000)','/systeminfo/BrowserMain.jsp?url=/integration/sapMutilBrowser.jsp','','','','')
GO

alter table sap_service add loadDate integer
GO
update sap_service set loadDate=0
GO
update int_dataInter set dataname='WEBSERVICE���ݽ���',datadesc='�칹ϵͳ�����ͬһ��׼��ͨ������������WEBSERVICE��ʵ��ϵͳ������ݽ�����' where id=2 
GO 