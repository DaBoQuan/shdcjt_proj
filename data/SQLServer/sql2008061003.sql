ALTER TABLE workflow_base ADD  titleFieldId integer null
GO
ALTER TABLE workflow_base ADD  keywordFieldId integer null
GO

CREATE TABLE Workflow_Keyword(
	id int identity (1, 1) NOT NULL ,
	keywordName varchar(60) NULL ,
	keywordDesc varchar(200) NULL ,
	parentId int NULL ,
	isLast char(1) NULL ,
	isKeyword char(1) NULL ,
	showOrder decimal(6,2) NULL 
)
GO


insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�ۺϾ���','�ۺϾ���',-1,'0','0',1.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('��������Դ���ʵ�','��������Դ���ʵ�',-1,'0','0',2.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('���Ρ����罨�衢����','���Ρ����罨�衢����',-1,'0','0',3.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('ũҵ����ҵ��ˮ��������','ũҵ����ҵ��ˮ��������',-1,'0','0',4.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('����������','����������',-1,'0','0',5.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('ó��','ó��',-1,'0','0',6.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('����','����',-1,'0','0',7.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('������˾�������','������˾�������',-1,'0','0',8.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�������Ͷ�����','�������Ͷ�����',-1,'0','0',9.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�ơ��̡��ġ�������','�ơ��̡��ġ�������',-1,'0','0',10.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('����','����',-1,'0','0',11.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('���顢����','���顢����',-1,'0','0',12.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�ۺϵ���','�ۺϵ���',-1,'0','0',13.00)
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
select '�ƻ�','�ƻ�',id,'0','1',14.00
  from  Workflow_Keyword
  where keywordName='�ۺϾ���'
GO
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
select '�滮','�滮',id,'1','1',15.00
  from  Workflow_Keyword
  where keywordName='�ƻ�'
GO

update Workflow_Keyword set parentId=0 where parentId<0
GO
