create table Sys_tabledict
(
id int NOT NULL IDENTITY (1, 1),
tablename varchar(30) NULL,
tabledesc varchar(100) NULL,
tabledescen varchar(100) NULL,
tabletype int NULL,
modetype int NULL,
memo varchar(200) NULL
)
GO

create table Sys_fielddict
(
tabledictid int NOT NULL,
fieldname varchar(30) NULL,
fielddesc varchar(100) NULL,
fielddescen varchar(100) NULL,
fielddbtype varchar(40) NULL,
fieldhtmltype char(1) NULL,
type int NULL,
dsporder int NULL
)
GO

alter table Workflow_DataInput_table
add FormId varchar(100)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmResource','������Դ','human resource',0,1,'������Դ')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'lastname','��Ա����','name','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'birthday','����','birthday','char(10)',3,2,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'nationality','����','nationality','int',1,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'telephone','�绰','telephone','varchar(60)',1,1,4) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'mobile','�ֻ�','mobilephone','varchar(60)',1,1,5) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'mobilecall','��������','other telephone','varchar(60)',1,1,6) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'email','�����ʼ�','email','varchar(60)',1,1,7) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'locationid','�����ص�','location','int',1,2,8) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'workroom','�칫��','office room','varchar(60)',1,1,9) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'homeaddress','��ͥסַ','home address','varchar(100)',1,1,10) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'startdate','��ͬ��ʼ����','beginning date of contract','char(10)',3,2,11) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'enddate','��ͬ��������','ending date of contract','char(10)',3,2,12) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'jobtitle','��λ','post','int',1,2,13) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'jobactivitydesc','ְ������','description of activity','varchar(200)',1,1,14) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'joblevel','ְ��','level','int',1,2,15) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'seclevel','��ȫ����','security level','int',1,2,16) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'departmentid','����','department','int',3,4,17) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'subcompanyid1','�ֲ�','subcompany','int',3,42,18) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'managerid','����','manager','int',3,1,19) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'assistantid','����','assistant','int',3,1,20) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'bankid1','����','bankid1','int',1,2,21) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'accountid1','�ʺ�','account','varchar(100)',1,1,22) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'createrid','������','creater','int',3,1,23) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'createdate','��������','create date','char(10)',3,2,24) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'lastmodid','����޸���','the last modifyer','int',3,1,25) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'lastmoddate','����޸�����','the date of last modifing','char(10)',3,2,26) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'lastlogindate','����½����','the date of last login','char(10)',3,2,27) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'certificatenum','���֤����','identity card no.','varchar(60)',1,1,28) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'nativeplace','����','native place','varchar(100)',1,1,29) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'educationlevel','ѧ��','education','varchar(100)',1,2,30) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'bememberdate','����ʱ��','the date of join the group','char(10)',3,2,31) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'bepartydate','�뵳ʱ��','the date of join the party','char(10)',3,2,32) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'workcode','���','code','varchar(60)',1,1,33) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'regresidentplace','����','regresidentplace','varchar(60)',1,1,34) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'residentplace','��ס��','residentplace','varchar(60)',1,1,35) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'policy','������ò','policy','varchar(30)',1,1,36) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'degree','ѧλ','degree','varchar(30)',1,1,37) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'height','���','height','varchar(10)',1,1,38) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'jobcall','ְ��','the title of a technical post','int',1,2,39) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'accumfundaccount','�������ʺ�','accumfundaccount','varchar(30)',1,1,40) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'birthplace','������','hometown','varchar(60)',1,1,41) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'folk','����','folk','varchar(30)',1,1,42) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'residentphone','��ס�ص绰','home phone','varchar(60)',1,1,43) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'residentpostcode','��ס���ʱ�','post code','varchar(60)',1,1,44) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'extphone','�ֻ�','extension phone','varchar(50)',1,1,45) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'fax','����','fax','varchar(60)',1,1,46) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'weight','����','weight','int',1,2,47) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'tempresidentnumber','��ס֤����','tempresidentnumber','varchar(60)',1,1,48) 
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'probationenddate','�����ڽ�������','the end date of probationership','char(10)',3,2,49) 
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmCountry','����','country',0,1,'����')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(2,'countryname','��������','countryname','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(2,'countrydesc','��������','description of country','varchar(200)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmLocations','�����ص�','location',0,1,'�����ص�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'locationname','�����ص�����','locationname','varchar(200)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'locationdesc','�����ص�����','description of location','varchar(200)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'address1','������ַ1','address1','varchar(200)',1,1,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'address2','������ַ2','address2','varchar(200)',1,1,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'locationcity','�����ص����ڳ���','city of location','int',3,58,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'postcode','�ʱ�','post code','varchar(20)',1,1,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'countryid','�����ص����ڹ���','country of location','int',1,2,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'telephone','�绰','telephone','varchar(60)',1,1,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'fax','����','fax','varchar(60)',1,1,9)

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmJobTitles','��λ��','post table',0,1,'��λ��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobtitlemark','ְλ��ʶ','mark of post','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobtitlename','ְλ����','description of post','varchar(200)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobtitleremark','��ע','remark','text',2,0,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobactivityid','����ְ��id','job activity id','int',1,2,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobdepartmentid','��������id','job department id','int',3,4,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobresponsibility','��λְ��','responsibility','varchar(200)',1,1,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobcompetency','��λҪ��','competency','varchar(200)',1,1,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'jobdoc','����ĵ�','document','int',1,2,8)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmDepartment','����','department',0,1,'������Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(5,'departmentmark','���ű�ʶ','mark of department','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(5,'departmentname','��������','description of department','varchar(200)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(5,'subcompanyid1','�����ֲ�id','subcompany','int',3,42,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(5,'supdepid','�ϼ�����id','super department id','int',3,4,4)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmSubCompany','�ֲ�','SubCompany',0,1,'�ֲ���Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(6,'subcompanyname','�ֲ����','name of subcompany','varchar(200)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(6,'subcompanydesc','�ֲ�����','description of subcompany','varchar(200)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(6,'companyid1','�����ܲ�id','company','int',1,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(6,'supsubcomid','�ϼ��ֲ�id','super subcompany','int',3,42,4)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmBank','����','bank',0,1,'������Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(7,'bankname','��������','name of bank','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(7,'bankdesc','��������','description of bank','varchar(200)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmEducationInfo','���������','education information',0,1,'���������')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(8,'school','ѧУ','school','varchar(100)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(8,'speciality','רҵ','speciality','varchar(60)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(8,'studydesc','��ϸ����','particular description','text',2,0,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(8,'startdate','��ʼʱ��','startdate','varchar(10)',3,2,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(8,'enddate','����ʱ��','enddate','varchar(10)',3,2,5)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmJobCall','ְ�Ʊ�','the titles of all technical post',0,1,'ְ�Ʊ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(9,'name','ְ������','name','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(9,'description','ְ������','description','varchar(60)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmCity','���б�','City',0,1,'���б�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(10,'cityname','��������','name of city','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(10,'citylongitude','���о���','longitude of city','numeric(8,3)',1,3,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(10,'citylatitude','����γ��','latitude of city','numeric(8,3)',1,3,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(10,'provinceid','ʡ��id','province','int',1,2,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(10,'countryid','����id','country','int',1,2,5)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmProvince','ʡ�ݱ�','Province',0,1,'ʡ�ݱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(11,'provincename','ʡ������','name of province','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(11,'provincedesc','ʡ������','description of province','varchar(200)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(11,'countryid','����id','country','int',1,2,3)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmJobActivities','ְ���','Job Activities',0,1,'ְ���')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(12,'jobactivitymark','ְ���ʶ','mark of activity','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(12,'jobactivityname','ְ������','description of activity','varchar(200)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(12,'jobgroupid','��������','work type','int',1,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(12,'joblevelfrom','���ְ��','lowest level','int',1,2,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(12,'joblevelto','���ְ��','highest level','int',1,2,5)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmJobGroups','ְ�����ͱ�','Activitie type',0,1,'ְ�����ͱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(13,'jobgroupname','������������','description of work type','varchar(200)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(13,'jobgroupremark','�������ͱ�ʶ','remark of work type','text',2,0,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('HrmSpeciality','רҵ��','Speciality',0,1,'רҵ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(14,'name','רҵ����','speciality name','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(14,'description','רҵ����','speciality description','varchar(60)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('DocDetail','�ĵ���Ϣ��','document information',0,2,'�ĵ���Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'maincategory','�ĵ���Ŀ¼','main category','int',1,2,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'subcategory','�ĵ���Ŀ¼','subcategory','int',1,2,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'seccategory','�ĵ���Ŀ¼','subdirectory','int',1,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docsubject','�ĵ�����','document subject','varchar(200)',1,1,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccontent','�ĵ�����','document content','text',2,0,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'hrmresid','�ĵ���ѡ���������Դ','humen resource','int',3,1,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'crmid','�ĵ���ѡ��Ŀͻ�','customer resource','int',3,1,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'projectid','�ĵ���ѡ�����Ŀ','project','int',3,8,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccreaterid','�ĵ�������','document creater','int',3,1,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docdepartmentid','�ĵ����������ڲ���','department of document creater','int',3,4,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccreatedate','�ĵ���������','create date of document','char(10)',3,2,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccreatetime','�ĵ�����ʱ��','create time of document','char(8)',3,19,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doclastmoduserid','�ĵ�����޸���','document latest modifyer','int',3,1,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doclastmoddate','�ĵ�����޸�����','the date of latest modifying','char(10)',3,2,14)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doclastmodtime','�ĵ�����޸�ʱ��','the time of latest modifying','char(8)',3,19,15)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docapproveuserid','�ĵ�������','document approver','int',3,1,16)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docapprovedate','�ĵ���������','the date of approving','char(10)',3,2,17)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docapprovetime','�ĵ�����ʱ��','the time of approving','char(8)',3,19,18)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docarchiveuserid','�ĵ��鵵��','document archiver','int',3,1,19)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docarchivedate','�ĵ��鵵����','the date of archiving','char(10)',3,2,20)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docarchivetime','�ĵ��鵵ʱ��','the time of archiving','char(8)',3,19,21)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'ownerid','�ĵ�ӵ����','document owner','int',3,1,22)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'keyword','�ؼ���','keyword','varchar(255)',1,1,23)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'accessorycount','��������','count of accessory','int',1,2,24)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'replaydoccount','�ظ��ĵ�������','count of replay','int',1,2,25)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docno','�ĵ��鵵��','document archive no.','varchar(100)',1,1,26)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'countMark','��ִ���','count of marking','int',1,2,27)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'sumMark','�ܷ���','sum of marking','int',1,2,28)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'sumReadCount','�����','count of reading','int',1,2,29)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccode','�ĵ����','document code','varchar(200)',1,1,30)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docedition','�ĵ��汾','document edition','int',1,2,31)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'maindoc','�ĵ��汾','main document','int',3,9,32)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docvaliduserid','��Ч������','the people who making document valid','int',3,1,33)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docvaliddate','��Ч����','the date of validation','char(10)',3,2,34)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docvalidtime','��Чʱ��','the time of validation','char(8)',3,19,35)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docpubuserid','����������','document publisher','int',3,1,36)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docpubdate','��������','the date of publishing','char(10)',3,2,37)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docpubtime','����ʱ��','the time of publishing','char(8)',3,19,38)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docreopenuserid','���´򿪲�����','the people who reopen the document','int',3,1,39)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docreopendate','���´�����','the date of reopenning','char(10)',3,2,40)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docreopentime','���´�ʱ��','the time of reopenning','char(8)',3,19,41)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docinvaluserid','ʧЧ������','the people who making document invalid','int',3,1,42)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docinvaldate','ʧЧ����','the date of invalidation','char(10)',3,2,43)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'docinvaltime','ʧЧʱ��','the time of invalidation','char(8)',3,19,44)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccanceluserid','���ϲ�����','the people who making document blank out','int',3,1,45)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccanceldate','��������','the date of blanking out','char(10)',3,2,46)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'doccanceltime','����ʱ��','the time of blanking out','char(8)',3,19,47)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'checkOutUserId','ǩ���û�','the people who check out the document','int',3,1,48)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'checkOutDate','ǩ������','the date of checking out','char(10)',3,2,49)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'checkOutTime','ǩ��ʱ��','the time of checking out','char(8)',3,19,50)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'invalidationdate','ʧЧ����','the date of invalidation','char(10)',3,2,51)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'canPrintedNum','�ɴ�ӡ����','total count of printing','int',1,2,52)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'hasPrintedNum','�Ѵ�ӡ����','printed count','int',1,2,53)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('DocMainCategory','�ĵ���Ŀ¼��Ϣ��','document main category information',0,2,'�ĵ���Ŀ¼��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(16,'categoryname','�ĵ���Ŀ¼����','name of main category','varchar(200)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(16,'coder','�ĵ���Ŀ¼����','code of main category','varchar(20)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('DocSubCategory','�ĵ���Ŀ¼��Ϣ��','document sub category information',0,2,'�ĵ���Ŀ¼��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(17,'maincategoryid','�ĵ���Ŀ¼','main category','int',1,2,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(17,'categoryname','�ĵ���Ŀ¼����','name of subcategory','varchar(200)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(17,'coder','�ĵ���Ŀ¼����','code','varchar(20)',1,1,3)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('DocSecCategory','�ĵ���Ŀ¼��Ϣ��','document subdirectory information',0,2,'�ĵ���Ŀ¼��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(18,'categoryname','�ĵ���Ŀ¼����','name of subdirectory','varchar(200)',1,1,1)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_CustomerInfo','�ͻ���Ϣ��','customer information',0,3,'�ͻ���Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'name','�ͻ�����','name of customer','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'engname','�ͻ�Ӣ������','english name of customer','varchar(50)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'address1','��ַ1','address1','varchar(250)',1,1,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'address2','��ַ2','address2','varchar(250)',1,1,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'address3','��ַ3','address3','varchar(250)',1,1,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'zipcode','�ʱ�','zip code','varchar(10)',1,1,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'city','����','city','int',3,58,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'country','����','country','int',1,2,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'province','ʡ��','province','int',1,2,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'county','��','county','varchar(50)',1,1,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'phone','��ϵ�绰','phone','varchar(50)',1,1,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'fax','����','fax','varchar(50)',1,1,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'email','��������','email','varchar(150)',1,1,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'website','��ַ','website','varchar(150)',1,1,14)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'source','��ϵ��ʽ','contact way','int',1,2,15)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'sector','��ҵ����','sector','int',1,2,16)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'manager','������','manager','int',3,1,17)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'manager','������','manager','int',3,7,18)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'parentid','��һ���ͻ�','parent customer','int',3,7,19)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'department','����','department','int',3,4,20)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'documentid','����ĵ�','related document','int',3,9,21)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'size_n','��ģ','size','int',3,62,22)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'type','����','type','int',3,60,23)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'typebegin','��ʼ����','begin date','char(10)',3,2,24)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'description','�ͻ�����','description','int',3,61,25)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'status','�ͻ�״̬','status','int',1,2,26)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'createdate','��������','create date','char(10)',3,2,27)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'introductionDocid','��������','introduction','int',3,9,28)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'evaluation','�ͻ���ֵ','evaluation','int',1,2,29)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'CreditAmount','���ý����','credit amount','decimal(15,3)',1,3,30)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'CreditTime','�����ڼ�','CreditTime','int',1,2,31)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'bankName','��������','name of bank','varchar(200)',1,1,32)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'accountName','��������','name of account','varchar(40)',1,1,33)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'accounts','�����ʺ�','account','varchar(200)',1,1,34)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'crmcode','�ͻ�����','code of customer','varchar(100)',1,1,35)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_ContactWay','�ͻ���ϵ��ʽ��','contact way with customer',0,3,'�ͻ���ϵ��ʽ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(20,'fullname','��ϵ��������','name of contract way','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(20,'description','��ϵ��������','description of contract way','varchar(150)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_SectorInfo','�ͻ�������Ϣ��','customer sector information',0,3,'�ͻ�������Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(21,'fullname','����','name','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(21,'description','����','description','varchar(150)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(21,'parentid','��һ����ҵ','parent sector','int',1,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(21,'seclevel','��ҵ����','sector level','int',1,2,4)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_CustomerSize','�ͻ���ģ��','company size',0,3,'�ͻ���ģ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(22,'fullname','��ģ','size','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(22,'description','����','description','varchar(150)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_CustomerType','�ͻ����ͱ�','customer type',0,3,'�ͻ����ͱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(23,'fullname','����','name','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(23,'description','����','description','varchar(150)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_CustomerDesc','�ͻ�������','customer description',0,3,'�ͻ�������')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(24,'fullname','����','name','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(24,'description','����','description','varchar(150)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_CustomerStatus','�ͻ�״̬��','customer status',0,3,'�ͻ�״̬��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(25,'fullname','����','name','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(25,'description','����','description','varchar(150)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_Evaluation_Level','�ͻ���ֵ��','customer evaluation',0,3,'�ͻ���ֵ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(26,'name','����','name','varchar(50)',1,1,1)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('Prj_ProjectInfo','��Ŀ��Ϣ��','project information',0,4,'�ͻ���Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'name','��Ŀ����','name of project','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'description','��Ŀ����','description of project','varchar(2000)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'prjtype','��Ŀ����','type of project','int',3,138,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'worktype','��������','type of work','int',3,139,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'securelevel','��ȫ����','securety level','int',1,2,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'status','��Ŀ״̬','project status','int',1,2,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'planbegindate','Ԥ�ƿ�ʼ����','begin date','char(10)',3,2,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'planbegintime','Ԥ�ƿ�ʼʱ��','begin time','char(5)',3,19,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'planenddate','Ԥ�ƽ�������','end date','char(10)',3,2,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'planendtime','Ԥ�ƽ���ʱ��','end time','char(5)',3,19,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'truebegindate','ʵ�ʿ�ʼ����','begin date','char(10)',3,2,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'truebegintime','ʵ�ʿ�ʼʱ��','begin time','char(5)',3,19,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'trueenddate','ʵ�ʽ�������','end date','char(10)',3,2,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'trueendtime','ʵ�ʽ���ʱ��','end time','char(5)',3,19,14)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'planmanhour','Ԥ�ƹ�ʱ','expecting man-hour','int',1,2,15)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'truemanhour','ʵ�ʹ�ʱ','actual man-hour','int',1,2,16)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'parentid','�ϼ���Ŀ','parent project','int',3,8,17)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'envaluedoc','������','envalue document','int',3,9,18)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'confirmdoc','ȷ����','confirm document','int',3,9,19)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'proposedoc','������','propose document','int',3,9,20)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'manager','��Ŀ����','manager of project','int',3,1,21)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'department','��Ŀ����','department of project','int',3,4,22)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'creater','��Ŀ������','creater of project','int',3,1,23)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'createdate','��������','create date of project','char(10)',3,2,24)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'createtime','����ʱ��','create time of project','char(8)',3,19,25)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'subcompanyid1','��Ŀ�ֲ�','subcompany of project','int',3,42,26)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'proCode','��Ŀ����','code of project','varchar(50)',1,1,27)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'factBeginDate','ʵ�ʿ�ʼ����','actualily begin date of project','char(10)',3,2,28)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'factEndDate','ʵ�ʽ�������','actualily end time of project','char(8)',3,19,29)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('Prj_ProjectType','��Ŀ���ͱ�','project type information',0,4,'��Ŀ���ͱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(28,'fullname','��Ŀ��������','name of project type','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(28,'description','��Ŀ��������','description of project type','varchar(150)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(28,'protypecode','��Ŀ���ͱ���','code of project type','varchar(50)',1,1,3)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('Prj_WorkType','�������ͱ�','work type information',0,4,'�������ͱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(29,'fullname','������������','name of work type','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(29,'description','������������','description of work type','varchar(150)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(29,'protypecode','�������ͱ���','code of work type','varchar(50)',1,1,3)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('Prj_ProjectStatus','��Ŀ״̬��','project status',0,4,'��Ŀ״̬��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(30,'fullname','��Ŀ״̬����','name of project status','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(30,'description','��Ŀ״̬����','description of project status','varchar(150)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CptCapital','�ʲ���Ϣ��','capital information',0,5,'�ʲ���Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'mark','���','mark','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'name','����','name','varchar(60)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'startdate','��Ч��','valid date','char(10)',3,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'enddate','��Ч��','invalid date','char(10)',3,2,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'seclevel','��ȫ����','security level','int',1,2,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'departmentid','����','department','int',3,4,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'resourceid','������Դ','humen resource','int',3,4,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'crmid','�ͻ�','customer','int',3,7,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'currencyid','����','currency','int',3,12,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'capitalcost','�ɱ�','cost of capital','decimal(15,3)',1,3,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'startprice','��ʼ�۸�','original price','decimal(15,3)',1,3,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'depreendprice','�۾ɵ׼�','price of depreciation','decimal(15,3)',1,3,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'capitalspec','����ͺ�','model of capital','varchar(60)',1,1,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'capitallevel','�ʲ��ȼ�','level of capital','varchar(30)',1,1,14)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'manufacturer','���쳧��','manufacture facturer','varchar(100)',1,1,15)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'manudate','��������','factory date','char(10)',3,2,16)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'capitaltypeid','��������','type of capital','int',1,2,17)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'capitalgroupid','�ʲ���','group of capital','int',3,25,18)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'unitid','������λ','unit','int',1,2,19)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'capitalnum','����','amount of capital','decimal(18,1)',1,3,20)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'currentnum','��ǰ����','current amount of capital','int',1,2,21)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'version','�汾','version','varchar(60)',1,1,22)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'remark','��ע','remark','text',2,0,23)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'replacecapitalid','���','replace capital','int',3,23,24)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'customerid','��Ӧ��','providing customer','int',1,2,25)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'location','��ŵص�','location','varchar(100)',1,1,26)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'usedhours','ʹ�õ�Сʱ��','used hours','decimal(18,3)',1,3,27)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'createrid','������','creater','int',3,1,28)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'createdate','��������','create date','char(10)',3,2,29)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'createtime','����ʱ��','create time','char(8)',3,19,30)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'lastmoderid','����޸���','last moderfyer','int',3,1,31)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'lastmoddate','�޸�����','date of last modifying','char(10)',3,2,32)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'lastmodtime','�޸�ʱ��','time of last modifying','char(8)',3,19,33)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'fnamark','������','financial mark','varchar(60)',1,1,34)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'alertnum','�ʲ����Ԥ����','lowest stock number','int',1,2,35)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'invoice','��Ʊ����','invoice no.','varchar(80)',1,1,36)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'StockInDate','�������','date of stocking in','char(10)',3,2,37)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'SelectDate','��������','date of purchase','char(10)',3,2,38)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CptCapitalType','�ʲ����ͱ�','capital type information',0,5,'�ʲ����ͱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(32,'name','����','name','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(32,'description','����','description','varchar(200)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CptCapitalAssortment','�ʲ����','capital group information',0,5,'�ʲ����')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(33,'assortmentname','����','assortment name','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(33,'assortmentremark','��ע','assortment remark','text',2,0,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(33,'supassortmentid','�ϼ��ʲ���','super assortment','int',3,25,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(33,'subassortmentcount','�¼��ʲ������','count of subordinate assortment','int',1,2,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(33,'capitalcount','�ʲ����ϸ���','count of capital','int',1,2,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(33,'assortmentmark','���','code of assortment','varchar(30)',1,1,6)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('LgcAssetUnit','������λ��','unit information',0,5,'������λ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(34,'unitname','����','unit name','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(34,'unitdesc','����','unit description','varchar(200)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('Meeting','������Ϣ��','meeting information',0,7,'������Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'meetingtype','��������','meeting type','varchar(60)',1,2,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'name','��������','meeting name','varchar(255)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'caller','�ټ���','caller','int',3,1,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'contacter','��ϵ��','contacter','int',3,1,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'begindate','��ʼ����','begindate','char(10)',3,2,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'begintime','��ʼʱ��','begintime','char(8)',3,19,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'enddate','��������','enddate','char(10)',3,2,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'endtime','����ʱ��','endtime','char(8)',3,19,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'desc_n','��ע','description','varchar(4000)',1,1,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'creater','������','creater','int',3,1,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'createdate','��������','createdate','char(10)',3,2,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'createtime','����ʱ��','createtime','char(8)',3,19,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'approver','������','approver','int',3,1,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'approvedate','��������','date of approving','char(10)',3,2,14)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'approvetime','����ʱ��','time of approving','char(8)',3,19,15)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'decision','�������','decision','text',2,0,16)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'decisiondate','��������','date of decision','char(10)',1,2,17)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'decisiontime','����ʱ��','time of decision','char(8)',1,19,18)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'decisionhrmid','������','people of decision','int',3,1,19)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'projectid','�����Ŀ','project','int',3,8,20)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'totalmember','Ӧ������','total members','int',1,2,21)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'address','����ص�','address','int',3,87,22)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'addressdesc','�����ַ','description of address','varchar(255)',1,1,23)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'customizeAddress','�Զ������ص�','customize address','varchar(400)',1,1,24)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'canceldate','��������','cancel date','char(10)',3,2,25)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'canceltime','����ʱ��','cancel time','char(8)',3,19,26)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('Meeting_Type','�������ͱ�','meeting type information',0,7,'�������ͱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(36,'name','��������','name','varchar(255)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(36,'desc_n','��������','description','varchar(255)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(36,'subcompanyid','�����ֲ�','subcompanyid','int',3,42,3)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('MeetingRoom','�����ұ�','meeting rooms',0,7,'�����ұ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(37,'name','����������','name of meetingroom','varchar(100)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(37,'roomdesc','����������','description of meetingroom','varchar(100)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(37,'hrmid','�����Ҹ�����','principal of meetingroom','int',3,1,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(37,'subcompanyid','�����ֲ�','subcompany of meetingroom','int',3,42,4)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('FnaCurrency','������Ϣ��','currency information',0,6,'������Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(38,'currencyname','��������','name of currency','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(38,'currencydesc','��������','description of currency','varchar(200)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('FnaBudgetfeeType','Ԥ���Ŀ��Ϣ��','subjects of budget',0,6,'Ԥ���Ŀ��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(39,'name','Ԥ���Ŀ����','name of subject','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(39,'description','Ԥ���Ŀ����','description of subject','varchar(250)',1,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(39,'supsubject','������Ŀ','super subject','int',1,2,3)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_Contract','��ͬ��Ϣ��','contract information',0,3,'��ͬ��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'name','��ͬ����','name of contract','varchar(100)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'typeId','��ͬ����','type of contract','int',1,2,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'price','��ͬ���','total money of contract','decimal(17,2)',1,3,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'crmId','��ؿͻ�','customer','int',3,7,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'contacterId','��ϵ��','contacter','int',3,1,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'startDate','��ʼʱ��','begin date','char(10)',3,2,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'endDate','����ʱ��','end date','char(10)',3,2,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'manager','������','manager','int',3,1,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'creater','������','creater','int',3,1,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'createDate','��������','create date','char(10)',3,2,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'createTime','����ʱ��','create time','char(10)',3,19,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'projid','�����Ŀ','related project','int',3,8,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'department','����','department','int',3,4,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'subcompanyid1','�ֲ�','subcompany','int',3,42,14)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'sellChanceId','���ۻ���','chance to sell','int',1,2,15)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_ContractType','��ͬ���ʱ�','contract type information',0,3,'��ͬ���ʱ�')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(41,'name','��ͬ��������','name of contract type','varchar(100)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(41,'contractdesc','��ͬ��������','description of contract type','varchar(200)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_SellChance','���ۻ�����Ϣ��','information of chance to sell',0,3,'���ۻ�����Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'subject','����','subject','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'creater','������','creater','int',3,1,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'customerid','�ͻ�','customer','int',3,7,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'sellstatusid','����״̬','sell status','int',1,2,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'predate','����Ԥ��','plan date to sell','char(10)',3,2,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'preyield','Ԥ������','plan income','decimal(18,2)',1,3,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'currencyid','����','currencyid','int',3,12,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'probability','����Ԥ��','probability','decimal(8,2)',1,3,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'createdate','��������','createdate','char(10)',3,2,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'createtime','����ʱ��','createtime','char(8)',3,19,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'content','����','content','text',2,0,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'approver','������','approver','int',3,1,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'approvedate','��������','approve date','char(10)',3,2,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'approvetime','����ʱ��','approve time','char(10)',3,19,14)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'departmentId','�ͻ�������','department','int',3,4,15)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'subCompanyId','�ͻ�����ֲ�','subcompany','int',3,42,16)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_SellStatus','����״̬��Ϣ��','information of status to sell',0,3,'����״̬��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(43,'fullname','����','name','varchar(50)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(43,'description','����','description','varchar(150)',1,1,2)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('CRM_ContractProduct','�ͻ���ͬ��ƷĿ¼��Ϣ��','products of contract',0,3,'�ͻ���ͬ��ƷĿ¼��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'contractId','��ͬ','contract','int',1,2,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'productId','��Ʒ','product','int',1,2,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'unitId','��λ','unit','int',1,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'number_n','��������','numbers of consignment','decimal(10,2)',1,3,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'price','����','price of product','decimal(17,2)',1,3,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'currencyId','����','currency','int',3,12,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'depreciation','�ۿ�','depreciation','int',1,2,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'sumPrice','�ܶ�','total prices','decimal(17,2)',1,3,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'planDate','��������','plan date of consignment','char(10)',3,2,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'factnumber_n','ʵ�ʽ�������','true numbers of consignment','int',1,2,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'factDate','ʵ�ʽ�������','true date of consignment','char(10)',3,2,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'lasttotelprice','�����ܼ�','final totel price','decimal(18,4)',1,3,12)
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('LgcAssetCountry','��Ʒ��Ϣ��','products information',0,3,'��Ʒ��Ϣ��')
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'assetname','��Ʒ����','name of product','varchar(60)',1,1,1)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'startdate','��ʼ����','startdate','char(10)',3,2,2)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'enddate','����ʱ��','enddate','char(10)',3,2,3)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'departmentid','����','department','int',3,4,4)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'resourceid','������Դ','humen resource','int',3,1,5)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'assetremark','��Ʒ˵��','remark of product','text',2,0,6)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'currencyid','����','currency','int',3,12,7)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'salesprice','���ۼ۸�','price of product','decimal(18,3)',1,3,8)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'costprice','�ɱ��۸�','cost of product','decimal(18,3)',1,3,9)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'createrid','������','creater','int',3,1,10)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'createdate','��������','create date','char(10)',3,2,11)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'lastmoderid','����޸���','last modifyer','int',3,1,12)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'lastmoddate','����޸�����','last modifying date','char(10)',3,2,13)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(1,'id','��Աid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(2,'id','����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(3,'id','�����ص�id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(4,'id','��λid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(5,'id','����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(6,'id','�ֲ�id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(7,'id','����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(8,'id','�������id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(9,'id','ְ��id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(10,'id','����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(11,'id','ʡ��id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(12,'id','ְ��id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(13,'id','ְ������id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(14,'id','רҵid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(15,'id','�ĵ�id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(16,'id','�ĵ���Ŀ¼id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(17,'id','�ĵ���Ŀ¼id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(18,'id','�ĵ���Ŀ¼id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(19,'id','�ͻ�id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(20,'id','�ͻ���ϵ��ʽid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(21,'id','�ͻ�����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(22,'id','�ͻ���ģid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(23,'id','�ͻ�����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(24,'id','�ͻ�����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(25,'id','�ͻ�״̬id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(26,'id','�ͻ���ֵid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(27,'id','��Ŀid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(28,'id','��Ŀ����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(29,'id','��������id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(30,'id','��Ŀ״̬id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(31,'id','�ʲ�id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(32,'id','�ʲ�����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(33,'id','�ʲ���id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(34,'id','������λid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(35,'id','����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(36,'id','��������id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(37,'id','������id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(38,'id','����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(39,'id','Ԥ���Ŀid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(40,'id','��ͬid','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(41,'id','��ͬ����id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(42,'id','���ۻ���id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(43,'id','����״̬id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(44,'id','�ͻ���ͬ��ƷĿ¼id','key','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(45,'id','��Ʒid','key','int',1,2,0)
GO
