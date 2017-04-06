/* ��Ӷ���Ȩ�� */
insert into SystemRights (id,rightdesc,righttype) values (398,'�����շ�ϵͳ','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (398,7,'�����շ�ϵͳ','�����շ�ϵͳ') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (398,8,'','') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3087,'���Ź���','SmsManage:View',398) 
/
drop table SMS_Message
/
/* ��������ϵͳ�õ������ݿ�� */
CREATE TABLE SMS_Message (
	id integer NOT NULL ,
	message varchar2 (100)  ,
	recievenumber varchar2 (15)  ,
	sendnumber varchar2 (15)  ,
	messagestatus char (1)  ,
	requestid integer NULL ,
	userid integer NULL ,
	usertype char (1)  ,
	messagetype char (1)  ,
	finishtime char (19)  
) 
/
/* �����Զ�ID���õ��������¼ */
insert into SequenceIndex(indexdesc,currentid) values('smsid',0)
/

/* �������õ��Ĵ洢���� */
CREATE or REPLACE PROCEDURE SMS_Message_Insert
	(id_1 	integer,
	 message_2 	varchar2,
	 recievenumber_3 	varchar2,
	 sendnumber_4 	varchar2,
	 messagestatus_5 	char,
	 requestid_6 	integer,
	 userid_7 	integer,
	 usertype_8 	char,
	 messagetype_9 	char,
	 finishtime_10 	varchar2,
    flag out integer ,
      msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)

AS 
begin
INSERT INTO SMS_Message 
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
	( id_1,
	 message_2,
	 recievenumber_3,
	 sendnumber_4,
	 messagestatus_5,
	 requestid_6,
	 userid_7,
	 usertype_8,
	 messagetype_9,
	 finishtime_10);
end;
/



CREATE or REPLACE PROCEDURE SequenceIndex_SelectSmsid
	( flag out integer ,
      msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)

AS 
begin
update SequenceIndex set currentid = currentid+1 where indexdesc='smsid';
open thecursor for
select currentid from SequenceIndex where indexdesc='smsid';
end;
/


INSERT INTO HtmlLabelIndex values(16891,'���Ź���') 
/
INSERT INTO HtmlLabelInfo VALUES(16891,'���Ź���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16891,'',8) 
/
/* �޸Ķ���ϵͳ�õ������ݿ�� */
alter table SMS_Message add smsyear char(4)
/
alter table SMS_Message add smsmonth char(2)
/
alter table SMS_Message add smsday char(2)
/
alter table SMS_Message add isdelete char(1)
/
alter table SMS_Message add touserid integer
/ 
alter table SMS_Message add tousertype char(1)
/
/* �޸����õ��Ĵ洢���� */
CREATE or REPLACE PROCEDURE SMS_Message_Insert
	(id_1 	integer,
	 message_2 	varchar2,
	 recievenumber_3 	varchar2,
	 sendnumber_4 	varchar2,
	 messagestatus_5 	char,
	 requestid_6 	integer,
	 userid_7 	integer,
	 usertype_8 	char,
	 messagetype_9 	char,
	 finishtime_10 	char,
     smsyear_11   char,
     smsmonth_12  char,
     smsday_13    char,
     isdelete_14   char,
     touserid_15   integer,
     tousertype_16 char,
     flag out integer ,
     msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor)

AS 
begin
INSERT INTO SMS_Message 
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
	( id_1,
	 message_2,
	 recievenumber_3,
	 sendnumber_4,
	 messagestatus_5,
	 requestid_6,
	 userid_7,
	 usertype_8,
	 messagetype_9,
	 finishtime_10,
     smsyear_11,
     smsmonth_12,
     smsday_13,
     isdelete_14,
     touserid_15,
     tousertype_16);
end;
/

update SMS_Message set isdelete='0'
/
update SMS_Message set isdelete='1' where messagestatus='3' 
/
update SMS_Message set messagetype='2' where messagetype<>'1'
/

INSERT INTO HtmlLabelIndex values(17008,'���ű���') 
/
INSERT INTO HtmlLabelIndex values(17009,'����ʱ�䱨��') 
/
INSERT INTO HtmlLabelInfo VALUES(17008,'���ű���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17008,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17009,'����ʱ�䱨��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17009,'',8) 
/

/* �޸Ķ���ϵͳ�õ������ݿ�� */
alter table SMS_Message modify message varchar2(200)
/
/* �޸����õ��Ĵ洢���� */
CREATE or REPLACE PROCEDURE SMS_Message_Insert
	(id_1 	integer,
	 message_2 	varchar2,
	 recievenumber_3 	varchar2,
	 sendnumber_4 	varchar2,
	 messagestatus_5 	char,
	 requestid_6 	integer,
	 userid_7 	integer,
	 usertype_8 	char,
	 messagetype_9 	char,
	 finishtime_10 	char,
     smsyear_11   char,
     smsmonth_12  char,
     smsday_13    char,
     isdelete_14   char,
     touserid_15   integer,
     tousertype_16 char,
     flag out integer ,
     msg out varchar2,
     thecursor IN OUT cursor_define.weavercursor)

AS 
begin
INSERT INTO SMS_Message 
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
	(id_1,
	 message_2,
	 recievenumber_3,
	 sendnumber_4,
	 messagestatus_5,
	 requestid_6,
	 userid_7,
	 usertype_8,
	 messagetype_9,
	 finishtime_10,
     smsyear_11,
     smsmonth_12,
     smsday_13,
     isdelete_14,
     touserid_15,
     tousertype_16);
end;
/

ALTER table SystemSet add smsserver varchar2(50)
/

/* ���� */



/* ����Ⱥ�������� */
CREATE or REPLACE PROCEDURE SystemSet_Update 
 (emailserver_1  varchar2 , 
  debugmode_2   char , 
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
  flag out integer ,
  msg out varchar2,
  thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
 update SystemSet set 
        emailserver=emailserver_1 , 
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
        smsserver=smsserver_15;
end;

/


INSERT INTO HtmlLabelIndex values(16953,'���ŷ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16953,'���ŷ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16953,'',8) 
/
