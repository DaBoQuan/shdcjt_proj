CREATE or REPLACE PROCEDURE workflow_CurOpe_UbySubmitNB 
(userid_2	integer, requestid_1 integer,groupid_1 integer,nodeid_2 integer,isremark_0 CHAR, currentdate char, currenttime char, flag out integer,msg out varchar2,thecursor IN OUT cursor_define.weavercursor)
AS 
nodeAttribute char(1);

begin 

update workflow_currentoperator set operatedate = currentdate,operatetime = currenttime,viewtype=-2 where requestid = requestid_1 and userid = userid_2 and isremark=isremark_0 and groupid = groupid_1 and nodeid=nodeid_2;

update workflow_currentoperator set isremark = '2', needwfback='0' where requestid =requestid_1 and isremark=isremark_0 and groupid =groupid_1 and nodeid=nodeid_2;

select nodeAttribute into nodeAttribute from workflow_nodebase where id = nodeid_2;
if nodeAttribute is null then  nodeAttribute:=0; end if;

IF  nodeAttribute=2  then
    BEGIN
        update workflow_currentoperator set isremark = '2', needwfback='0' where requestid =requestid_1 and (isremark='5' or isremark='8' or isremark='9') and userid = userid_2 and nodeid = nodeid_2;
    END;
else
    BEGIN
        update workflow_currentoperator set isremark = '2', needwfback='0' where requestid =requestid_1 and (isremark='5' or isremark='8' or isremark='9') and userid = userid_2;
    END;    
End if;

end;
/

CREATE or REPLACE PROCEDURE workflow_CurOpe_UpdatebySubmit 
(userid_2	integer, requestid_1 integer,groupid_1 integer,nodeid_2 integer,isremark_0 char,currentdate char, currenttime char, flag out integer,msg out varchar2,thecursor IN OUT cursor_define.weavercursor)
AS 
nodeAttribute char(1);
begin 
update workflow_currentoperator set operatedate = currentdate,operatetime = currenttime,viewtype=-2 where requestid = requestid_1 and userid = userid_2 and isremark=isremark_0 and groupid = groupid_1 and nodeid=nodeid_2;

update workflow_currentoperator set isremark = '2' where requestid =requestid_1 and isremark=isremark_0 and groupid =groupid_1 and nodeid=nodeid_2;

select nodeAttribute into nodeAttribute from workflow_nodebase where id = nodeid_2;
if nodeAttribute is null then  nodeAttribute:=0; end if;

IF  nodeAttribute=2  then
    BEGIN
        update workflow_currentoperator set isremark = '2' where requestid =requestid_1 and (isremark='5' or isremark='8' or isremark='9') and userid = userid_2 and nodeid = nodeid_2;
    END;
else
    BEGIN
        update workflow_currentoperator set isremark = '2' where requestid =requestid_1 and (isremark='5' or isremark='8' or isremark='9') and userid = userid_2;
    END;    
End if;

end;
/
