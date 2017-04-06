insert into SystemRights (id,rightdesc,righttype) values (587,'ϵͳ����ԱȨ��ά��','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (587,7,'ϵͳ����ԱȨ��ά��','ϵͳ����ԱȨ��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (587,8,'SysadminRightSet','SysadminRightSet') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4086,'ϵͳ����ԱȨ��ά��','SysadminRight:Maintenance',587) 
GO

insert into SystemRights (id,rightdesc,righttype) values (588,'��֯�ṹ����','3') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (588,7,'��֯�ṹ����','��֯�ṹ����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (588,8,'structure management','structure management') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4087,'��֯�ṹ����','Structure:Mag',588) 
GO

insert into SystemRights (id,rightdesc,righttype) values (590,'�������ֶ�ά��','5') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (590,7,'�ֶ�ά��','�������ֶ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (590,8,'FieldSet','Workflow FieldSet') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4089,'�ֶ�ά��','FieldManage:All',590) 
GO

insert into SystemRights (id,rightdesc,righttype) values (591,'��������ά��','5') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (591,7,'��ά��','��������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (591,8,'FormSet','Workflow FormSet') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4090,'��ά��','FormManage:All',591) 
GO

insert into systemrighttogroup(groupid,rightid) values(1,587)
GO
insert into systemrighttogroup(groupid,rightid) values(3,588)
GO
insert into systemrighttogroup(groupid,rightid) values(8,590)
GO
insert into systemrighttogroup(groupid,rightid) values(8,591)
GO

alter table SystemRights add detachable int
GO 
update SystemRights set detachable=0
GO 
update SystemRights set detachable=1
where id in(18,19,22,25,91,587,588,590,591)
GO 

ALTER PROCEDURE SystemRights_SelectAllID @flag integer output , @msg varchar(80) output AS 
select id,detachable from SystemRights set  @flag = 0 set  @msg = '��ѯϵͳȨ�޳ɹ�'

GO

ALTER PROCEDURE systemright_Srightsbygroup @id int, @flag int output, @msg varchar(80) output as 
begin select a.rightid,b.detachable from systemrighttogroup a,SystemRights b where a.groupid=@id and a.rightid=b.id end

GO

ALTER PROCEDURE SystemSet_Update 
 (@emailserver_1  varchar(60) , 
  @debugmode_2   char(1) , 
  @logleaveday_3  tinyint ,
  @defmailuser_4  varchar(60) ,
  @defmailpassword_5  varchar(60) ,
  @pop3server_6  varchar(60),
  @filesystem_7 varchar(200),
  @filesystembackup_8 varchar(200),
  @filesystembackuptime_9 int ,
  @needzip_10 char(1),
  @needzipencrypt_11 char(1),
  @defmailserver_12 varchar(60),
  @defmailfrom_13 varchar(60),
  @defneedauth_14 char(1),
  @smsserver_15 varchar(50),
  @detachable_16 char(1),
  @flag int output, 
  @msg varchar(80) output) 
AS 
 update SystemSet set 
        emailserver=@emailserver_1 , 
        debugmode=@debugmode_2,
        logleaveday=@logleaveday_3 ,
        defmailuser=@defmailuser_4 , 
        defmailpassword=@defmailpassword_5 , 
        pop3server=@pop3server_6 ,
        filesystem=@filesystem_7,
        filesystembackup=@filesystembackup_8 ,
        filesystembackuptime=@filesystembackuptime_9 , 
        needzip=@needzip_10 , 
        needzipencrypt=@needzipencrypt_11 ,
        defmailserver=@defmailserver_12 ,
        defmailfrom=@defmailfrom_13 ,
        defneedauth=@defneedauth_14 ,
        smsserver=@smsserver_15,
	detachable=@detachable_16 


GO

