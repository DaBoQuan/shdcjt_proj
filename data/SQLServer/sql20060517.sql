INSERT INTO HtmlLabelIndex values(18990,'���������ģ���ָ��״̬') 
GO
INSERT INTO HtmlLabelInfo VALUES(18990,'���������ģ���ָ��״̬',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18990,'Firstly, delete the appointed status',8) 
GO

CREATE TABLE SystemTemplateSubComp(
    subcompanyid int,
    templateid int
)
go
insert into SystemTemplateSubComp (subcompanyid,templateid) select id,-1 from HrmSubCompany
go

insert into SysPoppupInfo values (11,'/cpt/search/CptInstockSearch.jsp','�ʲ������������','y','�ʲ������������')
go  
INSERT INTO HtmlLabelIndex values(18993,'������') 
GO
INSERT INTO HtmlLabelIndex values(18995,'�ܷ�') 
GO
INSERT INTO HtmlLabelIndex values(18996,'ƽ����') 
GO
INSERT INTO HtmlLabelIndex values(18998,'һ����') 
GO
INSERT INTO HtmlLabelIndex values(18999,'���˴��') 
GO
INSERT INTO HtmlLabelIndex values(18992,'ƽ����') 
GO
INSERT INTO HtmlLabelIndex values(18991,'�����ǰ�ĵ����') 
GO
INSERT INTO HtmlLabelIndex values(18994,'������д�����۵�ԭ��') 
GO
INSERT INTO HtmlLabelIndex values(18997,'��ϸ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18991,'�����ǰ�ĵ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18991,'Please mark the current doc',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18992,'ƽ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18992,'Insipid',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18993,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18993,'Conspicuous',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18994,'������д�����۵�ԭ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18994,'Write the reason of this evaluation below',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18995,'�ܷ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18995,'Total',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18996,'ƽ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18996,'Average',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18997,'��ϸ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18997,'Detail',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18998,'һ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18998,'Totally',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18999,'���˴��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18999,'people marked',8) 
GO

INSERT INTO HtmlLabelIndex values(19003,'�������') 
GO
INSERT INTO HtmlLabelIndex values(19002,'�����') 
GO
INSERT INTO HtmlLabelIndex values(19000,'�����Ҫѡ��÷��������ύ��') 
GO
INSERT INTO HtmlLabelIndex values(19001,'û��ѡ����Ҫ���ĵ��ĵ�����鿴��ش�����־��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19000,'�����Ҫѡ��÷��������ύ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19000,'You must choose a point to submit!',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19001,'û��ѡ����Ҫ���ĵ��ĵ�����鿴��ش�����־��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19001,'No choosing doc to read,please check the related error log!',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19002,'�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19002,'Marker',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19003,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19003,'Mark Date',8) 
GO

update Htmllabelinfo set labelname='Value of Point' where indexid=18093 and languageid=8
GO
