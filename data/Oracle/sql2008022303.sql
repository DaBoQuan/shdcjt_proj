/* 增加一个用户-资源访问许可（仅限存储过程调用） */
CREATE OR REPLACE PROCEDURE Doc_DirAccessPermission_Insert
(
dirid_1 integer,
dirtype_1 integer, 
userid_1 integer,
usertype_1 integer,
operationcode_1 integer)
AS
count_1 integer;
count_num integer;
begin


if operationcode_1 = 0 then

  select count(createdoc) into count_num from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
  if count_num =0 then
      insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(dirid_1, dirtype_1, userid_1, usertype_1, 1, 0, 0, 0);
  else
      select createdoc into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
      update DirAccessPermission set createdoc = (count_1+1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
      end if;

elsif operationcode_1 = 1 then

    select count(createdir) into count_num  from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
    if count_num =0 then
        insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(dirid_1, dirtype_1, userid_1, usertype_1, 0, 1, 0, 0);
    else
        select createdir into count_1  from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
        update DirAccessPermission set createdir = (count_1+1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
        end if;
        
elsif operationcode_1 = 2 then
    select count(movedoc) into count_num  from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
    if count_num =0 then
        insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(dirid_1, dirtype_1, userid_1, usertype_1, 0, 0, 1, 0);
    else
        select movedoc into count_1  from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
        update DirAccessPermission set movedoc = (count_1+1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
        end if;

elsif operationcode_1 = 3 then
    select  count(copydoc) into count_num  from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
    if count_num =0 then
        insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(dirid_1, dirtype_1, userid_1, usertype_1, 0, 0, 0, 1);
    else
        select  copydoc into count_1  from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
        update DirAccessPermission set copydoc = (count_1+1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
        end if;
end if;
end;
/
CREATE OR REPLACE PROCEDURE Doc_DirAccessPermission_Delete
(
dirid_1 integer,
dirtype_1 integer, 
userid_1 integer,
usertype_1 integer,
operationcode_1 integer)
AS

count_1 integer;
count_num integer;
begin

if operationcode_1 = 0 then
  select count(createdoc) into count_num from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
  if  (count_num > 0)  then    
    select createdoc into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
    if (count_1 >0) then
    update DirAccessPermission set createdoc = (count_1-1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
    end if;
  end if;

elsif operationcode_1 = 1 then
  select count(createdir) into count_num from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
  if  (count_num >0 )  then
    select createdir into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
    if( count_1 >0) then
    update DirAccessPermission set createdir = (count_1-1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
    end if;
  end if;

elsif operationcode_1 = 2 then
  select count(movedoc) into count_num from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
  if  (count_num > 0 )  then
    select movedoc into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
    if( count_1 >0) then
    update DirAccessPermission set movedoc = (count_1-1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
    end if;
  end if;

elsif operationcode_1 = 3 then
  select  count(copydoc) into count_num from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
  if  (count_num >0)  then
    select  copydoc into count_1 from DirAccessPermission where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1 and rownum =1;
    if( count_1 >0) then
    update DirAccessPermission set copydoc = (count_1-1) where dirid = dirid_1 and dirtype = dirtype_1 and userid = userid_1 and usertype = usertype_1;
    end if;
  end if;

end if;
end;
/
