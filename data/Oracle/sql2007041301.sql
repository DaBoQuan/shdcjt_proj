delete from HtmlLabelIndex where id in(20291,20292,20293,20294,20295,20296,20297,20298)
/
delete from HtmlLabelInfo where indexId in(20291,20292,20293,20294,20295,20296,20297,20298)
/
INSERT INTO HtmlLabelIndex values(20294,'��ѡ������ֻ���Ƕ�Ӧ���ݡ�������ת��������Ч���̡�') 
/
INSERT INTO HtmlLabelIndex values(20291,'��ѡ������Ϊ���е���Ч���̡�') 
/
INSERT INTO HtmlLabelIndex values(20296,'������һ���ڵ������ִ�С���׼���������ĵ�״̬��Ϊ����������ִ�С��˻ء��������ĵ�״̬��Ϊ���˻ء���') 
/
INSERT INTO HtmlLabelIndex values(20297,'�������̱����б�����ʽΪ�������ť - �ĵ����������ť - ���ĵ������ֶΡ�') 
/
INSERT INTO HtmlLabelIndex values(20298,'����Ҫ��һ��������ʽΪ�������ť - �ĵ����������ť - ���ĵ����������ֶζ�Ӧ�ĵ�����ҳ�ֶΡ��ĵ����⡱��') 
/
INSERT INTO HtmlLabelIndex values(20292,'�½���༭����Ŀ¼�µ��ĵ�ʱ�����ĵ���Ч�������̣�ʧЧ����Ŀ¼�µ��ĵ�ʱ�����ĵ�ʧЧ�������̡�') 
/
INSERT INTO HtmlLabelIndex values(20293,'�ĵ���״̬�ı��ɳ��ڸ��ӹ��������') 
/
INSERT INTO HtmlLabelIndex values(20295,'ֻ�����½���༭����Ŀ¼�µ��ĵ�ʱ�Ŵ��������̡�') 
/
INSERT INTO HtmlLabelInfo VALUES(20291,'��ѡ������Ϊ���е���Ч���̡�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20291,'All of valid workflows could be approval workflows.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20292,'�½���༭����Ŀ¼�µ��ĵ�ʱ�����ĵ���Ч�������̣�ʧЧ����Ŀ¼�µ��ĵ�ʱ�����ĵ�ʧЧ�������̡�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20292,'The validity approval workflow will be triggered when create or edit a document in this SecCategory;the invalidity Approval workflow will be triggered when invalid a document in this SecCategory.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20293,'�ĵ���״̬�ı��ɳ��ڸ��ӹ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20293,'The change of document status depends on the additional rule of exit.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20294,'��ѡ������ֻ���Ƕ�Ӧ���ݡ�������ת��������Ч���̡�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20294,'Only valid workflows that related to approvement move bill could be Confirmation Workflow.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20295,'ֻ�����½���༭����Ŀ¼�µ��ĵ�ʱ�Ŵ��������̡�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20295,'The validity confirmation workflow will be triggered when create or edit a document in this SecCategory.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20296,'������һ���ڵ������ִ�С���׼���������ĵ�״̬��Ϊ����������ִ�С��˻ء��������ĵ�״̬��Ϊ���˻ء���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20296,'The status of document will be ��normal�� after the next operator of workflow confirm the workflow;the status of document will be ��reject�� after the next operator of workflow reject the workflow.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20297,'�������̱����б�����ʽΪ�������ť - �ĵ����������ť - ���ĵ������ֶΡ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20297,'The Approve Workflow must has the field of the show type is ''BrowserButton - Document'' or ''BrowserButton - Multi-Document''.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20298,'����Ҫ��һ��������ʽΪ�������ť - �ĵ����������ť - ���ĵ����������ֶζ�Ӧ�ĵ�����ҳ�ֶΡ��ĵ����⡱��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20298,'It must has one workflow field of the show type is ''BrowserButton - Document'' or ''BrowserButton - Multi-Document''.The field is related to the Document Properties Field ''Document Title''.',8) 
/
