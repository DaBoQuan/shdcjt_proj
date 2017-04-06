alter table Bill_Meeting add resourcenum integer
/
alter table Bill_Meeting add resources varchar2(255)
/
alter table Bill_Meeting add crms varchar2(255)
/
alter table Bill_Meeting add others varchar2(255)
/
alter table Bill_Meeting add projectid integer
/
alter table Meeting add cancel char(1)
/
alter table Meeting add canceldate char(10)
/
alter table Meeting add canceltime char(8)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'resourcenum',2166,'integer',1,2,7,0,'')
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'resources',2106,'varchar2(255)',3,17,7,0,'')
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'crms',2167,'varchar2(255)',3,18,7,0,'')
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'others',19078,'varchar2(255)',1,1,7,0,'')
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (85,'projectid',782,'integer',3,8,9,0,'')
/
INSERT INTO HtmlLabelIndex values(19078,'������Ա') 
/
INSERT INTO HtmlLabelInfo VALUES(19078,'������Ա',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19078,'others',8) 
/
INSERT INTO HtmlLabelIndex values(19095,'������ֹʱ���ڻ�����ʹ�ó�ͻ���Ƿ�������룿')
/
INSERT INTO HtmlLabelInfo VALUES(19095,'������ֹʱ���ڻ�����ʹ�ó�ͻ���Ƿ�������룿',7)
/
INSERT INTO HtmlLabelInfo VALUES(19095,'time conflict of the meeting,whether or not continue?',8)
/
INSERT INTO HtmlLabelIndex values(19097,'ռ��')
/
INSERT INTO HtmlLabelIndex values(19098,'ʹ�ó�ͻ')
/
INSERT INTO HtmlLabelIndex values(19096,'����')
/
INSERT INTO HtmlLabelInfo VALUES(19096,'����',7)
/
INSERT INTO HtmlLabelInfo VALUES(19096,'vacancy',8)
/
INSERT INTO HtmlLabelInfo VALUES(19097,'ռ��',7)
/
INSERT INTO HtmlLabelInfo VALUES(19097,'use',8)
/
INSERT INTO HtmlLabelInfo VALUES(19098,'ʹ�ó�ͻ',7)
/
INSERT INTO HtmlLabelInfo VALUES(19098,'use conflict',8)
/

