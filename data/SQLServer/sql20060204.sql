create table SysPoppupRemindInfo (
userid int ,
type int ,
usertype char(1) ,
statistic char(1),
remindcount int ,
count int
)
GO

create table SysPoppupInfo (
type int ,
link varchar(250) ,
description varchar(250) ,
statistic char(1),
typedescription varchar(250)
)
GO


INSERT INTO HtmlLabelIndex values(18099,'������ʾ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18099,'',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18099,'',8) 
GO

INSERT INTO HtmlLabelIndex values(18100,'�Ƿ���Ҫͳ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18100,'',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18100,'',8) 
GO

INSERT INTO HtmlLabelIndex values(18101,'ҳ�浼��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18101,'',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18101,'',8) 
GO


alter table SysPoppupRemindInfo add requestids varchar(1000)
GO


alter table SysPoppupRemindInfo drop column requestids
GO
alter table SysPoppupRemindInfo add  requestids text
GO

insert into SysPoppupInfo values (0,'/system/sysRemindWfLink.jsp?flag=newWf','�µ���������Ҫ������','y','�µ�������')
go 

insert into SysPoppupInfo values (1,'/system/sysRemindWfLink.jsp?flag=endWf','���������','y','���������')
go 

EXECUTE LMConfig_U_ByInfoInsert 2,111,4
GO
EXECUTE LMInfo_Insert 115,18121,'','javascript:void(0);',2,111,4,1 
GO

