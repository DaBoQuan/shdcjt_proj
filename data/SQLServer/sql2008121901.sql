insert into SystemRights (id,rightdesc,righttype) values (808,'COA��ֵά��','2') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (808,9,'COA��ֵ�S�o','COA��ֵ�S�o') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (808,7,'COA��ֵά��','COA��ֵά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (808,8,'COA Maintenance','COA Maintenance') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4319,'COA��ֵά��','coaset:all',808) 
GO
 


delete from HtmlLabelIndex where id=22087 
GO
delete from HtmlLabelInfo where indexid=22087 
GO
INSERT INTO HtmlLabelIndex values(22087,'���Ľ�') 
GO
delete from HtmlLabelIndex where id=22092 
GO
delete from HtmlLabelInfo where indexid=22092 
GO
INSERT INTO HtmlLabelIndex values(22092,'Ԥ֧���Сд') 
GO
delete from HtmlLabelIndex where id=22104 
GO
delete from HtmlLabelInfo where indexid=22104 
GO
INSERT INTO HtmlLabelIndex values(22104,'����д') 
GO
delete from HtmlLabelIndex where id=22100 
GO
delete from HtmlLabelInfo where indexid=22100 
GO
INSERT INTO HtmlLabelIndex values(22100,'��ؽ������') 
GO
delete from HtmlLabelIndex where id=22095 
GO
delete from HtmlLabelInfo where indexid=22095 
GO
INSERT INTO HtmlLabelIndex values(22095,'������Ϣ') 
GO
delete from HtmlLabelIndex where id=22094 
GO
delete from HtmlLabelInfo where indexid=22094 
GO
INSERT INTO HtmlLabelIndex values(22094,'��������') 
GO
delete from HtmlLabelIndex where id=22093 
GO
delete from HtmlLabelInfo where indexid=22093 
GO
INSERT INTO HtmlLabelIndex values(22093,'Ԥ֧����д') 
GO
delete from HtmlLabelIndex where id=22088 
GO
delete from HtmlLabelInfo where indexid=22088 
GO
INSERT INTO HtmlLabelIndex values(22088,'���Ļ��') 
GO
delete from HtmlLabelIndex where id=22103 
GO
delete from HtmlLabelInfo where indexid=22103 
GO
INSERT INTO HtmlLabelIndex values(22103,'���Сд') 
GO
delete from HtmlLabelIndex where id=22107 
GO
delete from HtmlLabelInfo where indexid=22107 
GO
INSERT INTO HtmlLabelIndex values(22107,'��������') 
GO
delete from HtmlLabelIndex where id=22106 
GO
delete from HtmlLabelInfo where indexid=22106 
GO
INSERT INTO HtmlLabelIndex values(22106,'��ؽ�') 
GO
delete from HtmlLabelIndex where id=22110 
GO
delete from HtmlLabelInfo where indexid=22110 
GO
INSERT INTO HtmlLabelIndex values(22110,'����д') 
GO
delete from HtmlLabelIndex where id=22099 
GO
delete from HtmlLabelInfo where indexid=22099 
GO
INSERT INTO HtmlLabelIndex values(22099,'�������д') 
GO
delete from HtmlLabelIndex where id=22109 
GO
delete from HtmlLabelInfo where indexid=22109 
GO
INSERT INTO HtmlLabelIndex values(22109,'��������') 
GO
delete from HtmlLabelIndex where id=22098 
GO
delete from HtmlLabelInfo where indexid=22098 
GO
INSERT INTO HtmlLabelIndex values(22098,'������') 
GO
delete from HtmlLabelIndex where id=22097 
GO
delete from HtmlLabelInfo where indexid=22097 
GO
INSERT INTO HtmlLabelIndex values(22097,'���ʽ') 
GO
delete from HtmlLabelIndex where id=22090 
GO
delete from HtmlLabelInfo where indexid=22090 
GO
INSERT INTO HtmlLabelIndex values(22090,'Ԥ֧����') 
GO
delete from HtmlLabelIndex where id=22101 
GO
delete from HtmlLabelInfo where indexid=22101 
GO
INSERT INTO HtmlLabelIndex values(22101,'�Ƿ����յ�����') 
GO
delete from HtmlLabelIndex where id=22091 
GO
delete from HtmlLabelInfo where indexid=22091 
GO
INSERT INTO HtmlLabelIndex values(22091,'Ԥ֧���') 
GO
delete from HtmlLabelIndex where id=22085 
GO
delete from HtmlLabelInfo where indexid=22085 
GO
INSERT INTO HtmlLabelIndex values(22085,'���ķ��ñ�����') 
GO
delete from HtmlLabelIndex where id=22108 
GO
delete from HtmlLabelInfo where indexid=22108 
GO
INSERT INTO HtmlLabelIndex values(22108,'��ǰԤ��') 
GO
delete from HtmlLabelIndex where id=22102 
GO
delete from HtmlLabelInfo where indexid=22102 
GO
INSERT INTO HtmlLabelIndex values(22102,'��������') 
GO
delete from HtmlLabelIndex where id=22089 
GO
delete from HtmlLabelInfo where indexid=22089 
GO
INSERT INTO HtmlLabelIndex values(22089,'��˾') 
GO
delete from HtmlLabelIndex where id=22086 
GO
delete from HtmlLabelInfo where indexid=22086 
GO
INSERT INTO HtmlLabelIndex values(22086,'���ķ������뵥') 
GO
delete from HtmlLabelIndex where id=22096 
GO
delete from HtmlLabelInfo where indexid=22096 
GO
INSERT INTO HtmlLabelIndex values(22096,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22085,'���ķ��ñ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22085,'ja expense wipe',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22085,'�����M�È��N��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22086,'���ķ������뵥',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22086,'ja expense applications',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22086,'�����M����Ո��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22087,'���Ľ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22087,'ja loan',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22087,'���Ľ���',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22088,'���Ļ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22088,'ja repayment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22088,'����߀���',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22089,'��˾',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22089,'company',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22089,'��˾',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22090,'Ԥ֧����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22090,'The subject matter of advance',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22090,'�A֧����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22091,'Ԥ֧���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22091,'The amount of advance',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22091,'�A֧���~',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22092,'Ԥ֧���Сд',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22092,'Advance the amount of lower-case',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22092,'�A֧���~С��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22093,'Ԥ֧����д',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22093,'Advance the amount of capital',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22093,'�A֧���~��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22094,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22094,'accounting date',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22094,'ӛ�~����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22095,'������Ϣ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22095,'bank infomation',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22095,'�y����Ϣ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22096,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22096,'repayment person',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22096,'',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22097,'���ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22097,'repayment type',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22097,'߀�ʽ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22098,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22098,'Repayment amount',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22098,'߀����~',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22099,'�������д',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22099,'Repayment of the amount of capital',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22099,'߀����~��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22100,'��ؽ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22100,'relate loan workflow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22100,'���P�������',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22101,'�Ƿ����յ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22101,'Whether it has received repayment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22101,'�Ƿ����յ�߀��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22102,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22102,'reason',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22102,'��Ո����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22103,'���Сд',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22103,'The amount of lower-case',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22103,'���~С��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22104,'����д',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22104,'The amount of capital',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22104,'���~��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22106,'��ؽ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22106,'relate loan',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22106,'���P����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22107,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22107,'expense type',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22107,'�M�����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22108,'��ǰԤ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22108,'current budget',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22108,'��ǰ�A��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22109,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22109,'bill sum',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22109,'�Γ�����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22110,'����д',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22110,'amount capital',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22110,'���~��',9) 
GO

 delete from HtmlLabelIndex where id=22112 
GO
delete from HtmlLabelInfo where indexid=22112 
GO
INSERT INTO HtmlLabelIndex values(22112,'��ֵ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22112,'��ֵ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22112,'Paragraph value',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22112,'��ֵ',9) 
GO

delete from HtmlLabelIndex where id=22117 
GO
delete from HtmlLabelInfo where indexid=22117 
GO
INSERT INTO HtmlLabelIndex values(22117,'COA��ֵ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22117,'COA��ֵ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22117,'COA SET',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22117,'COA��ֵ�O��',9) 
GO
delete from HtmlLabelIndex where id=22126 
GO
delete from HtmlLabelInfo where indexid=22126 
GO
INSERT INTO HtmlLabelIndex values(22126,'���Ŷ�') 
GO
delete from HtmlLabelIndex where id=22127 
GO
delete from HtmlLabelInfo where indexid=22127 
GO
INSERT INTO HtmlLabelIndex values(22127,'�˻���') 
GO
delete from HtmlLabelIndex where id=22128 
GO
delete from HtmlLabelInfo where indexid=22128 
GO
INSERT INTO HtmlLabelIndex values(22128,'��Ŀ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(22126,'���Ŷ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22126,'Department paragraph',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22126,'���T��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22127,'�˻���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22127,'Account paragraph',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22127,'������',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22128,'��Ŀ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22128,'sub account Paragraph',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22128,'��Ŀ��',9) 
GO
delete from HtmlLabelIndex where id=22105 
GO
delete from HtmlLabelInfo where indexid=22105 
GO
INSERT INTO HtmlLabelIndex values(22105,'�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22105,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22105,'related requests',8) 
GO

delete from HtmlLabelIndex where id=22105 
GO
delete from HtmlLabelInfo where indexid=22105 
GO
INSERT INTO HtmlLabelIndex values(22105,'�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22105,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22105,'related requests',8) 
GO



delete from HtmlLabelIndex where id=22207 
GO
delete from HtmlLabelInfo where indexid=22207 
GO
INSERT INTO HtmlLabelIndex values(22207,'�ֽ�������ʶ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22207,'�ֽ�������ʶ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22207,'Cash Flow Code',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22207,'�F���������R',9) 
GO
