/*td:1515 by zxf for ���ܴ����ظ��ķֲ�*/
CREATE OR REPLACE PROCEDURE HrmSubCompany_Insert (subcompanyname_1 	varchar2, subcompanydesc_2 	varchar2, companyid_3 	smallint, flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor) AS 
count0 int;
count1 int;
begin 
select count(*) into count0 from HrmSubCompany where subcompanyname=subcompanyname_1 ;
select count(*) into count1 from HrmSubCompany where subcompanydesc=subcompanydesc_2 ;
if count0>0 then
   flag:=2;
   msg:='�÷ֲ�����Ѿ����ڣ����ܱ��棡' ;
   return;
end if; 
if count1>0 then
   flag:=3;
   msg:='�÷ֲ�ȫ���Ѿ����ڣ����ܱ��棡' ;
   return;
end if;
INSERT INTO HrmSubCompany ( subcompanyname, subcompanydesc, companyid) VALUES ( subcompanyname_1, subcompanydesc_2, companyid_3); 
open thecursor for select (max(id)) from HrmSubCompany ; 
end;
/

CREATE OR REPLACE PROCEDURE HrmSubCompany_Update (id_1 	integer, subcompanyname_2 	varchar2, subcompanydesc_3 	varchar2, companyid_4 	smallint, flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor) AS 
count0 int;
count1 int;
begin 
select count(*) into count0 from HrmSubCompany where subcompanyname=subcompanyname_2 and id!=id_1;
select count(*) into count1 from HrmSubCompany where subcompanydesc=subcompanydesc_3 and id!=id_1;
if count0>0 then
   flag:=2;
   msg:='�÷ֲ�����Ѿ����ڣ����ܱ��棡' ;
   return;
end if; 
if count1>0 then
   flag:=3;
   msg:='�÷ֲ�ȫ���Ѿ����ڣ����ܱ��棡' ;
   return;
end if; 
UPDATE HrmSubCompany SET subcompanyname	 = subcompanyname_2, subcompanydesc	 = subcompanydesc_3, companyid	 = companyid_4  WHERE ( id	 = id_1) ; 
end;
/

insert into ErrorMsgIndex values (40,'�ֲ�����ظ�') 
/
insert into ErrorMsgInfo values (40,'�÷ֲ�����Ѿ����ڣ����ܱ���',7) 
/
insert into ErrorMsgInfo values (40,'The branch name duplicated',8) 
/
insert into ErrorMsgIndex values (43,'�ֲ�ȫ���ظ�') 
/
insert into ErrorMsgInfo values (43,'�÷ֲ�ȫ���Ѿ����ڣ����ܱ���',7) 
/
insert into ErrorMsgInfo values (43,'The branch name duplicated',8) 
/

/*td:1517 by zxf for ���ܴ����ظ��Ĳ���*/
CREATE OR REPLACE PROCEDURE HrmDepartment_Insert ( departmentmark_1 varchar2, departmentname_2 	varchar2, supdepid_3 integer, allsupdepid_4 varchar2, subcompanyid1_5 integer, showorder_6 integer, flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor) AS 
count0 int;
count1 int;
begin
select count(*) into count0 from HrmDepartment where subcompanyid1=subcompanyid1_5 and departmentmark=departmentmark_1;
select count(*) into count1 from HrmDepartment where subcompanyid1=subcompanyid1_5 and departmentname=departmentname_2;
if count0>0 then
   flag:=2;
   msg:='�ò��ż���Ѿ����ڣ����ܱ��棡' ;
   return;
end if; 
if count1>0 then
   flag:=3;
   msg:='�ò���ȫ���Ѿ����ڣ����ܱ��棡' ;
   return;
end if; 
INSERT INTO HrmDepartment ( departmentmark, departmentname, supdepid, allsupdepid, subcompanyid1, showorder) VALUES ( departmentmark_1, departmentname_2, supdepid_3, allsupdepid_4, subcompanyid1_5, showorder_6) ; 
open thecursor for select (max(id)) from HrmDepartment ; 
end;
/

CREATE OR REPLACE PROCEDURE HrmDepartment_Update (id_1 integer, departmentmark_2 varchar2, departmentname_3 varchar2, supdepid_4 integer, allsupdepid_5 varchar2, subcompanyid1_6 	integer, showorder_7 integer, flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor) AS 
count0 int;
count1 int;
begin
select count(*) into count0 from HrmDepartment where subcompanyid1=subcompanyid1_6 and departmentmark=departmentmark_2 and id!=id_1;
select count(*) into count1 from HrmDepartment where subcompanyid1=subcompanyid1_6 and departmentname=departmentname_3 and id!=id_1;
if count0>0 then
   flag:=2;
   msg:='�ò��ż���Ѿ����ڣ����ܱ��棡' ;
   return;
end if;  
if count1>0 then
   flag:=3;
   msg:='�ò���ȫ���Ѿ����ڣ����ܱ��棡' ;
   return;
end if; 
UPDATE HrmDepartment SET departmentmark = departmentmark_2, departmentname	= departmentname_3, supdepid = supdepid_4, allsupdepid = allsupdepid_5, subcompanyid1 = subcompanyid1_6, showorder = showorder_7 WHERE ( id	 = id_1); 
end;
/

insert into ErrorMsgIndex values (41,'���������ظ�') 
/
insert into ErrorMsgInfo values (41,'�ò��ż���Ѿ����ڣ����ܱ���',7) 
/
insert into ErrorMsgInfo values (41,'The department name duplicated',8) 
/
insert into ErrorMsgIndex values (44,'����ȫ���ظ�') 
/
insert into ErrorMsgInfo values (44,'�ò���ȫ���Ѿ����ڣ����ܱ���',7) 
/
insert into ErrorMsgInfo values (44,'The department name duplicated',8) 
/

/*td:1519 by zxf for ���Ʊ����õİ칫�ص㲻�ܱ�ɾ�� */
CREATE OR REPLACE PROCEDURE HrmLocations_Delete
(id_1 	integer,
flag out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor )
as 
count0 int;
begin
select count(*) into count0 from HrmLocations a join HrmResource b on a.id=b.locationid;
if count0>0 then
flag:=2;
msg:='�칫�ص���ʹ����';
return;
end if;
delete HrmLocations  WHERE ( id=id_1); 
end;
/

insert into ErrorMsgIndex values (42,'�칫�ص���ʹ����') 
/
insert into ErrorMsgInfo values (42,'�칫�ص���ʹ���У�����ɾ��',7) 
/
insert into ErrorMsgInfo values (42,'the site has been used',8) 
/

