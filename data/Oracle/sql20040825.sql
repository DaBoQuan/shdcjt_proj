 CREATE OR REPLACE PROCEDURE HrmResourceDateCheck
 (today_1 char,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
 as 
 begin
 update HrmResource set
   status = 7
 where
    (status = 0 or status = 1 or status = 2 or status = 3) and enddate < today_1 and enddate is not null;
 update HrmResource set
   status = 3
 where
   status = 0 and probationenddate < today_1 ;
end;
/
/*td:996 by dp for ������Դ������Ƹ����ְ�����ݺ�,�����¼��*/
CREATE or REPLACE procedure HrmResourceDateCheck
 (today_1 char,
	flag out integer  , 
	msg  out varchar2,
 thecursor IN OUT cursor_define.weavercursor)
 as
 begin
 update HrmResource set status = 7 , loginid='',password='' where (status = 0 or status = 1 or status = 2 or status = 3) and enddate < today_1 and enddate is not null ;
 update HrmResource set status = 3  where   status = 0 and probationenddate < today_1 ;
end;
/
update HrmResource set loginid='',password='' where status not in (0,1,2,3)
/