/*--------Ĭ��ֵΪ -1 , ���°汾�����ݶ���, ���½����̽ڵ�ʱ, -1 ����Ĭ��Ϊ "�ɲ鿴�������̵����нڵ�" --------*/
alter table workflow_flownode add viewnodeids  varchar(1000)  default '-1'
GO

/*--------��Ծɰ汾������, ���������̵Ľڵ�Ĳ鿴��ΧԤ��Ϊ "�ɲ鿴�������̵����нڵ�" --------*/
update workflow_flownode set viewnodeids = '-1'
GO


INSERT INTO HtmlLabelIndex values(17750,'��־�鿴��Χ') 
GO
INSERT INTO HtmlLabelInfo VALUES(17750,'��־�鿴��Χ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17750,'range of workflow log tracing',8) 
GO

