insert into SysPoppupInfo values (7,'/system/sysRemindWfLink.jsp?flag=contractExpWf','��ͬ��������','y','��ͬ��������')
go

create table HrmRemindMsg(id int IDENTITY,
                               remindtype int,
                               resourceid int,
                               reminddate char(10) ,
                               relatedid int
                               )
go
create index index_hrmremind on HrmRemindMsg(id)
go

INSERT INTO HtmlLabelIndex values(18884,'������')
GO
INSERT INTO HtmlLabelInfo VALUES(18884,'������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18884,'probation period',8)
GO