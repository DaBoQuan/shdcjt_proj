alter table workflow_bill add hasFileUp char(1)
GO
/*ִ�����Ͻű��⣬������Ŀ����ִ�����½ű�*/
update workflow_bill set hasFileUp='1' where id>=121 and id<=143
GO