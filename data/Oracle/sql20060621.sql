INSERT INTO HtmlLabelIndex values(19314,'�ʲ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19314,'�ʲ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19314,'capital auto loading',8) 
/
INSERT INTO HtmlLabelIndex values(19316,'���������ڴ����ʲ����룬���Ե�...') 
/
INSERT INTO HtmlLabelIndex values(19317,'�ʲ�����ɹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19316,'���������ڴ����ʲ����룬���Ե�...',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19316,'capital loading,please wait...',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19317,'�ʲ�����ɹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19317,'capital load success!',8) 
/
INSERT INTO HtmlLabelIndex values(19320,'�ʲ����ϵ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19320,'�ʲ����ϵ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19320,'capital type load',8) 
/
INSERT INTO HtmlLabelIndex values(19322,'�ʲ����ϱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19322,'�ʲ����ϱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19322,'capital type no',8) 
/
INSERT INTO HtmlLabelIndex values(19326,'�ʲ����ϵ���ɹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19326,'�ʲ����ϵ���ɹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19326,'capital type load success!',8) 
/

INSERT INTO HtmlLabelIndex values(19364,'���������ڴ����ʲ����ϵ��룬���Ե�...') 
/
INSERT INTO HtmlLabelInfo VALUES(19364,'���������ڴ����ʲ����ϵ��룬���Ե�...',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19364,'capital type loading,please wait...',8) 
/

INSERT INTO HtmlLabelIndex values(17342,'��ⵥ��') 
/
INSERT INTO HtmlLabelInfo VALUES(17342,'��ⵥ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17342,'',8) 
/


call MMConfig_U_ByInfoInsert (8,4)
/
call MMInfo_Insert (511,19320,'�ʲ����ϵ���','/cpt/capital/CapitalExcelToDB.jsp','mainFrame',8,1,4,0,'',1,'Capital:Maintenance',0,'','',0,'','',7)
/

ALTER TABLE cptcapital rename column capitalnum to capitalnumtemp
/
ALTER TABLE cptcapital add capitalnum number(18,1)
/
update  cptcapital set capitalnum = capitalnumtemp
/
ALTER TABLE cptcapital drop column capitalnumtemp
/


