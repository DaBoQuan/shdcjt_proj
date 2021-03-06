DELETE FROM HtmlLabelIndex WHERE id = 19772
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19772
GO
INSERT INTO HtmlLabelIndex values(19772,'日程设置') 
GO
INSERT INTO HtmlLabelInfo VALUES(19772,'日程设置',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19772,'Work Plan Set',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19773
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19773
GO
INSERT INTO HtmlLabelIndex values(19773,'日程类型设置') 
GO
INSERT INTO HtmlLabelInfo VALUES(19773,'日程类型设置',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19773,'Work Plan Type Set',8) 
GO


DELETE FROM HtmlLabelIndex WHERE id = 19774
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19774
GO
INSERT INTO HtmlLabelIndex values(19774,'日程类型名称') 
GO
INSERT INTO HtmlLabelInfo VALUES(19774,'日程类型名称',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19774,'Name of Work Plan Type',8) 
GO

INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('工作安排', 6, '#FF0000', '1', 2)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('会议日程', 6, '#00FF00', '1', 3)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('项目日程', 6, '#0000FF', '1', 4)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('客户联系', 6, '#FFFF00', '1', 5)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('个人便签', 6, '#00FFFF', '1', 6)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('目标绩效', 6, '#999999', '1', 7)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('目标计划', 6, '#FF00FF', '1', 8)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('默认日程类型', 7, '#FFCCCC', '1', 0)
GO
INSERT INTO WorkPlanType(workPlanTypeName, workPlanTypeAttribute, workPlanTypeColor, available, displayOrder)
VALUES('无权查看类型', 7, '#CCCCCC', '1', 1)
GO

DELETE FROM HtmlLabelIndex WHERE id = 19777
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19777
GO
INSERT INTO HtmlLabelIndex values(19777,'输入格式不正确！') 
GO
INSERT INTO HtmlLabelInfo VALUES(19777,'输入格式不正确！',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19777,'The Input Format is invalid!',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19778
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19778
GO
INSERT INTO HtmlLabelIndex values(19778,'该颜色已经被使用。') 
GO
INSERT INTO HtmlLabelInfo VALUES(19778,'该颜色已经被使用！',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19778,'The Colour is Applied!',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19781
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19781
GO
INSERT INTO HtmlLabelIndex values(19781,'日程提醒方式') 
GO
INSERT INTO HtmlLabelInfo VALUES(19781,'日程提醒方式',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19781,'Mode of the Work Plan Remind',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19782
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19782
GO
INSERT INTO HtmlLabelIndex values(19782,'不提醒') 
GO
INSERT INTO HtmlLabelInfo VALUES(19782,'不提醒',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19782,'Do not Remind',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19783
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19783
GO
INSERT INTO HtmlLabelIndex values(19783,'日程提醒时间') 
GO
INSERT INTO HtmlLabelInfo VALUES(19783,'日程提醒时间',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19783,'Time of Work Plan Remind',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19784
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19784
GO
INSERT INTO HtmlLabelIndex values(19784,'开始前') 
GO
INSERT INTO HtmlLabelInfo VALUES(19784,'开始前',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19784,'Before Start',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19785
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19785
GO
INSERT INTO HtmlLabelIndex values(19785,'结束前') 
GO
INSERT INTO HtmlLabelInfo VALUES(19785,'结束前',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19785,'Before End',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19788
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19788
GO
INSERT INTO HtmlLabelIndex values(19788,'日程开始提醒') 
GO
INSERT INTO HtmlLabelInfo VALUES(19788,'日程开始提醒',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19788,'Work Plan Begin Remind',8) 
GO

INSERT INTO SysPoppupInfo(type, link, description, statistic, typeDescription)
VALUES(12, '/system/SysRemindWorkPlan.jsp', '19788', 'y' , '19788')

DELETE FROM HtmlLabelIndex WHERE id = 19792
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19792
GO
INSERT INTO HtmlLabelIndex values(19792,'日程监控') 
GO
INSERT INTO HtmlLabelInfo VALUES(19792,'日程监控',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19792,'Work Plan Monitor',8) 
GO


DELETE FROM HtmlLabelIndex WHERE id = 19793
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19793
GO
INSERT INTO HtmlLabelIndex values(19793,'日程监控设置') 
GO
INSERT INTO HtmlLabelInfo VALUES(19793,'日程监控设置',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19793,'Work Plan Monitor Setting',8) 
GO



DELETE FROM HtmlLabelIndex WHERE id = 19794
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19794
GO
INSERT INTO HtmlLabelIndex values(19794,'日程监控人') 
GO
INSERT INTO HtmlLabelInfo VALUES(19794,'日程监控人',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19794,'Work Plan Control Men',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19795
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19795
GO
INSERT INTO HtmlLabelIndex values(19795,'日程类型数') 
GO
INSERT INTO HtmlLabelInfo VALUES(19795,'日程类型数',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19795,'Work Plan Type Amount',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19796
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19796
GO
INSERT INTO HtmlLabelIndex values(19796,'监控人不能为空!') 
GO
INSERT INTO HtmlLabelInfo VALUES(19796,'监控人不能为空!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19796,'You must choose the Work Plan Control Men!',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 19798
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 19798
GO
INSERT INTO HtmlLabelIndex values(19798,'持续时间') 
GO
INSERT INTO HtmlLabelInfo VALUES(19798,'持续时间',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19798,'Persistence Time',8) 
GO

insert into SystemRights (id,rightdesc,righttype) values (700,'日程类型设置','3') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (700,7,'日程类型设置','日程类型设置') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (700,8,'Work Plan Type Setting','Work Plan Type Setting') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4208,'日程类型设置','WorkPlanTypeSet:Set',700) 
GO


DELETE FROM HtmlLabelIndex WHERE id = 20168
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20168
GO
INSERT INTO HtmlLabelIndex values(20168,'按时间显示') 
GO
INSERT INTO HtmlLabelInfo VALUES(20168,'按时间显示',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20168,'View Through Time',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 20169
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20169
GO
INSERT INTO HtmlLabelInfo VALUES(20169,'按事件显示',7) 
GO
INSERT INTO HtmlLabelIndex values(20169,'按事件显示') 
GO
INSERT INTO HtmlLabelInfo VALUES(20169,'View Through Event',8) 
GO
