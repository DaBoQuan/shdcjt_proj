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
	 /*�����ڲ��û��Ĳ��� +80 ~ +85*/
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

					if recordcounts> 0 
                    then
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

					if recordcounts1> 0 
                    then
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
					null)
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

					if recordcounts3> 0 
                    then
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

					if recordcounts2> 0 
                    then
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
		select distinct t1.id , t2.sharelevel from HrmResource t1 ,  
 DocShare  t2 where  t1.loginid is not null and t2.docid =docid_1 and
 ( (t2.foralluser=1 and t2.seclevel<=t1.seclevel) 
 or ( t2.userid= t1.id ) or (t2.departmentid=t1.departmentid and t2.seclevel<=t1.seclevel)) 
 and t2.sharetype not in(-80,-81,-82,80,81,82,83,84,85)  
 
        )
	 loop 
		tempuserid  := shareuserid_cursor.id;
		tempsharelevel  := shareuserid_cursor.sharelevel;
		tempsharelevelold := 0;

					select count(sharelevel) into recordcounts4   from temptablevalue_3 where userid=tempuserid   
					and usertype=1; 

					if recordcounts4> 0 
                    then
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

					if recordcounts5> 0
                    then
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



declare
	docid_1 integer;
	doccreaterid_2 integer;
	recordCount integer;
	usertype_3 integer;
	docMax integer;
	execCount integer;
	i integer;

begin
select   max(id) into docMax  from docdetail;
i := 0;
while i<=docMax
loop     
    select  count(id) into recordCount from docdetail where id=i;
    if recordCount>0 then
    select id    ,doccreaterid    ,usertype   into docid_1,doccreaterid_2,usertype_3  from docdetail where id=i;  
		if usertype_3=1 
		then
		/*�����߱���*/

			  insert into docshare(docid,userid,sharetype,sharelevel,isSecDefaultShare) values (docid_1,doccreaterid_2,80,3,1);
	
		 /*������ֱ���ϼ�*/
	
			  insert into docshare(docid,userid,sharetype,sharelevel,isSecDefaultShare) values (docid_1,doccreaterid_2,81,1,1);
		

		 /*�����߼���ϼ�*/
	
			  insert into docshare(docid,userid,sharetype,sharelevel,isSecDefaultShare) values (docid_1,doccreaterid_2,82,1,1);
	   
		else
		/*�ⲿ�û������߱���*/

			  insert into docshare(docid,userid,sharetype,sharelevel,isSecDefaultShare) values (docid_1,doccreaterid_2,-80,3,1);

		 /*�ⲿ�û������˾���*/
	
			  insert into docshare(docid,userid,sharetype,sharelevel,isSecDefaultShare) values (docid_1,doccreaterid_2,-81,1,1);

		 /*�ⲿ�û������˾���������ϼ�*/
	
			  insert into docshare(docid,userid,sharetype,sharelevel,isSecDefaultShare) values (docid_1,doccreaterid_2,-82,1,1);
	  
		end if;
    end if;
	i:= i+1;   
end loop;
end;
/