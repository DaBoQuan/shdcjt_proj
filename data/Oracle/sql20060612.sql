INSERT INTO HtmlLabelIndex values(19206,'Ĭ��ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(19206,'Ĭ��ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19206,'default value',8) 
/

INSERT INTO HtmlLabelIndex values(19207,'�����ĵ�Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19207,'�����ĵ�Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19207,'Doc Catalog of connection',8) 
/

INSERT INTO HtmlLabelIndex values(19213,'�̶�Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19213,'�̶�Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19213,'root catalog',8) 
/

INSERT INTO HtmlLabelIndex values(19214,'ѡ��Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19214,'ѡ��Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19214,'select catalog',8) 
/

ALTER TABLE workflow_base ADD catelogType integer NULL
/

ALTER TABLE workflow_base ADD selectedCateLog integer NULL
/

ALTER TABLE workflow_SelectItem ADD docPath varchar2(100) NULL
/

ALTER TABLE workflow_SelectItem ADD docCategory varchar2(200) NULL
/

INSERT INTO HtmlLabelIndex values(19255,'��ѡ������') 
/
INSERT INTO HtmlLabelInfo VALUES(19255,'��ѡ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19255,'Chose Condition',8) 
/
delete from HtmlLabelIndex where id=19255
/
delete from HtmlLabelInfo where indexid=19255
/

INSERT INTO HtmlLabelIndex values(19255,'��ѡ������') 
/
INSERT INTO HtmlLabelInfo VALUES(19255,'��ѡ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19255,'Chose Condition',8) 
/

delete from HtmlLabelIndex where id=19303
/
delete from HtmlLabelInfo where indexid=19303
/

INSERT INTO HtmlLabelIndex values(19303,'������Դ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19303,'������Դ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19303,'Resource Condition',8) 
/

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 141,19303,'text','/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceConditionBrowser.jsp','','','','')
/
