INSERT INTO HtmlLabelIndex values(18880,'ǩ������ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18880,'ǩ������ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18880,'Opinion Field',8) 
/

INSERT INTO HtmlLabelIndex values(18882,'��ǩ(Ӣ��)') 
/
INSERT INTO HtmlLabelInfo VALUES(18882,'��ǩ(Ӣ��)',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18882,'Label_EN',8) 
/
INSERT INTO HtmlLabelIndex values(18881,'��ǩ(����)') 
/
INSERT INTO HtmlLabelInfo VALUES(18881,'��ǩ(����)',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18881,'Label_CN',8) 
/

INSERT INTO HtmlLabelIndex values(18887,'�ڵ���ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18887,'�ڵ���ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18887,'node form field',8) 
/

INSERT INTO HtmlLabelIndex values(18888,'�ڵ�ǩ������ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18888,'�ڵ�ǩ������ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18888,'Node Opinion Field',8) 
/


INSERT INTO HtmlLabelIndex values(18895,'ǩ������ֶ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(18895,'ǩ������ֶ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18895,'Opinion Field Name',8) 
/

INSERT INTO HtmlLabelIndex values(18896,'�Ƿ��ʹ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18896,'�Ƿ��ʹ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18896,'isUse',8) 
/

INSERT INTO HtmlLabelIndex values(18897,'�Ƿ���鿴Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18897,'�Ƿ���鿴Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18897,'isView',8) 
/

INSERT INTO HtmlLabelIndex values(18898,'�Ƿ���༭Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18898,'�Ƿ���༭Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18898,'isEdit',8) 
/

insert into SequenceIndex (indexdesc,currentid) values ('wfopinionfieldid',0)
/

CREATE TABLE WFOpinionField
(
	id integer not null,
	workflowid integer not null,
	label_cn varchar2(40) null,
	label_en varchar2(40) null,
	type_cn integer null,
	orderid integer null
)
/

CREATE TABLE WFOpinionNodeField
(
	workflowid integer not null,
	nodeid integer null,
	isUse integer null,
	isMust integer null,
	isView integer null,
	isEdit integer null,
	fieldid integer null
)
/