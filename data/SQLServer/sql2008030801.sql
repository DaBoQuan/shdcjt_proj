delete from HtmlLabelIndex where id=21274 
GO
delete from HtmlLabelInfo where indexid=21274 
GO
INSERT INTO HtmlLabelIndex values(21274,'Э����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(21274,'Э����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21274,'Accessory Setting Of Cowork',8) 
GO

insert into SystemRights (id,rightdesc,righttype) values (772,'Э������ά��','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (772,7,'Э������ά��','Э������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (772,8,'Accessory Maintenance Of CoWork','Accessory Maintenance Of CoWork') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4281,'Э������ά��','CoWorkAccessory:Maintenance',772) 
GO
