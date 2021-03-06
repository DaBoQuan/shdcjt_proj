delete from HtmlLabelIndex where id=20064 
GO
delete from HtmlLabelInfo where indexid=20064 
GO
INSERT INTO HtmlLabelIndex values(20064,'出差单据') 
GO
INSERT INTO HtmlLabelInfo VALUES(20064,'出差单据',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20064,'Evection Bill',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20064,'出差單據',9) 
GO

delete from HtmlLabelIndex where id=20065 
GO
delete from HtmlLabelInfo where indexid=20065 
GO
INSERT INTO HtmlLabelIndex values(20065,'公出单据') 
GO
INSERT INTO HtmlLabelInfo VALUES(20065,'公出单据',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20065,'Out Bill',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20065,'公出單據',9) 
GO

delete from HtmlLabelIndex where id in(20241,20242)
GO
delete from HtmlLabelInfo where indexId in(20241,20242)
GO
INSERT INTO HtmlLabelIndex values(20241,'签到明细') 
GO
INSERT INTO HtmlLabelIndex values(20242,'签退明细') 
GO
INSERT INTO HtmlLabelInfo VALUES(20241,'签到明细',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20241,'Sign In Detail',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20242,'签退明细',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20242,'Sign Out Detail',8) 
GO

delete from SystemRightToGroup where rightid=692
GO
delete from SystemRightDetail where rightid=692
GO
delete from SystemRightsLanguage where id=692
GO
delete from SystemRights where id=692
GO


insert into SystemRights (id,rightdesc,righttype) values (692,'考勤报表查看权限','3') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (692,8,'Schedule Report View Right','Schedule Report View Right') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (692,7,'考勤报表查看权限','考勤报表查看权限') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4200,'考勤报表查看权限','BohaiInsuranceScheduleReport:View',692) 
GO
insert into SystemRightToGroup (groupid, rightid) values (3,692)
GO
