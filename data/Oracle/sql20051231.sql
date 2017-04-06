CREATE table codemain (
    id integer ,
    titleImg Varchar2(20),  /*����ͼƬ*/
    titleName Varchar2(20),
    isUse char(1),/*1:Ϊ���� 2:Ϊ������*/
    allowStr Varchar2(20) /*Ȩ���ж��ַ���*/
)
/
create sequence codemain_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger codemain_Trigger
before insert on codemain
for each row
begin
select codemain_id.nextval into :new.id from dual;
end;
/

CREATE table codedetail (
    id integer ,
    codemainid integer not null, /*�����ID*/
    showname Varchar2(20), 
    showtype char(1), /*1:checkbox  3:input  3.year */
    value Varchar2(20), /*0:��ѡ�� 1:ѡ��  ��Ϊyearʱ 1|1 ��ʾ���ã�������Ϊ������ 1|0��ʾ��Ϊ������*/
    codeorder integer
)
/
create sequence codedetail_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger codedetail_Trigger
before insert on codedetail
for each row
begin
select codedetail_id.nextval into :new.id from dual;
end;
/



INSERT INTO  codemain (titleImg,titleName,isUse,allowStr) VALUES ('/images/sales.gif','��Ŀ����',1,'ProjCode:Maintenance')
/

INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'����ǰ׺',2,'proj',1)
/

INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'�ͻ����ͱ���',1,'1',2)
/

INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��Ŀ���ͱ���',1,'1',3)
/


INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'�������ͱ���',1,'1',4)
/


INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��',3,'1|1',5)
/
INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��',1,'1',6)
/

INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��',1,'1',7)
/


INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��ˮ��λ��',2,'4',8)
/


/*�޸���Ŀ��������ӵ�ַ����������*/
update MainMenuInfo set linkAddress='/system/codeMaint.jsp?codemainid=1' where  linkAddress='/proj/CodeFormat/CodeFormatView.jsp'
/
/*�������ͱ���빤�����ͱ���*/
ALTER  TABLE Prj_WorkType ADD worktypeCode Varchar2(50)
/

Create or replace PROCEDURE Prj_WorkType_Insert (
fullname_1 	Varchar2, 
description_2 	Varchar2,
worktypecode_3 Varchar2,
  flag out integer, 
  msg out varchar2,
  thecursor IN OUT cursor_define.weavercursor)
AS
BEGIN
INSERT INTO Prj_WorkType (fullname, description,worktypecode) 
VALUES ( fullname_1, description_2,worktypecode_3);
END;
/


Create or replace PROCEDURE Prj_WorkType_Update (
id_1	 	integer,
 fullname_2 	Varchar2,
 description_3 	Varchar2, 
 worktypecode_4 Varchar2,
  flag out integer, 
  msg out varchar2,
  thecursor IN OUT cursor_define.weavercursor)
  AS
  BEGIN
  UPDATE Prj_WorkType  
  SET  fullname	 = fullname_2, description = description_3,worktypecode= worktypecode_4  
   WHERE ( id	 = id_1);
END;
/

