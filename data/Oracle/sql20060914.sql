ALTER TABLE DocMainCategory ADD	norepeatedname integer NULL
/

ALTER TABLE DocSubCategory ADD	norepeatedname integer NULL
/

ALTER TABLE DocSecCategory ADD	nodownload integer NULL
/
ALTER TABLE DocSecCategory ADD	norepeatedname integer NULL
/
ALTER TABLE DocSecCategory ADD	iscontroledbydir integer NULL
/
ALTER TABLE DocSecCategory ADD	puboperation integer NULL
/
ALTER TABLE DocSecCategory ADD	childdocreadremind integer NULL
/
ALTER TABLE DocSecCategory ADD	readoptercanprint integer NULL
/
ALTER TABLE DocSecCategory ADD	editionIsOpen integer NULL
/
ALTER TABLE DocSecCategory ADD	editionPrefix VARCHAR2(100) NULL
/
ALTER TABLE DocSecCategory ADD	readerCanViewHistoryEdition integer NULL
/

CREATE TABLE DocSecCategoryMould (
	id integer  NOT NULL ,
	secCategoryId integer NULL ,
	mouldType  integer NULL ,  
	mouldId  integer NULL , 
    isDefault   integer NULL,
    mouldBind integer NULL
)
/

create sequence DocSecCategoryMould_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSecCategoryMould_Trigger
before insert on DocSecCategoryMould
for each row
begin
select DocSecCategoryMould_Id.nextval into :new.id from dual;
end;
/



CREATE TABLE DocSecCategoryMouldBookMark (
	DocSecCategoryMouldId integer  NULL ,
	BookMarkId integer NULL ,
	DocSecCategoryDocPropertyId  integer NULL 
)
/

CREATE TABLE DocSecCategoryDocProperty (
	id integer  NOT NULL ,
	secCategoryId integer NULL ,
	viewindex  integer NULL ,  
	type  integer NULL , 
    labelid   integer NULL,
    visible integer NULL,
    customName  VARCHAR2 (100) NULL ,
	columnWidth  integer NULL ,  
	mustInput  integer NULL , 
    isCustom   integer NULL,
    scope  VARCHAR2 (50) NULL,
    scopeid integer NULL ,
	fieldid  integer NULL 
)
/

create sequence DocSecCategoryDocProperty_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSecCategoryDocProperty_Tri
before insert on DocSecCategoryDocProperty
for each row
begin
select DocSecCategoryDocProperty_Id.nextval into :new.id from dual;
end;
/





ALTER TABLE DocDetail ADD	doccode VARCHAR2(50) NULL
/
ALTER TABLE DocDetail ADD	docedition integer NULL
/
ALTER TABLE DocDetail ADD	doceditionid integer NULL
/
ALTER TABLE DocDetail ADD	ishistory integer NULL
/
ALTER TABLE DocDetail ADD	maindoc integer NULL
/
ALTER TABLE DocDetail ADD	approvetype integer NULL
/
ALTER TABLE DocDetail ADD	readoptercanprint integer NULL
/
ALTER TABLE DocDetail ADD	docvaliduserid integer NULL
/
ALTER TABLE DocDetail ADD	docvaliddate char(10) NULL
/
ALTER TABLE DocDetail ADD	docvalidtime char(8) NULL
/
ALTER TABLE DocDetail ADD	docpubuserid integer NULL
/
ALTER TABLE DocDetail ADD	docpubdate char(10) NULL
/
ALTER TABLE DocDetail ADD	docpubtime char(8) NULL
/
ALTER TABLE DocDetail ADD	docreopenuserid integer NULL
/
ALTER TABLE DocDetail ADD	docreopendate char(10) NULL
/
ALTER TABLE DocDetail ADD	docreopentime char(8) NULL
/
ALTER TABLE DocDetail ADD	docinvaluserid integer NULL
/
ALTER TABLE DocDetail ADD	docinvaldate char(10) NULL
/
ALTER TABLE DocDetail ADD	docinvaltime char(8) NULL
/
ALTER TABLE DocDetail ADD	doccanceluserid integer NULL
/
ALTER TABLE DocDetail ADD	doccanceldate char(10) NULL
/
ALTER TABLE DocDetail ADD	doccanceltime char(8) NULL
/
ALTER TABLE DocDetail ADD	selectedpubmouldid integer NULL
/

UPDATE DocDetail SET ishistory = 0
/



CREATE TABLE DocSecCategoryTemplate (
	id integer NOT NULL,
	name varchar2(200) NULL,
	subcategoryid integer NULL,
	categoryname varchar2(200) NULL,
	docmouldid integer NULL,
	publishable char(1) NULL,
	replyable char(1) NULL,
	shareable char(1) NULL,
	cusertype char(1) NULL,
	cuserseclevel smallint NULL,
	cdepartmentid1 integer NULL,
	cdepseclevel1 smallint NULL,
	cdepartmentid2 integer NULL,
	cdepseclevel2 smallint NULL,
	croleid1 integer NULL,
	crolelevel1 char(1) NULL,
	croleid2 integer NULL,
	crolelevel2 char(1) NULL,
	croleid3 integer NULL,
	crolelevel3 char(1) NULL,
	hasaccessory char(1) NULL,
	accessorynum smallint NULL,
	hasasset char(1) NULL,
	assetlabel varchar2(200) NULL,
	hasitems char(1) NULL,
	itemlabel varchar2(200) NULL,
	hashrmres char(1) NULL,
	hrmreslabel varchar2(200) NULL,
	hascrm char(1) NULL,
	crmlabel varchar2(200) NULL,
	hasproject char(1) NULL,
	projectlabel varchar2(200) NULL,
	hasfinance char(1) NULL,
	financelabel varchar2(200) NULL,
	approveworkflowid integer NULL,
	markable char(1) NULL,
	markAnonymity char(1) NULL,
	orderable char(1)  DEFAULT (0) NULL,
	defaultLockedDoc integer  DEFAULT (0) NULL,
	allownModiMShareL integer NULL,
	allownModiMShareW integer NULL,
	maxUploadFileSize integer DEFAULT (5) NULL,
	wordmouldid integer NULL,
	coder varchar2(20) NULL,
	isSetShare integer NULL,
	nodownload integer NULL,
	norepeatedname integer NULL,
	iscontroledbydir integer NULL,
	puboperation integer NULL,
	childdocreadremind integer NULL,
	readoptercanprint integer NULL,
	editionIsOpen integer NULL,
	editionPrefix varchar2(100) NULL,
	readerCanViewHistoryEdition integer  NULL,
	isOpenApproveWf char(1) NULL,
	validityApproveWf integer NULL,
	invalidityApproveWf integer NULL)
/






create sequence DocSecCategoryTemplate_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSecCategoryTemplate_TRI
before insert on DocSecCategoryTemplate
for each row
begin
select DocSecCategoryTemplate_Id.nextval into :new.id from dual;
end;
/



ALTER TABLE DirAccessControlList ADD DocSecCategoryTemplateId integer NULL
/

ALTER TABLE secCreaterDocPope ADD DocSecCategoryTemplateId integer NULL
/

ALTER TABLE DocSecCategoryShare ADD DocSecCategoryTemplateId integer NULL
/

ALTER TABLE CodeMain ADD DocSecCategoryTemplateId integer NULL
/

ALTER TABLE DocSecCategoryDocProperty ADD DocSecCategoryTemplateId integer NULL
/
ALTER TABLE DocSecCategoryMould ADD DocSecCategoryTemplateId integer NULL
/


insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4166,'�ĵ�����','DocEdit:Publish',16) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4167,'�ĵ�ʧЧ','DocEdit:Invalidate',16) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4168,'�ĵ�����','DocEdit:Cancel',16) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4169,'�ĵ����´�','DocEdit:Reopen',16) 
/

INSERT INTO SequenceIndex(indexdesc,currentid) values('doceditionid',1)
/

INSERT INTO HtmlLabelIndex values(19449,'��ֹ�ĵ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19449,'��ֹ�ĵ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19449,'No repeated document name',8) 
/
 
INSERT INTO HtmlLabelIndex values(19450,'�汾����') 
/
INSERT INTO HtmlLabelInfo VALUES(19450,'�汾����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19450,'Edition Manager',8) 
/

INSERT INTO HtmlLabelIndex values(19451,'�ĵ�����ҳ') 
/
INSERT INTO HtmlLabelInfo VALUES(19451,'�ĵ�����ҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19451,'Document Properties',8) 
/
 
INSERT INTO HtmlLabelIndex values(19456,'Ŀ¼ģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19456,'Ŀ¼ģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19456,'DirectoryMould',8) 
/
 
INSERT INTO HtmlLabelIndex values(19457,'������Ϊ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19457,'������Ϊ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19457,'can be published to news',8) 
/

INSERT INTO HtmlLabelIndex values(19458,'��ֹ�ĵ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19458,'��ֹ�ĵ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19458,'No download',8) 
/
 
INSERT INTO HtmlLabelIndex values(19459,'�Ƿ��ܿ�Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19459,'�Ƿ��ܿ�Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19459,'is controled by directory',8) 
/

INSERT INTO HtmlLabelIndex values(19460,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(19460,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19460,'publication operation',8) 
/
 
INSERT INTO HtmlLabelIndex values(19461,'���ĵ��Ķ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19461,'���ĵ��Ķ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19461,'child document read Remind',8) 
/
 
INSERT INTO HtmlLabelIndex values(19462,'����ֻ�������˴�ӡ') 
/
INSERT INTO HtmlLabelInfo VALUES(19462,'����ֻ�������˴�ӡ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19462,'read operator can print',8) 
/
 
INSERT INTO HtmlLabelIndex values(19463,'���ĵ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19463,'���ĵ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19463,'by document setting',8) 
/


INSERT INTO HtmlLabelIndex values(19468,'���Ϊģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19468,'���Ϊģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19468,'Save as template',8) 
/

INSERT INTO HtmlLabelIndex values(19471,'ģ������') 
/
INSERT INTO HtmlLabelInfo VALUES(19471,'ģ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19471,'Mould Type',8) 
/
 
INSERT INTO HtmlLabelIndex values(19472,'ģ��ѡ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19472,'ģ��ѡ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19472,'Select Mould',8) 
/
 
INSERT INTO HtmlLabelIndex values(19473,'ģ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19473,'ģ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19473,'Bind Mould',8) 
/
 
INSERT INTO HtmlLabelIndex values(19474,'html��ʾģ��') 
/
INSERT INTO HtmlLabelIndex values(19475,'html�༭ģ��') 
/
INSERT INTO HtmlLabelIndex values(19476,'word��ʾģ��') 
/
INSERT INTO HtmlLabelIndex values(19477,'word�༭ģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19474,'html��ʾģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19474,'HTML View Mould',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19475,'html�༭ģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19475,'HTML Edit Mould',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19476,'word��ʾģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19476,'WORD View Mould',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19477,'word�༭ģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19477,'WORD Edit Mould',8) 
/

INSERT INTO HtmlLabelIndex values(19478,'�����ĵ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19478,'�����ĵ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19478,'Normal Document Binded',8) 
/
 
INSERT INTO HtmlLabelIndex values(19479,'��ʱ�ĵ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19479,'��ʱ�ĵ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19479,'Temporary Document Binded',8) 
/
 
INSERT INTO HtmlLabelIndex values(19480,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(19480,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19480,'Content Setting',8) 
/

INSERT INTO HtmlLabelIndex values(19499,'ģ���ֶι�����ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(19499,'ģ���ֶι�����ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19499,'Mould Field Association Evaluate',8) 
/

INSERT INTO HtmlLabelIndex values(19505,'ͬһ��ģ�����ͺ�ͬһ��ģ���ֻ��ѡ��һ��Ĭ��ֵ!') 
/
INSERT INTO HtmlLabelInfo VALUES(19505,'ͬһ��ģ�����ͺ�ͬһ��ģ���ֻ��ѡ��һ��Ĭ��ֵ!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19505,'Same Mould and Same Mould Bind can select only one default value!',8) 
/

INSERT INTO HtmlLabelIndex values(19506,'ͬһ��ģ������ֻ��ѡ��һ�������ĵ���!') 
/
INSERT INTO HtmlLabelInfo VALUES(19506,'ͬһ��ģ������ֻ��ѡ��һ�������ĵ���!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19506,'Same Mould Type can select only one normal document binding!',8) 
/

INSERT INTO HtmlLabelIndex values(19507,'ͬһ��ģ������ֻ��ѡ��һ����ʱ�ĵ���!') 
/
INSERT INTO HtmlLabelInfo VALUES(19507,'ͬһ��ģ������ֻ��ѡ��һ����ʱ�ĵ���!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19507,'Same Mould Type can select only one temporary document binding!',8) 
/
INSERT INTO HtmlLabelIndex values(19508,'δѡ��ģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19508,'δѡ��ģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19508,'No mould is selected !',8) 
/

INSERT INTO HtmlLabelIndex values(19509,'�п�') 
/
INSERT INTO HtmlLabelInfo VALUES(19509,'�п�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19509,'col width',8) 
/

INSERT INTO HtmlLabelIndex values(19511,'��ʾģ��')
/
INSERT INTO HtmlLabelInfo VALUES(19511,'��ʾģ��',7)
/
INSERT INTO HtmlLabelInfo VALUES(19511,'Display Mould',8)
/

INSERT INTO HtmlLabelIndex values(19512,'�ؼ���')
/
INSERT INTO HtmlLabelInfo VALUES(19512,'�ؼ���',7)
/
INSERT INTO HtmlLabelInfo VALUES(19512,'Key Word',8)
/

INSERT INTO HtmlLabelIndex values(19513,'���ĵ�')
/
INSERT INTO HtmlLabelInfo VALUES(19513,'���ĵ�',7)
/
INSERT INTO HtmlLabelInfo VALUES(19513,'Main Document',8)
/

INSERT INTO HtmlLabelIndex values(19515,'�������б�')
/
INSERT INTO HtmlLabelInfo VALUES(19515,'�������б�',7)
/
INSERT INTO HtmlLabelInfo VALUES(19515,'refered list',8)
/

INSERT INTO HtmlLabelIndex values(19516,'�Զ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19516,'�Զ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19516,'user-defined',8) 
/

INSERT INTO HtmlLabelIndex values(19522,'�Զ����ֶα�ǩ����Ϊ��') 
/
INSERT INTO HtmlLabelIndex values(19523,'�Զ����ֶα�ǩ������ͬ') 
/
INSERT INTO HtmlLabelInfo VALUES(19522,'�Զ����ֶα�ǩ����Ϊ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19522,'User Definition Field Label can not be Null',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19523,'�Զ����ֶα�ǩ������ͬ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19523,'User Definition Field Label can not be Same',8) 
/
 
INSERT INTO HtmlLabelIndex values(19528,'ֻ��Ȩ�޲����˿ɲ鿴��ʷ�汾') 
/
INSERT INTO HtmlLabelInfo VALUES(19528,'ֻ��Ȩ�޲����˿ɲ鿴��ʷ�汾',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19528,'read-only operator can view history edition',8) 
/
 
INSERT INTO HtmlLabelIndex values(19541,'�ĵ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19541,'�ĵ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19541,'Document Title',8) 
/
 
INSERT INTO HtmlLabelIndex values(19542,'�ĵ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19542,'�ĵ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19542,'Document Number',8) 
/
INSERT INTO HtmlLabelIndex values(19543,'�ĵ��汾') 
/
INSERT INTO HtmlLabelInfo VALUES(19543,'�ĵ��汾',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19543,'Document Edition',8) 
/

INSERT INTO HtmlLabelIndex values(19544,'�ĵ�״̬') 
/
INSERT INTO HtmlLabelInfo VALUES(19544,'�ĵ�״̬',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19544,'Document Status',8) 
/
 
INSERT INTO HtmlLabelIndex values(19587,'�汾��Ϣ') 
/
INSERT INTO HtmlLabelInfo VALUES(19587,'�汾��Ϣ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19587,'Edition',8) 
/
 
INSERT INTO HtmlLabelIndex values(19588,'�ظ���Ϣ') 
/
INSERT INTO HtmlLabelInfo VALUES(19588,'�ظ���Ϣ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19588,'Reply Info',8) 
/
 
INSERT INTO HtmlLabelIndex values(19661,'����') 
/
INSERT INTO HtmlLabelIndex values(19662,'���汾') 
/
INSERT INTO HtmlLabelInfo VALUES(19661,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19661,'Total',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19662,'���汾',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19662,'Edition',8) 
/
 

CREATE or REPLACE PROCEDURE Doc_SecCategory_Insert 
	(subcategoryid_1 	integer,
	categoryname_2 	varchar2,
	docmouldid_3 	integer,
	publishable_4 	char,
	replyable_5 	char,
	shareable_6 	char,
	cusertype_7 	integer,
	cuserseclevel_8 	smallint,
	cdepartmentid1_9 	integer,
	cdepseclevel1_10 	smallint,
	cdepartmentid2_11 	integer,
	cdepseclevel2_12 	smallint,
	croleid1_13	 		integer,
	crolelevel1_14	 	char,
	croleid2_15	 	integer,
	crolelevel2_16 	char,
	croleid3_17	 	integer,
	crolelevel3_18 	char,
	hasaccessory_19	 	char,
	accessorynum_20	 	smallint,
	hasasset_21		 	char,
	assetlabel_22	 	varchar2,
	hasitems_23	 	char,
	itemlabel_24 	varchar2,
	hashrmres_25 	char,
	hrmreslabel_26 	varchar2,
	hascrm_27	 	char,
	crmlabel_28	 	varchar2,
	hasproject_29 	char,
	projectlabel_30 	varchar2,
	hasfinance_31 	char,
	financelabel_32 	varchar2,
	approveworkflowid_33	integer,
	markable_34   char,
	markAnonymity_35   char,
	orderable_36     char,
	defaultLockedDoc_37   integer,
	allownModiMShareL_38 integer,
	allownModiMShareW_39 integer,
	maxUploadFileSize_40 integer,
    wordmouldid_41 integer,
    isSetShare_42   integer,
    noDownload_43 integer,
    noRepeatedName_44 integer,
    isControledByDir_45 integer,
    pubOperation_46 integer,
    childDocReadRemind_47 integer,
    readOpterCanPrint_48 integer,
	flag	out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor)
as 
begin 

	insert into docseccategory 
		(subcategoryid  ,
		categoryname  ,
		docmouldid  ,
		publishable  ,
		replyable  ,
		shareable  ,
		cusertype  ,
		cuserseclevel  ,
		cdepartmentid1  ,
		cdepseclevel1  ,
		cdepartmentid2  ,
		cdepseclevel2  ,
		croleid1 ,
		crolelevel1  ,
		croleid2  ,
		crolelevel2 ,
		croleid3  ,
		crolelevel3  ,
		hasaccessory  ,
		accessorynum  ,
		hasasset  ,
		assetlabel  ,
		hasitems  ,
		itemlabel  ,
		hashrmres ,
		hrmreslabel  ,
		hascrm  ,
		crmlabel  ,
		hasproject  ,
		projectlabel  ,
		hasfinance  ,
		financelabel  ,
		approveworkflowid ,
		markable ,
		markAnonymity ,
		orderable,
		defaultLockedDoc,
		allownModiMShareL,
		allownModiMShareW,
		maxUploadFileSize,
        wordmouldid,
        isSetShare,
        noDownload,
        noRepeatedName,
        isControledByDir,
        pubOperation,
        childDocReadRemind,
        readOpterCanPrint)
	values(
		subcategoryid_1 	,
		categoryname_2 	,
		docmouldid_3 		,
		publishable_4		,
		replyable_5 		,
		shareable_6 		,
		cusertype_7 		,
		cuserseclevel_8 	,
		cdepartmentid1_9 	,
		cdepseclevel1_10 	,
		cdepartmentid2_11 ,
		cdepseclevel2_12 	,
		croleid1_13	 	,
		crolelevel1_14	,
		croleid2_15	 	,
		crolelevel2_16 	,
		croleid3_17	 	,
		crolelevel3_18 	,
		hasaccessory_19	,
		accessorynum_20	,
		hasasset_21		,
		assetlabel_22	 	,
		hasitems_23	 	,
		itemlabel_24 		,
		hashrmres_25 		,
		hrmreslabel_26 	,
		hascrm_27	 	,
		crmlabel_28	 	,
		hasproject_29 	,
		projectlabel_30 	,
		hasfinance_31 	,
		financelabel_32 	,
		approveworkflowid_33,
		markable_34       ,
		markAnonymity_35  ,
		orderable_36     ,
		defaultLockedDoc_37,
		allownModiMShareL_38 ,
		allownModiMShareW_39,
		maxUploadFileSize_40,
        wordmouldid_41,
        isSetShare_42,
        noDownload_43,
        noRepeatedName_44,
        isControledByDir_45,
        pubOperation_46,
        childDocReadRemind_47,
        readOpterCanPrint_48
        );
	open thecursor for 
	select max(id) from docseccategory;
end;
/

CREATE or REPLACE PROCEDURE Doc_SecCategory_Update 
( 
	id_1	integer,
	subcategoryid_2 	integer,
	categoryname_3 	varchar2,
    coder_43 	varchar2,
	docmouldid_4 	integer,
	publishable_5 	char,
	replyable_6 	char,
	shareable_7 	char,
	cusertype_8 	integer,
	cuserseclevel_9 	smallint,
	cdepartmentid1_10 	integer,
	cdepseclevel1_11 	smallint,
	cdepartmentid2_12 	integer,
	cdepseclevel2_13 	smallint,
	croleid1_14	 		integer,
	crolelevel1_15	 	char,
	croleid2_16	 	integer,
	crolelevel2_17 	char,
	croleid3_18	 	integer,
	crolelevel3_19 	char,
	hasaccessory_20	 	char,
	accessorynum_21	 	smallint,
	hasasset_22		 	char,
	assetlabel_23	 	varchar2,
	hasitems_24	 	char,
	itemlabel_25 	varchar2,
	hashrmres_26 	char,
	hrmreslabel_27 	varchar2,
	hascrm_28	 	char,
	crmlabel_29	 	varchar2,
	hasproject_30 	char,
	projectlabel_31 	varchar2,
	hasfinance_32 	char,
	financelabel_33 	varchar2,
	approveworkflowid_34	integer,
	markable_35   char,
	markAnonymity_36   char,
	orderable_37     char,
	defaultLockedDoc_38   integer,
	allownModiMShareL_39 integer,
	allownModiMShareW_40 integer,
	maxUploadFileSize_41 integer,
    wordmouldid_42  integer,
    isSetShare_44   integer,
    noDownload_45 integer,
    noRepeatedName_46 integer,
    isControledByDir_47 integer,
    pubOperation_48 integer,
    childDocReadRemind_49 integer,
    readOpterCanPrint_50 integer,
	flag	out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor)
as
begin 
	update docseccategory set
	subcategoryid= subcategoryid_2,
	categoryname= categoryname_3,
    coder= coder_43,
	docmouldid= docmouldid_4,
	publishable= publishable_5,
	replyable= replyable_6,
	shareable= shareable_7,
	cusertype= cusertype_8,
	cuserseclevel= cuserseclevel_9,
	cdepartmentid1= cdepartmentid1_10,
	cdepseclevel1= cdepseclevel1_11,
	cdepartmentid2= cdepartmentid2_12,
	cdepseclevel2= cdepseclevel2_13,
	croleid1= croleid1_14,
	crolelevel1= crolelevel1_15,
	croleid2= croleid2_16,
	crolelevel2= crolelevel2_17,
	croleid3= croleid3_18,
	crolelevel3= crolelevel3_19,
	hasaccessory= hasaccessory_20,
	accessorynum= accessorynum_21,
	hasasset= hasasset_22,
	assetlabel= assetlabel_23,
	hasitems= hasitems_24,
	itemlabel= itemlabel_25,
	hashrmres= hashrmres_26,
	hrmreslabel= hrmreslabel_27,
	hascrm= hascrm_28,
	crmlabel= crmlabel_29,
	hasproject= hasproject_30,
	projectlabel= projectlabel_31,
	hasfinance= hasfinance_32,
	financelabel= financelabel_33,
	approveworkflowid= approveworkflowid_34,
	markable = markable_35       ,
	markAnonymity = markAnonymity_36  ,
	orderable = orderable_37 ,
	defaultLockedDoc=defaultLockedDoc_38,
	allownModiMShareL=allownModiMShareL_39,
	allownModiMShareW=allownModiMShareW_40,
	maxUploadFileSize=maxUploadFileSize_41,
    wordmouldid=wordmouldid_42,
    isSetShare=isSetShare_44,
    noDownload=noDownload_45,
    noRepeatedName=noRepeatedName_46,
    isControledByDir=isControledByDir_47,
    pubOperation=pubOperation_48,
    childDocReadRemind=childDocReadRemind_49,
    readOpterCanPrint=readOpterCanPrint_50
	where id= id_1;
end;
/
INSERT INTO HtmlLabelIndex values(19536,'�ĵ���Ч����') 
/
INSERT INTO HtmlLabelIndex values(19538,'�ֶι�����ֵ') 
/
INSERT INTO HtmlLabelIndex values(19535,'��������') 
/
INSERT INTO HtmlLabelIndex values(19539,'�ĵ�����ҳ�ֶ�') 
/
INSERT INTO HtmlLabelIndex values(19537,'�ĵ�ʧЧ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19535,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19535,'Approve Type',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19536,'�ĵ���Ч����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19536,'Document Validity Approve',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19537,'�ĵ�ʧЧ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19537,'Document Invalidity Approve',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19538,'�ֶι�����ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19538,'Field Association Evaluate',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19539,'�ĵ�����ҳ�ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19539,'Document Properties Field',8) 
/

INSERT INTO HtmlLabelIndex values(19540,'��������������') 
/
INSERT INTO HtmlLabelInfo VALUES(19540,'��������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19540,'Open Approve Workflow',8) 
/

INSERT INTO HtmlLabelIndex values(19546,'����ѡ���������̣�') 
/
INSERT INTO HtmlLabelInfo VALUES(19546,'����ѡ���������̣�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19546,'Please choose the approve workflow first!',8) 
/

INSERT INTO HtmlLabelIndex values(19561,'��Ϊ') 
/
INSERT INTO HtmlLabelInfo VALUES(19561,'��Ϊ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19561,'Set as',8) 
/

INSERT INTO HtmlLabelIndex values(19562,'��ǰ�ֶ�û���������ԣ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19562,'��ǰ�ֶ�û���������ԣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19562,'Current field hasn''t other attribute!',8) 
/

INSERT INTO HtmlLabelIndex values(19563,'��Ч/����') 
/
INSERT INTO HtmlLabelIndex values(19564,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(19563,'��Ч/����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19563,'Valid/Normal',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19564,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19564,'Be about to publish',8) 
/


INSERT INTO HtmlLabelIndex values(19615,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(19615,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19615,'Batch Approve',8) 
/

INSERT INTO HtmlLabelIndex values(19686,'���´򿪹鵵') 
/
INSERT INTO HtmlLabelIndex values(19687,'���´�����') 
/
INSERT INTO HtmlLabelIndex values(19688,'ǿ��ǩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19686,'���´򿪹鵵',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19686,'Reopen From Archive',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19687,'���´�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19687,'Reopen From Cancellation',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19688,'ǿ��ǩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19688,'Check In Compellably',8) 
/

INSERT INTO HtmlLabelIndex values(19689,'����ѡ������ļ�¼��') 
/
INSERT INTO HtmlLabelInfo VALUES(19689,'����ѡ������ļ�¼��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19689,'Please choose the operated record first!',8) 
/


INSERT INTO HtmlLabelIndex values(19690,'ǩ����') 
/
INSERT INTO HtmlLabelIndex values(19693,'ǩ��') 
/
INSERT INTO HtmlLabelIndex values(19692,'ǩ��') 
/
INSERT INTO HtmlLabelIndex values(19691,'ǩ��ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19690,'ǩ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19690,'Check Out Person',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19691,'ǩ��ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19691,'Check Out Time',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19692,'ǩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19692,'Check Out',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19693,'ǩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19693,'Check In',8) 
/

INSERT INTO HtmlLabelIndex values(19695,'�ĵ��ѱ�ǩ�������ܱ༭��') 
/
INSERT INTO HtmlLabelInfo VALUES(19695,'�ĵ��ѱ�ǩ�������ܱ༭��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19695,'The document has been checked out,couldn''t been edited!',8) 
/

ALTER TABLE DocSecCategory ADD  isOpenApproveWf char(1) null
/

ALTER TABLE DocSecCategory ADD  validityApproveWf integer null
/

ALTER TABLE DocSecCategory ADD  invalidityApproveWf integer null
/

ALTER TABLE DocDetail ADD  checkOutStatus char(1) null
/

ALTER TABLE DocDetail ADD  checkOutUserId integer null
/

ALTER TABLE DocDetail ADD  checkOutUserType char(1) null
/

ALTER TABLE DocDetail ADD  checkOutDate char(10) null
/
ALTER TABLE DocDetail ADD  checkOutTime char(8) null
/




CREATE TABLE DocSecCategoryApproveWfDetail (
	id integer  NOT NULL ,
	secCategoryId integer NULL ,
	approveType  char(1) NULL ,  
	workflowId  integer NULL , 
    workflowFieldId integer   NULL,
    docPropertyFieldId integer   NULL
)
/

create sequence DocSecApproveWfDetail_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSecCategoryApproveWD_Tri
before insert on DocSecCategoryApproveWfDetail
for each row
begin
select DocSecApproveWfDetail_Id.nextval into :new.id from dual;
end;
/




CREATE TABLE DocApproveWf (
	id integer  NOT NULL ,
	docId integer NULL ,
	approveType  char(1) NULL ,  
	requestId  integer NULL,
    status char(1)  NULL
)
/

create sequence DocApproveWf_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocApproveWf_TRI
before insert on DocApproveWf
for each row
begin
select DocApproveWf_Id.nextval into :new.id from dual;
end;
/
INSERT INTO HtmlLabelIndex values(19174,'Ȩ�޹���') 
/
INSERT INTO HtmlLabelInfo VALUES(19174,'Ȩ�޹���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19174,'Rights Manager',8) 
/