/*ԭ������־û��������/�ⲿ�û��������������type�ֶ�:���������͡����������͡�BUG 380 ,Created BY wangjingyong*/
alter table DocDetailLog add usertype char(1)
go
alter table DocDetailLog add creatertype char(1)
go
UPDATE DocDetailLog SET usertype = '1', creatertype = '1'
GO
