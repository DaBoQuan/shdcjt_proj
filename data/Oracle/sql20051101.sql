CREATE or REPLACE PROCEDURE Doc_SecCategory_Insert 
	(subcategoryid_1 	integer,
	categoryname_2 	varchar2,
	docmouldid_3 	integer,
	publishable_4 	char,
	replyable_5 	char,
	shareable_6 	char,
	cusertype_7 	integer,
	cuserseclevel_8 	smallint,
	cdepartmentid1_9 	integer,
	cdepseclevel1_10 	smallint,
	cdepartmentid2_11 	integer,
	cdepseclevel2_12 	smallint,
	croleid1_13	 		integer,
	crolelevel1_14	 	char,
	croleid2_15	 	integer,
	crolelevel2_16 	char,
	croleid3_17	 	integer,
	crolelevel3_18 	char,
	hasaccessory_19	 	char,
	accessorynum_20	 	smallint,
	hasasset_21		 	char,
	assetlabel_22	 	varchar2,
	hasitems_23	 	char,
	itemlabel_24 	varchar2,
	hashrmres_25 	char,
	hrmreslabel_26 	varchar2,
	hascrm_27	 	char,
	crmlabel_28	 	varchar2,
	hasproject_29 	char,
	projectlabel_30 	varchar2,
	hasfinance_31 	char,
	financelabel_32 	varchar2,
	approveworkflowid_33	integer,
	markable_34   char,
	markAnonymity_35   char,
	orderable_36     char,
	defaultLockedDoc_37   integer,
	allownModiMShareL_38 integer,
	allownModiMShareW_39 integer,
	flag	out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor)
as 
begin 

	insert into docseccategory 
		(subcategoryid  ,
		categoryname  ,
		docmouldid  ,
		publishable  ,
		replyable  ,
		shareable  ,
		cusertype  ,
		cuserseclevel  ,
		cdepartmentid1  ,
		cdepseclevel1  ,
		cdepartmentid2  ,
		cdepseclevel2  ,
		croleid1 ,
		crolelevel1  ,
		croleid2  ,
		crolelevel2 ,
		croleid3  ,
		crolelevel3  ,
		hasaccessory  ,
		accessorynum  ,
		hasasset  ,
		assetlabel  ,
		hasitems  ,
		itemlabel  ,
		hashrmres ,
		hrmreslabel  ,
		hascrm  ,
		crmlabel  ,
		hasproject  ,
		projectlabel  ,
		hasfinance  ,
		financelabel  ,
		approveworkflowid ,
		markable ,
		markAnonymity ,
		orderable,
		defaultLockedDoc,
		allownModiMShareL,
		allownModiMShareW)
	values(
		subcategoryid_1 	,
		categoryname_2 	,
		docmouldid_3 		,
		publishable_4		,
		replyable_5 		,
		shareable_6 		,
		cusertype_7 		,
		cuserseclevel_8 	,
		cdepartmentid1_9 	,
		cdepseclevel1_10 	,
		cdepartmentid2_11 ,
		cdepseclevel2_12 	,
		croleid1_13	 	,
		crolelevel1_14	,
		croleid2_15	 	,
		crolelevel2_16 	,
		croleid3_17	 	,
		crolelevel3_18 	,
		hasaccessory_19	,
		accessorynum_20	,
		hasasset_21		,
		assetlabel_22	 	,
		hasitems_23	 	,
		itemlabel_24 		,
		hashrmres_25 		,
		hrmreslabel_26 	,
		hascrm_27	 	,
		crmlabel_28	 	,
		hasproject_29 	,
		projectlabel_30 	,
		hasfinance_31 	,
		financelabel_32 	,
		approveworkflowid_33,
		markable_34       ,
		markAnonymity_35  ,
		orderable_36     ,
		defaultLockedDoc_37,
		allownModiMShareL_38 ,
		allownModiMShareW_39);
	open thecursor for 
	select max(id) from docseccategory;
end;
/ 
CREATE or REPLACE PROCEDURE Doc_SecCategory_Update 
( 
	id_1	integer,
	subcategoryid_2 	integer,
	categoryname_3 	varchar2,
	docmouldid_4 	integer,
	publishable_5 	char,
	replyable_6 	char,
	shareable_7 	char,
	cusertype_8 	integer,
	cuserseclevel_9 	smallint,
	cdepartmentid1_10 	integer,
	cdepseclevel1_11 	smallint,
	cdepartmentid2_12 	integer,
	cdepseclevel2_13 	smallint,
	croleid1_14	 		integer,
	crolelevel1_15	 	char,
	croleid2_16	 	integer,
	crolelevel2_17 	char,
	croleid3_18	 	integer,
	crolelevel3_19 	char,
	hasaccessory_20	 	char,
	accessorynum_21	 	smallint,
	hasasset_22		 	char,
	assetlabel_23	 	varchar2,
	hasitems_24	 	char,
	itemlabel_25 	varchar2,
	hashrmres_26 	char,
	hrmreslabel_27 	varchar2,
	hascrm_28	 	char,
	crmlabel_29	 	varchar2,
	hasproject_30 	char,
	projectlabel_31 	varchar2,
	hasfinance_32 	char,
	financelabel_33 	varchar2,
	approveworkflowid_34	integer,
	markable_35   char,
	markAnonymity_36   char,
	orderable_37     char,
	defaultLockedDoc_38   integer,
	allownModiMShareL_39 integer,
	allownModiMShareW_40 integer,
	flag	out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor)
as
begin 
	update docseccategory set
	subcategoryid= subcategoryid_2,
	categoryname= categoryname_3,
	docmouldid= docmouldid_4,
	publishable= publishable_5,
	replyable= replyable_6,
	shareable= shareable_7,
	cusertype= cusertype_8,
	cuserseclevel= cuserseclevel_9,
	cdepartmentid1= cdepartmentid1_10,
	cdepseclevel1= cdepseclevel1_11,
	cdepartmentid2= cdepartmentid2_12,
	cdepseclevel2= cdepseclevel2_13,
	croleid1= croleid1_14,
	crolelevel1= crolelevel1_15,
	croleid2= croleid2_16,
	crolelevel2= crolelevel2_17,
	croleid3= croleid3_18,
	crolelevel3= crolelevel3_19,
	hasaccessory= hasaccessory_20,
	accessorynum= accessorynum_21,
	hasasset= hasasset_22,
	assetlabel= assetlabel_23,
	hasitems= hasitems_24,
	itemlabel= itemlabel_25,
	hashrmres= hashrmres_26,
	hrmreslabel= hrmreslabel_27,
	hascrm= hascrm_28,
	crmlabel= crmlabel_29,
	hasproject= hasproject_30,
	projectlabel= projectlabel_31,
	hasfinance= hasfinance_32,
	financelabel= financelabel_33,
	approveworkflowid= approveworkflowid_34,
	markable = markable_35       ,
	markAnonymity = markAnonymity_36  ,
	orderable = orderable_37 ,
	defaultLockedDoc=defaultLockedDoc_38,
	allownModiMShareL=allownModiMShareL_39,
	allownModiMShareW=allownModiMShareW_40
	where id= id_1;
end;
/


CREATE or REPLACE PROCEDURE Doc_setDocShareByHrm 
(
	resourceid_1  integer,
	seclevel_1 integer,
	departmentid_1 integer,
	subcompanyid_1 integer,
	flag out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor)
as 
	docid_1 integer;
	sharelevel_1  integer;
	countrec integer;
	managerIds varchar2(50);
	sepindex integer;
	managerId integer;
	tempDownOwnerId integer;
begin 
	 /* ɾ��ԭ�еĸ��˵������ĵ�������Ϣ */
	delete from DocShareDetail where userid = resourceid_1 and usertype = 1;
	/*���ڶ��ĵ���Ȩ�޴���������޸� 
���Ѳ�����Ĭ�϶��Լ����ĵ�������ȫ����Ȩ��,Ҳ����Ĭ�϶����ѵ��¼����в鿴Ȩ��*/
	/*�Բ����Լ��������ĵ������������Լ����ĵ�������ȫ����Ȩ��*/
	for docid_cursor in(
	select id from docdetail where doccreaterid!= ownerid  and ownerid=resourceid_1)
		loop
			docid_1 := docid_cursor.id;  
			insert into temptablevalue values(docid_1, 3);
		end loop;
			
	/*��shareTypeΪ80�� ��ʾ���Լ����ĵ��Ŀ���Ȩ��*/
	for docid_cursor in(
	select distinct docid,sharelevel from docshare where sharetype=80 and userid=resourceid_1)
		loop
			docid_1 := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue values(docid_1, sharelevel_1);
		end loop;
	  
	/*��shareTypeΪ81�� ��ʾ���Լ���ֱ���¼����ĵ�*/
	for docid_cursor in(
	select  distinct docid,sharelevel from docshare  where sharetype=81 and userid in ( select id from hrmresource where managerid =resourceid_1))
		loop
			docid_1 := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue values(docid_1, sharelevel_1);
		end loop;
	
	/*��shareTypeΪ82��  ��ʾ���Լ�������*/ 
	for docid_cursor in(
	select  distinct docid,sharelevel from docshare  where sharetype=82 and userid in ( select id from hrmresource where concat(',',managerstr) like  concat(concat('%,',chr(resourceid_1)),',%')))
		loop
			docid_1 := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue values(docid_1, sharelevel_1);
		end loop;
	
	/*��shareTypeΪ83��  ��ʾ���Լ��ļ���ϼ�*/  
	select concat(managerstr,'0') into managerIds from  hrmresource where id =resourceid_1;
    sepindex := INSTR(managerIds,',');
	while sepindex != 0 
	loop     
     managerId := to_number(SUBSTR(managerIds,1,(sepindex-1)));
	 managerIds := SUBSTR(managerIds,(sepindex+1),(Length(managerIds)-sepindex));
	 sepindex := INSTR(managerIds,',');
		for docid_cursor in(
		select  distinct docid,sharelevel from docshare  where sharetype=83 and userid =managerId and  
		seclevel<=seclevel_1)
		loop
			docid_1 := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue values(docid_1, sharelevel_1);
		end loop;    
	end loop;
	/*��shareTypeΪ84�� ������ͬ�ֲ�*/
	for docid_cursor in(
		select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and 
		d1.sharetype=84  and  d1.seclevel<=seclevel_1 and d1.subcompanyid = subcompanyid_1)
	loop
		docid_1 :=docid_cursor.docid;
		sharelevel_1:=docid_cursor.sharelevel;
		insert into temptablevalue values(docid_1, sharelevel_1);
	end loop;
	
	/*��shareTypeΪ85�� ������ͬ����*/    
	for docid_cursor in(
		select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and 
		d1.sharetype=85  and  d1.seclevel<=seclevel_1 and d1.departmentid = departmentid_1)
	loop
		docid_1 :=docid_cursor.docid;
		sharelevel_1:=docid_cursor.sharelevel;
		insert into temptablevalue values(docid_1, sharelevel_1);
	end loop;
	
	/*��shareTypeΪ-81�� �����˵�ֱ�ӿͻ�*/ 
	for docid_cursor in(
		select  distinct docid,sharelevel from docshare   where sharetype=-81 and  userid in (select id  from 
		CRM_CustomerInfo   where manager=resourceid_1))
	loop
		docid_1 :=docid_cursor.docid;
		sharelevel_1:=docid_cursor.sharelevel;
		insert into temptablevalue values(docid_1, sharelevel_1);
	end loop;    
	
	/*��shareTypeΪ-82�� �����˵��¼��Ŀͻ�*/ 

   
	for downOwner_cursor in(
	select id from hrmresource where managerid=resourceid_1)
	loop   
		tempDownOwnerId := downOwner_cursor.id;
		for docid_cursor in(
		select  distinct docid,sharelevel from docshare  where sharetype=-82 and  userid in (select id  from 
		CRM_CustomerInfo   where manager=resourceid_1))
		loop
			docid_1 :=docid_cursor.docid;
			sharelevel_1:=docid_cursor.sharelevel;
			insert into temptablevalue values(docid_1, sharelevel_1);
		end loop; 
		
	end loop;    


	/* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
	for sharedocid_cursor in(
	select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= seclevel_1 ) 
	 or ( userid= resourceid_1 ) or (departmentid= departmentid_1 and seclevel<= seclevel_1 ) 
	 and sharetype not in (80,81,82,83,84,85,-80,-81,-82) )
	loop 
		docid_1 := sharedocid_cursor.docid;
		sharelevel_1 := sharedocid_cursor.sharelevel;
		select count(docid) into countrec from temptablevalue where docid = docid_1;
		if countrec = 0
			then
			insert into temptablevalue values(docid_1, sharelevel_1);
		elsif sharelevel_1 = 2
			then
			update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
		end if;
	end loop; 

	for sharedocid_cursor in(
		select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , hrmdepartment t4 where t1.id=t2.docid and t3.resourceid= resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel  and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= departmentid_1 )  or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= subcompanyid_1 ) or (t3.rolelevel=2) ) and t2.sharetype not in (80,81,82,83,84,85,-80,-81,-82))
	loop 
		docid_1 := sharedocid_cursor.docid;
		sharelevel_1 := sharedocid_cursor.sharelevel;
		select count(docid) into countrec from temptablevalue where docid = docid_1;
		if countrec = 0  
			then
			insert into temptablevalue values(docid_1, sharelevel_1);
		elsif sharelevel_1 = 2
			then
			update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */ 
		end if;
	end loop;
	  

	/* ����ʱ���е�����д�빲��� */
	for alldocid_cursor in(
	select docid ,max(sharelevel) as sharelevel from temptablevalue group by docid)
	loop 
		docid_1 :=alldocid_cursor.docid; 
		sharelevel_1:= alldocid_cursor.sharelevel;
		insert into docsharedetail values(docid_1, resourceid_1,1,sharelevel_1);
	end loop;
end;
/


/* ������ʱ����� */
CREATE GLOBAL TEMPORARY table temptablevalue_2
	(docid integer,
	sharelevel integer,
	usertype integer)
	ON COMMIT DELETE ROWS
/


 /*��һ�����˵�һƪ�ĵ����в���*/
CREATE or REPLACE   PROCEDURE Doc_setDocShareByHrmAndDoc
(    
	resourceid_1  integer,
	docid_1 integer,
	usertype_1 integer,
	seclevel_1 integer,
	departmentid_1 integer,
	subcompanyid_1 integer,
	flag out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor)
as 
	 docid_temp integer;
	 sharelevel_1  integer;
	 countrec integer;
	 managerIds varchar2(50);
	 sepindex integer;
	 managerId integer;
	 tempDownOwnerId integer;
	 crmtype integer;
begin
	/* ɾ��ԭ�еĸ��˴��ĵ�������Ϣ */
	delete from DocShareDetail where userid = resourceid_1 and usertype = usertype_1 and docid=docid_1;

	 /*�Բ����Լ��������ĵ������������Լ����ĵ�������ȫ����Ȩ��*/
	for docid_cursor in(
		select id from docdetail where doccreaterid!= ownerid  and ownerid=resourceid_1 and id=docid_1 and 
		usertype=usertype_1)
	loop 
		docid_temp := docid_cursor.id;
		insert into temptablevalue_2 values(docid_temp, 3,usertype_1);
	end loop;
	if usertype_1=1 /*�ڲ��û�*/
		then/*���ڶ��ĵ���Ȩ�޴���������޸����Ѳ�����Ĭ�϶��Լ����ĵ�������ȫ����Ȩ��,Ҳ����Ĭ�϶����ѵ��¼����в鿴Ȩ��*/   
		/*��shareTypeΪ80�� ��ʾ���Լ����ĵ��Ŀ���Ȩ��*/
		for docid_cursor in(
			select distinct docid,sharelevel from docshare where sharetype=80 and userid=resourceid_1 and 
			docid=docid_1)
		loop 
	
			docid_temp := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
		end loop;
		
		/*��shareTypeΪ81�� ��ʾ���Լ���ֱ���¼����ĵ�*/
	  
		for docid_cursor in(
			select  distinct docid,sharelevel from docshare  where sharetype=81 and userid in ( select id from 
			hrmresource where managerid =resourceid_1) and docid=docid_1)
		loop 
	
			docid_temp := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
		end loop;
		
		/*��shareTypeΪ82��  ��ʾ���Լ�������*/ 
		for docid_cursor in(
			 
			select  distinct docid,sharelevel from docshare  where sharetype=82 and userid in ( select id from 
			hrmresource where concat(',',managerstr) like  concat(concat('%,',chr(resourceid_1)),',%')) and 
			docid=docid_1)
					
		loop
			docid_temp := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
		end loop;
		  
		 /*��shareTypeΪ83��  ��ʾ���Լ��ļ���ϼ�*/  
		select concat(managerstr,'0') into managerIds from  hrmresource where id =resourceid_1;
		sepindex := INSTR(managerIds,',') ; 
		while sepindex != 0 
		loop     
			 managerId := to_number(SUBSTR(managerIds,1,sepindex-1));
			 managerIds := SUBSTR(managerIds,sepindex+1,Length(managerIds)-sepindex);
			 sepindex := INSTR(managerIds,',');
			
			for docid_cursor in(
				select  distinct docid,sharelevel from docshare  where sharetype=83 and userid =managerId and  
				seclevel<=seclevel_1 and docid=docid_1)
			loop
				docid_temp :=docid_cursor.docid;
				sharelevel_1 :=docid_cursor.sharelevel;
				insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
			end loop;    
		end loop;
		
		
		/*��shareTypeΪ84�� ������ͬ�ֲ�*/
		for docid_cursor in(
			select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and 
			d1.sharetype=84  and  d1.seclevel<=seclevel_1 and d1.subcompanyid = subcompanyid_1 and d1.docid=docid_1)
		loop
			docid_temp :=docid_cursor.docid;
			sharelevel_1:=docid_cursor.sharelevel;
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
		end loop;
	
	   
	 /*��shareTypeΪ85�� ������ͬ����*/    
		for docid_cursor in(
			select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and 
			d1.sharetype=85  and  d1.seclevel<=seclevel_1 and d1.departmentid = departmentid_1 and d1.docid=docid_1)
		loop
			docid_temp :=docid_cursor.docid;
			sharelevel_1:=docid_cursor.sharelevel;
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
		end loop;
	  
		
			/*��shareTypeΪ-81�� �����˵�ֱ�ӿͻ�*/ 
		for docid_cursor in(
			select  distinct docid,sharelevel from docshare   where sharetype=-81 and  userid in (select id  from 
			CRM_CustomerInfo   where manager=resourceid_1) and docid=docid_1)
		loop
			docid_temp :=docid_cursor.docid;
			sharelevel_1:=docid_cursor.sharelevel;
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
		end loop;  

		  /*��shareTypeΪ-82�� �����˵��¼��Ŀͻ�*/ 
		   
		for downOwner_cursor in(
			select id from hrmresource where managerid=resourceid_1)
		loop   
			tempDownOwnerId := downOwner_cursor.id;
			for docid_cursor in(
				select  distinct docid,sharelevel from docshare  where sharetype=-82 and  userid in (select id  
				from CRM_CustomerInfo   where manager=resourceid_1))
			loop
				docid_temp :=docid_cursor.docid;
				sharelevel_1:=docid_cursor.sharelevel;
				insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
			end loop; 
		end loop;       

		/* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
		for sharedocid_cursor in(
			select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= seclevel_1 ) 
			or ( userid= resourceid_1 ) or (departmentid= departmentid_1 and seclevel<= seclevel_1 ) 
			and sharetype not in (80,81,82,83,84,85,-80,-81,-82)  and docid=docid_1 )
		loop 
			docid_temp := sharedocid_cursor.docid;
			sharelevel_1 := sharedocid_cursor.sharelevel;
			select count(docid) into countrec from temptablevalue_2  where docid = docid_temp;
			if countrec = 0
				then
				insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
			elsif sharelevel_1 = 2
				then
				update temptablevalue_2 set sharelevel = 2 where docid=docid_temp ;/* �����ǿ��Ա༭, ���޸�ԭ�м�¼  */
			end if;
		end loop; 

		for sharedocid_cursor in(
			select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , 
			hrmdepartment  t4 
			where t1.id=t2.docid and t3.resourceid= resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel
			and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= departmentid_1 ) 
			or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= subcompanyid_1 ) or (t3.rolelevel=2) ) and t2.sharetype not in (80,81,82,83,84,85,-80,-81,-82) and t2.docid=docid_1)
		loop 
			docid_temp :=sharedocid_cursor.docid;
			sharelevel_1:=sharedocid_cursor.sharelevel;
			select count(docid) into countrec from temptablevalue_2 where docid = docid_temp;
			if countrec = 0  
				then
				insert into temptablevalue_2 values(docid_temp, sharelevel_1,usertype_1);
			elsif sharelevel_1 = 2
				then
				update temptablevalue_2 set sharelevel = 2 where docid=docid_temp; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼*/
			end if;

		end loop;

	else  /*�ⲿ�û�*/
		 /*��shareTypeΪ-80�� �����˵�ֱ�ӿͻ�*/ 
		for docid_cursor in
			(select  distinct docid,sharelevel from docshare   where sharetype=-80 and  userid= resourceid_1 and 
			docid=docid_1)
		loop 
			docid_temp := docid_cursor.docid;
			sharelevel_1 := docid_cursor.sharelevel;
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,9);
		end loop;  
		
		/*���Ƿ��д��ⲿ�û���������ҵ*/
		select type into crmtype from CRM_CustomerInfo where id=resourceid_1;
		select  count(id) into countrec from docshare where sharetype=(-1)*crmtype and seclevel<=seclevel_1 and 
		docid=docid_1;
		if countrec=1 
			then
			insert into temptablevalue_2 values(docid_temp, sharelevel_1,9);
		end if;
	end if;
 
 /* ����ʱ���е�����д�빲��� */
	for alldocid_cursor in(
	select docid ,max(sharelevel) as sharelevel from temptablevalue_2 group by docid)
	loop 
		docid_temp :=alldocid_cursor.docid; 
		sharelevel_1 := alldocid_cursor.sharelevel;
		if usertype_1=1 
			then
			insert into docsharedetail (docid,userid,usertype,sharelevel) values(docid_temp,resourceid_1,1,sharelevel_1);
		else
			insert into docsharedetail (docid,userid,usertype,sharelevel) values(docid_temp, 
			resourceid_1,9,sharelevel_1);
		end if;
	end loop;
end;
/
CREATE  or replace  PROCEDURE DocShare_FromDocSecCategoryI
(
	docid_1  integer, 
	sharetype_2	integer,
	seclevel_3	smallint,
	rolelevel_4	smallint, 
	sharelevel_5	smallint,
	userid_6	integer, 
	subcompanyid_7	integer,
	departmentid_8	integer, 
	roleid_9	integer, 
	foralluser_10	smallint,
	crmid_11	integer,
	sharesource_12 integer,
	flag	out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor
	)
as
	count_1 integer;
begin
	select  count(*)  into count_1 from DocShare where docid=docid_1 and sharetype=sharetype_2 and seclevel=seclevel_3 and rolelevel=rolelevel_4 and sharelevel<=sharelevel_5 	and userid=userid_6 and subcompanyid=subcompanyid_7 and departmentid=departmentid_8 and roleid=roleid_9 and foralluser=foralluser_10 
	and crmid=crmid_11 and sharesource=sharesource_12;
	if count_1=0 
		then
		insert into DocShare(docid,sharetype,seclevel,rolelevel,sharelevel,userid,subcompanyid,departmentid,roleid,foralluser,crmid,sharesource) values(docid_1,sharetype_2,seclevel_3,rolelevel_4,sharelevel_5,userid_6,subcompanyid_7,departmentid_8,roleid_9,foralluser_10,crmid_11,sharesource_12);  
	else 
		update DocShare 
		set docid=docid_1 , sharetype=sharetype_2 , seclevel=seclevel_3 , rolelevel=rolelevel_4 , 
		sharelevel=sharelevel_5 , userid=userid_6 , subcompanyid=subcompanyid_7 , departmentid=departmentid_8 
		, roleid=roleid_9 , foralluser=foralluser_10 , crmid=crmid_11 , sharesource=sharesource_12
		where docid=docid_1 and sharetype=sharetype_2 and seclevel=seclevel_3 and rolelevel=rolelevel_4 and 
		sharelevel<sharelevel_5 and userid=userid_6 and subcompanyid=subcompanyid_7 and departmentid=departmentid_8 
		and roleid=roleid_9 and foralluser=foralluser_10 and crmid=crmid_11 and sharesource=sharesource_12;
	end if;
end;
/



CREATE or REPLACE PROCEDURE DocShare_IFromDocSecCategory 
( 
	docid_1    integer,
	sharetype_2	integer,
	seclevel_3	smallint,
	rolelevel_4	smallint,
	sharelevel_5	smallint,
	userid_6	integer,
	subcompanyid_7	integer,
	departmentid_8	integer,
	roleid_9	integer,
	foralluser_10	smallint,
	crmid_11	integer,
	flag	out integer,
	msg out varchar2, 
	thecursor IN OUT cursor_define.weavercursor)
as 
begin 
	insert into DocShare(docid,sharetype,seclevel,rolelevel,sharelevel,userid,
    subcompanyid,departmentid,roleid,foralluser,crmid)
    values( docid_1, sharetype_2, seclevel_3, rolelevel_4, sharelevel_5, 
    userid_6, subcompanyid_7, departmentid_8, roleid_9, foralluser_10, crmid_11);

open thecursor for 
select max(id) from  DocShare;
end;
/

/* ������ʱ����� */
CREATE GLOBAL TEMPORARY table temptablevalue_3
	(
	userid integer,
	usertype integer,
	sharelevel integer)
	ON COMMIT DELETE ROWS
/

CREATE or replace PROCEDURE DocShareDetail_SetByDoc 
(
	docid_1  integer,
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
	tempsharelevelold integer ;
	tempsharetype integer ;
	sepindex integer;
	crmManagerId integer;
	crmManagerUpIds varchar2(100);
	hrmManager integer;
	hrmJmangers varchar2(50);
	hrmallmanagerid varchar2(255);
	tempseclevel integer;
	hrmallmanagerid_re varchar2(255);
	temppos integer;
	tempHrmManager integer;
	tempDownUserId integer;
	subCompId integer;
	sameSubUserId integer;
	departmentId integer;
	sameDepartUserId integer;
	recordcounts	integer;
	recordcounts1	integer;
    recordcounts2	integer;
    recordcounts3	integer;
    recordcounts4	integer;
    recordcounts5	integer;
/*
  �����ڲ��û�:
  ȥ������ǰ�����ĵ������ߺ�������Ĭ��Ϊ�༭Ȩ�޵�����.����ȥ������ȫ���ϼ�Ĭ�Ͼ��в鿴Ȩ�޵Ŀ���
  1.�ĵ��Ĵ����߾��е�Ȩ�޸��� DocShare ���й�������Ϊ:80�� sharelevel(��������ȷ��)
  2.��������ߺ��ĵ���������ͬһ���˵Ļ�,ֻ�����ô����ߵ�Ȩ��,�������������ߵ�Ȩ��
  3.��������ߺ��ĵ������߲���ͬһ���˵Ļ�,�ĵ������߰���ص�Ȩ�޴���,�ĵ���������Ĭ�ϵ�Ȩ��ӦΪ:��ȫ����Ȩ�� 
  4.�����������ط���ͬһ�ĵ���ͬһ���˸�Ȩ��ʱ��,��ȡ����Ȩ�޵�ԭ��
  5.���ڻظ��ĵ�,Ӧ������Ĭ��Ȩ�޼̳б��ظ��ĵ���Ȩ��,�����Զ���Ȩ�޽��н�һ�����޸�
  
   ����ǰ���������ĵ��Ĵ����ߺ������߾��б༭��Ȩ��
   ��ǰ�Ļظ��ĵ�,��������,�����µĻظ��ĵ���������
   80:�����˱��� 81:������ֱ���ϼ�   82:�����˼���ϼ�   83:����������   84:������ͬ�ֲ���Ա   85:������ͬ���ų�Ա
   -80:�ⲿ�û������˱���   -81:�ⲿ�û������˾���     -82:�ⲿ�û������˾�����ϼ�
*/    
begin

	if (usertype_4 <>1) /*�����ⲿ�û��Ĳ��� -80 ~ -82*/
		then
		for shareuserid_cursor in(
			 select  sharetype,sharelevel,userid from  docshare  where docid=docid_1 and  sharetype between  -82 and -80)
		loop
			tempsharetype := shareuserid_cursor.sharetype; 
			tempsharelevel := shareuserid_cursor.sharelevel; 
			tempuserid := shareuserid_cursor.userid; 
			if (tempsharetype=-80)   /*�ⲿ�û������˱���*/
				then
				if (tempsharelevel!=0) 
					then
					insert into temptablevalue_3 values (tempuserid,2, tempsharelevel);
					if createrid_2!=owenerid_3 /*����ĵ������ߺ��ĵ������߲���һ����,���ĵ�������Ĭ��Ϊ��ȫ����Ȩ��*/
						then
						insert into temptablevalue_3 values (owenerid_3,2, tempsharelevel);
					end if;
				end if;             
			elsif (tempsharetype=-81)  /*�ⲿ�û������˾���*/
				then 
				select manager into crmManagerId from CRM_CustomerInfo  where id=tempuserid;

				if (tempsharelevel!=0) 
					then
					insert into temptablevalue_3(userid,usertype,sharelevel) values(crmManagerId,1,tempsharelevel); 		 
				end if; 
			
			 elsif (tempsharetype=-82)   /*�ⲿ�û������˾���������ϼ�*/
				then        
				select manager into crmManagerId from CRM_CustomerInfo  where id=tempuserid;
				select concat(managerstr,'0') into crmManagerUpIds  from  hrmresource where id =crmManagerId;
				sepindex := INSTR(crmManagerUpIds,','); 
				while  sepindex != 0 
				loop 
					tempuserid := to_number( SUBSTR(crmManagerUpIds,1,(sepindex-1)));
					crmManagerUpIds := SUBSTR(crmManagerUpIds,(sepindex+1),(length(crmManagerUpIds)-sepindex));
					sepindex := INSTR(crmManagerUpIds,',');
					if tempsharelevel != 0
						then
						insert into temptablevalue_3(userid,usertype,sharelevel) values(tempuserid,1,tempsharelevel);
					end if;	
				end loop;
			end if;  
		end loop;

	else   /*�����ڲ��û��Ĳ��� +80 ~ +85*/
		for shareuserid_cursor in(
		select  sharetype,sharelevel,userid,seclevel from  docshare  where docid=docid_1 and  sharetype  between  
		80 and 85)
		loop 
			tempsharetype := shareuserid_cursor.sharetype;
			tempsharelevel := shareuserid_cursor.sharelevel;
			tempuserid := shareuserid_cursor.userid;
			tempseclevel :=shareuserid_cursor.seclevel;
			if (tempsharetype=80)   /*�ڲ��û������˱���*/
				then
				if (tempsharelevel!=0)
					then       
					tempsharelevelold := 0;
					
					
					select count(sharelevel) into recordcounts   from temptablevalue_3 where userid=tempuserid   
					and usertype=1; 

					if recordcounts> 0then
					select sharelevel into tempsharelevelold   from temptablevalue_3 where userid=tempuserid   
					and usertype=1; 
					end if;


						recordcounts:=0;	
					
					

					if (tempsharelevelold=0) 
						then/*��������*/
						insert into  temptablevalue_3(userid,usertype,sharelevel) 
						values(tempuserid,1,tempsharelevel); 
					elsif (tempsharelevel>tempsharelevelold) 
						then/*��������*/
						update temptablevalue_3  set sharelevel=tempsharelevel where userid=tempuserid  and 
						usertype=1;
					end if;

					if createrid_2!=owenerid_3  /*����ĵ������ߺ��ĵ������߲���һ����,���ĵ�������Ĭ��Ϊ��ȫ����Ȩ��*/
						then
						tempsharelevelold :=0;
						select sharelevel into tempsharelevelold  from temptablevalue_3 where 
						userid=owenerid_3  and usertype=1;  
						if (tempsharelevelold=0) 
							then/*��������*/
							insert into  temptablevalue_3(userid,usertype,sharelevel)values(owenerid_3,1,tempsharelevel);
						elsif(tempsharelevel>tempsharelevelold)
							then/*��������*/
							update temptablevalue_3  set sharelevel=tempsharelevel where userid=owenerid_3  
							and usertype=1;
						end if;
					end if;
				end if; 

			elsif (tempsharetype=81)   /*�ڲ��û�������ֱ���ϼ�*/  
				then               
				if (tempsharelevel!=0)
					then   
					select managerid into hrmManager  from hrmresource where id=tempuserid;                      

					if hrmManager >=0
						then
						tempsharelevelold := 0;


					select count(sharelevel) into recordcounts1   from temptablevalue_3 where userid=hrmManager   
					and usertype=1; 

					if recordcounts1> 0then
					select sharelevel into tempsharelevelold   from temptablevalue_3 where userid=hrmManager   
					and usertype=1; 
					end if;

             


				 
						if (tempsharelevelold=0) 
							then/*��������*/
							insert into  temptablevalue_3(userid,usertype,sharelevel) 
							values(hrmManager,1,tempsharelevel);
		  
						elsif (tempsharelevel>tempsharelevelold)
							then/*��������*/
							update temptablevalue_3  set sharelevel=tempsharelevel where userid=hrmManager;
						end if;
					end if;           
				end if;
			elsif (tempsharetype=82)   /*�ڲ��û������˱��˼���ϼ�*/
				then
				if (tempsharelevel!=0)
					then   
					select  managerstr into hrmallmanagerid   from hrmresource where id=tempuserid;
					hrmallmanagerid_re :=  to_char(hrmallmanagerid) ;
					temppos := INSTR(hrmallmanagerid_re, ',') ;
					temppos := INSTR(hrmallmanagerid_re,',',temppos+1);
					if  temppos <>0 
						then
					     hrmallmanagerid_re := SUBSTR(hrmallmanagerid_re,temppos,length(hrmallmanagerid_re));
					end if;	/*hrmJmangersΪ�����ϼ�*/
					hrmJmangers := to_char(hrmallmanagerid_re);
					sepindex := INSTR(hrmJmangers,',')  ;
					while  (sepindex != 0)
						loop 
						tempHrmManager := to_number( SUBSTR (hrmJmangers,1,(sepindex-1))); 
						hrmJmangers := SUBSTR(hrmJmangers,(sepindex+1),(length(hrmJmangers)-sepindex));       
						sepindex := INSTR(hrmJmangers,',') ; 
						tempsharelevelold := 0;
						select sharelevel into tempsharelevelold  from temptablevalue_3 where 
						userid=tempHrmManager  and usertype=1;   
						if (tempsharelevelold=0) 
							then/*��������*/
							insert into  temptablevalue_3(userid,usertype,sharelevel)values(tempHrmManager,1,tempsharelevel);
						elsif (tempsharelevel>tempsharelevelold)
							then /*��������*/
							update temptablevalue_3  set sharelevel=tempsharelevel where userid=tempHrmManager and 
							usertype=1 ;
						end if;	
					end  loop;  
				end if;
			elsif (tempsharetype=83)   /*�ڲ��û�����������*/
				then
				if (tempsharelevel!=0)
					then
					for temp_cursor in(
					select id from  hrmresource where concat(',',managerstr) like 
					concat(concat('%,',to_char(tempuserid)),',%') and seclevel>=tempseclevel and loginid is not 
					null and loginid !='')
					loop
						tempDownUserId := temp_cursor.id;
						tempsharelevelold := 0;
						select sharelevel into tempsharelevelold  from temptablevalue_3 where 
						userid=tempDownUserId and usertype=1 ;  
						if (tempsharelevelold=0)
							then /*��������*/
							insert into  temptablevalue_3(userid,usertype,sharelevel) values(tempDownUserId,1,tempsharelevel);
						elsif (tempsharelevel>tempsharelevelold) 
							then/*��������*/
							update temptablevalue_3  set sharelevel=tempsharelevel where userid=tempDownUserId  
							and usertype=1;
						end if;	
					end loop;
				end if;
			elsif (tempsharetype=84)   /*�ڲ��û�������ͬ�ֲ�*/
				then
				if (tempsharelevel!=0)
					then
					select subcompanyid1 into subCompId   from  hrmresource where id=tempuserid;
					for temp_cursor in(
					select id from  hrmresource where subcompanyid1=subCompId and seclevel>=tempseclevel   and 
					loginid is not null)
					loop
						sameSubUserId := temp_cursor.id;
						tempsharelevelold := 0;



					select count(sharelevel) into recordcounts3   from temptablevalue_3 where userid=sameSubUserId   
					and usertype=1; 

					if recordcounts3> 0then
					select sharelevel into tempsharelevelold   from temptablevalue_3 where userid=sameSubUserId   
					and usertype=1; 
					end if;




						if (tempsharelevelold=0) 
							then/*��������*/
							insert into  temptablevalue_3(userid,usertype,sharelevel) 
							values(sameSubUserId,1,tempsharelevel);
						elsif (tempsharelevel>tempsharelevelold)
							then /*��������*/
							update temptablevalue_3  set sharelevel=tempsharelevel where userid=sameSubUserId and 
							usertype=1 ;
						end if;
					end loop;
				end if; 
			elsif (tempsharetype=85)   /*�ڲ��û�������ͬ����*/
				then
				if (tempsharelevel!=0)
					then
					select departmentid into departmentId   from  hrmresource where id=tempuserid;
					for temp_cursor in(
						select id from  hrmresource where departmentid=departmentId and 
					seclevel>=tempseclevel  and loginid is not null )
					loop
						sameDepartUserId := temp_cursor.id;
						tempsharelevelold := 0;

					select count(sharelevel) into recordcounts2   from temptablevalue_3 where userid=sameDepartUserId   
					and usertype=1; 

					if recordcounts2> 0then
					select sharelevel into tempsharelevelold   from temptablevalue_3 where userid=sameDepartUserId   
					and usertype=1; 
					end if;


			
						if (tempsharelevelold=0) /*��������*/
							then
							insert into  temptablevalue_3(userid,usertype,sharelevel) 
							values(sameDepartUserId,1,tempsharelevel) ;
						elsif (tempsharelevel>tempsharelevelold) /*��������*/
							then
							update temptablevalue_3  set sharelevel=tempsharelevel where userid=sameDepartUserId 
							and usertype=1 ;
						end if;
					end loop;
				end if;
              end if;     
		end loop;
	end if;

	/* �ĵ�������Ϣ (�ڲ��û�) ���漰��ɫ���� */ 
	for shareuserid_cursor in(
		select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2 
	where  t1.loginid is not null and t2.docid = docid_1 and ( (t2.foralluser=1 and 
	t2.seclevel<=t1.seclevel)  or ( t2.userid= t1.id ) or (t2.departmentid=t1.departmentid and 
	t2.seclevel<=t1.seclevel)) and t2.sharetype not in(-80,-81,-82,80,81,82,83,84,85)  and t1.loginid is not null )
	 loop 
		tempuserid  := shareuserid_cursor.id;
		tempsharelevel  := shareuserid_cursor.sharelevel;
		tempsharelevelold := 0;

					select count(sharelevel) into recordcounts4   from temptablevalue_3 where userid=tempuserid   
					and usertype=1; 

					if recordcounts4> 0then
					select sharelevel into tempsharelevelold   from temptablevalue_3 where userid=tempuserid   
					and usertype=1; 
					end if;


		if (tempsharelevelold=0) /*��������*/
			then
			insert into temptablevalue_3(userid,usertype,sharelevel) values(tempuserid,1,tempsharelevel); 
		elsif (tempsharelevel>tempsharelevelold) /*��������*/
			then
			update temptablevalue_3 set sharelevel = tempsharelevel where userid=tempuserid and usertype = 1 ;
		end if;
	end loop;
		
	/* �ĵ�������Ϣ (�ڲ��û�) �漰��ɫ���� */ 
	for shareuserid_cursor in(
		select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2,  
	HrmRoleMembers  t3 where  t1.loginid is not null  and t2.docid = docid_1 and (  
	t3.resourceid=t1.id and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and ( (t3.rolelevel=2) or 
	(t3.rolelevel=0  and t1.departmentid=departmentid_6) or (t3.rolelevel=1 and t1.subcompanyid1=subcompanyid_7) ) ) 
	and t2.sharetype not in(-80,-81,-82,80,81,82,83,84,85) and t1.loginid is not null)
	loop
		tempuserid  := shareuserid_cursor.id;
		tempsharelevel  := shareuserid_cursor.sharelevel;
		tempsharelevelold := 0;

					select count(sharelevel) into recordcounts5   from temptablevalue_3 where userid=tempuserid   
					and usertype=1; 

					if recordcounts5> 0then
					select sharelevel into tempsharelevelold   from temptablevalue_3 where userid=tempuserid   
					and usertype=1; 
					end if;

if (tempsharelevelold=0) /*��������*/
			then
			insert into temptablevalue_3(userid,usertype,sharelevel) values(tempuserid,1,tempsharelevel);
		elsif (tempsharelevel>tempsharelevelold) /*��������*/
			then
			update temptablevalue_3 set sharelevel = tempsharelevel where userid=tempuserid and usertype = 1; 
		end if;
	end loop;

	/* �ĵ�������Ϣ �ⲿ�û� ( ���� ) */
	for shareuserid_cursor in(
		select distinct sharetype , seclevel, sharelevel from DocShare where 
	sharetype < 0 and docid = docid_1 and sharetype not in(-80,-81,-82,80,81,82,83,84,85))
	loop 
		tempsharetype := shareuserid_cursor.sharetype;
		tempuserid := shareuserid_cursor.seclevel;
		tempsharelevel  := shareuserid_cursor.sharelevel;
		tempsharelevelold := 0;
		select sharelevel into tempsharelevelold from temptablevalue_3 where userid=tempuserid and usertype = 
		tempsharetype ;  
		if (tempsharelevelold=0) /*��������*/
			then
			insert into temptablevalue_3(userid,usertype,sharelevel) values(tempuserid,tempsharetype,tempsharelevel);
		elsif(tempsharelevel>tempsharelevelold) /*��������*/
			then
			update temptablevalue_3 set sharelevel = tempsharelevel where userid=tempuserid and usertype = tempuserid ;
		end if;
	end loop;

	/* �ĵ�������Ϣ �ⲿ�û� ( �û�id ) */ 
	for shareuserid_cursor in(
		select distinct crmid , sharelevel from DocShare where crmid <> 0 and 
	sharetype = '9' and docid = docid_1 and sharetype not in(-80,-81,-82,80,81,82,83,84,85))
	loop 
		tempuserid  := shareuserid_cursor.crmid;
		tempsharelevel  := shareuserid_cursor.sharelevel;
		tempsharelevelold := 0;
		select  sharelevel into tempsharelevelold  from temptablevalue_3 where userid=tempuserid and usertype = 9; if (tempsharelevelold=0) /*��������*/
			then
			insert into temptablevalue_3(userid,usertype,sharelevel) values(tempuserid,9,tempsharelevel);
		elsif (tempsharelevel>tempsharelevelold) /*��������*/
			then
			update temptablevalue_3 set sharelevel = tempsharelevel where userid=tempuserid and usertype = 9;  
		end if;

	end loop;

	/* ����ʱ���е�����д�빲��� */ 
	delete docsharedetail where docid = docid_1;
	insert into docsharedetail (docid,userid,usertype,sharelevel) select docid_1 , userid,usertype,sharelevel from 
	temptablevalue_3;
end;
/