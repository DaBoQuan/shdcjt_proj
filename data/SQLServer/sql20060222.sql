insert into SysPoppupInfo values (2,'/system/sysRemindWfLink.jsp?flag=birthWf','��������','y','��������')
go
create table HrmBirthRemindMsg(id int IDENTITY,
                               title varchar(200),
                               resources varchar(500),
                               reminddate char(10))
go
create index index_hrmbirthremind on HrmBirthRemindMsg(id);
go
INSERT INTO HtmlLabelIndex values(18352,'����ף��')
GO
INSERT INTO HtmlLabelInfo VALUES(18352,'����ף��',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18352,'congratuation',8)
GO


insert into SysPoppupInfo values (6,'/system/sysRemindWfLink.jsp?flag=chgPassWf','����������','n','����������')
go
INSERT INTO HtmlLabelIndex values(18355,'��������')
GO
INSERT INTO HtmlLabelIndex values(18354,'������������')
GO
INSERT INTO HtmlLabelInfo VALUES(18354,'���ڰ�ȫ��ԭ���붨�ڸ�����������.',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18354,'please change you password frequently',8)
GO
INSERT INTO HtmlLabelInfo VALUES(18355,'��������',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18355,'change password',8)
GO

