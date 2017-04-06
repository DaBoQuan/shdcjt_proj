CREATE or REPLACE procedure HrmResourceDateCheck
 (today_1 char,
	flag out integer  ,
	msg  out varchar2,
 thecursor IN OUT cursor_define.weavercursor)
 as
 begin
 /* ���������ڵ��˵���Ա��Ϊ��Ч״̬ */
 update HrmResource set status = 7 , loginid='',password='' where (status = 0 or status = 1 or status = 2 or status = 3) and enddate < today_1 and enddate is not null ;

 /* ���������ڵ��˵���Ա��Ϊ��������״̬ */
 update HrmResource set status = 3 where status = 0 and probationenddate < today_1 and probationenddate is not null ;

 /* ����������δ������Ա���������ڸĻ�����״̬ */
 update HrmResource set status = 0 where status = 3 and (probationenddate >= today_1 or probationenddate is null) ;
end;
/
