delete from HtmlLabelIndex where id=21879 
GO
delete from HtmlLabelInfo where indexid=21879 
GO
INSERT INTO HtmlLabelIndex values(21879,'���õ�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(21879,'���õ�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21879,'The opening of pop-up window',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21879,'���Ï�������',9) 
GO
 
delete from HtmlLabelIndex where id=21880 
GO
delete from HtmlLabelInfo where indexid=21880 
GO
INSERT INTO HtmlLabelIndex values(21880,'�رյ�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(21880,'�رյ�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21880,'Close pop-up window',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21880,'�P�]��������',9) 
GO
delete from HtmlLabelIndex where id=21881 
GO
delete from HtmlLabelInfo where indexid=21881 
GO
INSERT INTO HtmlLabelIndex values(21881,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(21881,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21881,'The number of pop-up',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21881,'�����Δ�',9) 
GO
delete from HtmlLabelIndex where id=21882 
GO
delete from HtmlLabelInfo where indexid=21882 
GO
INSERT INTO HtmlLabelIndex values(21882,'���ڸ߶�') 
GO
INSERT INTO HtmlLabelInfo VALUES(21882,'���ڸ߶�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21882,'A high degree of window',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21882,'���ڸ߶�',9) 
GO
delete from HtmlLabelIndex where id=21884 
GO
delete from HtmlLabelInfo where indexid=21884 
GO
INSERT INTO HtmlLabelIndex values(21884,'���ڿ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(21884,'���ڿ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21884,'Width of the window',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21884,'���ڌ���',9) 
GO

delete from HtmlLabelIndex where id=21885 
GO
delete from HtmlLabelInfo where indexid=21885 
GO
INSERT INTO HtmlLabelIndex values(21885,'�ĵ�������������') 
GO
INSERT INTO HtmlLabelInfo VALUES(21885,'�ĵ�������������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21885,'Pop-up document set',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21885,'�ęn���������O��',9) 
GO
delete from HtmlLabelIndex where id=21886 
GO
delete from HtmlLabelInfo where indexid=21886 
GO
INSERT INTO HtmlLabelIndex values(21886,'���ڵ���״̬') 
GO
INSERT INTO HtmlLabelInfo VALUES(21886,'���ڵ���״̬',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21886,'Pop-up window state',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21886,'���ڏ�����B',9) 
GO
 
delete from HtmlLabelIndex where id=21887 
GO
delete from HtmlLabelInfo where indexid=21887 
GO
INSERT INTO HtmlLabelIndex values(21887,'����״̬') 
GO
INSERT INTO HtmlLabelInfo VALUES(21887,'����״̬',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21887,'Open',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21887,'�_����B',9) 
GO
delete from HtmlLabelIndex where id=21888 
GO
delete from HtmlLabelInfo where indexid=21888 
GO
INSERT INTO HtmlLabelIndex values(21888,'δ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(21888,'δ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21888,'δ�_��',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21888,'Unopened',9) 
GO
delete from HtmlLabelIndex where id=21889 
GO
delete from HtmlLabelInfo where indexid=21889 
GO
INSERT INTO HtmlLabelIndex values(21889,'�ѿ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(21889,'�ѿ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21889,'Has been opened',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21889,'���_��',9) 
GO


delete from SystemRights where id=800
GO
insert into SystemRights (id,rightdesc,righttype) values (800,'�ĵ�������������Ȩ��','1') 
GO
delete from SystemRightsLanguage where id=800
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (800,7,'�ĵ�������������Ȩ��','�ĵ�������������Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (800,9,'�ĵ�������������Ȩ��','�ĵ�������������Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (800,8,'Pop-up document setting authority','Pop-up document setting authority') 
GO
delete from SystemRightDetail where id=4310
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4310,'�ĵ�������������Ȩ��','Docs:SetPopUp',800) 
GO
