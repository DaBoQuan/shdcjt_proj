delete from HtmlLabelIndex where id in(15142,6083,614,6146,15236,1970,20782,20783)
GO
delete from HtmlLabelInfo where indexid in(15142,6083,614,6146,15236,1970,20782,20783)
GO

INSERT INTO HtmlLabelIndex values(15142,'��ͬ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(15142,'��ͬ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(15142,'Contract Name',8) 
GO
 
INSERT INTO HtmlLabelIndex values(6083,'��ͬ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(6083,'��ͬ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(6083,'Contract Character',8) 
GO

INSERT INTO HtmlLabelIndex values(614,'��ͬ') 
GO
INSERT INTO HtmlLabelInfo VALUES(614,'Contract',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(614,'��ͬ',7) 
GO
 
INSERT INTO HtmlLabelIndex values(6146,'��ͬ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(6146,'��ͬ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(6146,'Contract Sum',8) 
GO

INSERT INTO HtmlLabelIndex values(15236,'��ͬ��������') 
GO
INSERT INTO HtmlLabelIndex values(1970,'��ͬ��ʼ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(1970,'Contract start time',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(1970,'��ͬ��ʼ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(15236,'��ͬ��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(15236,'Contract end date',8) 
GO



INSERT INTO HtmlLabelIndex values(20782,'��Ʒʹ�õ�λ') 
GO
INSERT INTO HtmlLabelInfo VALUES(20782,'��Ʒʹ�õ�λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20782,'using unit of product',8) 
GO

INSERT INTO HtmlLabelIndex values(20783,'�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20783,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20783,'other money',8) 
GO

delete from HtmlLabelIndex where id in(20796,16501,1936)
GO
delete from HtmlLabelInfo where indexid in(20796,16501,1936)
GO

INSERT INTO HtmlLabelIndex values(20796,'��ͬ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20796,'��ͬ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20796,'Order Accessory',8) 
GO

INSERT INTO HtmlLabelIndex values(16501,'��ͬ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16501,'��ͬ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16501,'Contract Credit',8) 
GO

INSERT INTO HtmlLabelIndex values(1936,'��ͬ��ʼʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(1936,'��ͬ��ʼʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(1936,'Contract Start Time',8) 
GO