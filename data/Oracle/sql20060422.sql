CREATE TABLE Bill_HrmOvertimeSapa ( 
    id integer ,
    resourceid integer,
    departmentid integer,
    applydate char(10),
    reason varchar2(500),
    fromdate char(10),
    fromtime char(8),
    tilldate char(10),
    tilltime char(8),
    totalhours number(15,2),
    weekhours number(15,2),
    weekendhours number(15,2),
    holidayhours number(15,2),
    comments varchar2(500),
    requestid integer) 
/
create sequence B_HOtimeSapa_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger B_HOtimeSapa_Trigger
before insert on Bill_HrmOvertimeSapa
for each row
begin
select B_HOtimeSapa_id.nextval into :new.id from dual;
end;
/

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(161,18832,'Bill_HrmOvertimeSapa','','','','','','BillHrmOvertimeSapaOperation.jsp') 
/
 
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'resourceid',413,'integer',3,1,1,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'departmentid',124,'integer',3,4,2,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'applydate',855,'char(10)',3,2,3,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'reason',18833,'varchar2(500)',2,0,4,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'fromdate',18834,'char(10)',3,2,5,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'fromtime',18835,'char(8)',3,19,6,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'tilldate',18836,'char(10)',3,2,7,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'tilltime',18837,'char(8)',3,19,8,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'totalhours',18838,'number(15,2)',1,3,9,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'weekhours',18839,'number(15,2)',1,3,10,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'weekendhours',18840,'number(15,2)',1,3,11,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'holidayhours',18841,'number(15,2)',1,3,12,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (161,'comments',454,'varchar2(500)',2,1,13,0,'')
/
INSERT INTO HtmlLabelIndex values(18833,'加班理由') 
/
INSERT INTO HtmlLabelIndex values(18835,'加班起始时间') 
/
INSERT INTO HtmlLabelIndex values(18838,'共计（小时）') 
/
INSERT INTO HtmlLabelIndex values(18840,'周末加班时间（小时）') 
/
INSERT INTO HtmlLabelIndex values(18839,'平时加班时间（小时）') 
/
INSERT INTO HtmlLabelIndex values(18841,'节假日加班时间（小时）') 
/
INSERT INTO HtmlLabelIndex values(18836,'加班终止日期') 
/
INSERT INTO HtmlLabelIndex values(18837,'加班终止时间') 
/
INSERT INTO HtmlLabelIndex values(18834,'加班起始日期') 
/
INSERT INTO HtmlLabelIndex values(18832,'加班申请单据') 
/
INSERT INTO HtmlLabelInfo VALUES(18832,'加班申请单据',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18832,'Overtime Bill',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18833,'加班理由',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18833,'Reason for Overtime',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18834,'加班起始日期',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18834,'Overtime From date',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18835,'加班起始时间',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18835,'Overtime From time',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18836,'加班终止日期',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18836,'Overtime till date',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18837,'加班终止时间',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18837,'Overtime till time',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18838,'共计（小时）',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18838,'Overtime total time(hours)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18839,'平时加班时间（小时）',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18839,'Overtime week time(hours)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18840,'周末加班时间（小时）',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18840,'Overtime weekend time(hours)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18841,'节假日加班时间（小时）',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18841,'Overtime holiday time(hours)',8) 
/

CREATE TABLE Bill_HolidayApply ( 
    id integer ,
    resourceid integer,
    department integer,
    applydate char(10),
    typeofleave integer,
    applyfromdate char(10),
    applyfromtime char(8),
    appliedtilldate char(10),
    appliedtilltime char(8),
    totalhours number(15,2),
    comments varchar2(500),
    requestid integer) 
/
create sequence B_HolidayApply_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger B_HolidayApply_Trigger
before insert on Bill_HolidayApply
for each row
begin
select B_HolidayApply_id.nextval into :new.id from dual;
end;
/
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(162,18855,'Bill_HolidayApply','','','','','','BillHolidayApplyOperation.jsp') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'resourceid',413,'integer',3,1,0,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'department',124,'integer',3,4,1,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'applydate',855,'char(10)',3,2,2,0,'')
/

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'typeofleave',1881,'integer',5,0,3,0,'')
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,0,'事假',1,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,1,'病假',2,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,2,'年休',3,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,3,'调休',4,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,4,'婚假',5,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,5,'产假',6,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,6,'丧假',7,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,7,'生产性放假',8,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,8,'公休',9,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,9,'探亲假',9.01,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,10,'其他',9.02,'n' from workflow_billfield where fieldname='typeofleave'
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'applyfromdate',18857,'char(10)',3,2,4,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'applyfromtime',18858,'char(8)',3,19,5,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'appliedtilldate',18859,'char(10)',3,2,6,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'appliedtilltime',18860,'char(8)',3,19,7,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'totalhours',18862,'number(15,2)',1,3,8,0,'')
/
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (162,'comments',454,'varchar2(500)',2,1,9,0,'')
/
 
INSERT INTO HtmlLabelIndex values(18855,'请假单据') 
/
INSERT INTO HtmlLabelInfo VALUES(18855,'请假单据',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18855,'LeaveBill',8) 
/


INSERT INTO HtmlLabelIndex values(18857,'请假起始日期') 
/
INSERT INTO HtmlLabelInfo VALUES(18857,'请假起始日期',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18857,'ApplyFromDate',8) 
/

INSERT INTO HtmlLabelIndex values(18858,'请假起始时间') 
/
INSERT INTO HtmlLabelInfo VALUES(18858,'请假起始时间',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18858,'ApplyFromTime',8) 
/

INSERT INTO HtmlLabelIndex values(18859,'请假终止日期') 
/
INSERT INTO HtmlLabelInfo VALUES(18859,'请假终止日期',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18859,'AppliedTillDate',8) 
/

INSERT INTO HtmlLabelIndex values(18860,'请假终止时间') 
/
INSERT INTO HtmlLabelInfo VALUES(18860,'请假终止时间',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18860,'AppliedTillTime',8) 
/

INSERT INTO HtmlLabelIndex values(18862,'共计小时数') 
/
INSERT INTO HtmlLabelInfo VALUES(18862,'共计小时数',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18862,'TotalHours',8) 
/