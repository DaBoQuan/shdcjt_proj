delete from HtmlLabelIndex where id in(20272,20273)
/
delete from HtmlLabelInfo where indexId in(20272,20273)
/
INSERT INTO HtmlLabelIndex values(20272,'������ͻ����ƣ�ϵͳ�������Ƿ��������ͻ���') 
/
INSERT INTO HtmlLabelIndex values(20273,'�������������ƿͻ����ڣ�ϵͳ���������ѣ�����ֱ�ӽ����½��ͻ���Ƭҳ�档') 
/
INSERT INTO HtmlLabelInfo VALUES(20272,'������ͻ����ƣ�ϵͳ�������Ƿ��������ͻ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20272,'Please input customer name,system will search whether has repeated customer name.',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20273,'�������������ƿͻ����ڣ�ϵͳ���������ѣ�����ֱ�ӽ����½��ͻ���Ƭҳ�档',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20273,'If it has similar customer name,system will remind,otherwise it direct turn to new customer card page.',8) 
/