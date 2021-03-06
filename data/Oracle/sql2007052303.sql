CREATE or REPLACE PROCEDURE workflow_CurOpe_UpdatebyPass 
(requestid_1 integer,flag out integer,msg out varchar2,thecursor IN OUT cursor_define.weavercursor)
AS 
currentdate char(10);
currenttime char(8);

begin 
select to_char(sysdate,'yyyy-mm-dd') into currentdate from dual;
select to_char(sysdate,'hh24:mi:ss') into currenttime from dual;

update workflow_currentoperator 
set isremark=2,operatedate=currentdate,operatetime=currenttime 
where requestid =requestid_1 and isremark=0;

end;
/