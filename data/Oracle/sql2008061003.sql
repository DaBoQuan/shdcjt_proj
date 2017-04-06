ALTER TABLE workflow_base ADD  titleFieldId integer null
/
ALTER TABLE workflow_base ADD  keywordFieldId integer null
/

CREATE TABLE Workflow_Keyword(
	id integer NOT NULL ,
	keywordName varchar2(60) NULL ,
	keywordDesc varchar2(200) NULL ,
	parentId integer NULL ,
	isLast char(1) NULL ,
	isKeyword char(1) NULL ,
	showOrder number(6,2) NULL 
)
/

create sequence Workflow_Keyword_id
start with 1
increment by 1
nomaxvalue
nocycle
/


create or replace trigger Workflow_Keyword_Tri
before insert on Workflow_Keyword
for each row
begin
select Workflow_Keyword_id.nextval into :new.id from dual;
end;
/


insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�ۺϾ���','�ۺϾ���',-1,'0','0',1.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('��������Դ���ʵ�','��������Դ���ʵ�',-1,'0','0',2.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('���Ρ����罨�衢����','���Ρ����罨�衢����',-1,'0','0',3.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('ũҵ����ҵ��ˮ��������','ũҵ����ҵ��ˮ��������',-1,'0','0',4.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('����������','����������',-1,'0','0',5.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('ó��','ó��',-1,'0','0',6.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('����','����',-1,'0','0',7.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('������˾�������','������˾�������',-1,'0','0',8.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�������Ͷ�����','�������Ͷ�����',-1,'0','0',9.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�ơ��̡��ġ�������','�ơ��̡��ġ�������',-1,'0','0',10.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('����','����',-1,'0','0',11.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('���顢����','���顢����',-1,'0','0',12.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
values('�ۺϵ���','�ۺϵ���',-1,'0','0',13.00)
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
select '�ƻ�','�ƻ�',id,'0','1',14.00
  from  Workflow_Keyword
  where keywordName='�ۺϾ���'
/
insert into Workflow_Keyword(keywordName,keywordDesc,parentId,isLast,isKeyword,showOrder)
select '�滮','�滮',id,'1','1',15.00
  from  Workflow_Keyword
  where keywordName='�ƻ�'
/

update Workflow_Keyword set parentId=0 where parentId<0
/
