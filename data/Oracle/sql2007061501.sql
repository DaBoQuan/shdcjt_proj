delete from HtmlLabelIndex where id in (20494,20495,20496)
/
delete from HtmlLabelInfo where indexid in (20494,20495,20496)
/

INSERT INTO HtmlLabelIndex values(20494,'���½���') 
/
INSERT INTO HtmlLabelIndex values(20495,'���ڽ����ʼ������Ժ�...') 
/
INSERT INTO HtmlLabelInfo VALUES(20494,'���½���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20494,'Re-Parse',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20495,'���ڽ����ʼ������Ժ�...',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20495,'Parsing, Please wait...',8) 
/
INSERT INTO HtmlLabelIndex values(20496,'ȷ�����½����ʼ���') 
/
INSERT INTO HtmlLabelInfo VALUES(20496,'ȷ�����½����ʼ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20496,'Do you confirm re-parse the mail?',8) 
/
