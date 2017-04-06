/* For TD1370 */
create or replace  PROCEDURE WorkPlan_Update (
	id_1 integer,
	type_n_1 char,
	name_1 varchar2,
	resourceid_1 varchar2,
	begindate_1 char,
	begintime_1 char,
	enddate_1 char,
	endtime_1 char,	
	description_1 varchar2,
	requestid_1 varchar2,
	projectid_1 varchar2,
	crmid_1 varchar2,
	docid_1 varchar2,
	meetingid_1 varchar2,	
	isremind_1 integer,
	waketime_1 integer,
	taskid_1 varchar2,
	urgentLevel_1 char,	
	flag out 	integer	, 
    msg out	varchar2,
    thecursor IN OUT cursor_define.weavercursor)
AS 
begin
UPDATE WorkPlan SET
  type_n = type_n_1,
	name = name_1,
	resourceid = resourceid_1,
	begindate = begindate_1,
	begintime = begintime_1,
	enddate = enddate_1,
	endtime  = endtime_1,
	description = description_1,
	requestid  = requestid_1,
	projectid = projectid_1,
	crmid  = crmid_1,
	docid  = docid_1,
	meetingid = meetingid_1,
	isremind  = isremind_1,
	waketime  = waketime_1,	
	taskid = taskid_1,
	urgentLevel = urgentLevel_1	
WHERE id = id_1;
end;
/

/*td:1400 ��ҳ���ܸĽ� */
update WorkPlan set createrType = '1' 
/
/*��ԭ���ӿͻ���ϵ���е��������ɿͻ���������ô�ͻ���id�Ƿ���agentId�ֶ���ת����������resourceid����createrType��Ϊ2*/
CREATE or replace PROCEDURE WorkPlan_AgentForResource
AS 
    m_id integer;
    m_agentid integer;
    m_creatertype char(1);
    begin
    for all_cursor in(SELECT id, agentId FROM WorkPlan where agentId>0)
    loop
         m_id:=all_cursor.id;
         m_agentid:=all_cursor.agentid;
         update WorkPlan set resourceid = m_agentid , createrType = '2' , agentId = 0 where id = m_id;
    end loop;
end;
/
call WorkPlan_AgentForResource()
/
drop PROCEDURE WorkPlan_AgentForResource
/

/*�����ϵ�����ٶ���*/
ALTER TABLE CRM_ContacterLog_Remind ADD  lastestContactDate char(10) /*�������ϵʱ��*/
/

CREATE or replace PROCEDURE CRM_RemindContactDate
AS 
	m_customerids varchar2(100);
	m_begindate char(10);
	m_crmid varchar2(100);
	m_start integer;
	m_len integer;
begin
	for all_cursor in(SELECT crmid FROM WorkPlan where type_n = '3' group by crmid)
	loop
         m_customerids:=all_cursor.crmid;
         while (m_customerids<>'') loop      		
		m_len := length(m_customerids);
		m_start := INSTR(m_customerids,',' );
			if(m_start=0)then
			     m_crmid := m_customerids;
			     m_customerids := '';
			else
			     m_crmid := substr(m_customerids , 0 , m_start-1) ;
			     m_start := m_start + 1;
			     m_customerids := SUBSTR(m_customerids , m_start , m_len);
			end if;
			select  max (begindate) into m_begindate from WorkPlan WHERE type_n = '3' and concat(concat(',' , crmid ), ',') LIKE concat(concat('%,' , m_crmid ), ',%');
			update CRM_ContacterLog_Remind set lastestContactDate = m_begindate where customerid = m_crmid;
	     end loop;    
    end loop;
end;
/
call CRM_RemindContactDate()
/
drop PROCEDURE CRM_RemindContactDate
/

/*TD1476 oracle ���ڴ������ϲ��� �����ű�ʹ��DML���*/


/*workplan ���в����¼ʱ ���ѡ������ؿͻ���������ѡ�ͻ���CRM_ContacterLog_Remind ���е�lastestContactDate�����ϵ����*/
CREATE or REPLACE PROCEDURE CRMRLOGDATE_UPDATE_BY_CRMID
    (crmid_1 number,
flag	out integer, 
msg   out	varchar2, 
thecursor IN OUT cursor_define.weavercursor )

AS 
m_begindate char(10);
BEGIN
    SELECT MAX(begindate) INTO m_begindate
      FROM WorkPlan 
      WHERE type_n = '3' and concat(concat(',' , crmid), ',') LIKE concat(concat('%,' ,crmid_1),',%');

    UPDATE CRM_ContacterLog_Remind 
       SET lastestContactDate = m_begindate 
     WHERE customerid = crmid_1;
END;
/

/* For TD1412 */
Update Exchange_Info set createrType = '1'  where createrType is null
/