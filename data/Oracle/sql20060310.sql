alter table workflow_base add istemplate char(1)
/
alter table workflow_base add templateid integer
/ 
INSERT INTO HtmlLabelIndex values(18167,'ģ��ѡ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18167,'ģ��ѡ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18167,'TemplateSelect',8) 
/
INSERT INTO HtmlLabelIndex values(18334,'����ģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18334,'����ģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18334,'Workflow Template',8) 
/
INSERT INTO HtmlLabelIndex values(18369,'���ֶι���') 
/
INSERT INTO HtmlLabelIndex values(18368,'���ֶι���') 
/
INSERT INTO HtmlLabelInfo VALUES(18368,'���ֶι���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18368,'Row Field Rule',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18369,'���ֶι���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18369,'Col Field Rule',8) 
/
INSERT INTO HtmlLabelIndex values(18411,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(18411,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18411,'Form Type',8) 
/
delete from HtmlLabelIndex where id=18412
/
delete from HtmlLabelinfo where indexid=18412
/
INSERT INTO HtmlLabelIndex values(18412,'��ϲ�ѯ') 
/
INSERT INTO HtmlLabelIndex values(18413,'����������') 
/
INSERT INTO HtmlLabelInfo VALUES(18412,'��ϲ�ѯ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18412,'Condition Search',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18413,'����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18413,'WorkFlow Type',8) 
/
INSERT INTO HtmlLabelIndex values(18418,'��Ϊģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18418,'��Ϊģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18418,'Save Template',8) 
/
call MMConfig_U_ByInfoInsert (4,8)
/
call MMInfo_Insert (460,18334,'����ģ��','/workflow/workflow/managewf_frm.jsp?isTemplate=1','mainFrame',4,1,8,0,'',0,'',0,'','',0,'','',3)
/
delete from MainMenuInfo where id=121
/
delete FROM MainMenuConfig WHERE infoId = 121
/