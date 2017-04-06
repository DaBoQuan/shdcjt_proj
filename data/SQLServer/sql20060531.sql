alter table Bill_Meeting add resourcenum int
GO
alter table Bill_Meeting add resources varchar(255)
GO
alter table Bill_Meeting add crms varchar(255)
GO
alter table Bill_Meeting add others varchar(255)
GO
alter table Bill_Meeting add projectid int
GO
alter table Meeting add cancel char(1)
GO
alter table Meeting add canceldate char(10)
GO
alter table Meeting add canceltime char(8)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'resourcenum',2166,'int',1,2,7,0,'')
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'resources',2106,'varchar(255)',3,17,7,0,'')
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'crms',2167,'varchar(255)',3,18,7,0,'')
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'others',19078,'varchar(255)',1,1,7,0,'')
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'projectid',782,'int',3,8,9,0,'')
GO
INSERT INTO HtmlLabelIndex values(19078,'������Ա') 
GO
INSERT INTO HtmlLabelInfo VALUES(19078,'������Ա',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19078,'others',8) 
GO
INSERT INTO HtmlLabelIndex values(19095,'������ֹʱ���ڻ�����ʹ�ó�ͻ���Ƿ�������룿')
GO
INSERT INTO HtmlLabelInfo VALUES(19095,'������ֹʱ���ڻ�����ʹ�ó�ͻ���Ƿ�������룿',7)
GO
INSERT INTO HtmlLabelInfo VALUES(19095,'time conflict of the meeting,whether or not continue?',8)
GO
INSERT INTO HtmlLabelIndex values(19097,'ռ��')
GO
INSERT INTO HtmlLabelIndex values(19098,'ʹ�ó�ͻ')
GO
INSERT INTO HtmlLabelIndex values(19096,'����')
GO
INSERT INTO HtmlLabelInfo VALUES(19096,'����',7)
GO
INSERT INTO HtmlLabelInfo VALUES(19096,'vacancy',8)
GO
INSERT INTO HtmlLabelInfo VALUES(19097,'ռ��',7)
GO
INSERT INTO HtmlLabelInfo VALUES(19097,'use',8)
GO
INSERT INTO HtmlLabelInfo VALUES(19098,'ʹ�ó�ͻ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(19098,'use conflict',8)
GO

