insert into SystemRights (id,rightdesc,righttype) values (587,'ϵͳ����ԱȨ��ά��','7') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (587,7,'ϵͳ����ԱȨ��ά��','ϵͳ����ԱȨ��ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (587,8,'SysadminRightSet','SysadminRightSet') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4086,'ϵͳ����ԱȨ��ά��','SysadminRight:Maintenance',587) 
/

insert into SystemRights (id,rightdesc,righttype) values (588,'��֯�ṹ����','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (588,7,'��֯�ṹ����','��֯�ṹ����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (588,8,'structure management','structure management') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4087,'��֯�ṹ����','Structure:Mag',588) 
/

insert into SystemRights (id,rightdesc,righttype) values (590,'�������ֶ�ά��','5') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (590,7,'�ֶ�ά��','�������ֶ�ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (590,8,'FieldSet','Workflow FieldSet') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4089,'�ֶ�ά��','FieldManage:All',590) 
/

insert into SystemRights (id,rightdesc,righttype) values (591,'��������ά��','5') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (591,7,'��ά��','��������ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (591,8,'FormSet','Workflow FormSet') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4090,'��ά��','FormManage:All',591) 
/

insert into systemrighttogroup(groupid,rightid) values(1,587)
/
insert into systemrighttogroup(groupid,rightid) values(3,588)
/
insert into systemrighttogroup(groupid,rightid) values(8,590)
/
insert into systemrighttogroup(groupid,rightid) values(8,591)
/

alter table SystemRights add detachable integer
/
update SystemRights set detachable=0
/
update SystemRights set detachable=1
where id in(18,19,22,25,91,587,588,590,591)
/

create or replace PROCEDURE SystemRights_SelectAllID
(flag out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)
AS
begin
open thecursor for
select id,detachable from SystemRights;
end;
/

create or replace PROCEDURE systemright_Srightsbygroup
(id_1 integer,
flag out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)
as 
begin 
open thecursor for
select a.rightid,b.detachable from systemrighttogroup a,SystemRights b where a.groupid= id_1 and a.rightid=b.id;
end;
/

create or replace PROCEDURE SystemSet_Update 
	(emailserver_1  varchar2 , 
	debugmode_2   char, 
	logleaveday_3  smallint ,
	defmailuser_4  varchar2 ,
	defmailpassword_5  varchar2 ,
	pop3server_6  varchar2,
	filesystem_7 varchar2,
	filesystembackup_8 varchar2,
	filesystembackuptime_9 integer ,
	needzip_10 char,
	needzipencrypt_11 char,
	defmailserver_12 varchar2,
	defmailfrom_13 varchar2,
	defneedauth_14 char,
	smsserver_15 varchar2,
	detachable_16 char,
	flag out integer,
	msg out varchar2,
	thecursor IN OUT cursor_define.weavercursor)
AS
begin
	update SystemSet 
	set emailserver=emailserver_1 , 
		debugmode=debugmode_2,
		logleaveday=logleaveday_3 ,
		defmailuser=defmailuser_4 , 
		defmailpassword=defmailpassword_5 , 
		pop3server=pop3server_6 ,
		filesystem=filesystem_7,
		filesystembackup=filesystembackup_8 ,
		filesystembackuptime=filesystembackuptime_9 , 
		needzip=needzip_10 , 
		needzipencrypt=needzipencrypt_11 ,
		defmailserver=defmailserver_12 ,
		defmailfrom=defmailfrom_13 ,
		defneedauth=defneedauth_14 ,
		smsserver=smsserver_15,
		detachable=detachable_16;
end;
/