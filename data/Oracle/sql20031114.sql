/*
Date 2003-11-05
Author �����
Remark CRM��ͬ�з���ʱ�ɼ�¼���������Լ����뷢�����տ�ʱ��Ʊ�ݺ�
*/
CREATE TABLE CRM_ContractProInfo (
    id integer  NOT NULL ,
    proId integer NULL ,
    factNum integer NULL ,
    factDate char (10)  NULL ,
    formNum varchar2 (150)  NULL ,
    creater integer NULL 
)
/
create sequence CRM_ContractProInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger CRM_ContractProInfo_Trigger
before insert on CRM_ContractProInfo
for each row
begin
select CRM_ContractProInfo_id.nextval into :new.id from dual;
end;
/

CREATE or REPLACE PROCEDURE CRM_ContractProInfo_Insert 
	(
     proId_1 	integer,
     factNum_1 	integer,
	 factDate_1 	char,
     formNum_1   varchar2 ,
	 creater_1 	integer ,      
	 flag out integer, 
	 msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor
     )

AS 
begin
INSERT INTO CRM_ContractProInfo (proId,factNum,factDate,formNum,creater)
VALUES ( proId_1, factNum_1, factDate_1, formNum_1, creater_1 );
end;
/

CREATE or REPLACE PROCEDURE CRM_ContractProInfo_Select 
	(
     proId_1 	integer,
     flag out integer, 
	 msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor
     )

AS 
begin
open thecursor for
SELECT * FROM CRM_ContractProInfo WHERE proId = proId_1;
end;
/

CREATE or REPLACE PROCEDURE CRM_ContractProInfo_Update 
	(
     id_1 	integer,
     factNum_1 	integer,
	 factDate_1 	char,
     formNum_1   varchar2 ,
     creater_1 	integer ,    
     flag out integer, 
	 msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor
     )

AS
begin
UPDATE CRM_ContractProInfo set factNum = factNum_1 , factDate = factDate_1 , formNum = formNum_1 , 
creater = creater_1 WHERE id = id_1;
end;
/

CREATE or REPLACE PROCEDURE CRM_ContractProInfo_Del 
	(
     id_1 	integer,
     flag out integer, 
	 msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor
     )
AS 
begin
DELETE CRM_ContractProInfo WHERE id = id_1;
end;
/

CREATE or REPLACE PROCEDURE CRM_ContractProInfo_CountNum 
	(
     proId_1 integer,
     flag out integer, 
	 msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor
     )

AS
begin
open thecursor for
SELECT sum(factNum) FROM CRM_ContractProInfo WHERE proId = proId_1;
end;
/


ALTER TABLE CRM_Contract ADD department integer
/
ALTER TABLE CRM_Contract ADD subcompanyid1 integer 
/

/* ���� */

CREATE or REPLACE PROCEDURE ContractUpdateDepSub 
As
contractid_1 integer;
managerid_1 integer;
departmentid_1 integer;
subid_1 integer;
begin
for sharecontractid_cursor in
(select id,manager from CRM_Contract) 
loop
        select subcompanyid1 into subid_1 from HrmResource
         where id=managerid_1;
        select departmentid into departmentid_1 from HrmResource
         where id=managerid_1;  
        update CRM_Contract set department=departmentid_1, subcompanyid1=subid_1 where id=contractid_1;
end loop;
end;
/

call ContractUpdateDepSub()
/
drop PROCEDURE ContractUpdateDepSub 
/


ALTER TABLE CRM_PayInfo ADD formNum varchar2(150) 
/


CREATE or REPLACE  PROCEDURE CRM_PayInfo_Insert
	(id_1		integer,
	factprice_1	number,
	factdate_1 char,
	creater_1 integer,
    formNum_1   varchar2 ,
	flag out integer,
	msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)
as
begin
	insert into CRM_PayInfo
	(payid,factprice,factdate,creater,formNum)
	values
	(	id_1,factprice_1,	factdate_1 ,creater_1 ,formNum_1);
end;
/


CREATE or REPLACE  PROCEDURE CRM_PayInfo_update
	(id_1		integer,
	factprice_1	number,
	factdate_1 char,
	creater_1 integer,
    formNum_1   varchar2,
	flag out integer, 
	msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor
    )
as
begin
	update  CRM_PayInfo set
	factprice=factprice_1,
	factdate=factdate_1,
	creater=creater_1,
    formNum=formNum_1 
	WHERE id=id_1;
end;
/

CREATE TABLE Contract_ShareInfo (
	id integer  NOT NULL ,
    relateditemid integer NULL ,
	sharetype smallint NULL ,
	seclevel smallint NULL ,
	rolelevel smallint NULL ,
	sharelevel smallint NULL ,
	userid integer NULL ,
	departmentid integer NULL ,
	roleid integer NULL ,
	foralluser smallint NULL ,
	crmid integer NULL 
)
/
create sequence Contract_ShareInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Contract_ShareInfo_Trigger
before insert on Contract_ShareInfo
for each row
begin
select Contract_ShareInfo_id.nextval into :new.id from dual;
end;
/


CREATE or REPLACE PROCEDURE Contract_ShareInfo_Del 
(id_1 integer, 
flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
DELETE from Contract_ShareInfo  WHERE ( id = id_1);
end;
/

CREATE or REPLACE PROCEDURE Contract_ShareInfo_Ins (
relateditemid_1 integer, 
sharetype_1 smallint, 
seclevel_1  smallint, 
rolelevel_1 smallint, 
sharelevel_1 smallint, 
userid_1 integer, 
departmentid_1 integer, 
roleid_1 integer, 
foralluser_1 smallint, 
flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
INSERT INTO Contract_ShareInfo 
( relateditemid, sharetype, seclevel, rolelevel, sharelevel, userid, departmentid, roleid, foralluser ) 
VALUES ( relateditemid_1, sharetype_1 ,seclevel_1 , rolelevel_1 , sharelevel_1, userid_1, departmentid_1,
roleid_1, foralluser_1 );
flag:=1;
msg:='ok';
end;
/

CREATE or REPLACE PROCEDURE Contract_ShareInfo_SByCID 
(relateditemid_1 integer , 
flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor
) 
AS 
begin
open thecursor for
select * from Contract_ShareInfo where (relateditemid = relateditemid_1 );
end;
/


CREATE TABLE ContractShareDetail (
	contractid integer NULL ,
	userid integer NULL ,
	usertype integer NULL ,
	sharelevel integer NULL 
) 
/

CREATE or REPLACE PROCEDURE ContractShareDetail_Insert (
contractid_1 	integer, 
userid_2 	integer,
usertype_3 	integer, 
sharelevel_4 	integer, 
flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
INSERT INTO ContractShareDetail 
(contractid, userid, usertype, sharelevel) 
VALUES(contractid_1, userid_2, usertype_3, sharelevel_4);
end;
/

CREATE or REPLACE PROCEDURE ContractShareDetail_DById (
contractid_1 	integer ,
flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
DELETE ContractShareDetail WHERE ( contractid= contractid_1) ;
end;
/


insert into SystemRights (id,rightdesc,righttype) values (396,'�ͻ���ͬ����','0') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (396,7,'�ͻ���ͬ����','�ͻ���ͬ����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (396,8,'','') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3085,'�ͻ���ͬ����','CRM_Contract:Manage',396) 
/

/* ����ͻ���ͬ����Ա�Ľ�ɫ */

CREATE or REPLACE PROCEDURE HrmRolesAddContract 
As
roleid_1 integer;
begin
insert into HrmRoles (rolesmark,rolesname,docid) values ('�ͻ���ͬ����Ա','�ͻ���ͬ����Ա','');
select max(id) into roleid_1 from HrmRoles; 
delete SystemRightRoles where roleid = roleid_1;
insert into SystemRightRoles (rightid,roleid,rolelevel) values (396,roleid_1,'0');
end;
/

call HrmRolesAddContract()
/
drop PROCEDURE HrmRolesAddContract 
/
CREATE GLOBAL TEMPORARY TABLE temptablevaluecontract
 (contractid  integer,
 sharelevel integer)
 ON COMMIT DELETE ROWS
/





CREATE or REPLACE  TRIGGER Tri_Update_HrmresourceShare 
after  update  ON Hrmresource 
FOR each row

Declare resourceid_1 integer;
		subresourceid_1 integer;
		supresourceid_1 integer;
		olddepartmentid_1 integer;
		departmentid_1 integer;
		subcompanyid_1 integer;
		oldseclevel_1	 integer;
		seclevel_1	 integer;
		docid_1	 integer;
		crmid_1	 integer;
		prjid_1	 integer;
		cptid_1	 integer;
		sharelevel_1  integer;
		countrec      integer;
		oldmanagerstr_1    varchar2(200);
		managerstr_1    varchar2(200);
		managerstr_11 varchar2(200) ;
		mainid_1	integer;
		subid_1	integer;
		secid_1	integer;
		members_1 varchar2(200);
         contractid_1	 integer; /*2003-11-06�����*/
        contractroleid_1 integer ;   /*2003-11-06�����*/
        sharelevel_Temp integer; /*2003-11-06�����*/

begin
        
/* �Ӹ��޸ĵ����в����޸ĵ�resourceid �� */

 olddepartmentid_1 := :old.departmentid;
 oldseclevel_1 := :old.seclevel ; 
 oldmanagerstr_1 := :old.managerstr;
 resourceid_1 := :new.id ;
 departmentid_1 := :new.departmentid;
 subcompanyid_1 := :new.subcompanyid1;
 seclevel_1 := :new.seclevel ; 
 managerstr_1 := :new.managerstr;

if seclevel_1 is not null then
update HrmResource_Trigger set
seclevel =seclevel_1 
where id =resourceid_1;
end if;


if ( departmentid_1 is not null ) then
update HrmResource_Trigger set 
departmentid =departmentid_1
where id =resourceid_1;
end if;

if (  managerstr_1 is not null) then
update HrmResource_Trigger set
managerstr =managerstr_1
where id =resourceid_1;
end if;

if subcompanyid_1 is not null then
update HrmResource_Trigger set
subcompanyid1 =subcompanyid_1 
where id =resourceid_1;
end if;




/* ������źͰ�ȫ������Ϣ���޸�(���½���ʱ����������Ϣ�϶����޸�) */
  
if ( departmentid_1 <>olddepartmentid_1 or  seclevel_1 <> oldseclevel_1 or oldseclevel_1 is null )  then   
 
    if departmentid_1 is null   then
	departmentid_1 := 0;
	end if;
    if subcompanyid_1 is null   then
	subcompanyid_1 := 0;
	end if;


    /* �޸�Ŀ¼��ɱ� */
    if ((olddepartmentid_1 is not null) and (oldseclevel_1 is not null)) then
        Doc_DirAcl_DUserP_BasicChange (resourceid_1, olddepartmentid_1, oldseclevel_1);
    end if;
    if ((departmentid_1 is not null) and (seclevel_1 is not null)) then
        Doc_DirAcl_GUserP_BasicChange (resourceid_1, departmentid_1, seclevel_1);
    end if;


    /* �����½��ĵ�Ŀ¼���б� */
    


	delete from DocUserCategory where userid= resourceid_1 and usertype= '0';

	for all_cursor in(
	select distinct t1.id t1id from docseccategory t1,HrmResource_Trigger t2,hrmrolemembers t5
	where t1.cusertype='0' and t2.id= resourceid_1 
	and(( t2.seclevel>= t1.cuserseclevel) 
	or( t2.seclevel >= t1.cdepseclevel1 and t2.departmentid=t1.cdepartmentid1) 
	or( t2.seclevel >= t1.cdepseclevel2 and t2.departmentid=t1.cdepartmentid2) 
	or( t5.roleid=t1.croleid1 and t5.rolelevel=t1.crolelevel1 and t2.id=t5.resourceid )
	or( t5.roleid=t1.croleid2 and t5.rolelevel=t1.crolelevel2 and t2.id=t5.resourceid )
	or( t5.roleid=t1.croleid3 and t5.rolelevel=t1.crolelevel3 and t2.id=t5.resourceid ))
	)
	loop
		secid_1 := all_cursor.t1id;
		select  subcategoryid INTO subid_1 from docseccategory where id=secid_1;
		select  maincategoryid INTO mainid_1 from docsubcategory where id=subid_1;
		insert into  docusercategory (secid,mainid,subid,userid,usertype)
		values (secid_1,mainid_1,subid_1,resourceid_1,'0');
	end loop;

    /* DOC ����*/
	
    /* ɾ��ԭ�еĸ��˵������ĵ�������Ϣ */
	delete from DocShareDetail where userid = resourceid_1 and usertype = 1;



    /*  �����е���Ϣ�ַŵ� temptablevalue �� */
    /*  �Լ������Ļ����� owner �����¿��Ա༭ */
    for docid_cursor IN (select distinct id from DocDetail where ( doccreaterid = resourceid_1 or ownerid = resourceid_1 ) and usertype= '1')
	loop
	docid_1 := docid_cursor.id;
	insert into temptablevalue values(docid_1, 2);
	end loop;




    /* �Լ��¼����ĵ� */
    /* �����¼� */
 
     managerstr_11 := concat( concat('%,' , to_char(resourceid_1)) , ',%'); 

    for subdocid_cursor IN ( select distinct id from DocDetail where ( doccreaterid in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) or ownerid in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ) and usertype= '1')
	loop
	docid_1 :=subdocid_cursor.id;
	     select  count(docid) INTO countrec  from temptablevalue where docid = docid_1;
        if countrec = 0 then
		insert into temptablevalue values(docid_1, 1);
		end if;
	end loop;
         


    /* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
    for  sharedocid_cursor IN (select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= seclevel_1 )  or ( userid= resourceid_1 ) or (departmentid= departmentid_1 and seclevel<= seclevel_1 ))
	loop 
	docid_1:=sharedocid_cursor.docid;
	sharelevel_1 :=sharedocid_cursor.sharelevel;
        select  count(docid) INTO countrec  from temptablevalue where docid = docid_1  ;
        if countrec = 0  then        
            insert into temptablevalue values(docid_1, sharelevel_1);        
        else if sharelevel_1 = 2  then        
            update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */ end if;  
        end if;
	end loop;
    


    for sharedocid_cursor IN (select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.docid and t3.resourceid= resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= departmentid_1 ) or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= subcompanyid_1 ) or (t3.rolelevel=2) ))
    loop
	docid_1 :=sharedocid_cursor.docid;
	sharelevel_1 :=sharedocid_cursor.sharelevel;
	select  count(docid) INTO countrec  from temptablevalue where docid = docid_1  ;
        if countrec = 0  then
        
            insert into temptablevalue values(docid_1, sharelevel_1);
        
        else if sharelevel_1 = 2  then        
            update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */ end if;  
        end if;
	end loop;


 



    /* ����ʱ���е�����д�빲��� */
    for alldocid_cursor IN (select * from temptablevalue)
	loop
	docid_1 :=alldocid_cursor.docid;
	sharelevel_1 := alldocid_cursor.sharelevel;
	insert into docsharedetail values(docid_1, resourceid_1,1,sharelevel_1);
	end loop;
    



    /* ------- CRM  ���� ------- */


    /* ɾ��ԭ�еĸ��˵����пͻ�������Ϣ */
	delete from CrmShareDetail where userid = resourceid_1 and usertype = 1;



    /*  �����е���Ϣ�ַŵ� temptablevaluecrm �� */
    /*  �Լ��� manager �Ŀͻ� 2 */
    for crmid_cursor IN (select id from CRM_CustomerInfo where manager = resourceid_1 )
	loop
	crmid_1 :=crmid_cursor.id;
	insert into temptablevaluecrm values(crmid_1, 2);
	end loop;
    

    /* �Լ��¼��Ŀͻ� 3 */
    /* �����¼� */
     
     managerstr_11 := concat( concat('%,' , to_char(resourceid_1)) , ',%' );

    for subcrmid_cursor IN (select id from CRM_CustomerInfo where ( manager in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ))
	loop
	crmid_1 :=subcrmid_cursor.id;
        select count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1;
        if countrec = 0 then
		insert into temptablevaluecrm values(crmid_1, 3);
		end if;
	end loop;
    

 
    /* ��Ϊcrm����Ա�ܿ����Ŀͻ� */
    for rolecrmid_cursor IN (   select distinct t1.id from CRM_CustomerInfo  t1, hrmrolemembers  t2  where t2.roleid=8 and t2.resourceid= resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
	loop
	crmid_1:=rolecrmid_cursor.id;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1;
        if countrec = 0 then
		insert into temptablevaluecrm values(crmid_1, 4);
		end if;
	end loop;




    /* �ɿͻ��Ĺ����õ�Ȩ�� 1 2 */
    for sharecrmid_cursor IN (select distinct t2.relateditemid , t2.sharelevel from CRM_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	crmid_1 := sharecrmid_cursor.relateditemid;
	 sharelevel_1:=sharecrmid_cursor.sharelevel;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1 ; 
        if countrec = 0  then
        
            insert into temptablevaluecrm values(crmid_1, sharelevel_1);
        end if;
	end loop;
    




    for sharecrmid_cursor IN (   select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and t3.resourceid=resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=seclevel_1 and ( (t2.rolelevel=0  and t1.department=departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) ) 
    )
	loop
	crmid_1 :=sharecrmid_cursor.relateditemid;
	sharelevel_1 :=sharecrmid_cursor.sharelevel;
        select count(crmid) INTO countrec from temptablevaluecrm where crmid = crmid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluecrm values(crmid_1, sharelevel_1);
        end if;
	end loop;



    /* ����ʱ���е�����д�빲��� */
    for allcrmid_cursor IN (select * from temptablevaluecrm)
	loop
	crmid_1 :=allcrmid_cursor.crmid;
	sharelevel_1 := allcrmid_cursor.sharelevel;
	insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(crmid_1, resourceid_1,1,sharelevel_1);
	end loop;





    /* ------- PROJ ���� ------- */



    /*  �����е���Ϣ�ַŵ� temptablevaluePrj �� */
    /*  �Լ�����Ŀ2 */
    for prjid_cursor IN (select id from Prj_ProjectInfo where manager = resourceid_1 )
	loop
	prjid_1:=prjid_cursor.id;
	insert into temptablevaluePrj values(prjid_1, 2);
	end loop;
    



    /* �Լ��¼�����Ŀ3 */
    /* �����¼� */
     
     managerstr_11 :=  concat(concat('%,' , to_char(resourceid_1)) , ',%' );

    for subprjid_cursor IN (select id from Prj_ProjectInfo where ( manager in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ))
	loop
	prjid_1 :=subprjid_cursor.id;
        select  count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1;
        if countrec = 0 then
		insert into temptablevaluePrj values(prjid_1, 3);
		end if;
	end loop;

    
 
    /* ��Ϊ��Ŀ����Ա�ܿ�������Ŀ4 */
    for roleprjid_cursor IN (   select distinct t1.id from Prj_ProjectInfo  t1, hrmrolemembers  t2  where t2.roleid=9 and t2.resourceid= resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
	loop
	prjid_1 :=roleprjid_cursor.id;
        select count(prjid) INTO  countrec  from temptablevaluePrj where prjid = prjid_1;
        if countrec = 0 then
		insert into temptablevaluePrj values(prjid_1, 4);
		end if;
	end loop;

	 


    /* ����Ŀ�Ĺ����õ�Ȩ�� 1 2 */
    for shareprjid_cursor IN ( select distinct t2.relateditemid , t2.sharelevel from Prj_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	prjid_1 :=shareprjid_cursor.relateditemid;
	sharelevel_1 :=shareprjid_cursor.sharelevel;
        select  count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, sharelevel_1);
        end if;
	end loop;
   



    for shareprjid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and  t3.resourceid=resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=seclevel_1 and ( (t2.rolelevel=0  and t1.department=departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) ) 
    )
	loop
	 prjid_1 :=shareprjid_cursor.relateditemid;
	 sharelevel_1:=shareprjid_cursor.sharelevel;
        select count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, sharelevel_1);
        end	if;
		end loop;





    /* ��Ŀ��Ա5 (�ڲ��û�) */
	members_1 := concat(concat('%,' , to_char(resourceid_1)), ',%' );
    for inuserprjid_cursor IN (  SELECT  id FROM Prj_ProjectInfo   WHERE  ( concat(concat(',',members),',')  LIKE  members_1)  and isblock='1'  )
	loop
	prjid_1 :=inuserprjid_cursor.id;
        select  count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, 5);
        end	if;
	end loop;




    /* ɾ��ԭ�е������Ա��ص�������ĿȨ */
    delete from PrjShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allprjid_cursor IN (select * from temptablevaluePrj)
	loop
	prjid_1 :=allprjid_cursor.prjid;
	sharelevel_1 :=allprjid_cursor.sharelevel;
       insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(prjid_1, resourceid_1,1,sharelevel_1);
	end loop;



    /* ------- CPT ���� ------- */



    /*  �����е���Ϣ�ַŵ� temptablevalueCpt �� */
    /*  �Լ����ʲ�2 */
    for cptid_cursor IN (select id from CptCapital where resourceid = resourceid_1 )
	loop
	cptid_1 :=cptid_cursor.id;
	insert into temptablevalueCpt values(cptid_1, 2);
	end loop;
    

    /* �Լ��¼����ʲ�1 */
    /* �����¼� */
     
     managerstr_11 := concat(concat( '%,' , to_char(resourceid_1)),',%'); 

    for subcptid_cursor IN (
	select id from CptCapital where ( resourceid in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ))
	loop
	cptid_1 := subcptid_cursor.id;
        select  count(cptid) INTO countrec  from temptablevalueCpt where cptid = cptid_1;
        if countrec = 0  then
		insert into temptablevalueCpt values(cptid_1, 1);
		end if;
	end loop;

    

 
   
    /* ���ʲ��Ĺ����õ�Ȩ�� 1 2 */
    for sharecptid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CptCapitalShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	cptid_1 :=sharecptid_cursor.relateditemid;
	sharelevel_1 := sharecptid_cursor.sharelevel;
        select  count(cptid) into  countrec from temptablevalueCpt where cptid = cptid_1  ;
        if countrec = 0  then
        
            insert into temptablevalueCpt values(cptid_1, sharelevel_1);
        end if;
	end loop;




    for  sharecptid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.relateditemid and t3.resourceid= resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and t1.departmentid= departmentid_1 ) or (t2.rolelevel=1 and t1.departmentid=t4.id and t4.subcompanyid1= subcompanyid_1 ) or (t3.rolelevel=2) ))
	loop
	cptid_1:= sharecptid_cursor.relateditemid;
	sharelevel_1 := sharecptid_cursor.sharelevel;
        select count(cptid) INTO countrec  from temptablevalueCpt where cptid = cptid_1;  
        if countrec = 0 then         
            insert into temptablevalueCpt values(cptid_1, sharelevel_1);
        end  if;
	end loop;




    /* ɾ��ԭ�е������Ա��ص������ʲ�Ȩ */
    delete from CptShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allcptid_cursor IN (select * from temptablevalueCpt)
	loop
	cptid_1 :=allcptid_cursor.cptid;
	sharelevel_1 := allcptid_cursor.sharelevel;
        insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(cptid_1, resourceid_1,1,sharelevel_1);
	end loop;
     /* ------- �ͻ���ͬ����2003-11-06����� ------- */

    /* ������ʱ����� */
    /*Declare @temptablevalueCpt  table(contractid integer,sharelevel integer)*/

    /*  �����е���Ϣ�ַŵ� @temptablevalueCpt �� */

    /* �Լ��¼��Ŀͻ���ͬ 3 */
     
    /*set @managerstr_11 = '%,' + convert(varchar2(5),@resourceid_1) + ',%' */
    managerstr_11:=Concat ('%,' ,Concat(to_char(resourceid_1),',%'));

    for subcontractid_cursor in(
    select id from CRM_Contract where ( manager in (select distinct id from HrmResource where concat(',',managerstr) like managerstr_11 ) ))
    loop
        select count(contractid) into countrec from temptablevaluecontract where contractid = contractid_1;
        if countrec = 0  then
            insert into temptablevaluecontract values(contractid_1, 3);
        end if;
    end loop;
 
     /*  �Լ��� manager �Ŀͻ���ͬ 2 */   
    for contractid_cursor in
    (select id from CRM_Contract where manager = resourceid_1 )
    loop
        insert into temptablevaluecontract values(contractid_1, 2);
    end loop;
    
       /* ��Ϊ�ͻ���ͬ����Ա�ܿ����� */
    for roleids_cursor in
    (select roleid from SystemRightRoles where rightid = 396)
    loop

       for rolecontractid_cursor in
 (select distinct t1.id from CRM_Contract  t1, hrmrolemembers  t2  
 where t2.roleid=contractroleid_1 and t2.resourceid=resourceid_1 
 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1 ) 
 or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
       
      loop
            select count(contractid) into countrec from temptablevaluecontract 
            where contractid = contractid_1;
            if countrec = 0  then
                insert into temptablevaluecontract values(contractid_1, 2);
            else
                select sharelevel into sharelevel_1 from ContractShareDetail where 
                contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                if sharelevel_1 = 1 then
                     update ContractShareDetail set sharelevel = 2 
                     where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                end if;
            end if;
        end loop; 
        
    end loop;

    /* �ɿͻ���ͬ�Ĺ����õ�Ȩ�� 1 2 */
    for sharecontractid_cursor in
    (select distinct t2.relateditemid , t2.sharelevel from Contract_ShareInfo  t2  
    where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) 
    or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
    loop
        select count(contractid) into countrec from temptablevaluecontract where contractid = contractid_1;
        if countrec = 0 then
            insert into temptablevaluecontract values(contractid_1, sharelevel_1);
        else
            select sharelevel into sharelevel_Temp from temptablevaluecontract where contractid = contractid_1;
            if ((sharelevel_Temp = 1) and (sharelevel_1 = 2)) then
                update temptablevaluecontract set sharelevel = sharelevel_1 where contractid = contractid_1;
            end if;
        end if;
    end loop;



    for sharecontractid_cursor in
    (select distinct t2.relateditemid , t2.sharelevel from 
    CRM_Contract t1 ,  Contract_ShareInfo  t2,  HrmRoleMembers  t3  
    where  t1.id = t2.relateditemid and t3.resourceid=resourceid_1 and t3.roleid=t2.roleid and 
    t3.rolelevel>=t2.rolelevel and t2.seclevel<=seclevel_1 and 
    ( (t2.rolelevel=0  and t1.department=departmentid_1) or 
    (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) )) 
    loop
        select count(contractid) into countrec from temptablevaluecontract where contractid = contractid_1;
        if countrec = 0 then 
            insert into temptablevaluecontract values(contractid_1, sharelevel_1);
        else
            select sharelevel into sharelevel_Temp from temptablevaluecontract where contractid = contractid_1;
            if ((sharelevel_Temp = 1) and (sharelevel_1 = 2)) then
                update temptablevaluecontract set sharelevel = sharelevel_1 where contractid = contractid_1;
            end if;    
        end if;
    end loop;

    /* �Լ��¼��Ŀͻ���ͬ  (�ͻ�����������)*/
     
    managerstr_11:=concat( '%,',concat(to_char(resourceid_1),',%')); 

    for subcontractid_cursor in
    (select t2.id from CRM_CustomerInfo t1 , CRM_Contract t2 
    where ( t1.manager in (select distinct id from HrmResource where concat(',',managerstr) like managerstr_11 ) ) 
    and (t2.crmId = t1.id))
    loop
        select count(contractid)  into countrec from temptablevaluecontract where contractid = contractid_1;
        if countrec = 0 then 
            insert into temptablevaluecontract values(contractid_1, 1);
        end if;
    end loop;
    /*  �Լ��� manager �Ŀͻ� (�ͻ�����������) */
    for contractid_cursor in
    (select t2.id from CRM_CustomerInfo t1 , CRM_Contract t2 
    where (t1.manager = resourceid_1 ) and (t2.crmId = t1.id))
    loop
        insert into temptablevaluecontract values(contractid_1, 1);
    end loop;

    /* ɾ��ԭ�е������Ա��ص�����Ȩ */
    delete from ContractShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allcontractid_cursor in
    (select * from temptablevaluecontract)
    loop
        insert into ContractShareDetail( contractid, userid, usertype, sharelevel) 
        values(contractid_1, resourceid_1,1,sharelevel_1);
    end loop;

end if;       /* �����޸��˲��źͰ�ȫ�������� */
            

       
/* �����޸��˾����ֶ�,�µ������ϼ����ӶԸ��¼����ĵ�����,������Ϊ�ɶ� */
if ( managerstr_1 <> oldmanagerstr_1 )  then /* �½�������Դʱ��Ծ����ֶεĸı䲻���� */

    if ( managerstr_1 is not null and length(managerstr_1) > 1 ) then /* ���ϼ����� */
     

         managerstr_1 := concat( ',' , managerstr_1);

	/* ------- DOC ���� ------- */
        for supuserid_cursor in(select distinct t1.id id_1 , t2.id id_2 from HrmResource_Trigger t1, DocDetail t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%') and ( t2.doccreaterid = resourceid_1 or t2.ownerid = resourceid_1 ) and t2.usertype= '1' )
		loop
		supresourceid_1:= supuserid_cursor.id_1;
		docid_1 := supuserid_cursor.id_2;
            select  count(docid) INTO countrec  from docsharedetail where docid = docid_1 and userid= supresourceid_1 and usertype= 1 ;
            if countrec = 0  then
            
                insert into docsharedetail values(docid_1,supresourceid_1,1,1);
            end if;
		end loop;

	
	/* ------- CRM ���� ------- */
        for supuserid_cursor IN (select distinct t1.id  id_1, t2.id id_2 from HrmResource_Trigger t1, CRM_CustomerInfo t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%') and  t2.manager = resourceid_1  )
		loop
		supresourceid_1:= supuserid_cursor.id_1;
		crmid_1 := supuserid_cursor.id_2;
            select  count(crmid) INTO countrec  from CrmShareDetail where crmid = crmid_1 and userid= supresourceid_1 and usertype= 1;
            if countrec = 0 then
            
                insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(crmid_1,supresourceid_1,1,3);
            end if;
		end loop;



	/* ------- PROJ ���� ------- */
		for supuserid_cursor IN (    select distinct t1.id  id_1, t2.id id_2 from HrmResource_Trigger t1, Prj_ProjectInfo t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%')  and  t2.manager = resourceid_1 )
		loop
		supresourceid_1:= supuserid_cursor.id_1;
		prjid_1 :=supuserid_cursor.id_2;
            select  count(prjid) INTO countrec  from PrjShareDetail where prjid = prjid_1 and userid= supresourceid_1 and usertype= 1;
            if countrec = 0  then
            
                insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(prjid_1,supresourceid_1,1,3);
            end if;
		end loop;
		 


	/* ------- CPT ���� ------- */
		for supuserid_cursor IN (select distinct  t1.id  id_1, t2.id id_2 from HrmResource_Trigger t1, CptCapital t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%') and  t2.resourceid = resourceid_1  )
		loop
		supresourceid_1:=supuserid_cursor.id_1;
		cptid_1:=supuserid_cursor.id_2;
		    select  count(cptid) INTO countrec  from CptShareDetail where cptid = cptid_1 and userid= supresourceid_1 and usertype= 1;
            if countrec = 0  then
                insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(cptid_1,supresourceid_1,1,1);
            end if;
		end loop;
         
         /* ------- �ͻ���ͬ���� ����ı� 2003-11-06�����------- */
        for supuserid_cursor in
        (select distinct t1.id id_1, t2.id id_2 from HrmResource t1, CRM_Contract t2 
        where managerstr_1 like concat('%,',concat(to_char(t1.id),',%')) and  t2.manager = resourceid_1)
        loop
            supresourceid_1:=supuserid_cursor.id_1;
		   cptid_1:=supuserid_cursor.id_2;
            select count(contractid) into countrec from ContractShareDetail where contractid = contractid_1 and 
            userid= supresourceid_1 and usertype=1;
            if countrec = 0  then
                insert into ContractShareDetail( contractid, userid, usertype, sharelevel) 
                values(contractid_1,supresourceid_1,1,3);
            end if;
        end loop;
        
        for supuserid_cursor in
        (select distinct t1.id id_1, t3.id id_2 from HrmResource t1, CRM_CustomerInfo t2 ,CRM_Contract t3 where managerstr_1 
        like concat('%,',concat(to_char(t1.id),',%')) and  t2.manager = resourceid_1  and t2.id = t3.crmId)
        loop
            supresourceid_1:=supuserid_cursor.id_1;
		   cptid_1:=supuserid_cursor.id_2;
            select count(contractid) into countrec from ContractShareDetail 
            where contractid = contractid_1 and userid= supresourceid_1 and usertype= 1;
            if countrec = 0  then
                insert into ContractShareDetail( contractid, userid, usertype, sharelevel) 
                values(contractid_1,supresourceid_1,1,1);
            end if;
        end loop;
    end  if;           /* ���ϼ������ж����� */
end if;  /* �޸ľ�����ж����� */            
end ;
/


/

/* �޸�hrmrolemembers��trigger ���ڽ�ɫ��ĸ��� */
CREATE or REPLACE TRIGGER Tri_Update_HrmRoleMembersShare
after insert or update or delete ON  HrmRoleMembers
FOR each row
Declare roleid_1 integer;
        resourceid_1 integer;
        oldrolelevel_1 char(1);
        rolelevel_1 char(1);
        docid_1	 integer;
	    crmid_1	 integer;
	    prjid_1	 integer;
	    cptid_1	 integer;
        sharelevel_1  integer;
        departmentid_1 integer;
	    subcompanyid_1 integer;
        seclevel_1	 integer;
        countrec      integer;
        countdelete   integer;
        countinsert   integer;
		managerstr_11 varchar2(200); 
        oldroleid_1 integer;
        oldresourceid_1 integer;
        contractid_1	 integer;/*2003-11-06�����*/
        contractroleid_1 integer ;   /*2003-11-06�����*/
        sharelevel_Temp integer ;  /*2003-11-06�����*/
        
/* ĳһ���˼���һ����ɫ�����ڽ�ɫ�еļ������߽��д���,������������������˹���ķ�Χ,����Ҫɾ��
ԭ�й�����Ϣ,ֻ��Ҫ�ж����ӵĲ���, �����ڽ�ɫ�м���Ľ��ͻ���ɾ��ĳһ����Ա,ֻ��ɾ��ȫ������ϸ��,����������Դһ��
�˵Ĳ��Ż��߰�ȫ����ı�Ĳ��� */
begin
countdelete := :old.id;
countinsert := :new.id;
oldrolelevel_1 := :old.rolelevel;
oldroleid_1 :=  :old.roleid; 
oldresourceid_1 := :old.resourceid;

if countinsert > 0 then
	roleid_1 := :new.roleid;
	resourceid_1 := :new.resourceid;
	rolelevel_1 := :new.rolelevel;
else 
	roleid_1 := :old.roleid;
	resourceid_1 := :old.resourceid;
	rolelevel_1 := :old.rolelevel;
end if;

if resourceid_1 = 1 then 
    return ;
end if ;

/* �����ɾ��ԭ�����ݣ�����ɱ��е�Ȩ���������һ */
if (countdelete > 0) then
    select seclevel into seclevel_1  from hrmresource where id = oldresourceid_1 ;
    if seclevel_1 is not null then
        Doc_DirAcl_DUserP_RoleChange (oldresourceid_1, oldroleid_1, oldrolelevel_1, seclevel_1);
    end if;
end if;
/* ��������������ݣ�����ɱ��е�Ȩ���������һ */
if (countinsert > 0) then
    select  seclevel into seclevel_1 from hrmresource where id = resourceid_1;
    if seclevel_1 is not null then
        Doc_DirAcl_GUserP_RoleChange (resourceid_1, roleid_1, rolelevel_1, seclevel_1);
    end if;
end if;


if ( countinsert >0 and ( countdelete = 0 or rolelevel_1  > oldrolelevel_1 ) )  then   

    select  departmentid ,  subcompanyid1 ,  seclevel INTO  departmentid_1 ,subcompanyid_1 ,seclevel_1 
    from hrmresource where id = resourceid_1 ;
    if departmentid_1 is null  then
	departmentid_1 := 0;
	end if;
    if subcompanyid_1 is null  then
	subcompanyid_1 := 0;
	end if;


    if rolelevel_1 = '2'   then    /* �µĽ�ɫ����Ϊ�ܲ��� */
     

	/* ------- DOC ���� ------- */

        for sharedocid_cursor IN (select distinct docid , sharelevel from DocShare where roleid = roleid_1 and rolelevel <= rolelevel_1 and seclevel <= seclevel_1 )
        
        loop 
			docid_1 := sharedocid_cursor.docid ;
			sharelevel_1 := sharedocid_cursor.sharelevel;
            select  count(docid) INTO countrec  from docsharedetail where docid = docid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then            
                insert into docsharedetail values(docid_1, resourceid_1, 1, sharelevel_1);
            else if sharelevel_1 = 2 then            
                update docsharedetail set sharelevel = 2 where docid=docid_1 and userid = resourceid_1 and usertype = 1  ;/* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
				end if;
			end if;
        end loop;



	/* ------- CRM ���� ------- */

		for sharecrmid_cursor IN (     select distinct relateditemid , sharelevel from CRM_ShareInfo where roleid = roleid_1 and rolelevel <= rolelevel_1 and seclevel <= seclevel_1 )
		loop
		crmid_1:=sharecrmid_cursor.relateditemid;
		sharelevel_1 := sharecrmid_cursor.sharelevel;
			select  count(crmid) INTO countrec  from CrmShareDetail where crmid = crmid_1 and userid = resourceid_1 and usertype = 1  ;
			if countrec = 0  then
			
				insert into CrmShareDetail values(crmid_1, resourceid_1, 1, sharelevel_1);
			
			else if sharelevel_1 = 2  then
			
				update CrmShareDetail set sharelevel = 2 where crmid=crmid_1 and userid = resourceid_1 and usertype = 1  ;/* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
			end if;
			end if;
		end loop;
	   


	/* ------- PROJ ���� ------- */

		for shareprjid_cursor IN (      select distinct relateditemid , sharelevel from Prj_ShareInfo where roleid = roleid_1 and rolelevel <= rolelevel_1 and seclevel <= seclevel_1 )
		loop
		prjid_1 := shareprjid_cursor.relateditemid;
		sharelevel_1 := shareprjid_cursor.sharelevel;
            select count(prjid) INTO countrec  from PrjShareDetail where prjid = prjid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into PrjShareDetail values(prjid_1, resourceid_1, 1, sharelevel_1);
             
            else if sharelevel_1 = 2  then
            
                update PrjShareDetail set sharelevel = 2 where prjid=prjid_1 and userid = resourceid_1 and usertype = 1 ; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
		end loop;
	
  



	/* ------- CPT ���� ------- */

		for sharecptid_cursor IN (select distinct relateditemid , sharelevel from CptCapitalShareInfo where roleid = roleid_1 and rolelevel <= rolelevel_1 and seclevel <= seclevel_1 )
		loop
		cptid_1 :=sharecptid_cursor.relateditemid;
		sharelevel_1 :=sharecptid_cursor.sharelevel;
            select count(cptid) INTO  countrec  from CptShareDetail where cptid = cptid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into CptShareDetail values(cptid_1, resourceid_1, 1, sharelevel_1);
            
            else if sharelevel_1 = 2 then 
            
                update CptShareDetail set sharelevel = 2 where cptid=cptid_1 and userid = resourceid_1 and usertype = 1;  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
		end loop;
    end if;
    
            /* ------- �ͻ���ͬ���� �ܲ� 2003-11-06�����------- */
        for roleids_cursor in
        (select roleid from SystemRightRoles where rightid = 396) /*396Ϊ�ͻ���ͬ����Ȩ��*/
        loop
            for rolecontractid_cursor in
            (select distinct t1.id from CRM_Contract  t1, hrmrolemembers  t2  
            where t2.roleid=contractroleid_1 and t2.resourceid=resourceid_1 and t2.rolelevel=2)
            loop
               select count(contractid) into countrec from ContractShareDetail 
               where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                if countrec = 0 then 
                    insert into ContractShareDetail values(contractid_1, resourceid_1, 1, 2);
                else
                    select sharelevel into sharelevel_1 from ContractShareDetail 
                    where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                    if sharelevel_1 = 1 then
                         update ContractShareDetail set sharelevel = 2 
                         where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                    end if;
                end if;
            end loop;

        end loop;   
    if rolelevel_1 = '1' then        /* �µĽ�ɫ����Ϊ�ֲ��� */
    

	/* ------- DOC ���� ------- */
		for sharedocid_cursor IN (select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2 ,
		hrmdepartment  t4 where t1.id=t2.docid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and
		t2.seclevel <= seclevel_1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= subcompanyid_1)
		
		loop 
			docid_1 := sharedocid_cursor.docid;
			sharelevel_1 := sharedocid_cursor.sharelevel;
			select  count(docid) INTO countrec  from docsharedetail where docid = docid_1 and userid = resourceid_1 and usertype = 1 ; 
			if countrec = 0  then            
				insert into docsharedetail values(docid_1, resourceid_1, 1, sharelevel_1);            
			else if sharelevel_1 = 2  then            
				update docsharedetail set sharelevel = 2 where docid=docid_1 and userid = resourceid_1 and usertype = 1  ;/* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
			end if;
			end if;
		end loop;


	/* ------- CRM ���� ------- */
       for sharecrmid_cursor IN (      select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2 , hrmdepartment  t4 where t1.id=t2.relateditemid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and t2.seclevel <= seclevel_1 and t1.department = t4.id and t4.subcompanyid1= subcompanyid_1)
	   loop
	   crmid_1 :=sharecrmid_cursor.relateditemid;
	   sharelevel_1 :=sharecrmid_cursor.sharelevel;
            select  count(crmid) INTO countrec  from CrmShareDetail where crmid = crmid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into CrmShareDetail values(crmid_1, resourceid_1, 1, sharelevel_1);
            
            else if sharelevel_1 = 2  then
            
                update CrmShareDetail set sharelevel = 2 where crmid = crmid_1 and userid = resourceid_1 and usertype = 1 ; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
	   end loop;

  

	/* ------- PRJ ���� ------- */

		for shareprjid_cursor IN (        select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2 , hrmdepartment  t4 where t1.id=t2.relateditemid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and t2.seclevel <= seclevel_1 and t1.department=t4.id and t4.subcompanyid1= subcompanyid_1)
		loop
		prjid_1 := shareprjid_cursor.relateditemid;
		sharelevel_1 :=shareprjid_cursor.sharelevel;
            select  count(prjid) INTO countrec  from PrjShareDetail where prjid = prjid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into PrjShareDetail values(prjid_1, resourceid_1, 1, sharelevel_1);
            
            else if sharelevel_1 = 2  then
            
                update PrjShareDetail set sharelevel = 2 where prjid=prjid_1 and userid = resourceid_1 and usertype = 1  ;/* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
		end loop;
	

      

	/* ------- CPT ���� ------- */

		for sharecptid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2 , hrmdepartment  t4 where t1.id=t2.relateditemid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and t2.seclevel <= seclevel_1 and t1.departmentid=t4.id and t4.subcompanyid1= subcompanyid_1)
		loop
		cptid_1 :=sharecptid_cursor.relateditemid;
		sharelevel_1 :=sharecptid_cursor.sharelevel;
            select  count(cptid) INTO countrec  from CptShareDetail where cptid = cptid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into CptShareDetail values(cptid_1, resourceid_1, 1, sharelevel_1);
            
            else if sharelevel_1 = 2  then
            
                update CptShareDetail set sharelevel = 2 where cptid=cptid_1 and userid = resourceid_1 and usertype = 1 ; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
		end loop;

    end if;
         /* ------- �ͻ���ͬ���� �ֲ� 2003-11-06�����------- */
        for roleids_cursor in
        (select roleid from SystemRightRoles where rightid = 396) /*396Ϊ�ͻ���ͬ����Ȩ��*/
        loop
            for rolecontractid_cursor in
            (select distinct t1.id from CRM_Contract  t1, hrmrolemembers  t2  
            where t2.roleid=contractroleid_1 and t2.resourceid=resourceid_1 
            and (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 ))
            loop
               select count(contractid) into countrec from ContractShareDetail 
               where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                if countrec = 0 then
                    insert into ContractShareDetail values(contractid_1, resourceid_1, 1, 2);
                else   
                    select sharelevel into sharelevel_1 from ContractShareDetail 
                    where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                    if sharelevel_1 = 1 then
                         update ContractShareDetail set sharelevel = 2 
                         where contractid = contractid_1 and userid = resourceid_1 and usertype = 1  ;
                    end if;
                end if;
            end loop;
        end loop; 
    
    if rolelevel_1 = '0'     then     /* Ϊ�½�ʱ���趨����Ϊ���ż� */
    

        /* ------- DOC ���� ------- */

		for sharedocid_cursor IN (select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2
		where t1.id=t2.docid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and t2.seclevel <=
		seclevel_1 and t1.docdepartmentid= departmentid_1)
		
		loop 
			docid_1 := sharedocid_cursor.docid ;
			sharelevel_1 := sharedocid_cursor.sharelevel ;
			select  count(docid) INTO countrec  from docsharedetail where docid = docid_1 and userid =
			resourceid_1 and usertype = 1  ;
			if countrec = 0  then            
				insert into docsharedetail values(docid_1, resourceid_1, 1, sharelevel_1);            
			else if sharelevel_1 = 2  then            
				update docsharedetail set sharelevel = 2 where docid=docid_1 and userid = resourceid_1 and
				usertype = 1 ; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
			end if;
			end if;
		end loop;
	
	/* ------- CRM ���� ------- */

		for sharecrmid_cursor IN (select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2 where t1.id=t2.relateditemid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and t2.seclevel <= seclevel_1 and t1.department = departmentid_1)
		loop
		crmid_1 :=sharecrmid_cursor.relateditemid;
		sharelevel_1 :=sharecrmid_cursor.sharelevel;
          select  count(crmid) INTO countrec  from CrmShareDetail where crmid = crmid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into CrmShareDetail values(crmid_1, resourceid_1, 1, sharelevel_1);
            
            else if sharelevel_1 = 2  then
            
                update CrmShareDetail set sharelevel = 2 where crmid = crmid_1 and userid = resourceid_1 and usertype = 1 ; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
		end loop;
        
  

	/* ------- PRJ ���� ------- */

		for shareprjid_cursor IN (       select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2 where t1.id=t2.relateditemid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and t2.seclevel <= seclevel_1 and t1.department= departmentid_1)
		loop
		prjid_1 :=shareprjid_cursor.relateditemid;
		sharelevel_1 := shareprjid_cursor.sharelevel;
            select  count(prjid) INTO countrec  from PrjShareDetail where prjid = prjid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into PrjShareDetail values(prjid_1, resourceid_1, 1, sharelevel_1);
            
            else if sharelevel_1 = 2  then
            
                update PrjShareDetail set sharelevel = 2 where prjid = prjid_1 and userid = resourceid_1 and usertype = 1  ;/* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
		end loop;
 


	/* ------- CPT ���� ------- */

		for sharecptid_cursor IN (       select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2 where t1.id=t2.relateditemid and t2.roleid = roleid_1 and t2.rolelevel <= rolelevel_1 and t2.seclevel <= seclevel_1 and t1.departmentid= departmentid_1)
		loop
		 cptid_1 :=sharecptid_cursor.relateditemid;
		 sharelevel_1 := sharecptid_cursor.sharelevel;
            select count(cptid) INTO countrec  from CptShareDetail where cptid = cptid_1 and userid = resourceid_1 and usertype = 1  ;
            if countrec = 0  then
            
                insert into CptShareDetail values(cptid_1, resourceid_1, 1, sharelevel_1);
            
            else if sharelevel_1 = 2  then
            
                update CptShareDetail set sharelevel = 2 where cptid = cptid_1 and userid = resourceid_1 and usertype = 1 ; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end if;
			end if;
		end loop;    

    end if;
       /* ------- �ͻ���ͬ���� ���� 2003-11-06�����------- */
        for roleids_cursor in
        (select roleid from SystemRightRoles where rightid = 396) /*396Ϊ�ͻ���ͬ����Ȩ��*/
        loop
            for rolecontractid_cursor in
            (select distinct t1.id from CRM_Contract  t1, hrmrolemembers  t2  
            where t2.roleid=contractroleid_1 and t2.resourceid=resourceid_1 and 
            (t2.rolelevel=0 and t1.department=departmentid_1 ))
            loop    
               select count(contractid) into countrec from ContractShareDetail 
               where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                if countrec = 0  then
                    insert into ContractShareDetail values(contractid_1, resourceid_1, 1, 2);
                else
                    select sharelevel into sharelevel_1 from ContractShareDetail 
                    where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;
                    if sharelevel_1 = 1 then
                         update ContractShareDetail set sharelevel = 2 
                         where contractid = contractid_1 and userid = resourceid_1 and usertype = 1;  
                    end if;
                end if;      
            end loop;

        end loop;   

    else if ( countdelete > 0 and ( countinsert = 0 or rolelevel_1  < oldrolelevel_1 ) )  then 
/* ��Ϊɾ�����߼��𽵵� */


    select  departmentid ,  subcompanyid1 ,  seclevel INTO departmentid_1 ,subcompanyid_1 ,seclevel_1 
    from hrmresource where id = resourceid_1 ;
    if departmentid_1 is null then
	departmentid_1 := 0;
    end if;
	if subcompanyid_1 is null then
	subcompanyid_1 := 0;
	end if;
	
    /* ɾ��ԭ�еĸ��˵������ĵ�������Ϣ */
	delete from DocShareDetail where userid = resourceid_1 and usertype = 1;


    /*  �����е���Ϣ�ַŵ� temptablevalue �� */
    /*  �Լ������Ļ����� owner �����¿��Ա༭ */
    for docid_cursor IN (select distinct id from DocDetail where ( doccreaterid = resourceid_1 or ownerid = resourceid_1 ) and usertype= '1')
    
    loop 
		docid_1 := docid_cursor.id;
        insert into temptablevalue values(docid_1, 2);
    end loop;



    /* �Լ��¼����ĵ� */
    /* �����¼� */
    managerstr_11 := concat( concat('%,' , to_char(resourceid_1)) , ',%' );

    for subdocid_cursor IN (select distinct id from DocDetail where ( doccreaterid in (select distinct id from
	HrmResource where concat(',' , managerstr) like managerstr_11 ) or ownerid in (select distinct id from
	HrmResource where concat(',' , managerstr) like managerstr_11 ) ) and usertype= '1')
    
    loop
		docid_1 := subdocid_cursor.id;
        select  count(docid) INTO countrec  from temptablevalue where docid = docid_1;
        if countrec = 0 then
		insert into temptablevalue values(docid_1, 1);
		end if;
    end loop;
         
         


    /* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
    for sharedocid_cursor IN (select distinct docid , sharelevel from DocShare  where  (foralluser=1 and
	seclevel<= seclevel_1 )  or ( userid= resourceid_1 ) or (departmentid= departmentid_1 and seclevel<=
	seclevel_1 ))
    
    loop 
		docid_1 :=sharedocid_cursor.docid;
		sharelevel_1 :=sharedocid_cursor.sharelevel;
        select count(docid) INTO countrec  from temptablevalue where docid = docid_1  ;
        if countrec = 0  then        
            insert into temptablevalue values(docid_1, sharelevel_1);        
        else if sharelevel_1 = 2  then        
            update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */
        end if;
		end if;
    end loop;

    for sharedocid_cursor IN (select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2, 
	HrmRoleMembers  t3 , hrmdepartment t4 where t1.id=t2.docid and t3.resourceid= resourceid_1 and
	t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and
	t1.docdepartmentid= departmentid_1 ) or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1=
	subcompanyid_1 ) or (t3.rolelevel=2) ))

    loop
		docid_1 :=sharedocid_cursor.docid ;
		sharelevel_1 := sharedocid_cursor.sharelevel ;
        select  count(docid) INTO countrec  from temptablevalue where docid = docid_1 ; 
        if countrec = 0  then        
            insert into temptablevalue values(docid_1, sharelevel_1);        
        else if sharelevel_1 = 2  then        
            update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */
			end if;
		end if;
    end loop ;

    /* ����ʱ���е�����д�빲��� */
    for alldocid_cursor IN (select * from temptablevalue)    
    loop 
		docid_1 := alldocid_cursor.docid;
		sharelevel_1 := alldocid_cursor.sharelevel;
        insert into docsharedetail values(docid_1, resourceid_1,1,sharelevel_1);
    end loop;

    /* ------- CRM  ���� ------- */


    /* ɾ��ԭ�еĸ��˵����пͻ�������Ϣ */
	delete from CrmShareDetail where userid = resourceid_1 and usertype = 1;



    /*  �����е���Ϣ�ַŵ� temptablevaluecrm �� */
    /*  �Լ��� manager �Ŀͻ� 2 */
    for crmid_cursor IN (   select id from CRM_CustomerInfo where manager = resourceid_1 )
	loop
	crmid_1 := crmid_cursor.id;
	insert into temptablevaluecrm values(crmid_1, 2);
	end loop;
 


    /* �Լ��¼��Ŀͻ� 3 */
    /* �����¼� */
     
     managerstr_11 := concat(concat('%,' , to_char(resourceid_1)) , ',%' );

    for subcrmid_cursor IN (  select id from CRM_CustomerInfo where ( manager in (select distinct id from HrmResource where concat(',',managerstr) like managerstr_11 ) ))
	loop
	crmid_1 :=  subcrmid_cursor.id;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1;
        if countrec = 0  then
		insert into temptablevaluecrm values(crmid_1, 3);
		end if;
	end loop;
  

 
    /* ��Ϊcrm����Ա�ܿ����Ŀͻ� */
    for rolecrmid_cursor IN (   select distinct t1.id from CRM_CustomerInfo  t1, hrmrolemembers  t2  where t2.roleid=8 and t2.resourceid= resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
	loop
	crmid_1 := rolecrmid_cursor.id;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1;
        if countrec = 0 then
		insert into temptablevaluecrm values(crmid_1, 4);
		end if;
	end loop;



    /* �ɿͻ��Ĺ����õ�Ȩ�� 1 2 */
    for sharecrmid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CRM_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid = departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	crmid_1:= sharecrmid_cursor.relateditemid;
	sharelevel_1 :=sharecrmid_cursor.sharelevel;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluecrm values(crmid_1, sharelevel_1);
        end if;
	end loop;






    for sharecrmid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and t3.resourceid=resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=seclevel_1 and ( (t2.rolelevel=0  and t1.department = departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) ) )
	loop
	crmid_1 :=sharecrmid_cursor.relateditemid;
	sharelevel_1 := sharecrmid_cursor.sharelevel;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluecrm values(crmid_1, sharelevel_1);
        end if;
	end loop;




    /* ����ʱ���е�����д�빲��� */
    for allcrmid_cursor IN (    select * from temptablevaluecrm)
	loop
	crmid_1 :=allcrmid_cursor.crmid;
	sharelevel_1  := allcrmid_cursor.sharelevel;
        insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(crmid_1, resourceid_1,1,sharelevel_1);
	end loop;





    /* ------- PROJ ���� ------- */



    /*  �����е���Ϣ�ַŵ� temptablevaluePrj �� */
    /*  �Լ�����Ŀ2 */
    for prjid_cursor IN (select id from Prj_ProjectInfo where manager = resourceid_1 )
	loop
	prjid_1 := prjid_cursor.id;
      insert into temptablevaluePrj values(prjid_1, 2);
	end loop;



    /* �Լ��¼�����Ŀ3 */
    /* �����¼� */
     
     managerstr_11 := concat(concat('%,' , to_char(resourceid_1)), ',%' );

    for subprjid_cursor IN (    select id from Prj_ProjectInfo where ( manager in (select distinct id from HrmResource where ','+managerstr like managerstr_11 ) ))
	loop
	prjid_1 :=subprjid_cursor.id;
        select count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1;
        if countrec = 0 then
		insert into temptablevaluePrj values(prjid_1, 3);
		end if;
	end loop;


 
    /* ��Ϊ��Ŀ����Ա�ܿ�������Ŀ4 */
    for roleprjid_cursor IN (   select distinct t1.id from Prj_ProjectInfo  t1, hrmrolemembers  t2  where t2.roleid=9 and t2.resourceid= resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
	loop
	prjid_1:=roleprjid_cursor.id;
        select count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1;
        if countrec = 0 then
		insert into temptablevaluePrj values(prjid_1, 4);
		end if;
	end loop;

	 


    /* ����Ŀ�Ĺ����õ�Ȩ�� 1 2 */
    for shareprjid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from Prj_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	prjid_1 := shareprjid_cursor.relateditemid;
	sharelevel_1 :=  shareprjid_cursor.sharelevel;
        select count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, sharelevel_1);
        end if;
	end loop;



    for shareprjid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and  t3.resourceid=resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=seclevel_1 and ( (t2.rolelevel=0  and t1.department=departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) ) 
    
	)
	loop
	prjid_1 := shareprjid_cursor.relateditemid;
	sharelevel_1 := shareprjid_cursor.sharelevel;
        select  count(prjid) INTO countrec from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0 then 
        
            insert into temptablevaluePrj values(prjid_1, sharelevel_1);
        end if;
	end loop;

	

    /* ��Ŀ��Ա5 (�ڲ��û�) */
    for inuserprjid_cursor IN (    SELECT distinct t2.id FROM Prj_TaskProcess  t1,Prj_ProjectInfo  t2 WHERE  t1.hrmid =resourceid_1 and t2.id=t1.prjid and t1.isdelete<>'1' and t2.isblock='1' )
	loop
	prjid_1 :=inuserprjid_cursor.id;
        select  count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1 ; 
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, 5);
        end if;
	end loop;



    /* ɾ��ԭ�е������Ա��ص�������ĿȨ */
    delete from PrjShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allprjid_cursor IN (select * from temptablevaluePrj)
	loop
	prjid_1 := allprjid_cursor.prjid;
	sharelevel_1 := allprjid_cursor.sharelevel;
        insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(prjid_1, resourceid_1,1,sharelevel_1);
	end loop;
    



    /* ------- CPT ���� ------- */


    /*  �����е���Ϣ�ַŵ� temptablevalueCpt �� */
    /*  �Լ����ʲ�2 */
    for cptid_cursor IN (    select id from CptCapital where resourceid = resourceid_1 )
	loop
	cptid_1 := cptid_cursor.id;
	  insert into temptablevalueCpt values(cptid_1, 2);
	end loop;





    /* �Լ��¼����ʲ�1 */
    /* �����¼� */
     
     managerstr_11 := concat(concat('%,' , to_char(resourceid_1)), ',%' );

    for subcptid_cursor IN ( select id from CptCapital where ( resourceid in (select distinct id from HrmResource where ','+managerstr like managerstr_11 ) ))
	loop
	cptid_1 := subcptid_cursor.id;
        select  count(cptid) INTO countrec  from temptablevalueCpt where cptid = cptid_1;
        if countrec = 0 then
		insert into temptablevalueCpt values(cptid_1, 1);
		end if;
	end loop;

 
   
    /* ���ʲ��Ĺ����õ�Ȩ�� 1 2 */
    for sharecptid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CptCapitalShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	cptid_1 := sharecptid_cursor.relateditemid;
	sharelevel_1 := sharecptid_cursor.sharelevel;
        select count(cptid) INTO countrec from temptablevalueCpt where cptid = cptid_1  ;
        if countrec = 0  then
        
            insert into temptablevalueCpt values(cptid_1, sharelevel_1);
        end if;
	end loop;




    for sharecptid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.relateditemid and t3.resourceid= resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and t1.departmentid= departmentid_1 ) or (t2.rolelevel=1 and t1.departmentid=t4.id and t4.subcompanyid1= subcompanyid_1 ) or (t3.rolelevel=2) ))
	loop
	cptid_1 := sharecptid_cursor.relateditemid;
	sharelevel_1 := sharecptid_cursor.sharelevel;
        select count(cptid) INTO countrec from temptablevalueCpt where cptid = cptid_1  ;
        if countrec = 0  then
        
            insert into temptablevalueCpt values(cptid_1, sharelevel_1);
        end    if;
	end loop;

    


    /* ɾ��ԭ�е������Ա��ص������ʲ�Ȩ */
    delete from CptShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allcptid_cursor IN (select * from temptablevalueCpt)
	loop
	cptid_1 :=allcptid_cursor.cptid;
	sharelevel_1 :=allcptid_cursor.sharelevel;
        insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(cptid_1, resourceid_1,1,sharelevel_1);
	end loop;	

	end if;
end if; 
/* ������ɫɾ�����߼��𽵵͵Ĵ��� */
     /* ------- �ͻ���ͬ����2003-11-06����� ------- */ 
    /* ������ʱ����� */
    /*Declare @temptablevalueCpt  table(contractid integer,sharelevel integer)*/

    /*  �����е���Ϣ�ַŵ� @temptablevalueCpt �� */

    /* �Լ��¼��Ŀͻ���ͬ 3 */
     
    managerstr_11:=concat('%,',concat(to_char(resourceid_1), ',%' ));
    for subcontractid_cursor in
    (select id from CRM_Contract
    where (manager in (select distinct id from HrmResource where concat(',',managerstr) like managerstr_11 ) ))
    loop
        select count(contractid) into countrec from temptablevaluecontract where contractid = contractid_1;
        if countrec = 0  then
            insert into temptablevaluecontract values(contractid_1, 3);
        end if;
    end loop;
 /*  �Լ��� manager �Ŀͻ���ͬ 2 */
    for contractid_cursor in
    (select id from CRM_Contract where manager = resourceid_1)
    loop
        insert into temptablevaluecontract values(contractid_1, 2);
    end loop;
    
    /* ��Ϊ�ͻ���ͬ����Ա�ܿ����� */
    for roleids_cursor in
    (select roleid from SystemRightRoles where rightid = 396)
    loop

       for rolecontractid_cursor in
       (select distinct t1.id from CRM_Contract  t1, hrmrolemembers  t2  
       where t2.roleid=contractroleid_1 and t2.resourceid=resourceid_1 
       and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1 ) 
       or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
       
         loop
            select count(contractid) into countrec from temptablevaluecontract where contractid = contractid_1;
            if countrec = 0 then  
                insert into temptablevaluecontract values(contractid_1, 2);
            else
                select sharelevel into sharelevel_1 from ContractShareDetail where contractid = contractid_1 
                and userid = resourceid_1 and usertype = 1;
                if sharelevel_1 = 1 then
                     update ContractShareDetail 
                     set sharelevel = 2 where contractid = contractid_1 
                     and userid = resourceid_1 and usertype = 1;
                end if;
            end if;  
         end loop;
        
    end loop;
    
      /* �ɿͻ���ͬ�Ĺ����õ�Ȩ�� 1 2 */
    for sharecontractid_cursor in
    (select distinct t2.relateditemid , t2.sharelevel from Contract_ShareInfo  t2 
     where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  
     or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)))
    loop
        select count(contractid) into countrec from temptablevaluecontract where contractid = contractid_1;
        if countrec = 0 then  
            insert into temptablevaluecontract values(contractid_1, sharelevel_1);
        else
            select sharelevel into sharelevel_Temp from temptablevaluecontract 
            where contractid = contractid_1;
            if ((sharelevel_Temp = 1) and (sharelevel_1 = 2)) then
               update temptablevaluecontract set sharelevel = sharelevel_1 
               where contractid = contractid_1;
            end if;
         end if;
    end loop;



    for sharecontractid_cursor in
    (select distinct t2.relateditemid , t2.sharelevel 
    from CRM_Contract t1 ,  Contract_ShareInfo  t2,  HrmRoleMembers  t3  
    where  t1.id = t2.relateditemid and t3.resourceid=resourceid_1 
    and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel 
    and t2.seclevel<=seclevel_1 
    and ( (t2.rolelevel=0  and t1.department=departmentid_1) 
    or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) ))
     
        loop
        select count(contractid) into countrec from temptablevaluecontract where contractid = contractid_1;  
        if countrec = 0 then
            insert into temptablevaluecontract values(contractid_1, sharelevel_1);
        else
            select sharelevel into sharelevel_Temp from temptablevaluecontract where contractid = contractid_1;
            if ((sharelevel_Temp = 1) and (sharelevel_1 = 2)) then
              update temptablevaluecontract set sharelevel = sharelevel_1 where contractid = contractid_1;
            end if;
         end if;   
         end loop;
    /* �Լ��¼��Ŀͻ���ͬ  (�ͻ�����������)*/
     
    
    
    managerstr_11:= concat('%,',concat(to_char(resourceid_1),',%')); 


    for subcontractid_cursor in   
    (select t2.id from CRM_CustomerInfo t1, CRM_Contract t2 where ( t1.manager in 
    (select distinct id from HrmResource where concat(',',managerstr) like managerstr_11) ) 
    and (t2.crmId = t1.id))
    loop     
        select count(contractid) into countrec from temptablevaluecontract
        where contractid = contractid_1;
        if countrec = 0  then
              insert into temptablevaluecontract values(contractid_1, 1);
        end if;
    end loop;    
 
    /*  �Լ��� manager �Ŀͻ� (�ͻ�����������) */
    for contractid_cursor in
    (select t2.id from CRM_CustomerInfo t1 , CRM_Contract t2 
    where (t1.manager = resourceid_1 ) and (t2.crmId = t1.id))
        loop
          insert into temptablevaluecontract values(contractid_1, 1);
        end loop;


    /* ɾ��ԭ�е������Ա��ص�����Ȩ */
    delete from ContractShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allcontractid_cursor in
    (select * from temptablevaluecontract)
    loop
        insert into ContractShareDetail( contractid, userid, usertype, sharelevel) 
        values(contractid_1, resourceid_1,1,sharelevel_1);
end loop;

end ;
/