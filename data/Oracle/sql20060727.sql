INSERT INTO HtmlLabelIndex values(19414,'ϵͳ��֧��10�����ϵ���״�ֶΣ�') 
/
INSERT INTO HtmlLabelIndex values(19410,'��״�ֶ�����') 
/
INSERT INTO HtmlLabelIndex values(19412,'�½��¼��ڵ�') 
/
INSERT INTO HtmlLabelIndex values(19411,'�ϼ��ڵ�') 
/
INSERT INTO HtmlLabelIndex values(19413,'�½�ͬ���ڵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19410,'��״�ֶ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19410,'Tree Field Setting',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19411,'�ϼ��ڵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19411,'Superior Node',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19412,'�½��¼��ڵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19412,'New Sub Node',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19413,'�½�ͬ���ڵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19413,'New Peer Node',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19414,'ϵͳ��֧��10�����ϵ���״�ֶΣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19414,'The system doesn''t support 10 level of tree field!',8) 
/

INSERT INTO HtmlLabelIndex values(19441,'��ǰ�ֶ����¼��ڵ㣬����ɾ����') 
/
INSERT INTO HtmlLabelIndex values(19442,'ͬ���ֶ����Ʋ����ظ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19441,'��ǰ�ֶ����¼��ڵ㣬����ɾ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19441,'Current field has subnode,can''t be deleted.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19442,'ͬ���ֶ����Ʋ����ظ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19442,'The names of peer fields can''t be repeated.',8) 
/




CREATE TABLE DocTreeDocField (
	id integer  NOT NULL ,
	treeDocFieldName varchar2 (80) NULL ,
	superiorFieldId   integer NULL,
	allSuperiorFieldId  varchar2 (80) NULL ,
    fieldLevel   integer NULL,
    isLast  char    (1) NULL,
    showOrder   number(6, 2) NULL 
)
/
create sequence DocTreeDocField_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocTreeDocField_Trigger
before insert on DocTreeDocField
for each row
begin
select DocTreeDocField_Id.nextval into :new.id from dual;
end;
/



insert into  DocTreeDocField(treeDocFieldName,superiorFieldId,allSuperiorFieldId,fieldlevel,isLast,showOrder) values('root',0,'',0,1,0.00)
/


call MMConfig_U_ByInfoInsert (2,16)
/
call MMInfo_Insert (516,19410,'','/docs/category/DocTreeDocFieldFrame.jsp','mainFrame',2,1,16,0,'',0,'',0,'','',0,'','',1)
/

INSERT INTO HtmlLabelIndex values(19485,'��״�ĵ��ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19485,'��״�ĵ��ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19485,'Tree Document Field',8) 
/

INSERT INTO HtmlLabelIndex values(19490,'��״�ֶ���ʾ') 
/
INSERT INTO HtmlLabelInfo VALUES(19490,'��״�ֶ���ʾ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19490,'View by Tree Field',8) 
/

INSERT INTO HtmlLabelIndex values(19500,'��ϵ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19500,'��ϵ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19500,'System Type',8) 
/

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 143,19485,'varchar2(400)','/systeminfo/BrowserMain.jsp?url=/docs/category/DocTreeDocFieldBrowserMulti.jsp','DocTreeDocField','treeDocFieldName','id','/docs/category/DocTreeDocFieldDsp.jsp?id=')
/

ALTER TABLE DocSearchMould ADD  treeDocFieldId integer
/
