delete from HtmlLabelIndex where id=21879 
/
delete from HtmlLabelInfo where indexid=21879 
/
INSERT INTO HtmlLabelIndex values(21879,'���õ�������') 
/
INSERT INTO HtmlLabelInfo VALUES(21879,'���õ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21879,'The opening of pop-up window',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21879,'���Ï�������',9) 
/
 
delete from HtmlLabelIndex where id=21880 
/
delete from HtmlLabelInfo where indexid=21880 
/
INSERT INTO HtmlLabelIndex values(21880,'�رյ�������') 
/
INSERT INTO HtmlLabelInfo VALUES(21880,'�رյ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21880,'Close pop-up window',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21880,'�P�]��������',9) 
/
delete from HtmlLabelIndex where id=21881 
/
delete from HtmlLabelInfo where indexid=21881 
/
INSERT INTO HtmlLabelIndex values(21881,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(21881,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21881,'The number of pop-up',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21881,'�����Δ�',9) 
/
delete from HtmlLabelIndex where id=21882 
/
delete from HtmlLabelInfo where indexid=21882 
/
INSERT INTO HtmlLabelIndex values(21882,'���ڸ߶�') 
/
INSERT INTO HtmlLabelInfo VALUES(21882,'���ڸ߶�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21882,'A high degree of window',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21882,'���ڸ߶�',9) 
/
delete from HtmlLabelIndex where id=21884 
/
delete from HtmlLabelInfo where indexid=21884 
/
INSERT INTO HtmlLabelIndex values(21884,'���ڿ��') 
/
INSERT INTO HtmlLabelInfo VALUES(21884,'���ڿ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21884,'Width of the window',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21884,'���ڌ���',9) 
/

delete from HtmlLabelIndex where id=21885 
/
delete from HtmlLabelInfo where indexid=21885 
/
INSERT INTO HtmlLabelIndex values(21885,'�ĵ�������������') 
/
INSERT INTO HtmlLabelInfo VALUES(21885,'�ĵ�������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21885,'Pop-up document set',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21885,'�ęn���������O��',9) 
/
delete from HtmlLabelIndex where id=21886 
/
delete from HtmlLabelInfo where indexid=21886 
/
INSERT INTO HtmlLabelIndex values(21886,'���ڵ���״̬') 
/
INSERT INTO HtmlLabelInfo VALUES(21886,'���ڵ���״̬',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21886,'Pop-up window state',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21886,'���ڏ�����B',9) 
/
 
delete from HtmlLabelIndex where id=21887 
/
delete from HtmlLabelInfo where indexid=21887 
/
INSERT INTO HtmlLabelIndex values(21887,'����״̬') 
/
INSERT INTO HtmlLabelInfo VALUES(21887,'����״̬',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21887,'Open',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21887,'�_����B',9) 
/
delete from HtmlLabelIndex where id=21888 
/
delete from HtmlLabelInfo where indexid=21888 
/
INSERT INTO HtmlLabelIndex values(21888,'δ����') 
/
INSERT INTO HtmlLabelInfo VALUES(21888,'δ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21888,'δ�_��',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21888,'Unopened',9) 
/
delete from HtmlLabelIndex where id=21889 
/
delete from HtmlLabelInfo where indexid=21889 
/
INSERT INTO HtmlLabelIndex values(21889,'�ѿ���') 
/
INSERT INTO HtmlLabelInfo VALUES(21889,'�ѿ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21889,'Has been opened',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21889,'���_��',9) 
/


delete from SystemRights where id=800
/
insert into SystemRights (id,rightdesc,righttype) values (800,'�ĵ�������������Ȩ��','1') 
/
delete from SystemRightsLanguage where id=800
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (800,7,'�ĵ�������������Ȩ��','�ĵ�������������Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (800,9,'�ĵ�������������Ȩ��','�ĵ�������������Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (800,8,'Pop-up document setting authority','Pop-up document setting authority') 
/
delete from SystemRightDetail where id=4310
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4310,'�ĵ�������������Ȩ��','Docs:SetPopUp',800) 
/

