INSERT INTO HtmlLabelIndex values(17996,'���ݹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(17996,'���ݹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17996,'Bill Management',8) 
/

INSERT INTO HtmlLabelIndex values(17997,'�ֶ�λ��') 
/
INSERT INTO HtmlLabelInfo VALUES(17997,'�ֶ�λ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17997,'Field View Type',8) 
/
 

INSERT INTO HtmlLabelIndex values(17998,'����ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(17998,'����ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17998,'Add Field',8) 
/

call MMConfig_U_ByInfoInsert(4,5)
/
call MMInfo_Insert(423,17996,'���ݹ���','/workflow/workflow/BillManagementList.jsp','mainFrame',4,1,5,0,'',0,'',0,'','',0,'','',3)
/



alter table workflow_billfield add  fromUser char(1) default '1'
/

update   workflow_billfield  set  fromUser = '1' 
/
