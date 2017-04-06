CREATE TABLE [webSite] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (200)  NULL ,
	[linkKey] [varchar] (200)  NULL ,
	[newsId] [int] NULL ,
	[type] [char] (1) NULL,
    [researchId] [int] NULL 
) 
GO


CREATE TABLE [bill_onlineRegist]
(
    id int IDENTITY (1, 1) NOT NULL  ,
    requestid  int NULL ,    
    name varchar(200) NULL ,
    engname varchar(200) NULL ,
    address1 varchar(400) NULL ,
    city int NULL ,
    phone varchar(100) NULL ,
    email varchar(100) NULL ,
    website varchar(100) NULL ,
    contacterTitle int NULL,
    contacterName  varchar(100) NULL ,
    contacterJobTitle  varchar(100) NULL ,    
    type_n int NULL ,
    description int NULL ,
    size_n int NULL ,
    sector int NULL ,
    journal varchar(200) null ,
    crmmanager int NULL ,
    password varchar(100) NULL 
    
)
GO

CREATE TABLE [webMailList] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (200)  NULL ,
	[mailDesc] [varchar] (400)  NULL ,
    [userList] [varchar] (4000)  NULL 
) 
GO

CREATE TABLE [DocWebComment] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
    [docId] [int] NULL ,
	[name] [varchar] (100)  NULL ,
	[mail_1] [varchar] (30)  NULL ,
    [comment_1] [varchar] (2000)  NULL ,
    [createDate] [char] (10) NULL ,
    [createTime] [char] (8) NULL 
) 
GO

CREATE INDEX [DocWebComment_docId] ON [DocWebComment]([docId]) 
GO

insert into HtmlLabelIndex (id,indexdesc) values (17059	,'����ע��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17059,'����ע��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17059,'',8)
GO
insert into HtmlLabelIndex (id,indexdesc) values (17060	,'��˾����(���)')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17060,'��˾����(���)',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17060,'',8)
GO
insert into HtmlLabelIndex (id,indexdesc) values (17061	,'��ϵ�˳ƺ�')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17061,'��ϵ�˳ƺ�',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17061,'',8)
GO
insert into HtmlLabelIndex (id,indexdesc) values (17062	,'��ϵ������')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17062,'��ϵ������',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17062,'',8)
GO
insert into HtmlLabelIndex (id,indexdesc) values (17063	,'��ϵ�˹���ͷ��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17063,'��ϵ�˹���ͷ��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17063,'',8)
GO
insert into HtmlLabelIndex (id,indexdesc) values (17064	,'�����ʼ�')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17064,'�����ʼ�',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17064,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (17065	,'�ʼ��б�')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17065,'�ʼ��б�',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (17065,'',8)
GO


INSERT INTO HtmlLabelIndex values(17066,'��վ����') 
GO
INSERT INTO HtmlLabelIndex values(17067,'��վ��Ŀ') 
GO
INSERT INTO HtmlLabelIndex values(17068,'�鿴����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17066,'��վ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17066,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17067,'��վ��Ŀ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17067,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17068,'�鿴����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17068,'',8) 
GO

INSERT INTO HtmlLabelIndex values(17069,'���۹���') 
GO
INSERT INTO HtmlLabelInfo VALUES(17069,'���۹���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17069,'',8) 
GO



/* ��վά�� */

create PROCEDURE rightUpdateTemp 
As
declare @rightId_1 int

declare right_cursor cursor for
select id from SystemRights  where rightdesc = '��վά��'
open right_cursor 
fetch next from right_cursor into @rightId_1
while @@fetch_status=0
    begin 
        delete from SystemRights where id = @rightId_1
        delete from SystemRightsLanguage where id = @rightId_1
        delete from SystemRightDetail where rightid = @rightId_1        

        update SystemRightRoles set rightid = 406 where rightid = @rightId_1
        update SystemRightToGroup set rightid = 406 where rightid = @rightId_1
        
	fetch next from right_cursor into @rightId_1
    end 
close right_cursor deallocate right_cursor
GO

exec rightUpdateTemp
GO

drop PROCEDURE rightUpdateTemp 
GO

insert into SystemRights(id,rightdesc,righttype) values(406,'��վά��','0')
GO

insert into SystemRightsLanguage(id,languageid,rightname,rightdesc) values(406,7,'��վά��','��վά��')
GO

insert into SystemRightsLanguage(id,languageid,rightname,rightdesc) values(406,8,'','')
GO

insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid) values(3095,'��վά��','WebSiteView:View',406)
GO


/*��sunyard���ͻ--------------------------------------------------------------------*/

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 58,493,'int','/systeminfo/BrowserMain.jsp?url=/web/broswer/CityBrowser.jsp','HrmCity','cityname','id','')
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 59,462,'int','/systeminfo/BrowserMain.jsp?url=/web/broswer/ContacterTitleBrowser.jsp','CRM_ContacterTitle','fullname','id','')
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 60,1282,'int','/systeminfo/BrowserMain.jsp?url=/web/broswer/CustomerTypeBrowser.jsp','CRM_ContractType','name','id','')
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 61,1283,'int','/systeminfo/BrowserMain.jsp?url=/web/broswer/CustomerDescBrowser.jsp','CRM_CustomerDesc','fullname','id','')
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 62,1285,'int','/systeminfo/BrowserMain.jsp?url=/web/broswer/CustomerSizeBrowser.jsp','CRM_CustomerSize','fullname','id','')
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 63,575,'int','/systeminfo/BrowserMain.jsp?url=/web/broswer/SectorInfoBrowser.jsp','CRM_SectorInfo','fullname','id','')
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 64,17065,'varchar(200)','/systeminfo/BrowserMain.jsp?url=/web/mailList/MailListBrowser.jsp','webMailList','name','id','')
GO



INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(68,17059,'bill_onlineRegist','BillOnlineRegistAdd.jsp','','','','','BillOnlineRegistOperation.jsp') 
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'name',1976,'varchar(200)',1,1,1,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'engname',17060,'varchar(200)',1,1,2,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'address1',110,'varchar(400)',1,1,3,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'city',493,'int',3,58,4,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'email',477,'varchar(100)',1,1,5,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'website',76,'varchar(100)',1,1,6,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'contacterTitle',17061,'int',3,59,7,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'contacterName',17062,'varchar(100)',1,1,8,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'contacterJobTitle',17063,'varchar(100)',1,1,9,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'type_n',7179,'int',3,60,10,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'description',433,'int',3,61,11,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'size_n',576,'int',3,62,12,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'sector',575,'int',3,63,13,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'crmmanager',1278,'int',3,1,15,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'journal',17064,'varchar(200)',3,64,14,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'password',409,'varchar(100)',1,1,16,0)
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (68,'phone',421,'varchar(100)',1,1,5,0) 
GO

/*��sunyard���ͻ--------------------------------------------------------------------*/