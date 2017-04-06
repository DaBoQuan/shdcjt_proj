insert SequenceIndex (indexdesc,currentid) values('alertid',1)
GO

INSERT INTO HtmlLabelIndex values(18280,'��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18280,'��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18280,'quarter',8) 
GO

insert into SysPoppupInfo values (3,'/system/SysRemindGoalLink.jsp?type=3','Ŀ�꽨������','y','Ŀ�꽨��')
go  
insert into SysPoppupInfo values (4,'/system/SysRemindGoalLink.jsp?type=4','�ƻ���������','y','�ƻ�����')
go  
insert into SysPoppupInfo values (5,'/system/SysRemindGoalLink.jsp?type=5','�ύ��������','y','�ύ����')
go  


CREATE TABLE [HrmPerformanceAlertCheck] (
	[id] [int] NOT NULL ,
	[alertName] [varchar] (100)  NULL ,
	[cycle] [char] (1)  NULL ,
	[performanceDate] [varchar] (50)  NULL ,
	[performanceType] [char] (1)  NULL ,
	[objId] [int] NULL ,
	[alertType] [char] (1)  NULL 
) ON [PRIMARY]
GO



ALTER TABLE [HrmPerformanceAlertCheck] WITH NOCHECK ADD 
	CONSTRAINT [PK_HrmPerformanceAlertCheck] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO
