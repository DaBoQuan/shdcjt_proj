delete from HtmlLabelIndex where id=21274 
/
delete from HtmlLabelInfo where indexid=21274 
/
INSERT INTO HtmlLabelIndex values(21274,'Э����������') 
/
INSERT INTO HtmlLabelInfo VALUES(21274,'Э����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21274,'Accessory Setting Of Cowork',8) 
/

insert into SystemRights (id,rightdesc,righttype) values (772,'Э������ά��','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (772,7,'Э������ά��','Э������ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (772,8,'Accessory Maintenance Of CoWork','Accessory Maintenance Of CoWork') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4281,'Э������ά��','CoWorkAccessory:Maintenance',772) 
/
