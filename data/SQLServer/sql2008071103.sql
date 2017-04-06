CREATE TABLE HrmAnnualLeaveInfo (
	id int IDENTITY (1,1) NOT NULL ,
	requestid int NULL ,
	resourceid int NULL ,
	startdate varchar (30) NULL ,
	starttime varchar (30) NULL ,
	enddate varchar (30) NULL ,
	endtime varchar (30) NULL ,
	leavetime float NULL ,
	occurdate varchar (30) NULL ,
	otherleavetype int NULL ,
        leavetype int NULL,        
	status int NULL 
)
GO

create table hrmLeaveTypeColor(
   id int identity not null,
   itemid int null,
   color varchar(30),
   subcompanyid int
)
go


create table HrmAnnualManagement(
   id int identity not null,
   resourceid int,   
   annualyear varchar(30),   
   annualdays float,
   status int
)
go



create table HrmAnnualBatchProcess(
   id int identity not null,
   workingage float,
   annualdays float,
   subcompanyid int     
)
go

create table HrmAnnualPeriod(
   id int identity not null,
   annualyear varchar(30),
   startdate varchar(30),
   enddate varchar(30),
   subcompanyid int   
)
go


CREATE TABLE Bill_BoHaiLeave ( 
    id int IDENTITY,
    resourceId int,
    departmentId int,
    leaveType int,
    otherLeaveType int,
    fromDate char(10),
    fromTime char(8),
    toDate char(10),
    toTime char(8),
    leaveDays float,
    leaveReason varchar(500),
    requestid int) 
GO

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield,operationpage) VALUES(180,20063,'Bill_BoHaiLeave','AddBillBoHaiLeave.jsp','ManageBillBoHaiLeave.jsp','ViewBillBoHaiLeave.jsp','','','BillBoHaiLeaveOperation.jsp') 
GO

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'resourceId',413,'int',3,1,0,0,'')
go
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'departmentId',124,'int',3,4,1,0,'')
go
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'leaveType',1881,'char(2)',5,0,2,0,'')
go

INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,1,'�¼�',1,'n' from workflow_billfield where fieldname='leaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,2,'����',2,'n' from workflow_billfield where fieldname='leaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,3,'�����Ǵ�н��',3,'n' from workflow_billfield where fieldname='leaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,4,'������н��',4,'n' from workflow_billfield where fieldname='leaveType'
go

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'otherLeaveType',20053,'char(2)',5,0,3,0,'')
go

INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,1,'̽�׼�',1,'n' from workflow_billfield where fieldname='otherLeaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,2,'���',2,'n' from workflow_billfield where fieldname='otherLeaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,3,'���',3,'n' from workflow_billfield where fieldname='otherLeaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,4,'���ټ�������',4,'n' from workflow_billfield where fieldname='otherLeaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,5,'�����',5,'n' from workflow_billfield where fieldname='otherLeaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,6,'ɥ��',6,'n' from workflow_billfield where fieldname='otherLeaveType'
go
INSERT INTO workflow_SelectItem(fieldid,isbill,selectvalue,selectname,listorder,isdefault) select max(id),1,7,'��ͯ�㻤��',7,'n' from workflow_billfield where fieldname='otherLeaveType'
go

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'fromDate',1322,'char(10)',3,2,4,0,'')
go
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'fromTime',17690,'char(8)',3,19,5,0,'')
go
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'toDate',741,'char(10)',3,2,6,0,'')
go
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'toTime',743,'char(8)',3,19,7,0,'')
go
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'leaveDays',828,'float',1,3,8,0,'')
go

INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'lastyearannualdays',21614,'float',1,3,8,0,'')
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'thisyearannualdays',21615,'float',1,3,8,0,'')
GO
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'allannualdays',21616,'float',1,3,8,0,'')
GO 
 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype,detailtable) VALUES (180,'leaveReason',20054,'varchar(500)',2,0,9,0,'')
go 

alter table bill_bohaileave add lastyearannualdays float
go
alter table bill_bohaileave add thisyearannualdays float
go
alter table bill_bohaileave add allannualdays float
go 