
delete from  HtmlLabelIndex  where id=20155
GO


delete from  HtmlLabelInfo  where indexid=20155
GO


INSERT INTO HtmlLabelIndex values(20155,'��ʱ��׼����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20155,'��ʱ��׼����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20155,'set Type of G',8) 
GO


insert into SystemRights (id,rightdesc,righttype) values (702,'��ʱ��׼����','3') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (702,7,'��ʱ��׼����','��ʱ��׼����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (702,8,'','') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4210,'��ʱ��׼����','TIMESET',702) 
GO


