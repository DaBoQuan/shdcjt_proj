insert into SystemRights (id,rightdesc,righttype) values (405,'���ķ��Ĺ���','1')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (405,7,'���ķ��Ĺ���','���ķ��Ĺ���')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (405,8,'','')
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3094,'���ķ��Ĺ���','SendDoc:Manage',405)
/
insert into SystemRightToGroup(groupid,rightid) values(2,405)
/
INSERT INTO HtmlLabelIndex values(16971,'�����ֺ�')
/
INSERT INTO HtmlLabelInfo VALUES(16971,'�����ֺ�',7)
/
INSERT INTO HtmlLabelInfo VALUES(16971,'',8)
/
INSERT INTO HtmlLabelIndex values(16972,'���ܵȼ�')
/
INSERT INTO HtmlLabelInfo VALUES(16972,'���ܵȼ�',7)
/
INSERT INTO HtmlLabelInfo VALUES(16972,'',8)
/
INSERT INTO HtmlLabelIndex values(16973,'��������')
/
INSERT INTO HtmlLabelInfo VALUES(16973,'��������',7)
/
INSERT INTO HtmlLabelInfo VALUES(16973,'',8)
/
INSERT INTO HtmlLabelIndex values(16974,'�շ�����ת��')
/
INSERT INTO HtmlLabelInfo VALUES(16974,'�շ�����ת��',7)
/
INSERT INTO HtmlLabelIndex values(16975,'������')
/
INSERT INTO HtmlLabelInfo VALUES(16975,'������',7)
/
INSERT INTO HtmlLabelIndex values(16976,'���Ͳ���')
/
INSERT INTO HtmlLabelInfo VALUES(16976,'���Ͳ���',7)
/
INSERT INTO HtmlLabelIndex values(16977,'ӡ������')
/
INSERT INTO HtmlLabelInfo VALUES(16977,'ӡ������',7)
/
INSERT INTO HtmlLabelIndex values(16978,'�����')
/
INSERT INTO HtmlLabelInfo VALUES(16978,'�����',7)
/
INSERT INTO HtmlLabelIndex values(16980,'�����ֺ�')
/
INSERT INTO HtmlLabelInfo VALUES(16980,'�����ֺ�',7)
/
INSERT INTO HtmlLabelInfo VALUES(16980,'',8)
/
INSERT INTO HtmlLabelIndex values(16981,'����')
/
INSERT INTO HtmlLabelInfo VALUES(16981,'����',7)
/
INSERT INTO HtmlLabelIndex values(16982,'�ں�')
/
INSERT INTO HtmlLabelInfo VALUES(16982,'�ں�',7)
/
INSERT INTO HtmlLabelIndex values(16983,'��������')
/
INSERT INTO HtmlLabelInfo VALUES(16983,'��������',7)
/
INSERT INTO HtmlLabelIndex values(16984,'ӡ������')
/
INSERT INTO HtmlLabelInfo VALUES(16984,'ӡ������',7)
/
INSERT INTO HtmlLabelIndex values(16985,'���ͻ���')
/
INSERT INTO HtmlLabelInfo VALUES(16985,'���ͻ���',7)
/
INSERT INTO HtmlLabelIndex values(16986,'��������')
/
INSERT INTO HtmlLabelInfo VALUES(16986,'��������',7)
/
INSERT INTO HtmlLabelIndex values(16987,'���ͻ���')
/
INSERT INTO HtmlLabelInfo VALUES(16987,'���ͻ���',7)
/
INSERT INTO HtmlLabelIndex values(16988,'ӡ������')
/
INSERT INTO HtmlLabelInfo VALUES(16988,'ӡ������',7)
/
INSERT INTO HtmlLabelIndex values(16989,'ϵͳ��ַ')
/
INSERT INTO HtmlLabelInfo VALUES(16989,'ϵͳ��ַ',7)
/
INSERT INTO HtmlLabelInfo VALUES(16989,'',8)
/
INSERT INTO HtmlLabelIndex values(16990,'���ķ���')
/
INSERT INTO HtmlLabelInfo VALUES(16990,'���ķ���',7)
/
INSERT INTO HtmlLabelInfo VALUES(16990,'',8)
/
INSERT INTO HtmlLabelIndex values(16991,'���Ĵ���')
/
INSERT INTO HtmlLabelInfo VALUES(16991,'���Ĵ���',7)
/
INSERT INTO HtmlLabelInfo VALUES(16991,'',8)
/
INSERT INTO HtmlLabelIndex values(16992,'��')
/
INSERT INTO HtmlLabelInfo VALUES(16992,'��',7)
/
INSERT INTO HtmlLabelInfo VALUES(16992,'',8)
/
INSERT INTO HtmlLabelIndex values(16993,'�����ֺ�')
/
INSERT INTO HtmlLabelInfo VALUES(16993,'�����ֺ�',7)
/
INSERT INTO HtmlLabelInfo VALUES(16993,'',8)
/
INSERT INTO HtmlLabelIndex values(16994,'���Ļ���')
/
INSERT INTO HtmlLabelInfo VALUES(16994,'���Ļ���',7)
/
INSERT INTO HtmlLabelInfo VALUES(16994,'',8)
/
INSERT INTO HtmlLabelIndex values(16995,'ǩ����')
/
INSERT INTO HtmlLabelInfo VALUES(16995,'ǩ����',7)
/
INSERT INTO HtmlLabelInfo VALUES(16995,'',8)
/
INSERT INTO HtmlLabelIndex values(16996,'ǩ������')
/
INSERT INTO HtmlLabelInfo VALUES(16996,'ǩ������',7)
/
INSERT INTO HtmlLabelInfo VALUES(16996,'',8)
/
INSERT INTO HtmlLabelIndex values(16997,'Ĭ����Ϣ')
/
INSERT INTO HtmlLabelInfo VALUES(16997,'Ĭ����Ϣ',7)
/
INSERT INTO HtmlLabelInfo VALUES(16997,'',8)
/
INSERT INTO HtmlLabelIndex values(16998,'�ݴ�Ŀ¼')
/
INSERT INTO HtmlLabelInfo VALUES(16998,'',8)
/
INSERT INTO HtmlLabelInfo VALUES(16998,'�ݴ�Ŀ¼',7)
/
INSERT INTO HtmlLabelIndex values(16999,'������Ϣ')
/
INSERT INTO HtmlLabelInfo VALUES(16999,'������Ϣ',7)
/
INSERT INTO HtmlLabelInfo VALUES(16999,'',8)
/

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 52,16973,'integer','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docKindBrowser.jsp','DocSendDocKind','name','id','')
/
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 53,15534,'integer','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docInstancyLevelBrowser.jsp','DocInstancyLevel','name','id','')
/
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 54,16972,'integer','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docSecretLevelBrowser.jsp','docSecretLevel','name','id','')
/
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 55,16980,'integer','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/docNumberBrowser.jsp','DocSendDocNumber','name','id','')
/
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 56,16989,'varchar2(100)','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/systemIpBrowser.jsp','systemIp','name','id','/docs/sendDoc/systemIp.jsp?id=')
/

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(66,16974,'bill_SendDoc','BillSendDocAdd.jsp','BillSendDocManage.jsp','BillSendDocView.jsp','','','')
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'resourceId',16975,'integer',3,1,1,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'departmentId',16976,'integer',3,4,2,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docIds',857,'varchar2(100)',3,37,3,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'pieces',16977,'integer',1,2,4,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'subjectWord',16978,'varchar2(300)',1,1,5,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docKind',16973,'integer',3,52,6,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docInstancyLevel',15534,'integer',3,53,7,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docSecretLevel',16972,'integer',3,54,8,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docNumber',16980,'integer',3,55,9,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docNumberYear',16981,'integer',1,2,10,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'docNumberIssue',16982,'integer',1,2,11,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'finishDate',16983,'char(10)',3,2,12,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'sendDate',16984,'char(10)',3,2,13,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'phone',421,'varchar2(100)',1,1,14,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_1',16985,'varchar2(1000)',1,1,15,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_2',16986,'varchar2(1000)',1,1,16,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_3',16987,'varchar2(1000)',1,1,17,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'department_4',16988,'varchar2(1000)',1,1,18,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'desc_n',85,'varchar2(3000)',2,0,19,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'systemIds',16989,'varchar2(100)',3,56,20,0)
/

CREATE TABLE DocSendDocNumber (
	id integer  NOT NULL ,
	name varchar2 (200) NULL ,
	desc_n varchar2 (300) NULL
)
/
create sequence DocSendDocNumber_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSendDocNumber_Tri
before insert on DocSendDocNumber
for each row
begin
select DocSendDocNumber_id.nextval into :new.id from dual;
end;
/
CREATE TABLE DocInstancyLevel (
	id integer NOT NULL ,
	name varchar2 (200) NULL ,
	desc_n varchar2 (300) NULL
)
/
create sequence DocInstancyLevel_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocInstancyLevel_Tri
before insert on DocInstancyLevel
for each row
begin
select DocInstancyLevel_id.nextval into :new.id from dual;
end;
/
CREATE TABLE DocSecretLevel (
	id integer NOT NULL ,
	name varchar2 (200) NULL ,
	desc_n varchar2 (300) NULL
)
/
create sequence DocSecretLevel_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSecretLevel_Tri
before insert on DocSecretLevel
for each row
begin
select DocSecretLevel_id.nextval into :new.id from dual;
end;
/

CREATE TABLE DocSendDocKind (
	id integer NOT NULL ,
	name varchar2 (200) NULL ,
	desc_n varchar2 (300) NULL
)
/
create sequence DocSendDocKind_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSendDocKind_Tri
before insert on DocSendDocKind
for each row
begin
select DocSendDocKind_id.nextval into :new.id from dual;
end;
/

CREATE TABLE systemIp (
	id integer NOT NULL ,
	name varchar2 (200) NULL ,
	ip varchar2 (50) NULL
)
/
create sequence systemIp_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger systemIp_Tri
before insert on systemIp
for each row
begin
select systemIp_id.nextval into :new.id from dual;
end;
/

CREATE TABLE DocSendDocDefaultValue (
	categoryId integer NULL ,
	createrId integer NULL
)
/
CREATE TABLE bill_SendDoc (
    id integer NOT NULL ,
    requestid integer NULL ,
    subject varchar2 (300) NULL ,
    resourceId integer NULL ,
    departmentId integer NULL ,
    docIds varchar2 (100) NULL ,
    pieces integer NULL ,
    subjectWord varchar2 (300) NULL ,
    docKind integer NULL ,
    docInstancyLevel integer NULL ,
    docSecretLevel integer NULL ,
    docNumber integer NULL ,
    docNumberYear integer NULL ,
    docNumberIssue integer NULL ,
    finishDate char (10) NULL ,
    sendDate char (10) NULL ,
    phone varchar2 (100) NULL ,
    department_1 varchar2 (1000) NULL ,
    department_2 varchar2 (1000) NULL ,
    department_3 varchar2 (1000) NULL ,
    department_4 varchar2 (1000) NULL ,
    desc_n varchar2 (3000) NULL ,
    systemIds varchar2 (100) NULL
)
/
create sequence bill_SendDoc_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger bill_SendDoc_Tri
before insert on bill_SendDoc
for each row
begin
select bill_SendDoc_id.nextval into :new.id from dual;
end;
/


CREATE TABLE DocSendDocDetail (
    id integer NOT NULL ,
    subject varchar2 (300) NULL ,
    docIds varchar2 (100) NULL ,
    docKind varchar2 (200) NULL ,
    docInstancyLevel varchar2 (200) NULL ,
    docSecretLevel varchar2 (200) NULL ,
    docNumber_1 varchar2 (200) NULL ,
    docNumberYear_1 char (5) NULL ,
    docNumberIssue_1 char (5) NULL ,
    docNumber_2 varchar2 (200) NULL ,
    docNumberYear_2 char (5) NULL ,
    docNumberIssue_2 char (5) NULL ,
    sendDate char (10) NULL ,
    sendDepartment varchar2 (100) NULL ,
    department_1 varchar2 (1000) NULL ,
    department_2 varchar2 (1000) NULL ,
    department_3 varchar2 (1000) NULL ,
    department_4 varchar2 (1000) NULL ,
    signer integer NULL ,
    signDate char (10) NULL  ,
    requestLog Varchar2(4000) NULL  ,
    status  char  NULL ,
    createDate  char (10) NULL
)
/
create sequence DocSendDocDetail_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocSendDocDetail_Tri
before insert on DocSendDocDetail
for each row
begin
select DocSendDocDetail_id.nextval into :new.id from dual;
end;
/