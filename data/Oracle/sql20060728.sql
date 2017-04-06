CREATE TABLE workflow_TitleSet (
	flowId integer  NOT NULL ,
	fieldId   integer NULL)
/



INSERT INTO HtmlLabelIndex values(19501,'�����ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19501,'�����ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19501,'title field',8) 
/

insert into SystemRights (id,rightdesc,righttype) values (662,'�����ֶι���','5') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (662,7,'�����ֶι���','�����ֶι���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (662,8,'MANAGER FIELD OF TITLE','MANAGER FIELD OF TITLE') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4163,'�����ֶι���','WorkFlowTitleSet:ALL',662) 
/


INSERT INTO HtmlLabelIndex values(19502,'���̱��') 
/
INSERT INTO HtmlLabelInfo VALUES(19502,'���̱��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19502,'flow code',8) 
/


insert into SystemRights (id,rightdesc,righttype) values (663,'���̱��','5') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (663,8,'flow code','flow code') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (663,7,'���̱��','���̱��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4164,'���̱��','FLOWCODE:ALL',663) 
/

INSERT INTO HtmlLabelIndex values(19503,'����ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19503,'����ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19503,'field of coding',8) 
/

INSERT INTO HtmlLabelIndex values(19504,'��Ź���') 
/
INSERT INTO HtmlLabelInfo VALUES(19504,'��Ź���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19504,'rule of coding',8) 
/
 

CREATE TABLE workflow_Code (
	formId integer  NOT NULL ,
	flowId integer  NOT NULL ,
	codeFieldId  integer  NULL,
	isUse  char (1) NULL ,
    fieldLevel   integer NULL,
    currentCode  varchar2 (100) NULL)
/



CREATE TABLE workflow_CodeDetail (
	mainId integer  NOT NULL ,
	showId integer  NOT NULL ,
	codeValue  varchar2 (100) NULL,
	codeOrder  integer NULL )
/


CREATE TABLE workflow_codeSet (
	id integer  NOT NULL ,
	showName varchar2 (100) NULL ,
	showType  char (1) NULL)
/




insert into workflow_codeSet values(1,18729,'2')
/
insert into workflow_codeSet values(2,445,'1')
/
insert into workflow_codeSet values(3,6076,'1')
/
insert into workflow_codeSet values(4,18811,'2')
/