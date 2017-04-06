INSERT INTO HtmlLabelIndex values(19038,'��ͳ����Ա') 
GO
INSERT INTO HtmlLabelIndex values(19039,'��ͳ����Ա����') 
GO
INSERT INTO HtmlLabelIndex values(19040,'�ɲ鿴��Ա')
GO
INSERT INTO HtmlLabelIndex values(19041,'�ɲ鿴��Ա����') 
GO


INSERT INTO HtmlLabelIndex values(19042,'�ճ�ͳ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19038,'��ͳ����Ա',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19038,'member to be statistic',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19039,'��ͳ����Ա����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19039,'the type of the member to be statistic',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19040,'�ɲ鿴��Ա',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19040,'member to visit',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19041,'�ɲ鿴��Ա����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19041,'the type of the member to visit',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19042,'�ճ�ͳ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19042,'Work Pan Report Setting',8) 
GO

INSERT INTO HtmlLabelIndex values(19043,'�ճ�ͳ�Ʊ���鿴��Χ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19043,'�ճ�ͳ�Ʊ���鿴��Χ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19043,'Range of Work Plan Report Tracing',8) 
GO



insert into SystemRights (id,rightdesc,righttype) values (647,'�ճ�ͳ������','3') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (647,7,'�ճ�ͳ������','�ճ�ͳ������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (647,8,'Work Plan Report Setting','Work Plan Report Setting') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4147,'�ճ�ͳ������','WorkPlanReportSet:Set',647) 
GO



INSERT INTO HtmlLabelIndex values(19057,'�ճ���ͳ��') 
GO
INSERT INTO HtmlLabelIndex values(19058,'�ճ���ͳ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19057,'�ճ���ͳ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19057,'Work Plan Weekly Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19058,'�ճ���ͳ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19058,'Work Plan Monthly Report',8) 
GO

INSERT INTO HtmlLabelIndex values(19080,'�ճ�ͳ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19080,'�ճ�ͳ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19080,'Work Plan Report',8) 
GO


EXECUTE MMConfig_U_ByInfoInsert 3,15
GO
EXECUTE MMInfo_Insert 491,19042,'','/workplan/config/WorkPlanReportSetOperation.jsp','mainFrame',3,1,15,0,'',1,'WorkPlanReportSet:Set',0,'','',0,'','',2
GO

EXECUTE LMConfig_U_ByInfoInsert 2,140,0
GO
EXECUTE LMInfo_Insert 150,19057,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/workplan/report/WorkPlanReportListOperation.jsp?type=1',2,140,0,2 
GO

EXECUTE LMConfig_U_ByInfoInsert 2,140,1
GO
EXECUTE LMInfo_Insert 151,19058,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/workplan/report/WorkPlanReportListOperation.jsp?type=2',2,140,1,2 
GO


CREATE TABLE WorkPlanVisitSet 
(
    WorkPlanVisitSetID int IDENTITY (1, 1) PRIMARY KEY NOT NULL ,
    WorkPlanReportType int NULL ,
    WorkPlanReportContentID varchar (400) ,
    WorkPlanReportSec int NULL ,
    WorkPlanVisitType int NULL ,
    WorkPlanVisitContentID varchar (400) ,
    WorkPlanVisitSec int NULL 
)
GO

CREATE TABLE WorkPlanVisitSetDetail 
(
    WorkPlanVisitSetDetailID int IDENTITY (1, 1) PRIMARY KEY NOT NULL ,
    WorkPlanReportType int NULL ,
    WorkPlanReportContentID int NULL ,
    WorkPlanReportSec int NULL ,
    WorkPlanVisitType int NULL ,
    WorkPlanVisitContentID int NULL ,
    WorkPlanVisitSec int NULL ,
    WorkPlanVisitSetID int NULL 
)
GO