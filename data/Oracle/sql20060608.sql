INSERT INTO HtmlLabelIndex values(19023,'����������') 
/
INSERT INTO HtmlLabelInfo VALUES(19023,'����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19023,'set the Share of report',8) 
/

INSERT INTO HtmlLabelIndex values(19024,'������ �� Ч�ʱ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19024,'������ �� Ч�ʱ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19024,'WORKFLOW - EFFICIENCY REPORT FORM',8) 
/

INSERT INTO HtmlLabelIndex values(19059,'ƽ����ʱ') 
/
INSERT INTO HtmlLabelInfo VALUES(19059,'ƽ����ʱ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19059,'average spending',8) 
/

INSERT INTO HtmlLabelIndex values(19025,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(19025,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19025,'SET SHARE',8) 
/
INSERT INTO HtmlLabelIndex values(19101,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(19101,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19101,'percent of overTime',8) 
/
INSERT INTO HtmlLabelIndex values(19045,'���ύ') 
/
INSERT INTO HtmlLabelIndex values(19044,'����׼') 
/
INSERT INTO HtmlLabelInfo VALUES(19044,'����׼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19044,'approving',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19045,'���ύ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19045,'submiting',8) 
/

INSERT INTO HtmlLabelIndex values(19060,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(19060,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19060,'request',8) 
/

INSERT INTO HtmlLabelIndex values(19081,'��ʱ') 
/
INSERT INTO HtmlLabelInfo VALUES(19081,'��ʱ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19081,'Overtime',8) 
/

INSERT INTO HtmlLabelIndex values(19079,'��ʱ') 
/
INSERT INTO HtmlLabelInfo VALUES(19079,'��ʱ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19079,'spendtime',8) 
/
INSERT INTO HtmlLabelIndex values(19061,'����״̬') 
/
INSERT INTO HtmlLabelInfo VALUES(19061,'����״̬',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19061,'request status',8) 
/
INSERT INTO HtmlLabelIndex values(19062,'��ת��') 
/
INSERT INTO HtmlLabelInfo VALUES(19062,'��ת��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19062,'flowing',8) 
/
INSERT INTO HtmlLabelIndex values(19027,'��������ͳ�Ʊ�') 
/
INSERT INTO HtmlLabelIndex values(19028,'��������ͳ�Ʊ�') 
/
INSERT INTO HtmlLabelIndex values(19032,'�������������Ա������') 
/
INSERT INTO HtmlLabelIndex values(19037,'���������Ա������') 
/
INSERT INTO HtmlLabelIndex values(19030,'��Ա����ʱ�������') 
/
INSERT INTO HtmlLabelIndex values(19033,'����Ч������') 
/
INSERT INTO HtmlLabelIndex values(19036,'�����������������') 
/
INSERT INTO HtmlLabelIndex values(19035,'�ڵ����Ч����Ա������') 
/
INSERT INTO HtmlLabelIndex values(19029,'��������ʱ�������') 
/
INSERT INTO HtmlLabelIndex values(19034,'��ʱ�����������') 
/
INSERT INTO HtmlLabelIndex values(19031,'���̺�ʱͳ�Ʊ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19027,'��������ͳ�Ʊ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19027,'statistical table of Flow type',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19028,'��������ͳ�Ʊ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19028,'statistical table of treats manages the matters concerned',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19029,'��������ʱ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19029,'Analytical table of flow flow time',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19030,'��Ա����ʱ�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19030,'Analytical table of the time that personnel handles',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19031,'���̺�ʱͳ�Ʊ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19031,'Statistical table of the flow consumes time',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19032,'�������������Ա������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19032,'Order table of most personnel that treats manages matters concerned',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19033,'����Ч������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19033,'the oder of Flow efficiency',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19034,'��ʱ�����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19034,'Order table of Consumes when longest flow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19035,'�ڵ����Ч����Ա������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19035,'Order table of node operating efficiency personnel',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19036,'�����������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19036,'Order table of most flows of Goes over the time limit',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19037,'���������Ա������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19037,'Order table of most personnel of Goes over the time limit',8) 
/

INSERT INTO HtmlLabelIndex values(19083,'��') 
/
INSERT INTO HtmlLabelIndex values(19082,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(19082,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19082,'sort',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19083,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19083,'total',8) 
/

CALL MMConfig_U_ByInfoInsert (4,15)
/
CALL MMInfo_Insert (479,19023,'����������','/workflow/flowReport/ReportShareSet.jsp','mainFrame',4,1,15,0,'',0,'',0,'','',0,'','',3)
/


insert into SystemRights (id,rightdesc,righttype) values (646,'����������','5') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (646,8,'SET WORKFLOW - EFFICIENCY REPORT FORM','SET WORKFLOW - EFFICIENCY REPORT FORM') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (646,7,'Ч�ʱ���������','Ч�ʱ���������') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4146,'����������','REPORTSHARE:WORKFLOW',646) 
/



CALL MMConfig_U_ByInfoInsert (203,3)
/
CALL MMInfo_Insert (482,19029,'������תʱ�������','/workflow/flowReport/FlowTimeAnalyse.jsp','mainFrame',203,2,3,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (203,4)
/
CALL MMInfo_Insert (483,19030,'��Ա����ʱ�������','/workflow/flowReport/HandleRequestAnalyse.jsp','mainFrame',203,2,4,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (203,9)
/
CALL MMInfo_Insert (485,19033,'����Ч������','','',203,2,9,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (203,1)
/
CALL MMInfo_Insert (480,19027,'��������ͳ�Ʊ�','/workflow/flowReport/FlowTypeStat.jsp','mainFrame',203,2,1,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (203,5)
/
CALL MMInfo_Insert (484,19031,'���̺�ʱʱ��ͳ�Ʊ�','/workflow/flowReport/SpendTimeStat.jsp','mainFrame',203,2,5,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (203,2)
/
CALL MMInfo_Insert (481,19028,'��������ͳ�Ʊ�','/workflow/flowReport/PendingRequestStat.jsp','mainFrame',203,2,2,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (485,1)
/
CALL MMInfo_Insert (486,19032,'�������������Ա������','/workflow/flowReport/MostPendingRequest.jsp','mainFrame',485,3,1,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (485,3)
/
CALL MMInfo_Insert (488,19035,'�ڵ����Ч����Ա������','/workflow/flowReport/NodeOperatorfficiency.jsp','mainFrame',485,3,3,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (485,5)
/
CALL MMInfo_Insert (490,19037,'���������Ա������','/workflow/flowReport/MostExceedPerson.jsp','mainFrame',485,3,5,0,'',0,'',0,'','',0,'','',3)
/

CALL MMConfig_U_ByInfoInsert (485,2)
/
CALL MMInfo_Insert (487,19034,'��ʱ�����������','/workflow/flowReport/MostSpendTime.jsp','mainFrame',485,3,2,0,'',0,'',0,'','',0,'','',2)
/

CALL MMConfig_U_ByInfoInsert (485,4)
/
CALL MMInfo_Insert (489,19036,'�����������������','/workflow/flowReport/MostExceedFlow.jsp','mainFrame',485,3,4,0,'',0,'',0,'','',0,'','',3)
/


/******����******/
CREATE UNIQUE  INDEX workflow_requestid ON workflow_requestbase
(
	requestid  ASC
	) 
/

CREATE  INDEX hrmresource_id ON hrmresource
(
	id  ASC,
	departmentid asc
	) 
/

CREATE  INDEX idandstatus ON workflow_requestbase
(
	requestid  ASC,
	status asc
	) 
/

CREATE  INDEX workflowUserAndId ON workflow_currentoperator
(
	requestid  ASC,
	userid  ASC,
	workflowid asc
	) 
/

create  INDEX UserAndRequestId ON workflow_currentoperator
(   userid  ASC,
	requestid  ASC
	
	
	) 
/





create or replace view WorkFlowPending (uerid,counts) as 
SELECT      userid, COUNT(requestid) AS Expr1
FROM        workflow_currentoperator
WHERE     (isremark IN ('0', '1', '5')) 
AND (islasttimes = 1) AND (usertype = 0) and exists (select 1 from hrmresource where hrmresource.id=workflow_currentoperator.userid and hrmresource.status in (0,1,2,3) )
GROUP BY userid
ORDER BY COUNT(requestid) desc
/

create or replace view MostExceedPerson as 

select   userid,count(distinct workflow_requestbase.requestid) as counts,
(select count(requestid) from workflow_requestbase b 
where exists (select 1 from workflow_currentoperator  a 
where a.requestid=b.requestid 
and a.userid=workflow_currentoperator.userid) 
and b.status is not null ) as countall,

to_number(count(distinct workflow_requestbase.requestid)*100)/to_number((select count(requestid) from workflow_requestbase b 
where exists (select 1 from workflow_currentoperator  a 
where a.requestid=b.requestid 
and a.userid=workflow_currentoperator.userid) 
and b.status is not null ) ) as percents

from workflow_currentoperator,workflow_requestbase 
where  workflow_currentoperator.requestid=workflow_requestbase.requestid  
and (24*
(
to_date(NVL2(lastoperatedate ,lastoperatedate||' '||lastoperatetime,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')),'YYYY-MM-DD HH24:MI:SS') - 
to_date(createdate||' '||createtime,'YYYY-MM-DD HH24:MI:SS')
)
-
(
select 
sum(NVL(to_number(nodepasshour),0)+NVL(to_number(nodepassminute),0)/24) 
from workflow_nodelink where workflowid=workflow_requestbase.workflowid
)

)>0 
and   workflow_requestbase.status is not null   
and exists (select 1 from workflow_nodelink where workflowid=workflow_requestbase.workflowid
and  (workflow_currentoperator.usertype = 0) and exists (select 1 from hrmresource where hrmresource.id=workflow_currentoperator.userid and hrmresource.status in (0,1,2,3))  
and (to_number(NVL(nodepasshour,0))>0 or to_number(nvl(nodepassminute,0))>0))
group by userid
order by percents desc
/

INSERT INTO HtmlLabelIndex values(19026,'Ч�ʱ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19026,'Ч�ʱ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19026,'EFFICIENCY REPORT FORM',8) 
/

update htmllabelinfo set labelname='������תʱ�������' where indexid=19029 and languageid=7
/

update  SystemRights set rightdesc='����������' where id=646
/
update SystemRightsLanguage set  rightdesc='Ч�ʱ���������' ,rightname='Ч�ʱ���������' where id=646 and languageid=7
/
update SystemRightDetail set rightdetailname='����������' where id=4146
/

UPDATE MainMenuInfo SET defaultIndex=1 WHERE id=480
/
UPDATE MainMenuInfo SET defaultIndex=2 WHERE id=481
/
UPDATE MainMenuInfo SET defaultIndex=3 WHERE id=482
/
UPDATE MainMenuInfo SET defaultIndex=4 WHERE id=483
/
UPDATE MainMenuInfo SET defaultIndex=5 WHERE id=484
/
UPDATE MainMenuInfo SET defaultIndex=6 WHERE id=233
/
UPDATE MainMenuInfo SET defaultIndex=7 WHERE id=234
/
UPDATE MainMenuInfo SET defaultIndex=8 WHERE id=474
/
UPDATE MainMenuInfo SET defaultIndex=9 WHERE id=485
/
UPDATE MainMenuInfo SET defaultIndex=10 WHERE id=236
/
DELETE FROM MainMenuInfo WHERE id=232 OR id=235
/












