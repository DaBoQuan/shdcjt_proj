

/*�������������ecology��Ʒ�������������Ӳ�Ʒ������ύ���Ա��桷�Ľű�*/

/* ���ӹ���������� */
insert into HtmlLabelIndex (id,indexdesc) values (6166	,'��ز�Ʒ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6166,'��ز�Ʒ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6166,'',8)
GO

INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 6166,'int','/systeminfo/BrowserMain.jsp?url=/lgc/search/LgcProductBrowser.jsp','LgcAssetCountry','assetname','assetid','/lgc/asset/LgcAsset.jsp?paraid=')
GO



/*�����ǳ�Ӣ�ܡ�Ecology����Ʒ����������Դbug�޸�(20030725)�ύ���Ա��桷�Ľű�*/

insert into HrmUserDefine (
	userid,
	hasresourceid,
	hasresourcename,
	hasjobtitle,
	hasactivitydesc,
	hasjobgroup,
	hasjobactivity,
	hascostcenter,
	hascompetency,
	hasresourcetype,
	hasstatus,
	hassubcompany,
	hasdepartment,
	haslocation,
	hasmanager,
	hasassistant,
	hasroles,
	hasseclevel,
	hasjoblevel,
	hasworkroom,
	hastelephone,
	hasstartdate,
	hasenddate,
	hascontractdate,
	hasbirthday,
	hassex,
	projectable,
	crmable,
	itemable,
	docable,
	workflowable,
	subordinateable,
	trainable,
	budgetable,
	fnatranable,
	dspperpage,
	hasage,
	hasworkcode,
	hasjobcall,
	hasmobile,
	hasmobilecall,
	hasfax,
	hasemail,
	hasfolk,
	hasregresidentplace,
	hasnativeplace,
	hascertificatenum,
	hasmaritalstatus,
	haspolicy,
	hasbememberdate,
	hasbepartydate,
	hasislabouunion,
	haseducationlevel,
	hasdegree,
	hashealthinfo,
	hasheight,
	hasweight,
	hasresidentplace,
	hashomeaddress,
	hastempresidentnumber,
	hasusekind,
	hasbankid1,
	hasaccountid1,
	hasaccumfundaccount,
	hasloginid,
	hassystemlanguage)
values(-1,' ','1','1','1','1','1',' ',' ',' ','1','1','1','1','1','1',' ',' ','1','1','1',' ',' ',' ',' ','1','1','1','1','1','1','1',' ','1','1',10,' ','1','1','1','1','1','1',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ')
go
