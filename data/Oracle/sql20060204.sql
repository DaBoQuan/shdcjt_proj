create table SysPoppupRemindInfo (
userid integer ,
type integer ,
usertype char(1) ,
statistic char(1),
remindcount integer ,
count integer,
requestids varchar2(4000)
)
/
create table SysPoppupInfo (
type integer ,
link varchar2(250) ,
description varchar2(250) ,
statistic char(1),
typedescription varchar2(250)
)
/
insert into SysPoppupInfo values (0,'/system/sysRemindWfLink.jsp?flag=newWf','�µ���������Ҫ������','y','�µ�������')
/
insert into SysPoppupInfo values (1,'/system/sysRemindWfLink.jsp?flag=endWf','���������','y','���������')
/
call LMConfig_U_ByInfoInsert(2,111,4)
/
call LMInfo_Insert (115,18121,'','javascript:void(0);',2,111,4,1)
/
INSERT INTO HtmlLabelIndex values(18099,'������ʾ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18099,'',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18099,'',8) 
/

INSERT INTO HtmlLabelIndex values(18100,'�Ƿ���Ҫͳ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18100,'',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18100,'',8) 
/

INSERT INTO HtmlLabelIndex values(18101,'ҳ�浼��') 
/
INSERT INTO HtmlLabelInfo VALUES(18101,'',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18101,'',8) 
/

