

/*  �����ǹ��ڳ�Ӣ���ⲿ�û��ӿڵĵĽű�*/
   

create  table ycuser
(id integer not null,
 loginid Varchar2(60) null,
 logintype integer default(1))
/



insert into ycuser (id,loginid,logintype) values(1,'gmanager',1)
/
insert into ycuser (id,loginid,logintype) values(2,'sysadmin',1)
/

create or replace  procedure Ycuser_Insert
(id_1 integer,
 loginid_2 Varchar2,
 logintype_3 integer,
flag out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor
)
as
     
	numcount integer;

begin

select    count(*) into numcount  from ycuser where id= id_1;
if numcount =0 
then
insert into ycuser
(id,
 loginid,
 logintype)
values
(id_1,
 loginid_2,
 logintype_3);
end if ;
end;
/

create or replace procedure Ycuser_Update
(id_1 integer,
 loginid_2 varchar2,
 logintype_3 integer,
 flag out integer, 
 msg out varchar2 ,
 thecursor IN OUT cursor_define.weavercursor)

as 

begin
 update ycuser set 
 loginid = loginid_2,
 logintype = logintype_3
where 
 id = id_1;
 end;
/

create or replace procedure Ycuser_Delete
(id_1 integer,
 flag out integer ,
 msg out varchar2 ,
 thecursor IN OUT cursor_define.weavercursor
 )
as 
begin
delete ycuser
where 
 id = id_1;
end;
/

insert into HtmlLabelIndex (id,indexdesc) values (7181,'�ⲿϵͳ�û�')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (7181,'�ⲿϵͳ�û�',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (7181,'OtherSystemUser',8)
/

insert into SystemLogItem (itemid,lableid,itemdesc) values(84,7181,'�ⲿϵͳ�û�')
/

create or replace procedure Ycuser_Insert
(id_1 integer,
 loginid_2 varchar2,
 logintype_3 integer,
 flag  out integer, 
 msg out varchar2 ,
 thecursor IN OUT cursor_define.weavercursor)
as
numcount integer;
count1 integer;
begin

select   count(*) into numcount  from ycuser where id= id_1 ;
if numcount = 0 then
select  count(*) into count1  from ycuser where  loginid = loginid_2;
end if;

if count1 =0 then
	insert into ycuser
	(id,
	 loginid,
	 logintype)
	values
	(id_1,
	 loginid_2,
	 logintype_3);
else
	open thecursor for
	select 1 from dual;
end if;
end ;
/


create or replace procedure Ycuser_Update
(id_1 integer,
 loginid_2 varchar2,
 logintype_3 integer,
 flag  out integer, 
 msg out varchar2 ,
 thecursor IN OUT cursor_define.weavercursor)
as 

numcount integer;
begin
	select   count(*) into numcount   from ycuser where loginid = loginid_2 and id <> id_1;
	if numcount =0 then
		 update ycuser set 
		 loginid = loginid_2,
		 logintype = logintype_3
		where 
		 id = id_1;
	else
		open thecursor for
		select 1 from dual;
		end if;
end;
/


/*�����ǹ���̷С��ecology��Ʒ������ĿĿ¼Ȩ���Լ��༶Ŀ¼������ɾ�����ܵĽű���������ĵ���ecology��Ʒ������Ŀ¼Ȩ�޲����ύ���Ա��桷*/


/*  subcategoryid�����ϼ���Ŀ¼��������ֶ�Ϊ-1���ʾ�����ϼ�Ŀ¼����Ŀ¼
    seccategoryids����÷�Ŀ¼�µ�������Ŀ¼��id�б�ϵͳ��������Ŀ¼��ɾ����Ŀ¼��ͬʱҲ���Զ��޸�����ֶε�ֵ */
ALTER TABLE DocSubCategory  ADD
    subcategoryid integer DEFAULT -1 NOT NULL
/
ALTER TABLE DocSubCategory  ADD
    seccategoryids varchar2(500) NULL 
/
ALTER TABLE DocSecCategoryShare modify
     sharetype integer 
/


/*  �Զ�������Ŀ¼�ķ�Ŀ¼�ֶβ��ҷ�Ŀ¼�µ�������Ŀ¼������seccategoryids�ֶε�ֵ��
���������ھ�ϵͳ����������seccategoryids�ֶεĳ�ʼֵ */
create or replace PROCEDURE Doc_SetSecIdsFromOldTable 
as 
	subid_1 integer;
	secid_1 integer;
	secids_1 varchar2(500);
begin
for subcategory_cur in  ( select id from DocSubCategory )
loop
   subid_1 := subcategory_cur.id ;
   secids_1 := ' ' ; 
    for subcategory_cur in  ( select id from DocSecCategory where subcategoryid = subid_1 )
        loop
               secid_1 := subcategory_cur.id ;
               secids_1 := concat(secids_1 , concat(to_char( secid_1) , ','));
        end loop;
        if secids_1 is not null 
        then 
            secids_1 := substr(secids_1, 1, length(secids_1)-1);
        end if;
    update DocSubCategory  set seccategoryids = secids_1 where id = subid_1;
end loop ;
end;
/


/*  ȡ�÷�Ŀ¼����Ŀ¼�������ϼ���Ŀ¼id�����ƣ����ղ�ι�ϵ�Զ������� */

CREATE GLOBAL TEMPORARY TABLE temp_3
   ( orderid integer,
     subcategoryid integer, 
     subcategoryname varchar2(200))
ON COMMIT DELETE ROWS
/

create or replace PROCEDURE Doc_GetOrderedFatherSubid
    (
	mainid_1 integer, 
	categorytype_1 integer, 
	flag  out integer, 
	msg out varchar2 ,
	thecursor IN OUT cursor_define.weavercursor)
as 
	fatherid_1 integer;
	fatherid1_1 integer;
	fathername_1 varchar2(200);
	orderid_1 integer;
begin

    orderid_1 := 0;
    if  categorytype_1 = 1  then
        select subcategoryid into fatherid_1 from DocSubCategory where id = mainid_1;
    elsif categorytype_1 = 2  then
            select subcategoryid into fatherid_1 from DocSecCategory where id = mainid_1;

            if fatherid_1 is null  then 
	    fatherid_1 := -1;
            end if;

            if fatherid_1 = 0 then 
	    fatherid_1 := -1;
            end if;
    else 
    fatherid_1 := -1;
    end if;

while  fatherid_1 <> -1 
loop    
    select subcategoryid,categoryname into fatherid1_1, fathername_1 from DocSubCategory where id = fatherid_1;
    insert into temp_3 ( orderid,subcategoryid,subcategoryname) values(orderid_1, fatherid_1, fathername_1);
    fatherid_1 := fatherid1_1;
    orderid_1 := orderid_1 + 1;
end loop;
open thecursor for
select orderid, subcategoryid, subcategoryname from temp_3 order by orderid desc;
end ;
/
   



/* ��һ����Ŀ¼��id�ӵ��������ϼ���Ŀ¼��seccategoryids�б���ȥ */

CREATE or REPLACE procedure Doc_AddSecidToFather
(
secid_1 integer, 
flag out integer  , 
msg  out varchar2,
thecursor IN OUT cursor_define.weavercursor
	)
as 
fatherid_1 integer;
fatherid1_1 integer;
secid_ch_1 varchar2(10);
secids_1 varchar2(500);
begin
secid_ch_1 := to_char( secid_1) ;
select subcategoryid into fatherid_1 from DocSecCategory where id = secid_1;
if fatherid_1 is null then
fatherid_1 := -1 ;
end if;
if fatherid_1 = 0 then
fatherid_1 := -1 ; 
end if;

while fatherid_1 <> -1 loop
    select subcategoryid, seccategoryids into fatherid1_1,secids_1 from DocSubCategory where id = fatherid_1;
    if secids_1 is null then
        update DocSubCategory set seccategoryids = secid_ch_1 where id = fatherid_1;    
    elsif  instr (secids_1,secid_ch_1,1,1)=0  then    
        update DocSubCategory set seccategoryids = concat(concat(secids_1,','),secid_ch_1) where id = fatherid_1;
    end if;
    fatherid_1 := fatherid1_1 ;
end loop;
end;
/

/* ��һ����Ŀ¼��id���������ϼ���Ŀ¼��seccategoryids�б���ɾ�� */

CREATE or REPLACE  PROCEDURE Doc_DeleteSecidFromFather
        (secid_1 integer, 
        flag out integer  , 
        msg  out varchar2,
        thecursor IN OUT cursor_define.weavercursor
	)
 as 
 fatherid_1 integer;
 fatherid1_1 integer;
 secid_ch_1 varchar(10);
 secids_1 varchar(500);
begin
secid_ch_1 :=concat(concat(',',to_char(secid_1)),',');
select subcategoryid into fatherid_1 from DocSecCategory where id = secid_1;
if fatherid_1 is null then 
    fatherid_1 := -1;
end if;
if fatherid_1 = 0 then
    fatherid_1 := -1;
end if;

while fatherid_1 <> -1 loop
    select subcategoryid,seccategoryids into fatherid1_1,secids_1 from DocSubCategory where id = fatherid_1;
    if secids_1 is not null then
        secids_1 :=concat(concat(',',secids_1),',');
           if instr(secid_ch_1, secids_1) <> 0 then
                secids_1 := replace(secids_1, secid_ch_1, ',');
                if secids_1 = ',' then
                    secids_1 := ' ';
                else 
                    secids_1 := substr(secids_1, 2, length(secids_1)-2);
                end if;
                update DocSubCategory set seccategoryids = secids_1 where id = fatherid_1;
           end if;
   end if;
    fatherid_1 := fatherid1_1;
end loop;
end;
/







/* ȡ�þ���Ȩ�޵�����Ŀ¼��id�����ͣ����ƣ��ϼ�Ŀ¼id���ϼ�Ŀ¼���� */

CREATE GLOBAL TEMPORARY TABLE temp_4
 (
categoryid integer,
categorytype integer,
superdirid integer,
superdirtype integer,
categoryname varchar2(200),
orderid integer
 )
 ON COMMIT DELETE ROWS
/

CREATE or REPLACE procedure Doc_GetPermittedCategory
(
userid_1 integer,
usertype_1 integer, 
seclevel_1 integer,
operationcode_1 integer,  
flag out integer  , 
msg  out varchar2,
thecursor IN OUT cursor_define.weavercursor
)
as 
secdirid_1 integer;
secdirname_1 varchar2(200);
subdirid_1 integer;
subdirid1_1 integer;
superdirid_1 integer;
superdirtype_1 integer;
maindirid_1 integer;
subdirname_1 varchar2(200);
count_1 integer;
orderid_1 integer;
begin
if usertype_1 = 0 then
    if operationcode_1 = 0 then
        for secdir_cursor in(select id mainid, categoryname, subcategoryid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=userid_1 and usertype=usertype_1 and dirtype=2 and createdoc>0))        
        loop
            secdirid_1 := secdir_cursor.mainid;
            secdirname_1 := secdir_cursor.categoryname;
            subdirid_1 := secdir_cursor.subcategoryid;
            insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(secdirid_1, 2, subdirid_1, 1, secdirname_1, 0);
            if subdirid_1 is null then
            subdirid_1 := -1 ;
            end if;
            if subdirid_1 = 0 then
            subdirid_1 := -1 ;
            end if;
         
                while subdirid_1 <> -1 loop
                    select subcategoryid,categoryname,subcategoryid,maincategoryid into subdirid1_1,subdirname_1,superdirid_1,maindirid_1  from DocSubCategory where  id = subdirid_1 ;
                    if superdirid_1 = -1 then
                        superdirid_1 := maindirid_1 ;
                        superdirtype_1 := 0 ;        
                    else 
                        superdirtype_1 := 1 ;
                    end if;
                    count_1 := 0 ;        
                    select count(categoryid) into count_1 from temp_4 where categoryid = subdirid_1 and categorytype = 1 ;
                    if count_1 <= 0 then
                        insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(subdirid_1, 1, superdirid_1, superdirtype_1, subdirname_1, 0);
                    end if;
                    subdirid_1 := subdirid1_1 ;
                end loop;
            end loop;        
    elsif operationcode_1 = 1 then
        for secdir_cursor in (select id mainid, categoryname, subcategoryid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=userid_1 and usertype=usertype_1 and dirtype=2 and createdir>0))        
        loop
            secdirid_1 := secdir_cursor.mainid;
            secdirname_1 := secdir_cursor.categoryname;
            subdirid_1 := secdir_cursor.subcategoryid;
            insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(secdirid_1, 2, subdirid_1, 1, secdirname_1, 0);
            if subdirid_1 is null then
            subdirid_1 := -1 ;
            end if;
            if subdirid_1 = 0 then
            subdirid_1 := -1 ;
            end if;
         
            while subdirid_1 <> -1 loop
                select subcategoryid,categoryname,subcategoryid,maincategoryid into subdirid1_1,subdirname_1,superdirid_1,maindirid_1  from DocSubCategory where id = subdirid_1;
                if superdirid_1 = -1 then
                    superdirid_1 := maindirid_1 ;
                    superdirtype_1 := 0 ;        
                else 
                    superdirtype_1 := 1 ;
                end if;
                count_1 := 0 ;        
                select count(categoryid) into count_1 from temp_4 where categoryid = subdirid_1 and categorytype = 1 ;
                if count_1 <= 0 then
                    insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(subdirid_1, 1, superdirid_1, superdirtype_1, subdirname_1, 0);
                    end if;
                    subdirid_1 := subdirid1_1 ;
            end loop;
        end loop;        
    
    elsif operationcode_1 = 2 then
        for secdir_cursor in (select id mainid, categoryname, subcategoryid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=userid_1 and usertype=usertype_1 and dirtype=2 and movedoc>0))        
        loop
            secdirid_1 := secdir_cursor.mainid;
            secdirname_1 := secdir_cursor.categoryname;
            subdirid_1 := secdir_cursor.subcategoryid;
            insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(secdirid_1, 2, subdirid_1, 1, secdirname_1, 0);
            if subdirid_1 is null then
            subdirid_1 := -1 ;
            end if;
            if subdirid_1 = 0 then
            subdirid_1 := -1 ;
            end if;
         
            while subdirid_1 <> -1 loop
                select subcategoryid,categoryname,subcategoryid,maincategoryid into subdirid1_1,subdirname_1,superdirid_1,maindirid_1  from DocSubCategory where id = subdirid_1;
                if superdirid_1 = -1 then
                    superdirid_1 := maindirid_1 ;
                    superdirtype_1 := 0 ;        
                else 
                    superdirtype_1 := 1 ;
                end if;
                count_1 := 0 ;        
                select count(categoryid) into count_1 from temp_4 where categoryid = subdirid_1 and categorytype = 1 ;
                if count_1 <= 0 then
                    insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(subdirid_1, 1, superdirid_1, superdirtype_1, subdirname_1, 0);
                    end if;
                    subdirid_1 := subdirid1_1 ;
            end loop;
        end loop;        
    
    elsif operationcode_1 = 3 then
        for secdir_cursor in (select id mainid, categoryname, subcategoryid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=userid_1 and usertype=usertype_1 and dirtype=2 and copydoc>0))  
        loop
            secdirid_1 := secdir_cursor.mainid;
            secdirname_1 := secdir_cursor.categoryname;
            subdirid_1 := secdir_cursor.subcategoryid;
            insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(secdirid_1, 2, subdirid_1, 1, secdirname_1, 0);
            if subdirid_1 is null then
            subdirid_1 := -1 ;
            end if;
            if subdirid_1 = 0 then
            subdirid_1 := -1 ;
            end if;
         
            while subdirid_1 <> -1 loop
                select subcategoryid,categoryname,subcategoryid,maincategoryid into subdirid1_1,subdirname_1,superdirid_1,maindirid_1  from DocSubCategory where id = subdirid_1;
                if superdirid_1 = -1 then
                    superdirid_1 := maindirid_1 ;
                    superdirtype_1 := 0 ;        
                else 
                    superdirtype_1 := 1 ;
                end if;
                count_1 := 0 ;        
                select count(categoryid) into count_1 from temp_4 where categoryid = subdirid_1 and categorytype = 1 ;
                if count_1 <= 0 then
                    insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(subdirid_1, 1, superdirid_1, superdirtype_1, subdirname_1, 0);
                    end if;
                    subdirid_1 := subdirid1_1 ;
            end loop;
        end loop;    
    end if;

else 
    for secdir_cursor in (select id mainid, categoryname, subcategoryid from DocSecCategory where id in (select distinct dirid mainid from DirAccessControlList where dirtype=2 and operationcode=operationcode_1 and ((permissiontype=3 and seclevel<=seclevel_1) or (permissiontype=4 and usertype=usertype_1 and seclevel<=seclevel_1))))    
        loop
            secdirid_1 := secdir_cursor.mainid;
            secdirname_1 := secdir_cursor.categoryname;
            subdirid_1 := secdir_cursor.subcategoryid;
            insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(secdirid_1, 2, subdirid_1, 1, secdirname_1, 0);
            if subdirid_1 is null then
            subdirid_1 := -1 ;
            end if;
            if subdirid_1 = 0 then
            subdirid_1 := -1 ;
            end if;
         
            while subdirid_1 <> -1 loop
                select subcategoryid,categoryname,subcategoryid,maincategoryid into subdirid1_1,subdirname_1,superdirid_1,maindirid_1  from DocSubCategory where id = subdirid_1;
                if superdirid_1 = -1 then
                    superdirid_1 := maindirid_1 ;
                    superdirtype_1 := 0 ;        
                else 
                    superdirtype_1 := 1 ;
                end if;
                count_1 := 0 ;        
                select count(categoryid) into count_1 from temp_4 where categoryid = subdirid_1 and categorytype = 1 ;
                if count_1 <= 0 then
                    insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(subdirid_1, 1, superdirid_1, superdirtype_1, subdirname_1, 0);
                    end if;
                    subdirid_1 := subdirid1_1 ;
            end loop;
        end loop;  
end if;


for maindir_cursor in(select id, categoryname, categoryorder from DocMainCategory where id in (select distinct superdirid from temp_4 where superdirtype = 0))
loop
    subdirid_1 := maindir_cursor.id;
    subdirname_1 := maindir_cursor.categoryname;
    orderid_1 := maindir_cursor.categoryorder;
    insert into temp_4 (categoryid ,categorytype ,superdirid ,superdirtype ,categoryname ,orderid ) values(subdirid_1, 0, -1, -1, subdirname_1, orderid_1);
end loop;
open thecursor for 
select * from temp_4 order by orderid ;
end;
/


/* �޸ļ���Ƿ�ӵ��Ȩ�޵Ĵ洢���̣�����һ������������������ */
CREATE or REPLACE PROCEDURE Doc_DirAcl_CheckPermissionEx1
(
dirid_1 integer, 
dirtype_1 integer, 
userid_1 integer,
usertype_1 integer, 
seclevel_1 integer,
operationcode_1 integer, 
haspermission_1 in out integer 

)

AS

count_1 integer;
result integer;

begin
result := 0;

if usertype_1 = 0 then
    if operationcode_1 = 0 then
        select createdoc into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and
        userid = userid_1 and usertype = usertype_1;

    elsif operationcode_1 = 1 then
         select createdir into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and
        userid = userid_1 and usertype = usertype_1;

    elsif operationcode_1 = 2 then
        select movedoc  into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid= userid_1 and usertype = usertype_1;

    elsif operationcode_1 = 3 then
        select copydoc into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and
        userid = userid_1 and usertype = usertype_1;

    end if; 
else 
    select  count(mainid) into  count_1 from DirAccessControlList where dirid=dirid_1 and dirtype=dirtype_1 and
   operationcode=operationcode_1 and ((permissiontype=3 and seclevel<=seclevel_1) or (permissiontype=4 and
   usertype=usertype_1 and seclevel<=seclevel_1));
end if;

if  count_1 is not null then
    result := 1;
end if;

haspermission_1 := result;
end;
/

/* �����м̳��Ե�Ȩ�޼�飬���������ȼ��Ŀ¼�����Ƿ���Ȩ�ޣ���μ��������Ŀ¼�Ƿ���Ȩ�ޣ�����������ϼ���Ŀ¼�Ƿ���Ȩ�� */

create or replace PROCEDURE Doc_DirAcl_CheckPermissionEx
(
dirid_1 integer, 
dirtype_1 integer,
userid_1 integer, 
usertype_1 integer, 
seclevel_1 integer, 
operationcode_1 integer,
flag out integer  , 
msg  out varchar2,
thecursor IN OUT cursor_define.weavercursor
	) 

AS
result_1 integer;
mainid_1 integer;
fatherid_1 integer;
fatherid1_1 integer;

/* ���Ŀ¼�����Ƿ���Ȩ�� */
begin

Doc_DirAcl_CheckPermissionEx1 
(dirid_1, 
dirtype_1,
userid_1,
usertype_1,
seclevel_1,
operationcode_1, 
result_1 );

if result_1 <> 1 then
    
       /* ȡ���ϼ�Ŀ¼ */
    if dirtype_1 = 1 then
        select  subcategoryid into fatherid_1 from DocSubCategory where id = dirid_1;
    elsif dirtype_1 = 2 then
        select  subcategoryid into fatherid_1 from DocSecCategory where id = dirid_1;
        if fatherid_1 is null then
            fatherid_1 := -1;
         end if;
        if fatherid_1 = 0 then
            fatherid_1 := -1;
        end if;
    else 
        fatherid_1 := -1;
   end if;
    /* �����Ŀ¼�Ƿ���Ȩ�� */
    if dirtype_1 = 1 then
       select  maincategoryid into mainid_1 from DocSubCategory where id = dirid_1;
       Doc_DirAcl_CheckPermissionEx1 (mainid_1, 0, userid_1, usertype_1, seclevel_1, operationcode_1, result_1); 
       if result_1=1 then
           fatherid_1 := -1;
       end if;
    end if; 
elsif dirtype_1 = 2 and fatherid_1 <> -1 then
       select  maincategoryid into mainid_1 from DocSubCategory where id = fatherid_1;
       Doc_DirAcl_CheckPermissionEx1 (mainid_1, 0, userid_1, usertype_1, seclevel_1, operationcode_1, result_1); 
       if result_1=1 then
           fatherid_1 := -1;
       end if;
    
    /* ���¶������μ�������Ŀ¼�Ƿ���Ȩ�� */
    while fatherid_1 <> -1 loop
        Doc_DirAcl_CheckPermissionEx1(fatherid_1, 1, userid_1, usertype_1, seclevel_1, operationcode_1, result_1);
        if result_1 <> 1 then
            select  subcategoryid into fatherid1_1 from DocSubCategory where id = fatherid_1;
            fatherid_1 := fatherid1_1;
       
        else 
            fatherid_1 := -1;
        end if;
    end loop; 
end if;

open thecursor for 
select result_1 result from dual;

end;
/





/* ������ִ��proc.sql���������ھ�ϵͳ����ʱʹ�� */
call Doc_SetSecIdsFromOldTable()
/





/* ���ǹ���������Ĺ����ƻ��ύ���Ա���Ľű�   
  \sql\for SQLServer\yangguosheng\proc_2003-06-16.sql
\sql\for SQLServer\yangguosheng\table_2003-06-16.sql  */




alter table WorkPlan modify (  description  varchar2(4000))
/



create or replace  PROCEDURE WorkPlan_Insert 
	(type_n_1  char    ,
	name_1  varchar2    ,
	resourceid_1  varchar2   ,
	begindate_1  char    ,
	begintime_1  char    ,
	enddate_1  char   ,
	endtime_1  char    ,	
	color_1 char   ,
	description_1  Varchar2    ,
	requestid_1  varchar2    ,
	projectid_1  varchar2   ,
	crmid_1  varchar2   ,
	docid_1 varchar2   ,
	meetingid_1  varchar2   ,
	status_1  char  ,
	isremind_1 integer  ,
	waketime_1 integer   ,	
	createrid_1 integer   ,
	createdate_1 char    ,
	createtime_1 char ,
	deleted_1 char   ,
	flag out integer  , 
    msg  out varchar2,
    thecursor IN OUT cursor_define.weavercursor
	) 
AS 
begin
INSERT INTO WorkPlan 
	(type_n ,
	name  ,
	resourceid ,
	begindate ,
	begintime ,
	enddate ,
	endtime  ,
	color ,
	description ,
	requestid  ,
	projectid ,
	crmid  ,
	docid  ,
	meetingid ,
	status  ,
	isremind  ,
	waketime  ,	
	createrid  ,
	createdate  ,
	createtime ,
	deleted
    ) 
VALUES 
	(type_n_1 ,
	name_1  ,
	resourceid_1 ,
	begindate_1 ,
	begintime_1 ,
	enddate_1 ,
	endtime_1  ,
	color_1 ,
	description_1 ,
	requestid_1  ,
	projectid_1 ,
	crmid_1  ,
	docid_1  ,
	meetingid_1 ,
	status_1  ,
	isremind_1  ,
	waketime_1  ,	
	createrid_1  ,
	createdate_1  ,
	createtime_1 ,
	deleted_1 );
open thecursor for
select * from (select * from   WorkPlan order by id desc ) where rownum =1;
end;
/

create or replace  PROCEDURE WorkPlan_Update
	(
	id_1 	integer ,	
	type_n_1  char   ,
	name_1  varchar2   ,
	resourceid_1  varchar2   ,
	begindate_1  char  ,
	begintime_1  char   ,
	enddate_1  char   ,
	endtime_1  char   ,	
	color_1 char  ,
	description_1  varchar2    ,
	requestid_1  varchar2    ,
	projectid_1  varchar2   ,
	crmid_1  varchar2   ,
	docid_1  varchar2    ,
	meetingid_1  varchar2   ,
	isremind_1 integer,
	waketime_1 integer   ,	
	flag out integer  , 
    msg  out varchar2,
    thecursor IN OUT cursor_define.weavercursor
	) 

AS 
begin  
UPDATE WorkPlan
set
	 type_n = type_n_1,
	 name = name_1 ,
	 resourceid = resourceid_1,
	 begindate = begintime_1,
	 enddate = enddate_1 ,
	 endtime = endtime_1,
	 color = color_1 ,
	 description = description_1, 
	 requestid = requestid_1 ,
	 projectid = projectid_1 ,
	 crmid = crmid_1 ,
	 docid = docid_1 ,
	 meetingid = meetingid_1 ,
	 isremind = isremind_1 ,
	 waketime = waketime_1  
where id = id_1 ;

end;

/



/*�����ǳ�Ӣ�ܵ�������Դ����ʱ��ά���������ύ���Ա���Ľű�*/


create or replace  procedure SequenceIndexRes_Init

as 

id_1 integer; 
resid_2 integer;
curid_3 integer;

begin

select max(id) into  id_1 from HrmResource;
select  max(id) into resid_2 from HrmCareerApply;
if resid_2 is null then
    resid_2 := 0;
end if;
if id_1 is null then 
    id_1 := 0;
end if;
if( id_1>resid_2) then
    curid_3:= concat(id_1,1);
else 
    curid_3 := concat(resid_2,1);
end if;
update SequenceIndex set currentid = curid_3 where indexdesc='resourceid';

end;
/

call SequenceIndexRes_Init()
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values(3050,'������Դʱ�����','HrmResourceScheduleCopy:Copy',36)
/

 
/*��������������ڡ�ecology��Ʒ�������������ñ����������������ύ���Ա��桷�Ľű�*/
update workflow_browserurl set 
browserurl = '/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp?sqlwhere=where feetype=to_char(1)' where tablename = 'FnaBudgetfeeType' 
/





