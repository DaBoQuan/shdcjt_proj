/* ��Ӷ���Ȩ�� */
insert into SystemRights (id,rightdesc,righttype) values (398,'�����շ�ϵͳ','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (398,7,'�����շ�ϵͳ','�����շ�ϵͳ') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (398,8,'','') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3087,'���Ź���','SmsManage:View',398) 
GO

drop table SMS_Message
go
/* ��������ϵͳ�õ������ݿ�� */
CREATE TABLE SMS_Message (
	id int NOT NULL ,
	message varchar (100)  ,
	recievenumber varchar (15)  ,
	sendnumber varchar (15)  ,
	messagestatus char (1)  ,
	requestid int NULL ,
	userid int NULL ,
	usertype char (1)  ,
	messagetype char (1)  ,
	finishtime char (19)  
) 
GO
/* �����Զ�ID���õ��������¼ */
insert into SequenceIndex(indexdesc,currentid) values('smsid',0)
go
/* �������õ��Ĵ洢���� */
alter PROCEDURE SMS_Message_Insert
	(@id_1 	int,
	 @message_2 	varchar(100),
	 @recievenumber_3 	varchar(15),
	 @sendnumber_4 	varchar(15),
	 @messagestatus_5 	char(1),
	 @requestid_6 	int,
	 @userid_7 	int,
	 @usertype_8 	char(1),
	 @messagetype_9 	char(1),
	 @finishtime_10 	varchar(19),
     @flag			int	output, 
	 @msg			varchar(80) output)

AS INSERT INTO SMS_Message 
	 ( id,
	 message,
	 recievenumber,
	 sendnumber,
	 messagestatus,
	 requestid,
	 userid,
	 usertype,
	 messagetype,
	 finishtime) 
 
VALUES 
	( @id_1,
	 @message_2,
	 @recievenumber_3,
	 @sendnumber_4,
	 @messagestatus_5,
	 @requestid_6,
	 @userid_7,
	 @usertype_8,
	 @messagetype_9,
	 @finishtime_10)
GO



CREATE PROCEDURE SequenceIndex_SelectSmsid
	(@flag int output, 
     @msg varchar(80) output)

AS 
select currentid from SequenceIndex where indexdesc='smsid'
update SequenceIndex set currentid = currentid+1 where indexdesc='smsid'

GO


INSERT INTO HtmlLabelIndex values(16891,'���Ź���') 
GO
INSERT INTO HtmlLabelInfo VALUES(16891,'���Ź���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16891,'',8) 
GO
/* �޸Ķ���ϵͳ�õ������ݿ�� */
alter table SMS_Message add smsyear char(4),smsmonth char(2),smsday char(2),isdelete char(1),touserid int,tousertype char(1)
GO
/* �޸����õ��Ĵ洢���� */
alter PROCEDURE SMS_Message_Insert
	(@id_1 	int,
	 @message_2 	varchar(100),
	 @recievenumber_3 	varchar(15),
	 @sendnumber_4 	varchar(15),
	 @messagestatus_5 	char(1),
	 @requestid_6 	int,
	 @userid_7 	int,
	 @usertype_8 	char(1),
	 @messagetype_9 	char(1),
	 @finishtime_10 	char(19),
     @smsyear_11   char(4),
     @smsmonth_12  char(2),
     @smsday_13    char(2),
     @isdelete_14   char(1),
     @touserid_15   int,
     @tousertype_16 char(1),
     @flag			int	output, 
	 @msg			varchar(80) output)

AS INSERT INTO SMS_Message 
	 ( id,
	 message,
	 recievenumber,
	 sendnumber,
	 messagestatus,
	 requestid,
	 userid,
	 usertype,
	 messagetype,
	 finishtime,
     smsyear,
     smsmonth,
     smsday,
     isdelete,
     touserid,
     tousertype) 
 
VALUES 
	( @id_1,
	 @message_2,
	 @recievenumber_3,
	 @sendnumber_4,
	 @messagestatus_5,
	 @requestid_6,
	 @userid_7,
	 @usertype_8,
	 @messagetype_9,
	 @finishtime_10,
     @smsyear_11,
     @smsmonth_12,
     @smsday_13,
     @isdelete_14,
     @touserid_15,
     @tousertype_16)
GO

update SMS_Message set isdelete='0'
go
update SMS_Message set isdelete='1' where messagestatus='3' 
go
update SMS_Message set messagetype='2' where messagetype<>'1'
go

INSERT INTO HtmlLabelIndex values(17008,'���ű���') 
GO
INSERT INTO HtmlLabelIndex values(17009,'����ʱ�䱨��') 
GO
INSERT INTO HtmlLabelInfo VALUES(17008,'���ű���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17008,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17009,'����ʱ�䱨��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17009,'',8) 
GO

/* �޸Ķ���ϵͳ�õ������ݿ�� */
alter table SMS_Message alter column message varchar(200)
GO
/* �޸����õ��Ĵ洢���� */
alter PROCEDURE SMS_Message_Insert
	(@id_1 	int,
	 @message_2 	varchar(200),
	 @recievenumber_3 	varchar(15),
	 @sendnumber_4 	varchar(15),
	 @messagestatus_5 	char(1),
	 @requestid_6 	int,
	 @userid_7 	int,
	 @usertype_8 	char(1),
	 @messagetype_9 	char(1),
	 @finishtime_10 	char(19),
     @smsyear_11   char(4),
     @smsmonth_12  char(2),
     @smsday_13    char(2),
     @isdelete_14   char(1),
     @touserid_15   int,
     @tousertype_16 char(1),
     @flag			int	output, 
	 @msg			varchar(80) output)

AS INSERT INTO SMS_Message 
	 ( id,
	 message,
	 recievenumber,
	 sendnumber,
	 messagestatus,
	 requestid,
	 userid,
	 usertype,
	 messagetype,
	 finishtime,
     smsyear,
     smsmonth,
     smsday,
     isdelete,
     touserid,
     tousertype) 
 
VALUES 
	( @id_1,
	 @message_2,
	 @recievenumber_3,
	 @sendnumber_4,
	 @messagestatus_5,
	 @requestid_6,
	 @userid_7,
	 @usertype_8,
	 @messagetype_9,
	 @finishtime_10,
     @smsyear_11,
     @smsmonth_12,
     @smsday_13,
     @isdelete_14,
     @touserid_15,
     @tousertype_16)
GO

ALTER table SystemSet add smsserver varchar(50)
GO

/* ���� */



/* ����Ⱥ�������� */
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
        smsserver=@smsserver_15

GO


INSERT INTO HtmlLabelIndex values(16953,'���ŷ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16953,'���ŷ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16953,'',8) 
GO
