update HrmPerformanceTargetDetail set unit=''
/

INSERT INTO HtmlLabelIndex values(18522,'������λ�Զ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18522,'������λ�Զ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18522,'CUSTOM SET UNIT',8) 
/


insert into SystemRights (id,rightdesc,righttype) values (641,'�Զ��������λ','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (641,8,'custom set unit','custom set unit') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (641,7,'�Զ��������λ','�Զ��������λ') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4141,'�Զ��������λ����','Custom:Performance',641) 
/


call MMConfig_U_ByInfoInsert (433,9)
/
call MMInfo_Insert (471,18522,'������λ�Զ���','hrm/performance/maintenance/custom/CustomList.jsp','mainFrame',433,2,9,0,'',1,'Custom:Performance',0,'','',0,'','',2)
/

insert into SystemRightToGroup (groupid,rightid) select max(id),641 from SystemRightGroups
/

CREATE TABLE HrmPerformanceCustom (
	id integer  NOT NULL ,
	unitName varchar2 (50)  NULL ,
	memo varchar2 (50)  NULL ,
	status char (1)  NULL 
)
/
create sequence HPfCustom_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HPfCustom_Trigger
before insert on HrmPerformanceCustom
for each row
begin
select HPfCustom_id.nextval into :new.id from dual;
end;
/

INSERT INTO HtmlLabelIndex values(18507,'�ƻ�����') 
/
INSERT INTO HtmlLabelIndex values(18508,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(18507,'�ƻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18507,'PLAN PROVE',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18508,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18508,'SET POINT',8) 
/
INSERT INTO HtmlLabelIndex values(18509,'Ŀ������') 
/
INSERT INTO HtmlLabelInfo VALUES(18509,'Ŀ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18509,'GOAL PROVE',8) 
/

call LMConfig_U_ByInfoInsert (2,94,4)
/
call LMInfo_Insert (141,18508,'/images_face/ecologyFace_2/LeftMenuIcon/MyAssess.gif','/hrm/performance/targetCheck/SetPoint.jsp',2,94,4,2 )
/

call LMConfig_U_ByInfoInsert (2,94,5)
/
call LMInfo_Insert (142,18507,'/images_face/ecologyFace_2/LeftMenuIcon/MyPlan.gif','/hrm/performance/targetPlan/PlanProve.jsp',2,94,5,2) 
/
call LMConfig_U_ByInfoInsert (2,94,6)
/
call LMInfo_Insert (143,18509,'/images_face/ecologyFace_2/LeftMenuIcon/MyAssess.gif','/hrm/performance/goal/GoalProve.jsp',2,94,6,2) 
/
