delete from SystemRights where id=397
go
delete from SystemRightsLanguage where id=397
go
delete from SystemRightDetail where id=3086
go

insert into SystemRights (id,rightdesc,righttype) values (397,'��������ά��','0') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (397,7,'��������ά��','��������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (397,8,'','') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3086,'��������ά��','DataCenter:Maintenance',397) 
GO
 
delete from HtmlLabelIndex where id=16889
go
delete from  HtmlLabelInfo where indexid= 16889
go
INSERT INTO HtmlLabelIndex values(16889,'��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16889,'��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16889,'',8) 
GO

delete from HtmlLabelIndex where id=16890
go
delete from  HtmlLabelInfo where indexid= 16890
go

INSERT INTO HtmlLabelIndex values(16890,'ͳ����ά��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16890,'ͳ����ά��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16890,'',8) 
GO

delete from HtmlLabelIndex where id=16892
go
delete from  HtmlLabelInfo where indexid= 16892
go
delete from HtmlLabelIndex where id=16893
go
delete from  HtmlLabelInfo where indexid= 16893
go
INSERT INTO HtmlLabelIndex values(16892,'����ͳ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16892,'����ͳ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16892,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16893,'ͳ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16893,'ͳ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16893,'',8) 
GO

delete from HtmlLabelIndex where id=16894
go
delete from  HtmlLabelInfo where indexid= 16894
go

INSERT INTO HtmlLabelIndex values(16894,'��ʱ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16894,'��ʱ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16894,'',8) 
GO
 

delete from HtmlLabelIndex where id=16895
go
delete from  HtmlLabelInfo where indexid= 16895
go
delete from HtmlLabelIndex where id=16896
go
delete from  HtmlLabelInfo where indexid= 16896
go
INSERT INTO HtmlLabelIndex values(16895,'������ҵ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16895,'������ҵ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16895,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16896,'ȡǰ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16896,'ȡǰ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16896,'',8) 
GO

delete from HtmlLabelIndex where id in (16901,16902,16903)
go
delete from  HtmlLabelInfo where indexid in (16901,16902,16903)
go
INSERT INTO HtmlLabelIndex values(16901,'ͳ��ͼ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16901,'ͳ��ͼ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16901,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16902,'���㵥λ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16902,'���㵥λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16902,'',8) 
GO


INSERT INTO HtmlLabelIndex values(16903,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16903,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16903,'',8) 
GO

delete from HtmlLabelIndex where id in (17028,17029)
go
delete from  HtmlLabelInfo where indexid in (17028,17029)
go
INSERT INTO HtmlLabelIndex values(17028,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17028,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17028,'last month',8) 
GO
 
INSERT INTO HtmlLabelIndex values(17029,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17029,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17029,'last year',8) 
GO


delete from HtmlLabelIndex where id in (17030,17031,17032)
go
delete from  HtmlLabelInfo where indexid in (17030,17031,17032)
go


INSERT INTO HtmlLabelIndex values(17030,'�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17030,'�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17030,'Input modify',8) 
GO

INSERT INTO HtmlLabelIndex values(17031,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17031,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17031,'Monthly modify',8) 
GO

INSERT INTO HtmlLabelIndex values(17032,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17032,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17032,'Year modify',8) 
GO

delete HtmlLabelIndex where id = 16538 
GO

delete HtmlLabelInfo where indexid = 16538 
GO

INSERT INTO HtmlLabelIndex values(16538,'��ϸ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16538,'��ϸ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16538,'Detail Report',8) 
GO

delete HtmlLabelIndex where id = 17070 
GO

delete HtmlLabelInfo where indexid = 17070 
GO

INSERT INTO HtmlLabelIndex values(17070,'���򱨱�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17070,'���򱨱�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17070,'Ordinal Report',8) 
GO

delete from HtmlLabelIndex where id=17496
go
delete from  HtmlLabelInfo where indexid= 17496
go

INSERT INTO HtmlLabelIndex values(17496,'ģ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17496,'ģ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17496,'Mould Design',8) 
GO
