
delete from HtmlLabelIndex where id=18399
Go
delete from HtmlLabelInfo where indexid=18399
Go
delete from HtmlLabelInfo where indexid=18399
Go
INSERT INTO HtmlLabelIndex values(18399,'�������û�û���棬����뿪�����ᶪʧ���ݣ����Ҫ�뿪��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18399,'�������û�û���棬����뿪�����ᶪʧ���ݣ����Ҫ�뿪��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18399,'the datas do not saved ,if you left ��you will lost data��sure��',8) 
GO

delete from HtmlLabelIndex where id=18407
Go
delete from HtmlLabelInfo where indexid=18407
Go
delete from HtmlLabelInfo where indexid=18407
Go
INSERT INTO HtmlLabelIndex values(18407,'�����ĸĶ���û���棬����뿪�����ᶪʧ���ݣ����Ҫ�뿪��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18407,'�����ĸĶ���û���棬����뿪�����ᶪʧ���ݣ����Ҫ�뿪��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18407,'you have not save data��sure to levave��',8) 
GO


INSERT INTO HtmlLabelIndex values(17362,'�������ڱ�����ڻ������ʼ���ڣ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17362,'�������ڱ�����ڻ������ʼ���ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17362,'',8) 
GO
INSERT INTO HtmlLabelIndex values(17363,'��ʼ���ڱ���С�ڻ���ڽ������ڣ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17363,'��ʼ���ڱ���С�ڻ���ڽ������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17363,'',8) 
GO

insert into SystemRightGroups (rightgroupmark,rightgroupname,rightgroupremark) values ('KPI','Ŀ�꼨ЧȨ����','Ŀ�꼨Ч�Ĺ�������')
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),600 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),601 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),602 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),603 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),604 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),605 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),606 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),607 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),608 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),609 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),610 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),619 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),626 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),632 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),633 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),634 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),635 from SystemRightGroups
GO
insert into SystemRightToGroup (groupid,rightid) select max(id),636 from SystemRightGroups
GO
