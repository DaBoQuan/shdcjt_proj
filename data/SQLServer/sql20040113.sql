insert into SystemRights (id,rightdesc,righttype) values (405,'���ķ��Ĺ���','1')
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (405,7,'���ķ��Ĺ���','���ķ��Ĺ���')
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (405,8,'','')
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3094,'���ķ��Ĺ���','SendDoc:Manage',405)
GO
insert into SystemRightToGroup(groupid,rightid) values(2,405)
GO
INSERT INTO HtmlLabelIndex values(16971,'�����ֺ�')
GO
INSERT INTO HtmlLabelInfo VALUES(16971,'�����ֺ�',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16971,'',8)
GO
INSERT INTO HtmlLabelIndex values(16972,'���ܵȼ�')
GO
INSERT INTO HtmlLabelInfo VALUES(16972,'���ܵȼ�',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16972,'',8)
GO
INSERT INTO HtmlLabelIndex values(16973,'��������')
GO
INSERT INTO HtmlLabelInfo VALUES(16973,'��������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16973,'',8)
GO
INSERT INTO HtmlLabelIndex values(16974,'�շ�����ת��')
GO
INSERT INTO HtmlLabelInfo VALUES(16974,'�շ�����ת��',7)
GO
INSERT INTO HtmlLabelIndex values(16975,'������')
GO
INSERT INTO HtmlLabelInfo VALUES(16975,'������',7)
GO
INSERT INTO HtmlLabelIndex values(16976,'���Ͳ���')
GO
INSERT INTO HtmlLabelInfo VALUES(16976,'���Ͳ���',7)
GO
INSERT INTO HtmlLabelIndex values(16977,'ӡ������')
GO
INSERT INTO HtmlLabelInfo VALUES(16977,'ӡ������',7)
GO
INSERT INTO HtmlLabelIndex values(16978,'�����')
GO
INSERT INTO HtmlLabelInfo VALUES(16978,'�����',7)
GO
INSERT INTO HtmlLabelIndex values(16980,'�����ֺ�')
GO
INSERT INTO HtmlLabelInfo VALUES(16980,'�����ֺ�',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16980,'',8)
GO
INSERT INTO HtmlLabelIndex values(16981,'����')
GO
INSERT INTO HtmlLabelInfo VALUES(16981,'����',7)
GO
INSERT INTO HtmlLabelIndex values(16982,'�ں�')
GO
INSERT INTO HtmlLabelInfo VALUES(16982,'�ں�',7)
GO
INSERT INTO HtmlLabelIndex values(16983,'��������')
GO
INSERT INTO HtmlLabelInfo VALUES(16983,'��������',7)
GO
INSERT INTO HtmlLabelIndex values(16984,'ӡ������')
GO
INSERT INTO HtmlLabelInfo VALUES(16984,'ӡ������',7)
GO
INSERT INTO HtmlLabelIndex values(16985,'���ͻ���')
GO
INSERT INTO HtmlLabelInfo VALUES(16985,'���ͻ���',7)
GO
INSERT INTO HtmlLabelIndex values(16986,'��������')
GO
INSERT INTO HtmlLabelInfo VALUES(16986,'��������',7)
GO
INSERT INTO HtmlLabelIndex values(16987,'���ͻ���')
GO
INSERT INTO HtmlLabelInfo VALUES(16987,'���ͻ���',7)
GO
INSERT INTO HtmlLabelIndex values(16988,'ӡ������')
GO
INSERT INTO HtmlLabelInfo VALUES(16988,'ӡ������',7)
GO
INSERT INTO HtmlLabelIndex values(16989,'ϵͳ��ַ')
GO
INSERT INTO HtmlLabelInfo VALUES(16989,'ϵͳ��ַ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16989,'',8)
GO
INSERT INTO HtmlLabelIndex values(16990,'���ķ���')
GO
INSERT INTO HtmlLabelInfo VALUES(16990,'���ķ���',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16990,'',8)
GO
INSERT INTO HtmlLabelIndex values(16991,'���Ĵ���')
GO
INSERT INTO HtmlLabelInfo VALUES(16991,'���Ĵ���',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16991,'',8)
GO
INSERT INTO HtmlLabelIndex values(16992,'��')
GO
INSERT INTO HtmlLabelInfo VALUES(16992,'��',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16992,'',8)
GO
INSERT INTO HtmlLabelIndex values(16993,'�����ֺ�')
GO
INSERT INTO HtmlLabelInfo VALUES(16993,'�����ֺ�',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16993,'',8)
GO
INSERT INTO HtmlLabelIndex values(16994,'���Ļ���')
GO
INSERT INTO HtmlLabelInfo VALUES(16994,'���Ļ���',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16994,'',8)
GO
INSERT INTO HtmlLabelIndex values(16995,'ǩ����')
GO
INSERT INTO HtmlLabelInfo VALUES(16995,'ǩ����',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16995,'',8)
GO
INSERT INTO HtmlLabelIndex values(16996,'ǩ������')
GO
INSERT INTO HtmlLabelInfo VALUES(16996,'ǩ������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16996,'',8)
GO
INSERT INTO HtmlLabelIndex values(16997,'Ĭ����Ϣ')
GO
INSERT INTO HtmlLabelInfo VALUES(16997,'Ĭ����Ϣ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16997,'',8)
GO
INSERT INTO HtmlLabelIndex values(16998,'�ݴ�Ŀ¼')
GO
INSERT INTO HtmlLabelInfo VALUES(16998,'',8)
GO
INSERT INTO HtmlLabelInfo VALUES(16998,'�ݴ�Ŀ¼',7)
GO
INSERT INTO HtmlLabelIndex values(16999,'������Ϣ')
GO
INSERT INTO HtmlLabelInfo VALUES(16999,'������Ϣ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(16999,'',8)
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 52,16973,'int','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docKindBrowser.jsp','DocSendDocKind','name','id','')
GO
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 53,15534,'int','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docInstancyLevelBrowser.jsp','DocInstancyLevel','name','id','')
GO
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 54,16972,'int','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docSecretLevelBrowser.jsp','docSecretLevel','name','id','')
GO
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 55,16980,'int','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docNumberBrowser.jsp','DocSendDocNumber','name','id','')
GO
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 56,16989,'varchar(100)','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/systemIpBrowser.jsp','systemIp','name','id','/docs/sendDoc/systemIp.jsp?id=')
GO

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(66,16974,'bill_SendDoc','BillSendDocAdd.jsp','BillSendDocManage.jsp','BillSendDocView.jsp','','','')
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'resourceId',16975,'int',3,1,1,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'departmentId',16976,'int',3,4,2,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docIds',857,'varchar(100)',3,37,3,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'pieces',16977,'int',1,2,4,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'subjectWord',16978,'varchar(300)',1,1,5,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docKind',16973,'int',3,52,6,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docInstancyLevel',15534,'int',3,53,7,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docSecretLevel',16972,'int',3,54,8,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docNumber',16980,'int',3,55,9,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docNumberYear',16981,'int',1,2,10,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docNumberIssue',16982,'int',1,2,11,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'finishDate',16983,'char(10)',3,2,12,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'sendDate',16984,'char(10)',3,2,13,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'phone',421,'varchar(100)',1,1,14,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_1',16985,'varchar(1000)',1,1,15,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_2',16986,'varchar(1000)',1,1,16,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_3',16987,'varchar(1000)',1,1,17,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_4',16988,'varchar(1000)',1,1,18,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'desc_n',85,'varchar(3000)',2,0,19,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'systemIds',16989,'varchar(100)',3,56,20,0)
GO

CREATE TABLE [DocSendDocNumber] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (200) NULL ,
	[desc_n] [varchar] (300) NULL
)
GO

CREATE TABLE [DocInstancyLevel] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (200) NULL ,
	[desc_n] [varchar] (300) NULL
)
GO
CREATE TABLE [DocSecretLevel] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (200) NULL ,
	[desc_n] [varchar] (300) NULL
)
GO
CREATE TABLE [DocSendDocKind] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (200) NULL ,
	[desc_n] [varchar] (300) NULL
)
GO
CREATE TABLE [systemIp] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (200) NULL ,
	[ip] [varchar] (50) NULL
)
GO
CREATE TABLE [DocSendDocDefaultValue] (
	[categoryId] [int] NULL ,
	[createrId] [int] NULL
)
GO
CREATE TABLE [bill_SendDoc] (
    [id] [int] IDENTITY (1, 1) NOT NULL ,
    [requestid] [int] NULL ,
    [subject] [varchar] (300) NULL ,
    [resourceId] [int] NULL ,
    [departmentId] [int] NULL ,
    [docIds] [varchar] (100) NULL ,
    [pieces] [int] NULL ,
    [subjectWord] [varchar] (300) NULL ,
    [docKind] [int] NULL ,
    [docInstancyLevel] [int] NULL ,
    [docSecretLevel] [int] NULL ,
    [docNumber] [int] NULL ,
    [docNumberYear] [int] NULL ,
    [docNumberIssue] [int] NULL ,
    [finishDate] [char] (10) NULL ,
    [sendDate] [char] (10) NULL ,
    [phone] [varchar] (100) NULL ,
    [department_1] [varchar] (1000) NULL ,
    [department_2] [varchar] (1000) NULL ,
    [department_3] [varchar] (1000) NULL ,
    [department_4] [varchar] (1000) NULL ,
    [desc_n] [varchar] (3000) NULL ,
    [systemIds] [varchar] (100) NULL
)
GO

CREATE TABLE [DocSendDocDetail] (
    [id] [int] IDENTITY (1, 1) NOT NULL ,
    [subject] [varchar] (300) NULL ,
    [docIds] [varchar] (100) NULL ,
    [docKind] [varchar] (200) NULL ,
    [docInstancyLevel] [varchar] (200) NULL ,
    [docSecretLevel] [varchar] (200) NULL ,
    [docNumber_1] [varchar] (200) NULL ,
    [docNumberYear_1] [char] (5) NULL ,
    [docNumberIssue_1] [char] (5) NULL ,
    [docNumber_2] [varchar] (200) NULL ,
    [docNumberYear_2] [char] (5) NULL ,
    [docNumberIssue_2] [char] (5) NULL ,
    [sendDate] [char] (10) NULL ,
    [sendDepartment] [varchar] (100) NULL ,
    [department_1] [varchar] (1000) NULL ,
    [department_2] [varchar] (1000) NULL ,
    [department_3] [varchar] (1000) NULL ,
    [department_4] [varchar] (1000) NULL ,
    [signer] [int] NULL ,
    [signDate] [char] (10) NULL  ,
    [requestLog] [text] NULL  ,
    [status]  [char]  NULL ,
    [createDate]  [char] (10) NULL
)
GO
