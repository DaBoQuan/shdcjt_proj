INSERT INTO HtmlLabelIndex values(19309,'���ĵ�λ') 
GO
INSERT INTO HtmlLabelIndex values(19310,'�ϼ���λ') 
GO
INSERT INTO HtmlLabelIndex values(19311,'����Ա') 
GO
INSERT INTO HtmlLabelIndex values(19312,'�½�ͬ����λ') 
GO
INSERT INTO HtmlLabelIndex values(19313,'�½��¼���λ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19309,'���ĵ�λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19309,'Receive Unit',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19310,'�ϼ���λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19310,'Superior Unit',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19311,'����Ա',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19311,'Receiver',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19312,'�½�ͬ����λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19312,'New Peer Unit',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19313,'�½��¼���λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19313,'New Lower Unit',8) 
GO
INSERT INTO HtmlLabelIndex values(19315,'�ϼ���λ����Ϊ����λ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19315,'�ϼ���λ����Ϊ����λ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19315,'The superior unit cann''t be this unit!',8) 
GO

INSERT INTO HtmlLabelIndex values(19319,'ϵͳ��֧��10�����ϵ����ĵ�λ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19319,'ϵͳ��֧��10�����ϵ����ĵ�λ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19319,'The system doesn''t support 10 level of receive unit!',8) 
GO

INSERT INTO HtmlLabelIndex values(19323,'����ȫѡ') 
GO
INSERT INTO HtmlLabelIndex values(19324,'�ر�ȫѡ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19323,'����ȫѡ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19323,'Open Check All',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19324,'�ر�ȫѡ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19324,'Close Check All',8) 
GO


EXECUTE MMConfig_U_ByInfoInsert 20,5
GO
EXECUTE MMInfo_Insert 510,19309,'','/docs/sendDoc/DocReceiveUnitFrame.jsp','mainFrame',20,2,5,0,'',0,'',0,'','',0,'','',1
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 142,19309,'varchar(400)','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/DocReceiveUnitBrowserMulti.jsp','DocReceiveUnit','receiveUnitName','id','/docs/sendDoc/DocReceiveUnitDsp.jsp?id=')
GO

INSERT INTO HtmlLabelIndex values(19365,'��ǰ��λ���¼���λ������ɾ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19365,'��ǰ��λ���¼���λ������ɾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19365,'Current unit has subunit,can''t be deleted.',8) 
GO
INSERT INTO HtmlLabelIndex values(19366,'ͬ����λ���Ʋ����ظ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19366,'ͬ����λ���Ʋ����ظ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19366,'The names of peer units couldn''t be repeated.',8) 
GO

update ErrorMsgInfo set msgName='�ü�¼�����ã�����ɾ����' where indexid=20 and languageid=7
GO



CREATE TABLE [DocReceiveUnit] (
        [id] [int] IDENTITY (1, 1) NOT NULL ,
        [receiveUnitName] [varchar] (200) NULL , 
        [superiorUnitId] int NULL ,
        [receiverIds] [varchar] (200) NULL ,
        [allSuperiorUnitId] [varchar] (80) NULL ,
        [unitLevel] int NULL ,
        [showOrder] int NULL 
) 
GO
