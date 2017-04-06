INSERT INTO HtmlLabelIndex values(19414,'ϵͳ��֧��10�����ϵ���״�ֶΣ�') 
GO
INSERT INTO HtmlLabelIndex values(19410,'��״�ֶ�����') 
GO
INSERT INTO HtmlLabelIndex values(19412,'�½��¼��ڵ�') 
GO
INSERT INTO HtmlLabelIndex values(19411,'�ϼ��ڵ�') 
GO
INSERT INTO HtmlLabelIndex values(19413,'�½�ͬ���ڵ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19410,'��״�ֶ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19410,'Tree Field Setting',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19411,'�ϼ��ڵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19411,'Superior Node',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19412,'�½��¼��ڵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19412,'New Sub Node',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19413,'�½�ͬ���ڵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19413,'New Peer Node',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19414,'ϵͳ��֧��10�����ϵ���״�ֶΣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19414,'The system doesn''t support 10 level of tree field!',8) 
GO

INSERT INTO HtmlLabelIndex values(19441,'��ǰ�ֶ����¼��ڵ㣬����ɾ����') 
GO
INSERT INTO HtmlLabelIndex values(19442,'ͬ���ֶ����Ʋ����ظ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19441,'��ǰ�ֶ����¼��ڵ㣬����ɾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19441,'Current field has subnode,can''t be deleted.',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19442,'ͬ���ֶ����Ʋ����ظ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19442,'The names of peer fields can''t be repeated.',8) 
GO



CREATE TABLE DocTreeDocField (
	id int IDENTITY (1, 1) NOT NULL ,
        treeDocFieldName varchar(80) NULL , 
        superiorFieldId int NULL ,
        allSuperiorFieldId varchar(80) NULL ,
        fieldLevel int NULL ,
	    isLast  char(1) NULL,
        showOrder decimal(6,2) NULL 
) 
GO


insert into  DocTreeDocField(treeDocFieldName,superiorFieldId,allSuperiorFieldId,fieldLevel,isLast,showOrder) values('root',0,'',0,1,0.00)
GO


EXECUTE MMConfig_U_ByInfoInsert 2,16
GO
EXECUTE MMInfo_Insert 516,19410,'','/docs/category/DocTreeDocFieldFrame.jsp','mainFrame',2,1,16,0,'',0,'',0,'','',0,'','',1
GO

INSERT INTO HtmlLabelIndex values(19485,'��״�ĵ��ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19485,'��״�ĵ��ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19485,'Tree Document Field',8) 
GO

INSERT INTO HtmlLabelIndex values(19490,'��״�ֶ���ʾ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19490,'��״�ֶ���ʾ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19490,'View by Tree Field',8) 
GO

INSERT INTO HtmlLabelIndex values(19500,'��ϵ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19500,'��ϵ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19500,'System Type',8) 
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 143,19485,'varchar(400)','/systeminfo/BrowserMain.jsp?url=/docs/category/DocTreeDocFieldBrowserMulti.jsp','DocTreeDocField','treeDocFieldName','id','/docs/category/DocTreeDocFieldDsp.jsp?id=')


ALTER TABLE DocSearchMould ADD  treeDocFieldId int
GO
