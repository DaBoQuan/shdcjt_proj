CREATE TABLE BPMGoalGroup (
	id integer NOT NULL ,
	goalName varchar2 (150) NULL ,
	objId integer default 0,
	goalType char (1)  NULL ,
	goalDate varchar2 (10)  NULL ,
	cycle char (1)  NULL ,
	status char (1)  NULL ,
	requestid integer default 0 
) 
/

CREATE TABLE BillBPMApproveGoal (
	id integer NOT NULL ,
	requestid integer default 0 ,
	paraID integer default 0 
) 
/
create sequence BBPMAppGoal_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger BBPMAppGoal_Trigger
before insert on BillBPMApproveGoal
for each row
begin
select BBPMAppGoal_id.nextval into :new.id from dual;
end;
/

CREATE TABLE BillBPMApprovePlan (
	id integer NOT NULL ,
	requestid integer default 0 ,
	paraID integer default 0 
) 
/
create sequence BBPMAppPlan_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger BBPMAppPlan_Trigger
before insert on BillBPMApprovePlan
for each row
begin
select BBPMAppPlan_id.nextval into :new.id from dual;
end;
/

CREATE TABLE BillBPMGrade (
	id integer NOT NULL ,
	requestid integer default 0 ,
	paraID integer default 0 
) 
/
create sequence BBPMGrade_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger BBPMGrade_Trigger
before insert on BillBPMGrade
for each row
begin
select BBPMGrade_id.nextval into :new.id from dual;
end;
/

CREATE TABLE GradeGroup (
	id integer NOT NULL ,
	gradeName varchar2 (100)  NULL ,
	cycle char (1)  NULL ,
	checkType char (1)  NULL ,
	checkDate varchar2 (10)  NULL ,
	type_c char (1)  NULL ,
	objId integer default 0 ,
	item integer default 0 ,
	requestId integer default 0 
) 
/

CREATE TABLE HrmCheckSchemeContent (
	id integer NOT NULL ,
	schemeId integer default 0 ,
	type_c char (1)  NULL ,
	percent_n integer default 0 ,
	cycle char (1)  NULL 
) 
/
create sequence HCSContent_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HCSContent_Trigger
before insert on HrmCheckSchemeContent
for each row
begin
select HCSContent_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmCheckSchemeDetail (
	id integer NOT NULL ,
	contentId integer default 0 ,
	item integer default 0 ,
	checkFlow integer default 0 ,
	percent_n integer default 0 ,
	nodePercent_n integer default 0 
) 
/
create sequence HCSchemeDetail_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HCSchemeDetail_Trigger
before insert on HrmCheckSchemeDetail
for each row
begin
select HCSchemeDetail_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmCheckSchemeTargetV (
	id integer NOT NULL ,
	schemeId integer default 0 ,
	targetId integer default 0 ,
	type_c char (1)  NULL ,
	typeM char (1)  NULL 
) 
/
create sequence HCSchemeTargetV_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HCSchTV_Trigger
before insert on HrmCheckSchemeTargetV
for each row
begin
select HCSchemeTargetV_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceAppendRule (
	id integer NOT NULL ,
	ruleName varchar2 (100)  NULL ,
	memo varchar2 (200)  NULL ,
	conditions varchar2 (200)  NULL ,
	conditionsum varchar2 (200)  NULL ,
	formula varchar2 (200)  NULL ,
	formulasum varchar2 (200)  NULL ,
	status char (1)  NULL ,
	deptId varchar2 (1000)  NULL ,
	hrmId varchar2 (1000)  NULL ,
	postid varchar2 (1000)  NULL ,
	formulaDeptId varchar2 (1000)  NULL ,
	formulaHrmId varchar2 (1000)  NULL ,
	formulaPostId varchar2 (1000)  NULL 
) 
/
create sequence HPfAppendRule_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfARule_id_Trigger
before insert on HrmPerformanceAppendRule
for each row
begin
select HPfAppendRule_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceAppendRuleTarget (
	id integer  NOT NULL ,
	ruleId integer default 0 ,
	objId integer default 0 ,
	type_t char (1)  NULL 
) 
/
create sequence HPfARuleTarget_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfARuleTarget_Trigger
before insert on HrmPerformanceAppendRuleTarget
for each row
begin
select HPfARuleTarget_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceBeforePoint (
	id integer NOT NULL ,
	planId integer default 0 ,
	point1 varchar2 (200)  NULL 
) 
/
create sequence HPBPoint_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPBPoint_Trigger
before insert on HrmPerformanceBeforePoint
for each row
begin
select HPBPoint_id.nextval into :new.id from dual;
end;
/

CREATE TABLE HrmPerformanceCheckDetail (
	id integer NOT NULL ,
	checkId integer default 0 ,
	targetName varchar2 (100)  NULL ,
	percent_n integer default 0 ,
	stdName varchar2 (2000)  NULL ,
	crmCode varchar2 (50)  NULL ,
	parentId integer default 0 ,
	levels integer default 0 ,
	depath varchar2 (2000)  NULL ,
	targetIndex varchar2 (50)  DEFAULT ('-1') 
) 
/
ALTER TABLE HrmPerformanceCheckDetail  ADD  PRIMARY KEY   
	(
		id
	)   
/

CREATE TABLE HrmPerformanceCheckFlow (
	id integer  NOT NULL ,
	objId integer default 0 ,
	objType char (1)  NULL ,
	goalFlowId integer default 0 ,
	planFlowId integer default 0 
) 
/
create sequence HPfCheckFlow_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfCheckFlow_Trigger
before insert on HrmPerformanceCheckFlow
for each row
begin
select HPfCheckFlow_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceCheckPoint (
	id integer NOT NULL ,
	cycle char (1)  NULL ,
	checkType char (1)  NULL ,
	checkDate varchar2 (10)  NULL ,
	objId integer default 0 ,
	point1 numeric(10, 3) NULL ,
	point2 numeric(10, 3) NULL ,
	point3 numeric(10, 3) NULL ,
	point4 numeric(10, 3) NULL ,
	point5 numeric(10, 3) NULL ,
	point6 numeric(10, 3) NULL ,
	point7 numeric(10, 1) NULL ,
	point8 varchar2 (200)  NULL ,
	content varchar2 (4000)  NULL ,
	memo varchar2 (4000)  NULL ,
	ruleIds varchar2 (1000)  NULL 
)  
/
create sequence HPfCheckPoint_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfCheckPoint_Trigger
before insert on HrmPerformanceCheckPoint
for each row
begin
select HPfCheckPoint_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceCheckPointDetail (
	id integer NOT NULL ,
	checkId integer default 0 ,
	targetName varchar2 (100)  NULL ,
	percent_n integer default 0 ,
	stdName varchar2 (2000)  NULL ,
	crmCode varchar2 (50)  NULL ,
	parentId integer default 0 ,
	levels integer default 0 ,
	depath varchar2 (2000)  NULL ,
	targetIndex varchar2 (50)  NULL ,
	point numeric(10, 1) NULL ,
	nodePointId integer NOT NULL 
) 
/

CREATE TABLE HrmPerformanceCheckRule (
	id integer NOT NULL ,
	ruleName varchar2 (100)  NULL ,
	memo varchar2 (200)  NULL ,
	status char (1)  NULL 
) 
/

CREATE TABLE HrmPerformanceCheckScheme (
	id integer NOT NULL ,
	schemeName varchar2 (100)  NULL ,
	memo varchar2 (100)  NULL ,
	checkBranchId varchar2 (1000)  NULL ,
	checkDeptId varchar2 (1000)  NULL ,
	checkPostId varchar2 (1000)  NULL ,
	checkHrmId varchar2 (1000)  NULL ,
	viewSuperiorId char (1)  NULL ,
	viewSeSuperiorId char (1)  NULL ,
	viewPostId varchar2 (1000)  NULL ,
	viewHrmId varchar2 (1000)  NULL ,
	status char (1)  NULL 
) 
/

CREATE TABLE HrmPerformanceDiyCheckPoint (
	id integer NOT NULL ,
	checkId integer default 0 ,
	targetName varchar2 (100)  NULL ,
	percent_n integer default 0 ,
	stdName varchar2 (2000)  NULL ,
	crmCode varchar2 (50)  NULL ,
	parentId integer default 0 ,
	levels integer default 0 ,
	depath varchar2 (2000)  NULL ,
	targetIndex varchar2 (50)  NULL ,
	point numeric(10, 1) NULL ,
	nodePointId integer NOT NULL 
) 
/

CREATE TABLE HrmPerformanceFlow (
	id integer NOT NULL ,
	type_1 char (1)  NULL ,
	relatingFlow integer default 0 
) 
/
create sequence HPfFlow_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfFlow_Trigger
before insert on HrmPerformanceFlow
for each row
begin
select HPfFlow_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceGoal (
	id integer NOT NULL ,
	goalName varchar2 (100)  NULL ,
	objId integer default 0 ,
	goalCode varchar2 (25)  NULL ,
	parentId integer default 0 ,
	goalDate varchar2 (10)  NULL ,
	workUnit integer default 0 ,
	operations integer default 0 ,
	type_t integer default 0 ,
	startDate varchar2 (50)  NULL ,
	endDate varchar2 (50)  NULL ,
	goalType char (1)  NULL ,
	cycle char (1)  NULL ,
	property char (1)  NULL ,
	unit varchar2 (10)  NULL ,
	targetValue decimal(15, 3) NULL ,
	previewValue decimal(15, 3) NULL ,
	memo varchar2 (1000)  NULL ,
	percent_n integer default 0 ,
	pointStdId integer default 0 ,
	status char (1)  NULL ,
	allShare char (1)  NULL ,
	requestId integer default 0 ,
	groupId integer default 0 
) 
/

CREATE TABLE HrmPerformanceGoalShare (
	id integer  NOT NULL ,
	objId integer default 0 ,
	type_t char (1)  NULL ,
	type_s char (1)  NULL ,
	logs varchar2 (100)  NULL 
) 
/
create sequence HPfGShare_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfGShar_Trigger
before insert on HrmPerformanceGoalShare
for each row
begin
select HPfGShare_id.nextval into :new.id from dual;
end;
/

CREATE TABLE HrmPerformanceGoalStd (
	id integer NOT NULL ,
	goalId integer default 0 ,
	stdName varchar2 (200)  NULL ,
	point integer default 0 
) 
/
create sequence HPforGoalStd_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPforGoalStd_Trigger
before insert on HrmPerformanceGoalStd
for each row
begin
select HPforGoalStd_id.nextval into :new.id from dual;
end;
/

CREATE TABLE HrmPerformanceGrade (
	id integer NOT NULL ,
	gradeName varchar2 (100)  NULL ,
	source char (1)  NULL ,
	memo varchar2 (200)  NULL ,
	status char (1)  NULL 
) 
/

CREATE TABLE HrmPerformanceGradeDetail (
	id integer  NOT NULL ,
	gradeId integer default 0 ,
	grade varchar2 (10)  NULL ,
	condition1 integer default 0 ,
	condition2 integer default 0 
) 
/
create sequence HPfGradeDetaild_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfGradeDetaild_Trigger
before insert on HrmPerformanceGradeDetail
for each row
begin
select HPfGradeDetaild_id.nextval into :new.id from dual;
end;
/

CREATE TABLE HrmPerformanceNodePoint (
	id integer NOT NULL ,
	cycle char (1)  NULL ,
	reportId integer default 0 ,
	checkType char (1)  NULL ,
	checkDate varchar2 (10)  NULL ,
	objId integer default 0 ,
	requestId integer default 0 ,
	nodeId integer default 0 ,
	operationId integer default 0 ,
	point1 varchar2 (200)  NULL ,
	point2 varchar2 (200)  NULL ,
	point3 varchar2 (200)  NULL ,
	point4 varchar2 (200)  NULL 
) 
/

CREATE TABLE HrmPerformancePlanDown (
	id integer NOT NULL ,
	planId integer default 0 ,
	objId integer default 0 ,
	status char (1)  NULL ,
	logs varchar2 (200)  NULL 
) 
/
create sequence HPfPlanDown_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPlanDown_Trigger
before insert on HrmPerformancePlanDown
for each row
begin
select HPfPlanDown_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformancePlanEffort (
	id integer NOT NULL ,
	planId integer default 0 ,
	effortName varchar2 (200)  NULL ,
	viewSort integer default 0 
) 
/
create sequence HPfPlanEffortn_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPlanEffortn_Trigger
before insert on HrmPerformancePlanEffort
for each row
begin
select HPfPlanEffortn_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformancePlanEffortModul (
	id integer  NOT NULL ,
	planId integer default 0 ,
	effortName varchar2 (200)  NULL ,
	viewSort integer default 0 
) 
/
create sequence HPfPEModul_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPEModul_Trigger
before insert on HrmPerformancePlanEffortModul
for each row
begin
select HPfPEModul_id.nextval into :new.id from dual;
end;
/

CREATE TABLE HrmPerformancePlanKey (
	id integer  NOT NULL ,
	planId integer default 0 ,
	keyName varchar2 (200)  NULL ,
	viewSort integer default 0 
) 
/
create sequence HPfPlanKey_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPlanKey_Trigger
before insert on HrmPerformancePlanKey
for each row
begin
select HPfPlanKey_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformancePlanKeyModul (
	id integer NOT NULL ,
	planId integer default 0 ,
	keyName varchar2 (200)  NULL ,
	viewSort integer default 0 
) 
/
create sequence HPfPlanKeyModul_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPlanKeyModul_Trigger
before insert on HrmPerformancePlanKeyModul
for each row
begin
select HPfPlanKeyModul_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformancePlanKind (
	id integer NOT NULL ,
	headers varchar2 (100)  NULL ,
	planName varchar2 (50)  NULL ,
	sort integer default 0 
) 
/

CREATE TABLE HrmPerformancePlanKindDetail (
	id integer NOT NULL ,
	planId integer default 0 ,
	headers varchar2 (100)  NULL ,
	planName varchar2 (50)  NULL ,
	sort integer default 0 
) 
/
create sequence HPfPKindDetail_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPKindDetail_Trigger
before insert on HrmPerformancePlanKindDetail
for each row
begin
select HPfPKindDetail_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformancePlanModul (
	id integer NOT NULL ,
	groupId integer default 0 ,
	type_n char (1)  NULL ,
	name varchar2 (200)  NULL ,
	objId integer default 0 ,
	resourceid varchar2 (200)  NULL ,
	oppositeGoal integer default 0 ,
	begindate char (10)  NULL ,
	planProperty integer default 0 ,
	principal varchar2 (200)  NULL ,
	cowork varchar2 (200)  NULL ,
	upPrincipal varchar2 (400)  NULL ,
	downPrincipal varchar2 (400)  NULL ,
	teamRequest varchar2 (4000)  NULL ,
	begintime char (8)  NULL ,
	enddate char (10)  NULL ,
	endtime char (8)  NULL ,
	rbeginDate char (10)  NULL ,
	rendDate char (10)  NULL ,
	rbeginTime char (8)  NULL ,
	rendTime char (8)  NULL ,
	cycle char (1)  NULL ,
	planType char (1)  NULL ,
	percent_n integer default 0 ,
	color char (6)  NULL ,
	description varchar2 (4000)  NULL ,
	requestIdn integer default 0 ,
	requestid varchar2 (100)  NULL ,
	projectid varchar2 (100)  NULL ,
	crmid varchar2 (100)  NULL ,
	docid varchar2 (100)  NULL ,
	meetingid varchar2 (100)  NULL ,
	status char (1)  NULL ,
	isremind integer default 0 ,
	waketime integer default 0 ,
	createrid integer default 0 ,
	createdate char (10)  NULL ,
	createtime char (8)  NULL ,
	deleted char (1)  NULL ,
	taskid integer default 0 ,
	urgentLevel char (1)  NULL ,
	agentId integer default 0 ,
	deptId integer default 0 ,
	subcompanyId integer default 0 ,
	createrType char (1)  NULL ,
	finishRemind integer default 0 ,
	relatedprj varchar2 (500)  NULL ,
	relatedcus varchar2 (500)  NULL ,
	relatedwf varchar2 (500)  NULL ,
	relateddoc varchar2 (500)  NULL ,
	allShare char (1)  NULL ,
	planDate varchar2 (20)  NULL ,
	timeModul char (1)  NULL ,
	frequency integer default 0 ,
	frequencyy integer default 0 
)  
/

CREATE TABLE HrmPerformancePointAdjust (
	id integer NOT NULL ,
	pointId integer default 0 ,
	content varchar2 (4000)  NULL ,
	adjustDate varchar2 (10)  NULL ,
	adjustPerson integer default 0 ,
	point_before numeric(10, 0) NULL ,
	point_after numeric(10, 3) NULL 
)  
/
create sequence HPfPointAdjust_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPointAdjust_Trigger
before insert on HrmPerformancePointAdjust
for each row
begin
select HPfPointAdjust_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformancePointRule (
	id integer NOT NULL ,
	minPoint integer default 0 ,
	maxPoint integer default 0 ,
	pointMethod char (1)  NULL ,
	pointModul char (1)  NULL ,
	pointModify char (1)  NULL 
) 
/
create sequence HPfPointRule_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPointRule_Trigger
before insert on HrmPerformancePointRule
for each row
begin
select HPfPointRule_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceReport (
	id integer NOT NULL ,
	reportGroupId integer default 0 ,
	planId integer default 0 ,
	objId integer default 0 ,
	cycle char (1)  NULL ,
	docId varchar2 (100)  NULL ,
	allShare char (1)  NULL ,
	reportDate varchar2 (10)  NULL ,
	reportType char (1)  NULL ,
	status char (1)  NULL ,
	percent_n integer default 0 ,
	pointSelf numeric(10, 3) NULL ,
	reportTypep char (1)  NULL 
) 
/

CREATE TABLE HrmPerformanceReportLog (
	id integer NOT NULL ,
	reportName varchar2 (100)  NULL ,
	reportLog varchar2 (4000)  NULL ,
	cycle char (1)  NULL ,
	reportDate varchar2 (50)  NULL ,
	reportType char (1)  NULL ,
	objId integer default 0 
)  
/

CREATE TABLE HrmPerformanceSchemeContent (
	id integer NOT NULL ,
	schemeId integer default 0 ,
	type_c char (1)  NULL ,
	percent_n integer default 0 ,
	cycle char (1)  NULL 
) 
/
create sequence HPfSchemeContent_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfSchemeContent_Trigger
before insert on HrmPerformanceSchemeContent
for each row
begin
select HPfSchemeContent_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceSchemeDetail (
	id integer NOT NULL ,
	contentId integer default 0 ,
	item integer default 0 ,
	checkFlow integer default 0 ,
	percent_n integer default 0 
) 
/

CREATE TABLE HrmPerformanceSchemePercent (
	id integer NOT NULL ,
	itemId integer default 0 ,
	nodeId integer default 0 ,
	groupId integer default 0 ,
	percent_n integer default 0 ,
	type_n char (1)  NULL ,
	type_d char (1)  NULL 
) 
/
create sequence HPfSchemePercent_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfSchemePercent_Trigger
before insert on HrmPerformanceSchemePercent
for each row
begin
select HPfSchemePercent_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceTargetDetail (
	id integer NOT NULL ,
	targetId integer default 0 ,
	targetName varchar2 (100)  NULL ,
	targetCode varchar2 (20)  NULL ,
	type_l char (1)  NULL ,
	cycle char (1)  NULL ,
	Type_t char (1)  NULL ,
	unit varchar2 (10)  NULL ,
	targetValue decimal(15, 1) NULL ,
	previewValue decimal(15, 1) NULL ,
	memo varchar2 (200)  NULL ,
	others varchar2 (100)  NULL ,
	owner integer default 0 
) 
/

CREATE TABLE HrmPerformanceTargetStd (
	id integer NOT NULL ,
	targetDetailId integer default 0 ,
	stdName varchar2 (100)  NULL ,
	point integer default 0 
) 
/
create sequence HPfTargetStd_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfTargetStd_Trigger
before insert on HrmPerformanceTargetStd
for each row
begin
select HPfTargetStd_id.nextval into :new.id from dual;
end;
/
CREATE TABLE HrmPerformanceTargetType (
	id integer NOT NULL ,
	targetName varchar2 (100)  NULL ,
	memo varchar2 (200)  NULL ,
	num integer default 0 
) 
/

CREATE TABLE hrmPerformanceAlert (
	id integer  NOT NULL ,
	type_a char (1)  NULL ,
	yearCondition1 integer default 0 ,
	yearCondition2 integer default 0 ,
	yearConCount integer default 0 ,
	yearAlertCount integer default 0 ,
	yearAlertUnit char (1)  NULL ,
	yearFrequency integer default 0 ,
	yearInterval integer default 0 ,
	monthCondition1 integer default 0 ,
	monthCondition2 integer default 0 ,
	monthConCount integer default 0 ,
	monthAlertCount integer default 0 ,
	monthAlertUnit char (1)  NULL ,
	monthFrequency integer default 0 ,
	monthInterval integer default 0 ,
	quarterCondition1 integer default 0 ,
	quarterCondition2 integer default 0 ,
	quarterConCount integer default 0 ,
	quarterAlertCount integer default 0 ,
	quarterAlertUnit char (1)  NULL ,
	quarterFrequency integer default 0 ,
	quarterInterval integer default 0 ,
	weekCondition1 integer default 0 ,
	weekCondition2 integer default 0 ,
	weekConCount integer default 0 ,
	weekAlertCount integer default 0 ,
	weekAlertUnit char (1)  NULL ,
	weekFrequency integer default 0 ,
	weekInterval integer default 0 
) 
/
create sequence hPfAlert_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hPfAlert_Trigger
before insert on hrmPerformanceAlert
for each row
begin
select hPfAlert_id.nextval into :new.id from dual;
end;
/
CREATE TABLE hrmPerformanceCheckStd (
	id integer NOT NULL ,
	checkDetailId integer default 0 ,
	stdName varchar2 (100)  NULL ,
	point integer default 0 
) 
/
create sequence hPfCheckStd_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hPfCheckStd_Trigger
before insert on hrmPerformanceCheckStd
for each row
begin
select hPfCheckStd_id.nextval into :new.id from dual;
end;
/
CREATE TABLE workPlanGroup (
	id integer NOT NULL ,
	planName varchar2 (100)  NULL ,
	cycle char (1)  NULL ,
	planDate varchar2 (50)  NULL ,
	objId integer default 0 ,
	status char (1)  NULL ,
	type_d char (1)  NULL ,
	requestId integer default 0 
) 
/
ALTER TABLE workPlan add groupId integer default 0
/
ALTER TABLE workPlan add objId	integer	null
/
ALTER TABLE workPlan add oppositeGoal	integer	Null
/
ALTER TABLE workPlan add planProperty	integer	null
/
ALTER TABLE workPlan add principal	varchar2(200)	null
/
ALTER TABLE workPlan add cowork	varchar2(200)		null
/
ALTER TABLE workPlan add upPrincipal	varchar2(200) null
/
ALTER TABLE workPlan add downPrincipal	varchar2(200) null
/
ALTER TABLE workPlan add teamRequest	varchar2(200) null
/
ALTER TABLE workPlan add rbeginDate	char(10)	null
/
ALTER TABLE workPlan add rendDate	char(10)	null
/
ALTER TABLE workPlan add rbeginTime	char(8)		null
/
ALTER TABLE workPlan add rendTime	char(8)		null
/
ALTER TABLE workPlan add cycle char (1)  NULL
/
ALTER TABLE workPlan add planType char (1) NULL
/
ALTER TABLE workPlan add percent_n integer default 0
/
ALTER TABLE workPlan add requestIdn integer default 0
/
ALTER TABLE workPlan add allShare char (1)  NULL
/
ALTER TABLE workPlan add planDate varchar2 (20)  NULL
/


CREATE TABLE HrmPerformancePlanCheck (
	id integer  NOT NULL ,
	planModulId integer default 0 ,
	cycle char (1)  NULL ,
	planDate varchar2 (10)  NULL ,
	planDay varchar2 (10)  NULL 
) 
/
create sequence HPfPlanCheck_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfPlanCheck_Trigger
before insert on HrmPerformancePlanCheck
for each row
begin
select HPfPlanCheck_id.nextval into :new.id from dual;
end;
/

ALTER TABLE GradeGroup  ADD	 PRIMARY KEY   
	(
		id
	)
/

ALTER TABLE HrmPerformanceAppendRule  ADD  PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceAppendRuleTarget  ADD PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceBeforePoint  ADD 	PRIMARY KEY   
	(
		id
	)   
/



ALTER TABLE HrmPerformanceCheckPoint  ADD 
	 PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceCheckPointDetail  ADD 
	 PRIMARY KEY   
	(
		id,
		nodePointId
	)   
/

ALTER TABLE HrmPerformanceCheckRule  ADD 
	PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceCheckScheme  ADD 
	 PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceDiyCheckPoint  ADD 
	 PRIMARY KEY   
	(
		id,
		nodePointId
	)   
/

ALTER TABLE HrmPerformanceFlow  ADD 
	PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceGrade  ADD 
	 PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceGradeDetail  ADD 
	 PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceNodePoint  ADD 
	 PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePlanDown  ADD 
	 PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePlanEffort  ADD 
	 PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePlanKey  ADD 
	CONSTRAINT PK_HrmPerformancePlanKey PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePlanKind  ADD 
	CONSTRAINT PK_HrmPerformancePlanKind PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePlanKindDetail  ADD 
	PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePlanModul  ADD 
	CONSTRAINT PK_HrmPerformancePlanModul PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePointAdjust  ADD 
	CONSTRAINT PK_HrmPerformancePointAdjust PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformancePointRule  ADD 
	CONSTRAINT PK_HrmPerformancePointRule PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceReport  ADD 
	CONSTRAINT PK_HrmPerformanceReport PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceReportLog  ADD 
	CONSTRAINT PK_HrmPerformanceReportLog PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceSchemeContent  ADD 
	CONSTRAINT PK_HrmPerformanceSchemeContent PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceSchemeDetail  ADD 
	CONSTRAINT PK_HrmPerformanceSchemeDetail PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceTargetDetail  ADD 
	CONSTRAINT PK_hrmPerformanceTargetDetail PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE HrmPerformanceTargetType  ADD 
	CONSTRAINT PK_hrmPerformanceTargetType PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE hrmPerformanceCheckStd  ADD 
	CONSTRAINT PK_hrmPerformanceCheckStd PRIMARY KEY   
	(
		id
	)   
/

ALTER TABLE workPlanGroup  ADD 
	CONSTRAINT PK_workPlanGroup PRIMARY KEY   
	(
		id
	)   
/

INSERT INTO HtmlLabelIndex values(18057,'���˶���') 
/
INSERT INTO HtmlLabelInfo VALUES(18057,'���˶���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18057,'CHECK TARGET',8) 
/

INSERT INTO HtmlLabelIndex values(18078,'�ƻ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(18078,'�ƻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18078,'ATTRIBUTE OF PLAN',8) 
/

INSERT INTO HtmlLabelIndex values(18094,'���˱�') 
/
INSERT INTO HtmlLabelInfo VALUES(18094,'���˱�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18094,'CHECK RESULT',8) 
/

INSERT INTO HtmlLabelIndex values(18086,'ָ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18086,'ָ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18086,'TARGET',8) 
/
INSERT INTO HtmlLabelIndex values(18093,'��ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(18093,'��ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18093,'VALUE OF OINT',8) 
/
INSERT INTO HtmlLabelIndex values(18064,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(18064,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18064,'CHECK ITEM',8) 
/
INSERT INTO HtmlLabelIndex values(18067,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18067,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18067,'FLOW OF CHECK',8) 
/

INSERT INTO HtmlLabelIndex values(18062,'��ְ�ܽ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18062,'��ְ�ܽ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18062,'REPORT WORK',8) 
/

INSERT INTO HtmlLabelIndex values(18065,'����Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18065,'����Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18065,'PERCENT OF CHECK',8) 
/
INSERT INTO HtmlLabelIndex values(18063,'Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18063,'Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18063,'PERCENT',8) 
/
INSERT INTO HtmlLabelIndex values(18060,'Ŀ�꿼��') 
/
INSERT INTO HtmlLabelInfo VALUES(18060,'Ŀ�꿼��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18060,'TARGET CHECK',8) 
/
INSERT INTO HtmlLabelIndex values(18056,'���˷���') 
/
INSERT INTO HtmlLabelInfo VALUES(18056,'���˷���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18056,'CHECK SCHEME',8) 
/

INSERT INTO HtmlLabelIndex values(18053,'��Ч���˵÷�') 
/
INSERT INTO HtmlLabelIndex values(18054,'Ŀ��ƻ����˵÷�') 
/
INSERT INTO HtmlLabelInfo VALUES(18053,'��Ч���˵÷�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18053,'PKI CHECK POINT',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18054,'Ŀ��ƻ����˵÷�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18054,'PLAN CHECK POINT',8) 
/
INSERT INTO HtmlLabelIndex values(18076,'����Դ') 
/
INSERT INTO HtmlLabelInfo VALUES(18076,'����Դ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18076,'DATA SOURCE',8) 
/
INSERT INTO HtmlLabelIndex values(18076,'����Դ') 
/
INSERT INTO HtmlLabelInfo VALUES(18076,'����Դ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18076,'DATA SOURCE',8) 
/
INSERT INTO HtmlLabelIndex values(18070,'�÷�����') 
/
INSERT INTO HtmlLabelInfo VALUES(18070,'�÷�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18070,'MODIFY POINT',8) 
/
INSERT INTO HtmlLabelIndex values(18073,'�������') 
/
INSERT INTO HtmlLabelInfo VALUES(18073,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18073,'ALLOW ADJUST',8) 
/


INSERT INTO HtmlLabelIndex values(18085,'ָ������') 
/
INSERT INTO HtmlLabelInfo VALUES(18085,'ָ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18085,'TYPE OF TARGET',8) 
/
INSERT INTO HtmlLabelIndex values(18071,'�������ֱ�׼') 
/
INSERT INTO HtmlLabelIndex values(18072,'�ֹ�����') 
/
INSERT INTO HtmlLabelIndex values(18068,'���ַ�Χ') 
/
INSERT INTO HtmlLabelIndex values(18069,'���ַ�ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(18068,'���ַ�Χ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18068,'RANGE OF POINT',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18069,'���ַ�ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18069,'METHOD OF GRADE',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18071,'�������ֱ�׼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18071,'BY GRADE STD',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18072,'�ֹ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18072,'HANDWORK',8) 
/
 

INSERT INTO HtmlLabelIndex values(18061,'�Զ��忼��') 
/
INSERT INTO HtmlLabelIndex values(18075,'����') 
/
INSERT INTO HtmlLabelIndex values(18090,'����') 
/
INSERT INTO HtmlLabelIndex values(18092,'��׼����') 
/
INSERT INTO HtmlLabelIndex values(18055,'�Զ��忼�˵÷�') 
/
INSERT INTO HtmlLabelIndex values(18074,'�ܷ�����ģʽ') 
/
INSERT INTO HtmlLabelIndex values(18089,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18055,'�Զ��忼�˵÷�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18055,'CUSTOM CHECK POINT',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18061,'�Զ��忼��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18061,'CUSTOM CHECK',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18074,'�ܷ�����ģʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18074,'ALL ASSESS MODEL',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18075,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18075,'DEFINE',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18089,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18089,'RATION',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18090,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18090,'DETERMINE THE NATURE',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18092,'��׼����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18092,'DEFINE OF STD',8) 
/

INSERT INTO HtmlLabelIndex values(18058,'���˽���鿴') 
/
INSERT INTO HtmlLabelInfo VALUES(18058,'���˽���鿴',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18058,'CHECK POINT VIEW',8) 
/

INSERT INTO HtmlLabelIndex values(18280,'��') 
/
INSERT INTO HtmlLabelInfo VALUES(18280,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18280,'quarter',8) 
/

INSERT INTO HtmlLabelIndex values(18041,'Ŀ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(18041,'Ŀ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18041,'PKI',8) 
/

INSERT INTO HtmlLabelIndex values(18042,'���˵ȼ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(18042,'���˵ȼ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18042,'GRADESETTING',8) 
/

INSERT INTO HtmlLabelIndex values(18043,'�������̹���') 
/
INSERT INTO HtmlLabelInfo VALUES(18043,'�������̹���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18043,'CHECKFLOWCONNECTION',8) 
/

INSERT INTO HtmlLabelIndex values(18044,'�ƻ������趨') 
/
INSERT INTO HtmlLabelInfo VALUES(18044,'�ƻ������趨',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18044,'PLANATTRIBUTE',8) 
/

INSERT INTO HtmlLabelIndex values(18046,'����ʱ���趨') 
/
INSERT INTO HtmlLabelInfo VALUES(18046,'����ʱ���趨',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18046,'ALERTTIME',8) 
/
INSERT INTO HtmlLabelIndex values(18080,'����Ƶ��') 
/
INSERT INTO HtmlLabelIndex values(18081,'����һ��') 
/
INSERT INTO HtmlLabelIndex values(18046,'����ʱ���趨') 
/
INSERT INTO HtmlLabelIndex values(18079,'������ǰ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18046,'����ʱ���趨',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18046,'ALERTTIME',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18079,'������ǰ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18079,'NUMBER OF ALERT',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18080,'����Ƶ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18080,'FREQUENCY OF ALERT',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18081,'����һ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18081,'ALERT ONCE',8) 
/

INSERT INTO HtmlLabelIndex values(18047,'ָ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18047,'ָ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18047,'TARGET STORAGE',8) 
/

INSERT INTO HtmlLabelIndex values(18048,'�Զ��忼�˱�') 
/
INSERT INTO HtmlLabelInfo VALUES(18048,'�Զ��忼�˱�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18048,'CUSTOM CHECK LIST',8) 
/

INSERT INTO HtmlLabelIndex values(18049,'���˷����趨') 
/
INSERT INTO HtmlLabelInfo VALUES(18049,'���˷����趨',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18049,'CHECK SCHEME',8) 
/

INSERT INTO HtmlLabelIndex values(18050,'���ֹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18050,'���ֹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18050,'POINT RULE',8) 
/

INSERT INTO HtmlLabelIndex values(18097,'���˵ȼ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18097,'���˵ȼ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18097,'GRADE',8) 
/
INSERT INTO HtmlLabelIndex values(18096,'����') 
/
INSERT INTO HtmlLabelIndex values(18095,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18095,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18095,'OPEN',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18096,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18096,'CLOSE',8) 
/

INSERT INTO HtmlLabelIndex values(18098,'�������ò����߼�') 
/
INSERT INTO HtmlLabelInfo VALUES(18098,'�������ò����߼�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18098,'CONDITION ERROR',8) 
/


INSERT INTO HtmlLabelIndex values(18102,'Ŀ����������') 
/
INSERT INTO HtmlLabelIndex values(18103,'�ƻ���������') 
/
INSERT INTO HtmlLabelInfo VALUES(18102,'Ŀ����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18102,'TARGET CHECK FLOW',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18103,'�ƻ���������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18103,'PLAN CHECK FLOW',8) 
/

INSERT INTO HtmlLabelIndex values(18104,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18104,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18104,'FLOW NAME',8) 
/


INSERT INTO HtmlLabelIndex values(18105,'���и����͵��������̣��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18105,'���и����͵��������̣��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18105,'HAVE THE KIND OF FLOW',8) 
/



INSERT INTO HtmlLabelIndex values(18106,'Ŀ���趨') 
/
INSERT INTO HtmlLabelInfo VALUES(18106,'Ŀ���趨',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18106,'SET TARGET',8) 
/

INSERT INTO HtmlLabelIndex values(18108,'�����ύ') 
/
INSERT INTO HtmlLabelIndex values(18107,'�ƻ��ύ') 
/
INSERT INTO HtmlLabelInfo VALUES(18107,'�ƻ��ύ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18107,'SUBMIT PLAN',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18108,'�����ύ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18108,'SUBMIT REPORT',8) 
/

INSERT INTO HtmlLabelIndex values(18109,'ǰ') 
/
INSERT INTO HtmlLabelIndex values(18110,'��') 
/
INSERT INTO HtmlLabelInfo VALUES(18109,'ǰ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18109,'AHEAD',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18110,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18110,'BACK',8) 
/


INSERT INTO HtmlLabelIndex values(18111,'��ֹʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18111,'��ֹʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18111,'DEADLINE',8) 
/

INSERT INTO HtmlLabelIndex values(18112,'�ƻ����ʷ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18112,'�ƻ����ʷ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18112,'THE KIND OF PLAN',8) 
/

INSERT INTO HtmlLabelIndex values(18113,'�ƻ������б�') 
/
INSERT INTO HtmlLabelInfo VALUES(18113,'�ƻ������б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18113,'THE KIND OF PLAN LIST',8) 
/

INSERT INTO HtmlLabelIndex values(18114,'ָ����Ŀ') 
/
INSERT INTO HtmlLabelInfo VALUES(18114,'ָ����Ŀ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18114,'TARGET NUMBERS',8) 
/

INSERT INTO HtmlLabelIndex values(18115,'��������ϸָ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18115,'��������ϸָ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18115,'VIEW TARGET',8) 
/

INSERT INTO HtmlLabelIndex values(18117,'��Բ') 
/
INSERT INTO HtmlLabelInfo VALUES(18117,'��Բ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18117,'DOLLAR',8) 
/

INSERT INTO HtmlLabelIndex values(18119,'���浽ָ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18119,'���浽ָ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18119,'SAVE TO TARGET',8) 
/

INSERT INTO HtmlLabelIndex values(18120,'���ص����˱�') 
/
INSERT INTO HtmlLabelInfo VALUES(18120,'���ص����˱�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18120,'RETURN TO CUSTOM',8) 
/
INSERT INTO HtmlLabelIndex values(18122,'�Զ��忼�˱�ָ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18122,'�Զ��忼�˱�ָ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18122,'TARGET OG CUSTOM CEHCK',8) 
/

INSERT INTO HtmlLabelIndex values(18123,'ͬһ��ڵ����Ȩ��ָ�����ܴ���100') 
/
INSERT INTO HtmlLabelInfo VALUES(18123,'ͬһ��ڵ����Ȩ��ָ�����ܴ���100',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18123,'The same level of sum power index can not be greater than 100%',8) 
/


INSERT INTO HtmlLabelIndex values(18125,'��ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(18125,'��ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18125,'FORMULA',8) 
/

INSERT INTO HtmlLabelIndex values(18126,'���ö���') 
/
INSERT INTO HtmlLabelInfo VALUES(18126,'���ö���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18126,'APPLY TO',8) 
/


INSERT INTO HtmlLabelIndex values(18127,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18127,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18127,'THE TARGET OF CONDITION',8) 
/

INSERT INTO HtmlLabelIndex values(18128,'���˿��˵÷�') 
/
INSERT INTO HtmlLabelIndex values(18129,'�ϼ����˵÷�') 
/
INSERT INTO HtmlLabelIndex values(18130,'���ڲ��ſ��˵÷�') 
/
INSERT INTO HtmlLabelInfo VALUES(18128,'���˿��˵÷�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18128,'THE POINT OF PERSONAL',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18129,'�ϼ����˵÷�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18129,'THE POINT OF SUPERIOR',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18130,'���ڲ��ſ��˵÷�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18130,'THE POINT OF OWNER DEPARTMENT',8) 
/

INSERT INTO HtmlLabelIndex values(18131,'��ѡ������') 
/
INSERT INTO HtmlLabelInfo VALUES(18131,'��ѡ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18131,'PELASE CHOOSE A CONDITION',8) 
/


INSERT INTO HtmlLabelIndex values(18132,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18132,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18132,'SPACE SUPERIOR',8) 
/

INSERT INTO HtmlLabelIndex values(18133,'�鿴����') 
/
INSERT INTO HtmlLabelInfo VALUES(18133,'�鿴����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18133,'THE OBJECT OF VIEW',8) 
/

INSERT INTO HtmlLabelIndex values(18134,'����Ȩ��') 
/
INSERT INTO HtmlLabelIndex values(18135,'����Ȩ��(������)') 
/
INSERT INTO HtmlLabelInfo VALUES(18134,'����Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18134,'POWER INDEX OF POINT',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18135,'����Ȩ��(������)',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18135,'POWER INDEX OF POINT (DOWN)',8) 
/

INSERT INTO HtmlLabelIndex values(18136,'�¹����ƻ�') 
/
INSERT INTO HtmlLabelIndex values(18137,'�¿��˻���') 
/
INSERT INTO HtmlLabelInfo VALUES(18136,'�¹����ƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18136,'the working plan the month',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18137,'�¿��˻���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18137,'SUM OF CHECK',8) 
/

INSERT INTO HtmlLabelIndex values(18138,'����дȨ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18138,'����дȨ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18138,'PLEASE INPUT POWER INDEX',8) 
/

INSERT INTO HtmlLabelIndex values(18139,'��ѡ�������Ȩ�غ�Ӧ����100') 
/
INSERT INTO HtmlLabelInfo VALUES(18139,'��ѡ�������Ȩ�غ�Ӧ����100',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18139,'SUM OF THE SELECTED POWER INDEX MUST 100',8) 
/

INSERT INTO HtmlLabelIndex values(18147,'��ѡ��һ��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18147,'��ѡ��һ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18147,'PLEASE CHOOSE A ITEM',8) 
/

INSERT INTO HtmlLabelIndex values(18170,'�����ƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18170,'�����ƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18170,'WORK PLAN',8) 
/

INSERT INTO HtmlLabelIndex values(18174,'ͬһ�ڵ�Ĳ�����Ȩ�غͱ�����100') 
/
INSERT INTO HtmlLabelInfo VALUES(18174,'ͬһ�ڵ�Ĳ�����Ȩ�غͱ�����100',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18174,'THE SUM OF THE POWER INDE OF of THE SAME POINT must 100',8) 
/

INSERT INTO HtmlLabelIndex values(18175,'���нڵ��Ȩ�غͱ�����100') 
/
INSERT INTO HtmlLabelInfo VALUES(18175,'���нڵ��Ȩ�غͱ�����100',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18175,'THE SUM OF POWER INDEX OF ALL POINT MUST 100',8) 
/

INSERT INTO HtmlLabelIndex values(18087,'Ŀ��ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(18087,'Ŀ��ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18087,'VALUE OF TARGET',8) 
/
INSERT INTO HtmlLabelIndex values(18088,'Ԥ��ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(18088,'Ԥ��ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18088,'VALUE OF ALERT',8) 
/
INSERT INTO HtmlLabelIndex values(18075,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18075,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18075,'DEFINE',8) 
/
INSERT INTO HtmlLabelIndex values(18091,'���ֱ�׼') 
/
INSERT INTO HtmlLabelInfo VALUES(18091,'���ֱ�׼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18091,'STD OF POINT',8) 
/

INSERT INTO HtmlLabelIndex values(18176,'����Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18176,'����Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18176,'THE POWER OF NETX POINT',8) 
/
 INSERT INTO HtmlLabelIndex values(18179,'Ȩ��ָ������Ϊ100') 
/
INSERT INTO HtmlLabelInfo VALUES(18179,'Ȩ��ָ������Ϊ100',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18179,'THE POWER INDEX MUST 100%',8) 
/


INSERT INTO HtmlLabelIndex values(18181,'Ŀ��ƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18181,'Ŀ��ƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18181,'TARGET PLAN',8) 
/

INSERT INTO HtmlLabelIndex values(18182,'Ԥ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18182,'Ԥ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18182,'estimate',8) 
/

INSERT INTO HtmlLabelIndex values(18184,'���β���') 
/
INSERT INTO HtmlLabelIndex values(18183,'���β���') 
/
INSERT INTO HtmlLabelInfo VALUES(18183,'���β���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18183,'UP DEPARMENT',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18184,'���β���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18184,'DOWN DEPARTMENT',8) 
/

INSERT INTO HtmlLabelIndex values(18185,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18185,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18185,'DOWN',8) 
/
INSERT INTO HtmlLabelIndex values(18186,'ͬ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18186,'ͬ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18186,'agree',8) 
/

INSERT INTO HtmlLabelIndex values(18187,'��ؼƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18187,'��ؼƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18187,'RELATIONS PLAN',8) 
/

INSERT INTO HtmlLabelIndex values(18188,'���') 
/
INSERT INTO HtmlLabelInfo VALUES(18188,'���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18188,'assort',8) 
/

INSERT INTO HtmlLabelIndex values(18189,'��ȷ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18189,'��ȷ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18189,'confirmed',8) 
/

INSERT INTO HtmlLabelIndex values(18190,'') 
/
INSERT INTO HtmlLabelInfo VALUES(18190,'Э���ƻ���˵�����������β��ŵ�Э��������Լ���Ϊ��������˵ļƻ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18190,'Э���ƻ���˵�����������β��ŵ�Э��������Լ���Ϊ��������˵ļƻ���',8) 
/

INSERT INTO HtmlLabelIndex values(18191,'��ӦĿ��') 
/
INSERT INTO HtmlLabelIndex values(18192,'�����β���/�����˵�Э������') 
/
INSERT INTO HtmlLabelInfo VALUES(18191,'��ӦĿ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18191,'the corresponding target',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18192,'�����β���/�����˵�Э������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18192,'',8) 
/

INSERT INTO HtmlLabelIndex values(18193,'��ѡ���Ӧ���ŵ�������') 
/
INSERT INTO HtmlLabelInfo VALUES(18193,'��ѡ���Ӧ���ŵ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18193,'PLEASE SELECT PRINCIPAL OF THE DEPARTMENT',8) 
/

INSERT INTO HtmlLabelIndex values(18196,'��ǰ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18196,'��ǰ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18196,'CURREN CYCLE',8) 
/

INSERT INTO HtmlLabelIndex values(18200,'�����ؼ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18200,'�����ؼ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18200,'the key of the point of work',8) 
/

INSERT INTO HtmlLabelIndex values(18201,'Ҫ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18201,'Ҫ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18201,'Request',8) 
/

INSERT INTO HtmlLabelIndex values(18202,'�ɹ�Ҫ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18202,'�ɹ�Ҫ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18202,'achevement request',8) 
/

INSERT INTO HtmlLabelIndex values(18212,'�ƻ���Ȩ�غͱ���Ϊ100') 
/
INSERT INTO HtmlLabelInfo VALUES(18212,'�ƻ���Ȩ�غͱ���Ϊ100',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18212,'�ƻ���Ȩ�غͱ���Ϊ100',8) 
/

INSERT INTO HtmlLabelIndex values(18213,'���뱾����Ա���ƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18213,'���뱾����Ա���ƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18213,'input plan of the employee',8) 
/
INSERT INTO HtmlLabelIndex values(18214,'��ѡ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18214,'��ѡ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18214,'PlEASE CHOOSE',8) 
/
 
INSERT INTO HtmlLabelIndex values(18217,'���뱾�ֲ����żƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18217,'���뱾�ֲ����żƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18217,'import depatement plan',8) 
/

INSERT INTO HtmlLabelIndex values(18219,'��ӵ��ֲ��ƻ�') 
/
INSERT INTO HtmlLabelIndex values(18218,'��ӵ����żƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18218,'��ӵ����żƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18218,'Apply to department plan',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18219,'��ӵ��ֲ��ƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18219,'apply to branch plan',8) 
/
INSERT INTO HtmlLabelIndex values(18220,'�ƻ�����ģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18220,'�ƻ�����ģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18220,'PLAN MODULE',8) 
/

INSERT INTO HtmlLabelIndex values(18221,'����ģʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(18221,'����ģʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18221,'Wake mode',8) 
/

INSERT INTO HtmlLabelIndex values(18222,'��') 
/
INSERT INTO HtmlLabelInfo VALUES(18222,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18222,'bases',8) 
/
INSERT INTO HtmlLabelIndex values(18223,'�����ڽ����ƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18223,'�����ڽ����ƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18223,'Don''t set plan of frequency',8) 
/
INSERT INTO HtmlLabelIndex values(18059,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18059,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18059,'MIDYEAR',8) 
/
INSERT INTO HtmlLabelIndex values(18225,'����Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18225,'����Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18225,'adjust percent',8) 
/

INSERT INTO HtmlLabelIndex values(18215,'�ֽ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18215,'�ֽ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18215,'break',8) 
/

INSERT INTO HtmlLabelIndex values(18224,'�ֽ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18224,'�ֽ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18224,'Break Situation',8) 
/

INSERT INTO HtmlLabelIndex values(18231,'����ָ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18231,'����ָ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18231,'Import KPI',8) 
/

INSERT INTO HtmlLabelIndex values(18237,'������ָ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18237,'������ָ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18237,'Save to KPI room',8) 
/

INSERT INTO HtmlLabelIndex values(18238,'Ŀ������') 
/
INSERT INTO HtmlLabelInfo VALUES(18238,'Ŀ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18238,'KPI Name',8) 
/

INSERT INTO HtmlLabelIndex values(18239,'����λ') 
/
INSERT INTO HtmlLabelInfo VALUES(18239,'����λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18239,'Responsible Unit',8) 
/

INSERT INTO HtmlLabelIndex values(18240,'ͬ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18240,'ͬ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18240,'synchronize',8) 
/


INSERT INTO HtmlLabelIndex values(18248,'ϵͳ��ֵ') 
/
INSERT INTO HtmlLabelIndex values(18249,'��ǰ��ֵ') 
/
INSERT INTO HtmlLabelIndex values(18250,'������ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(18248,'ϵͳ��ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18248,'System Point',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18249,'��ǰ��ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18249,'Current Point',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18250,'������ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18250,'Modified Point',8) 
/

INSERT INTO HtmlLabelIndex values(18251,'������¼') 
/
INSERT INTO HtmlLabelInfo VALUES(18251,'������¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18251,'Modified Log',8) 
/

INSERT INTO HtmlLabelIndex values(18252,'����ǰ��ֵ') 
/
INSERT INTO HtmlLabelIndex values(18253,'�������ֵ') 
/
INSERT INTO HtmlLabelIndex values(18254,'����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18252,'����ǰ��ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18252,'Point Before Modifing',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18253,'�������ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18253,'Point After Modifing',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18254,'����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18254,'Modified Time',8) 
/

INSERT INTO HtmlLabelIndex values(18257,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(18257,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18257,'Deliverer',8) 
/

INSERT INTO HtmlLabelIndex values(18258,'���Ƚ���Ŀ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18258,'���Ƚ���Ŀ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18258,'First you should add goal',8) 
/

INSERT INTO HtmlLabelIndex values(18259,'ȷ���ύ������') 
/
INSERT INTO HtmlLabelInfo VALUES(18259,'ȷ���ύ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18259,'Are you sure',8) 
/

INSERT INTO HtmlLabelIndex values(18260,'�Ƿ�ͬ���¼���λ') 
/
INSERT INTO HtmlLabelInfo VALUES(18260,'�Ƿ�ͬ���¼���λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18260,'Synchronize Sub Unit',8) 
/

INSERT INTO HtmlLabelIndex values(18261,'��ֵ�������ַ�Χ') 
/
INSERT INTO HtmlLabelInfo VALUES(18261,'��ֵ�������ַ�Χ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18261,'Paranormal Point',8) 
/

/*����*/
INSERT INTO HtmlLabelIndex values(18229,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(18229,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18229,'self check',8) 
/

INSERT INTO HtmlLabelIndex values(18230,'δ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18230,'δ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18230,'don''t start',8) 
/


INSERT INTO HtmlLabelIndex values(18232,'���ֱ��������ֹ����趨��Χ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18232,'���ֱ��������ֹ����趨��Χ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18232,'point must in point rule',8) 
/

INSERT INTO HtmlLabelIndex values(18233,'����д������') 
/
INSERT INTO HtmlLabelInfo VALUES(18233,'����д������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18233,'please input point',8) 
/

INSERT INTO HtmlLabelIndex values(18234,'����д����') 
/
INSERT INTO HtmlLabelInfo VALUES(18234,'����д����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18234,'please input schedule',8) 
/
INSERT INTO HtmlLabelIndex values(18235,'��ѡ����ְ�ܽ��ĵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18235,'��ѡ����ְ�ܽ��ĵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18235,'please choose document of report work',8) 
/

INSERT INTO HtmlLabelIndex values(18236,'�±������') 
/
INSERT INTO HtmlLabelInfo VALUES(18236,'�±������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18236,'sum of report of month',8) 
/

INSERT INTO HtmlLabelIndex values(18241,'ͬһ������ֻ����Ψһ���¹����ƻ����˻��¿��˻���') 
/
INSERT INTO HtmlLabelInfo VALUES(18241,'ͬһ������ֻ����Ψһ���¹����ƻ����˻��¿��˻���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18241,'',8) 
/

INSERT INTO HtmlLabelIndex values(18242,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18242,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18242,'down point',8) 
/
INSERT INTO HtmlLabelIndex values(18243,'����д����') 
/
INSERT INTO HtmlLabelInfo VALUES(18243,'����д����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18243,'PLEASE INPUT POINT',8) 
/

INSERT INTO HtmlLabelIndex values(18246,'����û������') 
/
INSERT INTO HtmlLabelInfo VALUES(18246,'����û������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18246,'please check',8) 
/

INSERT INTO HtmlLabelIndex values(18247,'�¶ȿ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18247,'�¶ȿ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18247,'check of the month',8) 
/
 
 INSERT INTO HtmlLabelIndex values(18255,'�¼�ָ�꽫һ��ɾ������ȷ�ϣ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18255,'�¼�ָ�꽫һ��ɾ������ȷ�ϣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18255,'will del childitem ,pleas confirm',8) 
/
INSERT INTO HtmlLabelIndex values(17955,'�ܵ÷�') 
/
INSERT INTO HtmlLabelInfo VALUES(17955,'�ܵ÷�',7) 
/

INSERT INTO HtmlLabelIndex values(18263,'�ۺ����ʿ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18263,'�ۺ����ʿ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18263,'ability check',8) 
/

INSERT INTO HtmlLabelIndex values(18264,'�����÷�') 
/
INSERT INTO HtmlLabelInfo VALUES(18264,'�����÷�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18264,'modified point',8) 
/
INSERT INTO HtmlLabelIndex values(18265,'��̸��¼') 
/
INSERT INTO HtmlLabelInfo VALUES(18265,'��̸��¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18265,'interview note',8) 
/
INSERT INTO HtmlLabelIndex values(18266,'������̸��¼') 
/
INSERT INTO HtmlLabelInfo VALUES(18266,'������̸��¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18266,'save interview note',8) 
/

INSERT INTO HtmlLabelIndex values(18267,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18267,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18267,'point order',8) 
/

INSERT INTO HtmlLabelIndex values(18268,'��δ�����������̣���͹���Ա��ϵ') 
/
INSERT INTO HtmlLabelInfo VALUES(18268,'��δ�����������̣���͹���Ա��ϵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18268,'flow not set',8) 
/

INSERT INTO HtmlLabelIndex values(18118,'Ȩ��ָ�����ܴ���100') 
/
INSERT INTO HtmlLabelInfo VALUES(18118,'Ȩ��ָ�����ܴ���100',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18118,'The power index can not be greater than 100%',8) 
/



CALL MMConfig_U_ByInfoInsert (3,5)
/
CALL MMInfo_Insert (433,18041,'Ŀ�����','','',3,1,5,0,'',0,'',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,1)
/
CALL MMInfo_Insert (434,18042,'���˵ȼ�����','hrm/performance/maintenance/checkGrade/GradeList.jsp','mainFrame',433,2,1,0,'',1,'CheckGradeInfo:Maintenance',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,2)
/
CALL MMInfo_Insert (435,18043,'�������̹���','hrm/performance/maintenance/checkFlow/checkFlowList.jsp','mainFrame',433,2,1,0,'',1,'CheckFlowInfo:Maintenance',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,3)
/
CALL MMInfo_Insert (436,18044,'�ƻ������趨','hrm/performance/maintenance/planKind/PlanList.jsp','mainFrame',433,2,1,0,'',1,'PlanKindInfo:Maintenance',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,4)
/
CALL MMInfo_Insert (437,18046,'����ʱ���趨','hrm/performance/maintenance/alertTime/alertList.jsp','mainFrame',433,2,1,0,'',1,'AlertTimeInfo:Maintenance',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,5)
/
CALL MMInfo_Insert (439,18048,'�Զ��忼�˱�','hrm/performance/maintenance/diyCheck/CheckList.jsp','mainFrame',433,2,2,0,'',1,'DiyCheck:Maintenance',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,8)
/
CALL MMInfo_Insert (441,18050,'���ֹ���','hrm/performance/pointRule/RuleView.jsp','mainFrame',433,2,2,0,'',1,'PointRule:Performance',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,6)
/
CALL MMInfo_Insert (438,18047,'ָ���','hrm/performance/maintenance/targetType/TargetTypeList.jsp','mainFrame',433,2,1,0,'',1,'TargetTypeInfo:Maintenance',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (433,7)
/
CALL MMInfo_Insert (440,18049,'���˷����趨','hrm/performance/checkScheme/CheckSchemeList.jsp','mainFrame',433,2,2,0,'',1,'CheckScheme:Performance',0,'','',0,'','',2)
/




insert into SystemRights (id,rightdesc,righttype) values (600,'���˵ȼ�����','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (600,7,'���˵ȼ�����','���˵ȼ����֣�������ɾ�����޸�') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (600,8,'CHECK GRADE SET','') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4099,'���˵ȼ��趨','CheckGradeInfo:Maintenance',600) 
/

insert into SystemRights (id,rightdesc,righttype) values (601,'���������趨','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (601,7,'���������趨','���������趨') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (601,8,'CHECK FLOW SETTING','CHECK FLOW SETTING') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4100,'���������趨','CheckFlowInfo:Maintenance',601) 
/

insert into SystemRights (id,rightdesc,righttype) values (602,'�ƻ������趨','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (602,7,'�ƻ������趨','�ƻ������趨') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (602,8,'PLAN ATTRIBUTE SETTING','PLAN ATTRIBUTE SETTING') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4101,'�ƻ������趨','PlanKindInfo:Maintenance',602) 
/

insert into SystemRights (id,rightdesc,righttype) values (603,'����ʱ���趨','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (603,7,'����ʱ���趨','����ʱ���趨') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (603,8,'ALERT TIME SETTING','ALERT TIME SETTING') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4102,'����ʱ���趨','AlertTimeInfo:Maintenance',603) 
/

insert into SystemRights (id,rightdesc,righttype) values (604,'ָ����趨','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (604,7,'ָ����趨','ָ����趨') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (604,8,'TARGET LIST SETTING','TARGET LIST SETTING') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4103,'ָ����趨','TargetTypeInfo:Maintenance',604) 
/

insert into SystemRights (id,rightdesc,righttype) values (605,'�Զ��忼�˱��趨','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (605,8,'CUSTOM CHECK SETTING','CUSTOM CHECK SETTING') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (605,7,'�Զ��忼�˱��趨','�Զ��忼�˱��趨') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4104,'�Զ��忼�˱��趨','DiyCheck:Maintenance',605) 
/

insert into SystemRights (id,rightdesc,righttype) values (606,'���˷����趨','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (606,7,'���˷����趨','���˷����趨') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (606,8,'CHECK SCHEME SETTING','CHECK SCHEME SETTING') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4105,'���˷����趨','CheckScheme:Performance',606) 
/

insert into SystemRights (id,rightdesc,righttype) values (607,'���ֹ����趨','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (607,8,'POINT RULE SETTING','POINT RULE SETTING') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (607,7,'���ֹ����趨','���ֹ����趨') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4106,'���ֹ����趨','PointRule:Performance',607) 
/
 




insert into SystemRights (id,rightdesc,righttype) values (619,'�÷�����','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (619,8,'Modify Point','Modify Point') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (619,7,'�÷�����','�÷�����') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4123,'�÷�����','ModifyPoint:Edit',619) 
/

insert into SystemRights (id,rightdesc,righttype) values (626,'�ֲ�Ŀ���趨Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (626,7,'�ֲ�Ŀ���趨Ȩ��','�ֲ�Ŀ���趨Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (626,8,'SubCompany Goal Manage','SubCompany Goal Manage') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4108,'�ֲ�Ŀ���趨Ȩ��','SubCompanyGoal:Manage',626) 
/

insert into SystemRights (id,rightdesc,righttype) values (608,'����Ŀ���趨Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (608,7,'����Ŀ���趨Ȩ��','����Ŀ���趨Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (608,8,'Department Goal Manage','Department Goal Manage') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4109,'����Ŀ���趨Ȩ��','DepartmentGoal:Manage',608) 
/

insert into SystemRights (id,rightdesc,righttype) values (632,'����Ŀ���趨Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (632,8,'Company Goal Manage','Company Goal Manage') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (632,7,'����Ŀ���趨Ȩ��','����Ŀ���趨Ȩ��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4136,'����Ŀ���趨Ȩ��','CompanyGoal:Manage',632) 
/




insert into SystemRights (id,rightdesc,righttype) values (636,'���ű�������Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (636,7,'���ű�������Ȩ��','���ű�������Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (636,8,'GROUP REPORT SETTING','GROUP REPORT SETTING') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4113,'���ű�������Ȩ��','GroupReport:Performance',636) 
/

 
insert into SystemRights (id,rightdesc,righttype) values (635,'�ֲ���������Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (635,8,'BRANCH REPORT SETTING','BRANCH REPORT SETTING') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (635,7,'�ֲ���������Ȩ��','�ֲ���������Ȩ��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4114,'�ֲ���������Ȩ��','BranchReport:Performance',635) 
/ 


insert into SystemRights (id,rightdesc,righttype) values (634,'���żƻ��趨Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (634,8,'group plan setting','group plan setting') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (634,7,'���żƻ��趨Ȩ��','���żƻ��趨Ȩ��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4110,'���żƻ��趨Ȩ��','GroupPlan:Performance',634) 
/

insert into SystemRights (id,rightdesc,righttype) values (633,'�ֲ��ƻ��趨Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (633,8,'branch plan setting','branch plan setting') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (633,7,'�ֲ��ƻ��趨Ȩ��','�ֲ��ƻ��趨Ȩ��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4111,'�ֲ��ƻ��趨Ȩ��','BranchPlan:Performance',633) 
/


insert into SystemRights (id,rightdesc,righttype) values (610,'���ű�������Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (610,7,'���ű�������Ȩ��','���ű�������Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (610,8,'DEPARTMENT REPORT SUBMIT','DEPARTMENT REPORT SUBMIT') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4115,'���ű�������Ȩ��','DepartmentReport:Performance',610) 
/

insert into SystemRights (id,rightdesc,righttype) values (609,'���żƻ��趨Ȩ��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (609,7,'���żƻ��趨Ȩ��','���żƻ��趨Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (609,8,'Department PLAN SEETING','Department PLAN SEETING') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4112,'���żƻ��趨Ȩ��','DepartmentPlan:Performance',609) 
/


/*����sequence��*/
insert INTO SequenceIndex (indexdesc,currentid) values('gradeid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('planid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('targettypeid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('targetdetailid',1) 
/
insert INTO SequenceIndex (indexdesc,currentid) values('checkruleid',1) 
/
insert INTO SequenceIndex (indexdesc,currentid) values('checkdetailid',1)  
/

insert INTO SequenceIndex (indexdesc,currentid) values('appendruleid',1)   
/

insert INTO SequenceIndex (indexdesc,currentid) values('checkschemeid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('chemecontentid',1)

/
insert INTO SequenceIndex (indexdesc,currentid) values('schemedetailid',1)

/
/*
�ƻ�
*/
insert INTO SequenceIndex (indexdesc,currentid) values('targetplanid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('plangroupid',1)
/

/*
����
*/
insert INTO SequenceIndex (indexdesc,currentid) values('reportid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('reportlogid',1)
/
/*
����
*/

insert INTO SequenceIndex (indexdesc,currentid) values('checkid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('nodepointid',1)
/
insert INTO SequenceIndex (indexdesc,currentid) values('checkpointid',1)
/

/*Ŀ��*/
/*���Ŀ��Sequence*/
INSERT INTO SequenceIndex(indexdesc, currentid)VALUES('goalid',1)
/

/*���Ŀ��GroupSequence*/
INSERT INTO SequenceIndex(indexdesc, currentid)VALUES('goalgroupid',1)
/
/*
��߲˵�
*/

 
INSERT INTO HtmlLabelIndex values(18408,'��Ч�ƻ�') 
/
INSERT INTO HtmlLabelIndex values(18409,'��Ч����') 
/
INSERT INTO HtmlLabelInfo VALUES(18408,'��Ч�ƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18408,'Performorce Plan',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18409,'��Ч����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18409,'Perfomeroce Report',8) 
/ 

update leftmenuinfo set defaultindex=7 where id=97
/
update  leftmenuconfig set viewindex=7 where infoid=97 
/

CALL LMConfig_U_ByInfoInsert (2,94,1)
/
CALL LMInfo_Insert (95,18028,'/images_face/ecologyFace_2/LeftMenuIcon/MyKPI.gif','/hrm/performance/goal/myGoalFrame.jsp',2,94,1,9 )
/

CALL LMConfig_U_ByInfoInsert (2,94,3)
/
CALL LMInfo_Insert (120,18220,'/images_face/ecologyFace_2/LeftMenuIcon/MyKPI.gif','/hrm/performance/targetPlan/PlanModulList.jsp',2,94,3,2 )
/

CALL LMConfig_U_ByInfoInsert (2,94,2)
/
CALL LMInfo_Insert( 125,18408,'/images_face/ecologyFace_2/LeftMenuIcon/MyPlan.gif','/hrm/performance/targetPlan/PlanMain.jsp',2,94,2,2)
/

CALL LMConfig_U_ByInfoInsert (2,94,4)
/
CALL LMInfo_Insert( 126,16434,'/images_face/ecologyFace_2/LeftMenuIcon/MyAssess.gif','/hrm/performance/targetCheck/CheckMain.jsp',2,94,4,2)
/

CALL LMConfig_U_ByInfoInsert (2,94,6)
/
CALL LMInfo_Insert (124,18267,'/images_face/ecologyFace_2/LeftMenuIcon/MyKPI.gif','/hrm/performance/targetCheck/PointSort.jsp',2,94,6,2 )
/

CALL LMConfig_U_ByInfoInsert (2,94,5)
/
CALL LMInfo_Insert (127,18409,'/images_face/ecologyFace_2/LeftMenuIcon/MyReport.gif','/hrm/performance/targetReport/ReportMain.jsp',2,94,5,2 )
/



/**/
INSERT INTO HrmPerformanceCheckFlow (objId,objType) VALUES (0,'0')
/
INSERT INTO HrmPerformanceCheckFlow (objId,objType) SELECT id,'1' FROM HrmSubCompany
/
INSERT INTO HrmPerformanceCheckFlow (objId,objType) SELECT id,'2' FROM HrmDepartment
/
INSERT INTO HrmPerformanceCheckFlow (objId,objType) SELECT id,'3' FROM HrmDepartment
/

INSERT INTO HtmlLabelIndex values(18197,'Ŀ�꼨Ч�ƻ�����') 
/
INSERT INTO HtmlLabelIndex values(18198,'Ŀ�꼨ЧĿ������') 
/
INSERT INTO HtmlLabelIndex values(18199,'Ŀ�꼨Ч��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18197,'Ŀ�꼨Ч�ƻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18198,'Ŀ�꼨ЧĿ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18199,'Ŀ�꼨Ч��������',7) 
/

INSERT INTO HtmlLabelInfo VALUES(18197,'BPM Plan Approve',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18198,'BPM Target Approve',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18199,'BPM Grade',8) 
/

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 124,407,'integer','/systeminfo/BrowserMain.jsp?url=/hrm/performance/targetPlan/WorkPlanGroupBrowser.jsp','WorkPlanGroup','planName','id','/hrm/performance/targetPlan/PlanList.jsp?id=')
/
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 125,330,'integer','/systeminfo/BrowserMain.jsp?url=/htm/performance/goal/goalGroupBrowser.jsp','BPMGoalGroup','goalName','id','/hrm/performance/goal/myGoalList.jsp?id=')
/
INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 126,351,'integer','/systeminfo/BrowserMain.jsp?url=/htm/performance/report/HrmPerformanceReportGroupBrowser.jsp','GradeGroup','gradeName','id','/hrm/performance/targetCheck/GradeList.jsp?id=')
/

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(145,18197,'BillBPMApprovePlan','','','','','','BillBPMApprovePlanOperation.jsp') 
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (145,'paraID',407,'integer',3,124,1,0) 
/

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(146,18198,'BillBPMApproveGoal','','','','','','BillBPMApproveGoalOperation.jsp') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (146,'paraID',330,'integer',3,125,1,0) 
/

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(147,18199,'BillBPMGrade','','','','','','BillBPMGradeOperation.jsp') 
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (147,'paraID',351,'integer',3,126,1,0) 
/

CREATE or replace PROCEDURE GetMaxId_PRO 
(type_1 varchar2,
flag out 	integer,
msg out	varchar2,
thecursor IN OUT cursor_define.weavercursor)
as 
id_1 integer;
begin
select   currentid into id_1  from SequenceIndex where indexdesc= type_1;
update SequenceIndex set currentid = id_1+1 where indexdesc= type_1;
open thecursor for
select id_1 from dual;
end;
/

CREATE or replace procedure BPMSequenceId_Get
(indexdesc_1 varchar2,
flag out 	integer,
msg out	varchar2,
thecursor IN OUT cursor_define.weavercursor)
as 
id_1 integer;
begin
select currentid into id_1 from SequenceIndex where indexdesc = indexdesc_1;
update SequenceIndex set currentid = id_1+1 where indexdesc = indexdesc_1;
open thecursor for
select id_1 from dual;
end;
/

CREATE or replace procedure HrmBPMGoalMaxId_Get
(flag out 	integer,
msg out	varchar2,
thecursor IN OUT cursor_define.weavercursor)
as 
id_1 integer;
begin
select  currentid into id_1  from SequenceIndex where indexdesc='goalid';
update SequenceIndex set currentid = id_1+1 where indexdesc='goalid';
open thecursor for
select id_1 from dual;
end;
/

/*���� BPMGoalGroup ��ĸ��ģ��������и���Ŀ���״̬*/
create or REPLACE  TRIGGER Tri_UHrmPGoal_ByStatus 
after INSERT  or UPDATE ON BPMGoalGroup
FOR each row
Declare 
status_1 char(1);
groupid_2 integer;
countdelete_3 integer;
countinsert_4 integer;

begin
countdelete_3 := :old.id;
countinsert_4 :=:new.id;

/*����ʱ countinsert_4 >0 AND countdelete_3 = 0 */
/*ɾ��ʱ countinsert_4 =0 */
/*����ʱ countinsert_4 >0 AND countdelete_3 > 0 */

/*����*/
IF (countinsert_4>0 AND countdelete_3=0)
then
	groupid_2 := :new.id;
	status_1 := :new.status;
	UPDATE HrmPerformanceGoal SET status=status_1 WHERE groupid=groupid_2;
end if;

/*����*/
IF (countinsert_4 >0 AND countdelete_3>0)
then
	groupid_2 := :new.id;
	status_1 := :new.status;
	UPDATE HrmPerformanceGoal SET status=status_1 WHERE groupid=groupid_2;
end if;
end ;
/

create or REPLACE TRIGGER delCheckStd  
after  DELETE ON HrmPerformanceCheckDetail
FOR each row
DECLARE id_1 smallint;
begin
id_1 := :old.id;
delete from  hrmPerformanceCheckStd  where checkDetailId=id_1;
end;
/

create or REPLACE  TRIGGER deletecontent 
after DELETE ON HrmPerformanceSchemeContent
FOR each row
declare id_1 smallint;
begin
id_1 := :old.id;
delete from HrmPerformanceSchemeDetail where contentId=id_1;
end;
/

create or REPLACE  TRIGGER deleteItem 
after DELETE ON HrmPerformanceSchemeDetail
FOR each row
declare id_1 smallint;
begin
id_1 := :old.id;
delete from HrmPerformanceSchemePercent where itemId =id_1;
end;
/

create or REPLACE  TRIGGER AddTargetToMain 
after INSERT ON HrmPerformanceTargetDetail
FOR each row
declare id_1 smallint;
begin
id_1 := :old.targetId;
update hrmPerformanceTargetType set num=num+1 where id=id_1;
end;
/

create or REPLACE  TRIGGER delTargetToMain 
after DELETE ON HrmPerformanceTargetDetail
FOR each row
declare id_1 smallint;
begin
id_1 := :old.targetId;
update hrmPerformanceTargetType set num=num+1 where id=id_1;
end;
/

INSERT INTO HtmlLabelIndex values(18435,'��') 
/
INSERT INTO HtmlLabelInfo VALUES(18435,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18435,':',8) 
/
