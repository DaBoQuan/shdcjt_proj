INSERT INTO HtmlLabelIndex values(17051,'������') 
GO
INSERT INTO HtmlLabelIndex values(17052,'������') 
GO
INSERT INTO HtmlLabelIndex values(17053,'�����쵼') 
GO
INSERT INTO HtmlLabelIndex values(17054,'�ֹ��쵼') 
GO
INSERT INTO HtmlLabelIndex values(17055,'������') 
GO
INSERT INTO HtmlLabelIndex values(17056,'�Ƿ���Ҫ�ֹ��쵼����') 
GO
INSERT INTO HtmlLabelIndex values(17057,'�Ƿ���Ҫ�ܾ�������') 
GO
INSERT INTO HtmlLabelIndex values(17050,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17050,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17050,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17051,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17051,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17052,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17052,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17053,'�����쵼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17053,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17054,'�ֹ��쵼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17054,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17055,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17055,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17056,'�Ƿ���Ҫ�ֹ��쵼����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17056,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17057,'�Ƿ���Ҫ�ܾ�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17057,'',8) 
GO


ALTER TABLE bill_SendDoc ADD  resourceId_1 varchar(200) /*�����쵼����������Դ��*/
GO
ALTER TABLE bill_SendDoc ADD  resourceId_2 varchar(200) /*�ֹ��쵼����������Դ��*/
GO
ALTER TABLE bill_SendDoc ADD  resourceId_3 varchar(200) /*�����ˣ���������Դ��*/
GO
ALTER TABLE bill_SendDoc ADD  leaderCheck char(1) /*�Ƿ���Ҫ�ֹ��쵼������check��*/
GO
ALTER TABLE bill_SendDoc ADD  generalManagerCheck char(1) /*�Ƿ���Ҫ�ܾ���������check��*/
GO
UPDATE workflow_billfield set dsporder=30 where billid=66 and fieldname='desc_n'
GO
UPDATE workflow_billfield set dsporder=31 where billid=66 and fieldname='systemIds'
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'resourceId_1',17053,'varchar(200)',3,17,19,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'resourceId_2',17054,'varchar(200)',3,17,20,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'resourceId_3',17055,'varchar(200)',3,17,21,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'leaderCheck',17056,'char(1)',4,0,22,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (66,'generalManagerCheck',17057,'char(1)',4,0,23,0) 
GO



ALTER TABLE bill_InnerSendDoc ADD  resourceId_1 varchar(200) /*�����ˣ���������Դ��*/
GO
ALTER TABLE bill_InnerSendDoc ADD  resourceId_2 varchar(200) /*�����ˣ���������Դ��*/
GO
ALTER TABLE bill_InnerSendDoc ADD  resourceId_3 varchar(200) /*�����ˣ���������Դ��*/
GO
ALTER TABLE bill_InnerSendDoc ADD  resourceId_4 varchar(200) /*�����쵼����������Դ��*/
GO
ALTER TABLE bill_InnerSendDoc ADD  resourceId_5 varchar(200) /*�ֹ��쵼����������Դ��*/
GO
ALTER TABLE bill_InnerSendDoc ADD  resourceId_6 varchar(200) /*�����ˣ���������Դ��*/
GO
ALTER TABLE bill_InnerSendDoc ADD  leaderCheck char(1) /*�Ƿ���Ҫ�ֹ��쵼������check��*/
GO
ALTER TABLE bill_InnerSendDoc ADD  generalManagerCheck char(1) /*�Ƿ���Ҫ�ܾ���������check��*/
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'resourceId_1',17050,'varchar(200)',3,17,19,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'resourceId_2',17051,'varchar(200)',3,17,20,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'resourceId_3',17052,'varchar(200)',3,17,21,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'resourceId_4',17053,'varchar(200)',3,17,22,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'resourceId_5',17054,'varchar(200)',3,17,23,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'resourceId_6',17055,'varchar(200)',3,17,24,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'leaderCheck',17056,'char(1)',4,0,25,0)
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (67,'generalManagerCheck',17057,'char(1)',4,17,26,0)
GO