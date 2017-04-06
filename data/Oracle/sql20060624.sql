INSERT INTO HtmlLabelIndex values(19334,'���ı�') 
/
INSERT INTO HtmlLabelIndex values(19335,'ά������') 
/
INSERT INTO HtmlLabelInfo VALUES(19334,'���ı�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19334,'Document Form',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19335,'ά������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19335,'Edit Document',8) 
/

CREATE TABLE workflow_docshow (
	flowId integer NULL ,
	selectItemId integer NULL ,
	secCategoryID  varchar2(500) NULL,
	modulId integer NULL ,
    fieldId integer NULL
)
/

CREATE TABLE workflow_createdoc (
	id integer  NOT NULL ,
	workflowId integer NULL ,
	status char(1) NULL ,
	flowCodeField integer NULL ,
	flowDocField integer NULL ,
	flowDocCatField integer NULL ,
    defaultView  varchar2(500) NULL
)
/
create sequence workflow_createdoc_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger workflow_createdoc_Trigger
before insert on workflow_createdoc
for each row
begin
select workflow_createdoc_Id.nextval into :new.id from dual;
end;
/




INSERT INTO HtmlLabelIndex values(19331,'���̴����ĵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19331,'���̴����ĵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19331,'Create Document through WorkFlow',8) 
/

INSERT INTO HtmlLabelIndex values(19332,'�߼�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19332,'�߼�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19332,'Advanced Config',8) 
/

INSERT INTO HtmlLabelIndex values(19337,'�ĵ���������') 
/
INSERT INTO HtmlLabelInfo VALUES(19337,'�ĵ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19337,'Document Basic Attribute',8) 
/

INSERT INTO HtmlLabelIndex values(19338,'���̱����ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19338,'���̱����ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19338,'Work Flow Coding Field',8) 
/

INSERT INTO HtmlLabelIndex values(19339,'�����ĵ��ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19339,'�����ĵ��ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19339,'Create Document Field',8) 
/

INSERT INTO HtmlLabelIndex values(19340,'Ĭ����ʾ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19340,'Ĭ����ʾ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19340,'Default Display Attribute',8) 
/

INSERT INTO HtmlLabelIndex values(19341,'ѡ����ʾ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19341,'ѡ����ʾ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19341,'Choose Display Attribute',8) 
/

INSERT INTO HtmlLabelIndex values(19342,'��ϸ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19342,'��ϸ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19342,'Particular Config',8) 
/

INSERT INTO HtmlLabelIndex values(19360,'����Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19360,'����Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19360,'Associate Calatog',8) 
/

INSERT INTO HtmlLabelIndex values(19367,'�����ĵ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19367,'�����ĵ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19367,'Create Document Attribute',8) 
/

INSERT INTO HtmlLabelIndex values(19368,'�ĵ�����Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19368,'�ĵ�����Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19368,'Document Catalog',8) 
/

INSERT INTO HtmlLabelIndex values(19369,'�ĵ���ʾģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19369,'�ĵ���ʾģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19369,'Document Display Template',8) 
/

INSERT INTO HtmlLabelIndex values(19370,'�ĵ���������') 
/
INSERT INTO HtmlLabelInfo VALUES(19370,'�ĵ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19370,'Document Parameter Config',8) 
/

INSERT INTO HtmlLabelIndex values(19371,'��ʾģ���ǩ') 
/
INSERT INTO HtmlLabelInfo VALUES(19371,'��ʾģ���ǩ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19371,'Display Template Label',8) 
/

INSERT INTO HtmlLabelIndex values(19372,'�����ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19372,'�����ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19372,'Work Flow Field',8) 
/

INSERT INTO HtmlLabelIndex values(19373,'Ŀ¼δѡ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19373,'Ŀ¼δѡ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19373,'No Choosing Folder',8) 
/
