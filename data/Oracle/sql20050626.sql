Create or replace PROCEDURE PDocShare_SetById (
	docid_1  integer , 
	flag out integer,
	msg out varchar2,
	thecursor IN OUT cursor_define.weavercursor )
AS
    doccreaterid_1 integer;
	hrmid integer;
	sharelevel_1 integer;
begin
    /*ɾ��docsharedetail����ص�����*/
    
	delete docsharedetail where docid = docid_1;

    /*�����ĵ������ߵĹ���*/
    select doccreaterid into doccreaterid_1  from docdetail where id =  docid_1;
    insert into docsharedetail(docid,userid,usertype,sharelevel) values(docid_1,doccreaterid_1,1,2);

    /*ѭ������docshare�еļ�¼*/
    for all_cursor in
		(select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2 where  t1.loginid is not null and t2.docid = docid_1 and ( (t2.foralluser=1 and t2.seclevel<=t1.seclevel)  or ( t2.userid= t1.id ) or (t2.departmentid=t1.departmentid and t2.seclevel<=t1.seclevel)))
	loop
		hrmid :=all_cursor.id;
		sharelevel_1:= all_cursor.sharelevel;
		insert into docsharedetail(docid,userid,usertype,sharelevel) values(docid_1,hrmid,1,sharelevel_1);     
	end loop;  
end;
/
