create table DocDetailContent (
docid integer primary key ,
doccontent clob
)
/

insert into DocDetailContent(docid, doccontent) select id , doccontent from docdetail 
/

alter table DocDetail drop column doccontent
/


create GLOBAL TEMPORARY TABLE TM_DocShareDetail_User
( userid integer,
  usertype integer,
  sharelevel integer ) 
ON COMMIT DELETE ROWS
/

CREATE or replace PROCEDURE DocShareDetail_SetByDoc
(
docid_1  integer ,
createrid_2  integer , 
owenerid_3  integer , 
usertype_4  integer , 
replydocid_5  integer , 
departmentid_6  integer , 
subcompanyid_7  integer ,
managerid_8 integer ,
considermanager_9 integer ,
flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor
) 
AS 
recordercount integer ;
allmanagerid varchar2(255);
tempuserid integer;
tempsharelevel integer ;
tempsharetype integer ;
sepindex integer ;		/* �������ڵ�λ�� */

begin

    /* ����ǻظ�ĳһ���ĵ��Ļظ��ĵ�����ԭ�ĵ��Ĺ�����뱾�ظ��ĵ��Ĺ��� */
    if replydocid_5 != 0 then
        insert into TM_DocShareDetail_User(userid,usertype,sharelevel) 
        select userid,usertype,sharelevel from DocShareDetail where docid = replydocid_5 ;
    end if ;

    /* �����ڲ��û� */
    if usertype_4 = 1  then
        /* �ĵ��Ĵ����ߺ������߾��б༭��Ȩ�� */
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=createrid_2 and usertype = 1 ;
        if recordercount = 0 then
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(createrid_2,1,2) ;
        else 
            update TM_DocShareDetail_User set sharelevel = 2 where userid=createrid_2 and usertype = 1 ;
        end if ;
        
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=owenerid_3 and usertype = 1 ;
        if recordercount = 0 then
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(owenerid_3,1,2) ;
        else 
            update TM_DocShareDetail_User set sharelevel = 2 where userid=owenerid_3 and usertype = 1 ;
        end if ;
        
        /* �����Ҫ�������о��������ߣ������ϼ������в鿴Ȩ�� */
        if considermanager_9 = 1 then
            select concat(managerstr,'0') into allmanagerid  from HrmResource where id = createrid_2  ;
            sepindex := instr(allmanagerid , ',', 1, 1) ;
            
            while  sepindex != 0 LOOP
                tempuserid := TO_NUMBER(SUBSTR(allmanagerid,1,sepindex-1)) ;
                allmanagerid := SUBSTR(allmanagerid,sepindex+1) ;
                sepindex := instr(allmanagerid , ',', 1, 1) ;

                select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=tempuserid and usertype = 1 ;
                if recordercount = 0 then
                    insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(tempuserid,1,1) ;
                end if ;
            end LOOP;
            
            if owenerid_3 != createrid_2 then
                select concat(managerstr,'0') into allmanagerid  from HrmResource where id = owenerid_3  ;
                sepindex := instr(allmanagerid , ',', 1, 1) ;
                
                while  sepindex != 0 LOOP
                    tempuserid := TO_NUMBER(SUBSTR(allmanagerid,1,sepindex-1)) ;
                    allmanagerid := SUBSTR(allmanagerid,sepindex+1) ;
                    sepindex := instr(allmanagerid , ',', 1, 1) ;

                    select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=tempuserid and usertype = 1 ;
                    if recordercount = 0 then
                        insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(tempuserid,1,1) ;
                    end if ;
                end LOOP;
            end if ;
        end if ;
    /* �����ⲿ�û� */
    else  
        /* �ĵ��Ĵ����ߣ��ͻ����ʹ����ߣ��ͻ����ľ�����б༭��Ȩ�� */
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=createrid_2 and usertype = 9 ;
        if recordercount = 0 then 
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(createrid_2,9,2) ;
        else 
            update TM_DocShareDetail_User set sharelevel = 2 where userid=createrid_2 and usertype = 9 ;
        end if ;
        
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=managerid_8 and usertype = 1 ;
        if recordercount = 0 then 
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(managerid_8,1,2) ;
        else 
            update TM_DocShareDetail_User set sharelevel = 2 where userid=managerid_8 and usertype = 1 ;
        end if ;
        
        /* �����Ҫ�������о��������ߣ������ϼ������в鿴Ȩ�� */
        if considermanager_9 = 1 then
            select concat(managerstr,'0') into allmanagerid  from HrmResource where id = managerid_8  ;
            sepindex := instr(allmanagerid , ',', 1, 1) ;
            
            while  sepindex != 0 LOOP
                tempuserid := TO_NUMBER(SUBSTR(allmanagerid,1,sepindex-1)) ;
                allmanagerid := SUBSTR(allmanagerid,sepindex+1) ;
                sepindex := instr(allmanagerid , ',', 1, 1) ;

                select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=tempuserid and usertype = 1 ;
                if recordercount = 0 then
                    insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(tempuserid,1,1) ;
                end if ;
            end LOOP;
        end if ;
    end if ;

    /* �ĵ�������Ϣ (�ڲ��û�) ���漰��ɫ���� */
    for shareuserid_cursor IN (
    select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2 where  t1.loginid is not null and t2.docid = docid_1 and ( (t2.foralluser=1 and t2.seclevel<=t1.seclevel)  or ( t2.userid= t1.id ) or (t2.departmentid=t1.departmentid and t2.seclevel<=t1.seclevel)) )
    loop
        tempuserid := shareuserid_cursor.id;
        tempsharelevel := shareuserid_cursor.sharelevel;
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=tempuserid and usertype = 1 ;
        if recordercount = 0  then 
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(tempuserid,1,tempsharelevel) ;
        else 
            if tempsharelevel = 2 then
                update TM_DocShareDetail_User set sharelevel = 2 where userid=tempuserid and usertype = 1 ;
            end if ;
        end if ;
    end loop ;

    /* �ĵ�������Ϣ (�ڲ��û�) �漰��ɫ���� */
    for shareuserid_cursor IN (
    select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2,  HrmRoleMembers  t3 where  t1.loginid is not null and t2.docid = docid_1 and (  t3.resourceid=t1.id and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and ( (t3.rolelevel=2) or (t3.rolelevel=0  and t1.departmentid=departmentid_6) or (t3.rolelevel=1 and t1.subcompanyid1=subcompanyid_7) ) ) )
    loop
        tempuserid := shareuserid_cursor.id;
        tempsharelevel := shareuserid_cursor.sharelevel;
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=tempuserid and usertype = 1 ;
        if recordercount = 0 then 
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(tempuserid,1,tempsharelevel) ;
        else 
            if tempsharelevel = 2 then 
                update TM_DocShareDetail_User set sharelevel = 2 where userid=tempuserid and usertype = 1 ;
            end if ;
        end if ;
    end loop ;

    /* �ĵ�������Ϣ �ⲿ�û� ( ���� ) */
    for shareuserid_cursor IN (
    select distinct sharetype , seclevel, sharelevel from DocShare where sharetype < 0 and docid = docid_1 )
    loop
        tempsharetype := shareuserid_cursor.sharetype;
        tempuserid := shareuserid_cursor.seclevel;
        tempsharelevel := shareuserid_cursor.sharelevel;
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=tempuserid and usertype = tempsharetype ;
        if recordercount = 0 then 
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(tempuserid,tempsharetype,tempsharelevel) ;
        else 
            if tempsharelevel = 2 then
                update TM_DocShareDetail_User set sharelevel = 2 where userid=tempuserid and usertype = tempsharetype ;
            end if ;
        end if ;
    end loop ;

    /* �ĵ�������Ϣ �ⲿ�û� ( �û�id ) */
    for shareuserid_cursor IN (
    select distinct crmid , sharelevel from DocShare where crmid <> 0 and sharetype = '9' and docid = docid_1 )
    loop
        tempuserid := shareuserid_cursor.crmid;
        tempsharelevel := shareuserid_cursor.sharelevel;
        select count(sharelevel) into recordercount  from TM_DocShareDetail_User where userid=tempuserid and usertype = 9 ;
        if recordercount = 0 then 
            insert into TM_DocShareDetail_User(userid,usertype,sharelevel) values(tempuserid,9,1) ;
        else 
            if tempsharelevel = 2 then 
                update TM_DocShareDetail_User set sharelevel = 2 where userid=tempuserid and usertype = 9 ;
            end if ;
        end if ;
    end loop ;

    /* ����ʱ���е�����д�빲��� */
    delete docsharedetail where docid = docid_1 ;
    insert into docsharedetail (docid,userid,usertype,sharelevel) 
        select docid_1 , userid,usertype,sharelevel from TM_DocShareDetail_User ;
end ;
/
