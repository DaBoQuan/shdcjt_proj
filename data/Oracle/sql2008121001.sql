delete from HtmlLabelIndex where id=20064 
/
delete from HtmlLabelInfo where indexid=20064 
/
INSERT INTO HtmlLabelIndex values(20064,'�����') 
/
INSERT INTO HtmlLabelInfo VALUES(20064,'�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20064,'Evection Bill',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20064,'����Γ�',9) 
/

delete from HtmlLabelIndex where id=20065 
/
delete from HtmlLabelInfo where indexid=20065 
/
INSERT INTO HtmlLabelIndex values(20065,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(20065,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20065,'Out Bill',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20065,'�����Γ�',9) 
/

delete from HtmlLabelIndex where id in(20241,20242)
/
delete from HtmlLabelInfo where indexId in(20241,20242)
/
INSERT INTO HtmlLabelIndex values(20241,'ǩ����ϸ') 
/
INSERT INTO HtmlLabelIndex values(20242,'ǩ����ϸ') 
/
INSERT INTO HtmlLabelInfo VALUES(20241,'ǩ����ϸ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20241,'Sign In Detail',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20242,'ǩ����ϸ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20242,'Sign Out Detail',8) 
/

delete from SystemRightToGroup where rightid=692
/
delete from SystemRightDetail where rightid=692
/
delete from SystemRightsLanguage where id=692
/
delete from SystemRights where id=692
/


insert into SystemRights (id,rightdesc,righttype) values (692,'���ڱ���鿴Ȩ��','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (692,8,'Schedule Report View Right','Schedule Report View Right') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (692,7,'���ڱ���鿴Ȩ��','���ڱ���鿴Ȩ��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4200,'���ڱ���鿴Ȩ��','BohaiInsuranceScheduleReport:View',692) 
/
insert into SystemRightToGroup (groupid, rightid) values (3,692)
/

