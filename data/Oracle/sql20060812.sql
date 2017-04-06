create table hpBaseElement(
	id integer  NOT NULL,
	elementtype	Char(1)	Not null,
	title	Varchar2(200)	null,
	logo	Varchar2(500)	null,
	perpage	integer	null,
	linkmode	Char(1)	null,
	moreurl	Varchar2(500)	null,
	elementdesc	Varchar2(1000)	null
)
/

INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 1,'2','RSS�Ķ���
','/images/homepage/element/1.gif',5,'2','getRssMore','����ֱ���RSS��ַ�Լ�RSS����')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 7,'2','��������
','/images/homepage/element/3.gif',5,'2','getNews','ϵͳ�����е�����')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 8,'1','��������
','/images/homepage/element/4.gif',5,'2','getNoreadFlow','ϵͳ���̲��ֵĴ�������')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 11,'1','���¿ͻ�
','/images/homepage/element/7.gif',5,'3','getNewCrmMore','��������˵���µĿͻ�')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 12,'1','���»���
','/images/homepage/element/8.gif',5,'2','getNewMettingMore','���µĻ���')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 6,'1','δ���ĵ�
','/images/homepage/element/2.gif',5,'2','getNoReadDoc','ϵͳ�����е�δ���ĵ�!')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 13,'1','δ��Э��
','/images/homepage/element/9.gif',5,'2','getNoReadCword','δ��Э��')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 14,'1','����Ŀ��
','/images/homepage/element/10.gif',5,'2','getMoreTarget','����Ŀ��')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 15,'1','���ռƻ�
','/images/homepage/element/11.gif',5,'2','getWorkPlanMore','���ռƻ�')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 16,'2','�ҵ��ʼ�
','/images/homepage/element/12.gif',5,'2','getMyMail','�ҵ��ʼ�')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 9,'1','��Ϣ����
','/images/homepage/element/5.gif',5,'2','getNoteMore','ϵͳ�е���Ϣ����')
/
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 10,'1','�ҵ���Ŀ
','/images/homepage/element/6.gif',5,'2','getNewProj','���ܿ���������ͨ�����һ�û�н�������Ŀ')
/



create table hpFieldElement(
	id integer  NOT NULL,
	elementid	integer	Not null,
	fieldname	Varchar2(30)	Not null,
	fieldColumn	Varchar2(300)	Not null,
	isDate	Char(1)	Not null,
	transMethod	Varchar2(300)	null,
	fieldwidth Varchar2(10)	 null,
	linkurl	Varchar2(300)	Null,
	valuecolumn	Varchar2(50)	null,
	isLimitLength	char(1)	null,
	ordernum integer	Not null
)
/

INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 1,1,'229','subject','0','','*','','','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 2,1,'1339','createtime','1','','62','','','',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 7,7,'229','docdocsubject','0','','*','/docs/docs/DocDsp.jsp?id=','id','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 4,6,'229','docsubject','0','','*','/docs/docs/DocDsp.jsp?id=','id','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 5,6,'19521','doclastmoddate','1','','76','','','',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 6,6,'19520','doclastmodtime','1','','62','','','',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 8,7,'19521','doclastmoddate','1','','76','','','',4)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 9,7,'19520','doclastmodtime','1','','62','','','',5)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 10,7,'341','summary','0','','','','','1',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 11,7,'74','img','0','','','','','0',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 12,8,'229','requestname','0','getRequestNewLink','*','','','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 13,8,'882','creater','0','getHrmStr','50','','','0',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 14,8,'17994','receivedate','1','','76','','','0',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 15,8,'18002','receivetime','1','','62','','','0',4)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 16,9,'195','typedescription','0','getInfoRemindLable','*','','','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 17,9,'16816','count','0','getInfoRemindStr','20','','','0',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 27,12,'2151','name','0','','*','/meeting/data/ViewMeeting.jsp?meetingid=','id','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 28,12,'780','address','0','','50','/meeting/Maint/MeetingRoom.jsp?id=','address','',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 29,12,'19559','begindate','1','','76','','','',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 30,12,'19560','begintime','1','','62','','','',4)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 31,13,'195','name','0','','*','/cowork/ViewCoWork.jsp?id=','id','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 32,13,'271','creater','0','getHrmStr','50','','','',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 33,13,'722','createdate','1','','76','','','',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 34,13,'1339','createtime','1','','62','','','',4)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 35,16,'344','subject','0','','*','/email/WeavermailDetail.jsp?msgid=','','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 36,16,'2034','priority','0','','40','','','0',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 37,16,'2035','senddate','0','','126','','','',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 40,15,'195','name','0','','*','/workplan/data/WorkPlanDetail.jsp?workid=','','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 41,15,'15534','urgentLevel','0','getWorkPlanStatusName','40','','','0',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 42,15,'1035','enddate','1','','76','','','0',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 43,15,'1036','endtime','1','','62','','','0',4)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 44,14,'18238','goalname','0','','*','','','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 45,14,'6071','percent_n','0','','40','','','0',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 18,1,'722','createdate','1','','76','','','0',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 19,10,'229','name','0','','*','/proj/data/ViewProject.jsp?ProjID=','id','1',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 20,10,'587','status','0','getProjStatusName','40','','','',2)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 21,10,'19550','planenddate','0','','76','','','',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 22,10,'19551','planendtime','0','','62','','','',4)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 23,11,'16857','name','0','','*','','','',1)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 24,11,'18901','movedate','1','','76','','','',3)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 25,11,'19552','movetime','1','','62','','','',4)
/
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 26,11,'15078','status','0','','50','','','',2)
/


create table hpWhereElement(
	id integer NOT NULL,
	elementid	integer	Not null,
	settingshowmethod	Varchar2(300)	Not null,
	getwheremethod	Varchar2(300)	null
)
/

INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 2,1,'getRssSettingStr','')
/
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 6,7,'getNewsSettingStr','')
/
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 9,8,'getWfSettingStr','')
/
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 11,9,'getInfoRemindSettingStr','')
/
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 13,13,'getCworkSettingStr','')
/



create table hpSqlElement(
	id integer  NOT NULL,
	elementid	integer	Not null,
	sppbMethod	Varchar2(1000)	null
)
/
create sequence hpSqlElement_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpSqlElement_Trigger
before insert on hpSqlElement
for each row
begin
select hpSqlElement_id.nextval into :new.id from dual;
end;
/


INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 6,'getNoReadDocSpb')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 8,'getNoReadWfSpb')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 9,'getInfoRemaind')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 10,'getProjectSppb')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 12,'getNewMeetingSppb')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 13,'getNewCworkSppb')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES (14,'getMonthTargetSppb')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 11,'getNewCrmSppb')
/
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 15,'getDayPlanSppb')
/


create table hpextelement(
   id integer not null,
   extsettinge Varchar2(300) null,
   extopreate Varchar2(300) null,
   extshow Varchar2(300) null,
   description   Varchar2(300) null
)
/

INSERT INTO hpextelement( id,extsettinge,extopreate,extshow,description) VALUES ( 1,'','','getRssContent','rss���⴦��')
/
INSERT INTO hpextelement( id,extsettinge,extopreate,extshow,description) VALUES ( 7,'','','getNewsContent','�������ݵ���ʾ')
/
INSERT INTO hpextelement( id,extsettinge,extopreate,extshow,description) VALUES ( 16,'','','getEmailContent','�ʼ����ݵ���ʾ')
/

create  index hpextelement_id_clu on hpextelement (id)
/

create table  hpElement(
	id integer  NOT NULL,
	title	Varchar2(30)	null,
	logo	Varchar2(500)	null,
	islocked	Char(1)	Not null,
	strsqlwhere	Varchar2(2000)	null,
	ebaseid	integer	Not null,	
	isSysElement	Char(1)	Not null,
	hpid	integer 	Not null
)
/

create sequence hpElement_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpElement_Trigger
before insert on hpElement
for each row
begin
select hpElement_id.nextval into :new.id from dual;
end;
/

create table  hpElementSettingDetail(
	id integer  NOT NULL,
	userid	integer	Not null,
	usertype	integer	Not null,
	eid	integer	Not null,
	perpage	integer	Not null,
	linkmode	integer	Not null,
	showfield	Varchar2(500)	null,
	sharelevel       char(1),
	hpid            integer null
)
/
create sequence hpElementSD_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpElementSD_Trigger
before insert on hpElementSettingDetail
for each row
begin
select hpElementSD_id.nextval into :new.id from dual;
end;
/

create table hpFieldLength(
	id integer  NOT NULL,
	eid	integer	Not null,
	userid	integer	Null,
	usertype	integer	Null,
	efieldid	integer	Not null,
	charnum	integer	Not null
)
/
create sequence hpFieldLength_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpFieldLength_Trigger
before insert on hpFieldLength
for each row
begin
select hpFieldLength_id.nextval into :new.id from dual;
end;
/

alter table SystemSet  add  defUseNewHomepage Char(1)
/

update  systemSet  set defUseNewHomepage='1'
/

create table  hpinfo(
	id integer  NOT NULL,
	infoname	Varchar2(50)	Not null,
	infodesc	Varchar2(500)	null,
	styleid	integer	Not null,
	layoutid	integer	Not null,
	Subcompanyid	integer	Not null,
	isUse	Char(1)	Not null
)
/
create sequence hpinfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpinfo_Trigger
before insert on hpinfo
for each row
begin
select hpinfo_id.nextval into :new.id from dual;
end;
/

create table  hpsubcompanyappiont(
	id integer  NOT NULL,
	subcompanyid	integer	Not null,
	infoid	integer	Not null 
)
/
create sequence hpsubcomapp_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpsubcomapp_Trigger
before insert on hpsubcompanyappiont
for each row
begin
select hpsubcomapp_id.nextval into :new.id from dual;
end;
/

create table  hpuserselect(
	id integer  NOT NULL,
	userid	integer	Not null,
	infoid	integer	Not null
)
/
create sequence hpuserselect_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpuserselect_Trigger
before insert on hpuserselect
for each row
begin
select hpuserselect_id.nextval into :new.id from dual;
end;
/

create table  hpBaseLayout(
	id integer  NOT NULL,
	layoutname	Varchar2(50)	Not null,
	layoutdesc	Varchar2(500)	null,
	layoutimage	Varchar2(200)	Not null,
	layoutcode	Varchar2(2000)	Not null,
	allowArea	Varchar2(50)	Not null
)
/

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(1,'һ������','һ������','\images\homepage\layout\layout_01.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td id=area_A  width=W$_A  valign=top  areaflag=A><TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td></tr></table>','A')
/

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(2,'��������','��������','\images\homepage\layout\layout_02.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td id=area_A  width=W$_A  valign=top  areaflag=A><TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td><td id=area_B  width=W$_B  
valign=top  areaflag=B><!--E$_B--></td></tr></table>','A,B')
/

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(3,'��������','��������','\images\homepage\layout\layout_03.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td id=area_A  width=W$_A  valign=top  areaflag=A><TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td><td id=area_B  width=W$_B  
valign=top  areaflag=B><!--E$_B--></td><td id=area_C  width=W$_C  valign=top  areaflag=C><!--E$_C--></td></tr></table>','A,B,C')
/

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(4,'��������1','��������1','\images\homepage\layout\layout_04.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td colspan=2 id=area_A  width=W$_A  valign=top  areaflag=A> <TABLE width=100% id=tblInfo style=''font-size:12px; 
border:1px solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A-->  </td>   <td rowspan=2 
id=area_B  width=W$_B  valign=top  areaflag=B><!--E$_B--></td>  </tr>  <tr>    <td id=area_C  width=W$_C  valign=top  
areaflag=C><!--E$_C--></td>    <td id=area_D  width=W$_D  valign=top  areaflag=D><!--E$_D--></td>  </tr></table>','A,B,C,D')
/

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(5,'��������2','��������2','\images\homepage\layout\layout_05.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable> <tr><td id=area_A  width=W$_A  valign=top  areaflag=A>	<TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td>    <td id=area_B  width=W$_B  
valign=top  areaflag=B><!--E$_B--></td>    <td rowspan="2" id=area_C width=W$_C  valign=top  areaflag=C><!--E$_C--></td>  </tr>  <tr>    
 <td colspan="2" id=area_D  width=W$_D valign=top areaflag=D><!--E$_D--></td>  </tr></table>','A,B,C,D')
/


create table  hpLayout(
	id	integer	 NOT NULL,
	hpid	integer	Not null,
	layoutbaseid	integer	null,
	areaflag	Varchar2(50)	Not null,
	areasize	Varchar2(50)	null,
    areaElements    Varchar2(500)  default '',
	userid	integer	null,
    usertype	integer	null

 )
/
create sequence hpLayout_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpLayout_Trigger
before insert on hpLayout
for each row
begin
select hpLayout_id.nextval into :new.id from dual;
end;
/


create table hpstyle(
	id integer    NOT NULL,
	stylename	Varchar2(50)	Not null,
	styledesc	Varchar2(500)	null,
	hpbgimg	Varchar2(100)	null,
	hpbgcolor	Varchar2(20)	null,
	etitlebgimg	Varchar2(100)	null,
	etitlebgcolor	Varchar2(20)	null,
	ebgimg	Varchar2(100)	null,
	ebgcolor	Varchar2(20) null,
	etitlecolor	Varchar2(20)	null,
	ecolor	Varchar2(20)	null,
	ebordercolor	Varchar2(20)	null,
	edatemode	Varchar2(1)	null,
	etimemode	Varchar2(1)	null,
	elockimg1	Varchar2(100)	null,
	elockimg2	Varchar2(100)	null,
	eunlockimg1	Varchar2(100)	null,
	eunlockimg2	Varchar2(100)	null,
	erefreshimg1	Varchar2(100)	Null,
	erefreshimg2	Varchar2(100)	Null,
	esettingimg1	Varchar2(100)	Null,
	esettingimg2	Varchar2(100)	Null,
	ecoloseimg1	Varchar2(100)	Null,
	ecoloseimg2	Varchar2(100)	Null,
	emoreimg1	Varchar2(100)	Null,
	emoreimg2	Varchar2(100)	Null,
	esparatorimg	Varchar2(100)	Null,
	esymbol	Varchar2(100)	Null,
	issystemdefualt char(1) default '0'
)
/
create sequence hpstyle_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger hpstyle_Trigger
before insert on hpstyle
for each row
begin
select hpstyle_id.nextval into :new.id from dual;
end;
/

INSERT INTO hpstyle(stylename,styledesc,hpbgimg,hpbgcolor,etitlebgimg,etitlebgcolor,ebgimg,ebgcolor,etitlecolor,ecolor,ebordercolor,edatemode,etimemode,elockimg1,elockimg2,eunlockimg1,eunlockimg2,erefreshimg1,erefreshimg2,esettingimg1,esettingimg2,ecoloseimg1,ecoloseimg2,emoreimg1,emoreimg2,esparatorimg,esymbol,issystemdefualt) VALUES ('ϵͳ��ʽһ','ϵͳ��ʽһ','','','','#BBE3F9','','','#000000','#000000','#BBE3F9','','','/images/homepage/style/style1/lock1.gif','/images/homepage/style/style1/lock2.gif','/images/homepage/style/style1/unlock1.gif','/images/homepage/style/style1/unlock2.gif','/images/homepage/style/style1/refresh1.gif','/images/homepage/style/style1/refresh2.gif','/images/homepage/style/style1/setting1.gif','/images/homepage/style/style1/setting2.gif','/images/homepage/style/style1/close1.gif','/images/homepage/style/style1/close2.gif','/images/homepage/style/style1/more1.gif','/images/homepage/style/style1/more2.gif','/images/homepage/style/style1/esparatorimg.gif','/images/homepage/style/style1/esymbol.gif','1')
/

insert into hpinfo (infoname,infodesc,styleid,layoutid,subcompanyid,isuse)
values ('ϵͳĬ����ҳ1','ϵͳĬ����ҳ1',1,1,0,2)
/

insert into hpinfo (infoname,infodesc,styleid,layoutid,subcompanyid,isuse)
values ('ϵͳĬ����ҳ2','ϵͳĬ����ҳ2',1,1,0,2)
/

insert into hplayout(hpid,layoutbaseid,areaflag,areasize,areaelements,userid,usertype)
values (1,1,'A','100%','',1,4)
/

insert into hplayout(hpid,layoutbaseid,areaflag,areasize,areaelements,userid,usertype)
values (2,1,'A','100%','',1,4)
/

insert into SystemRights (id,rightdesc,righttype,detachable) values (659,'��ҳά��Ȩ��','7',1) 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (659,7,'��ҳά��Ȩ��','��ҳά��Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (659,8,'homepage maintenance','homepage maintenance') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4159,'��ҳά��Ȩ��','homepage:Maint',659) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4162,'��ҳ��ʽά��','homepage:styleMaint',659) 
/
insert into SystemRightToGroup (groupid, rightid) values (1,659)
/

call MMConfig_U_ByInfoInsert (11,20)
/
call MMInfo_Insert (515,19100,'��ҳ����','/homepage/maint/HomepageManit.jsp','mainFrame',11,1,20,0,'',0,'',0,'','',0,'','',9)
/


call MMConfig_U_ByInfoInsert (11,20)
/
call MMInfo_Insert (519,19439,'��ҳ��ʽά��','/homepage/style/HomepageStyleList.jsp','mainFrame',11,1,20,0,'',0,'',0,'','',0,'','',9)
/

INSERT INTO HtmlLabelIndex values(19405,'��ҳ����������') 
/
INSERT INTO HtmlLabelInfo VALUES(19405,'��ҳ����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19405,'homepage compatibility setting',8) 
/


INSERT INTO HtmlLabelIndex values(19406,'Ĭ��ʹ������ҳ') 
/
INSERT INTO HtmlLabelInfo VALUES(19406,'Ĭ��ʹ������ҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19406,'default use new homepage',8) 
/


INSERT INTO HtmlLabelIndex values(19407,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(19407,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19407,'layout',8) 
/


INSERT INTO HtmlLabelIndex values(19408,'Ԫ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19408,'Ԫ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19408,'Element',8) 
/


INSERT INTO HtmlLabelIndex values(19419,'����Զ���Ԫ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19419,'����Զ���Ԫ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19419,'Add new customer element',8) 
/

INSERT INTO HtmlLabelIndex values(19420,'������������ѡ�����ҳ') 
/
INSERT INTO HtmlLabelInfo VALUES(19420,'������������ѡ�����ҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19420,'It`s allow you selected follow this',8) 
/

INSERT INTO HtmlLabelIndex values(19422,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(19422,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19422,'reference',8) 
/


INSERT INTO HtmlLabelIndex values(19423,'��ѡ�������õ���ҳ') 
/
INSERT INTO HtmlLabelIndex values(19425,'��ѡ�������õ���ʽ') 
/
INSERT INTO HtmlLabelIndex values(19424,'��ѡ�������õĲ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19423,'��ѡ�������õ���ҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19423,'please select a homepage',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19424,'��ѡ�������õĲ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19424,'please select a layout',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19425,'��ѡ�������õ���ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19425,'please select a style',8) 
/


INSERT INTO HtmlLabelIndex values(19426,'Ч��ͼ') 
/
INSERT INTO HtmlLabelInfo VALUES(19426,'Ч��ͼ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19426,'effect picture',8) 
/


INSERT INTO HtmlLabelIndex values(19431,'�����Ҫѡ��һ����ҳ�����ύ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19431,'�����Ҫѡ��һ����ҳ�����ύ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19431,'before commit you must select a homepage!',8) 
/


INSERT INTO HtmlLabelIndex values(19433,'�½���ҳ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19433,'�½���ҳ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19433,'new homepage guide',8) 
/

INSERT INTO HtmlLabelIndex values(19434,'�½��Զ�����ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(19434,'�½��Զ�����ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19434,'create new style',8) 
/


INSERT INTO HtmlLabelIndex values(19439,'��ҳ��ʽά��') 
/
INSERT INTO HtmlLabelInfo VALUES(19439,'��ҳ��ʽά��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19439,'homepage style maintance',8) 
/



INSERT INTO HtmlLabelIndex values(19440,'��ҳ��ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(19440,'��ҳ��ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19440,'homepage style',8) 
/
 

INSERT INTO HtmlLabelIndex values(19443,'����������') 
/
INSERT INTO HtmlLabelIndex values(19446,'������') 
/
INSERT INTO HtmlLabelIndex values(19448,'��ǰͼ��') 
/
INSERT INTO HtmlLabelIndex values(19444,'ʱ����ʾ��ʽ') 
/
INSERT INTO HtmlLabelIndex values(19445,'�߿���ɫ') 
/
INSERT INTO HtmlLabelIndex values(19447,'�зָ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19443,'����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19443,'title backgroud',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19444,'ʱ����ʾ��ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19444,'time format',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19445,'�߿���ɫ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19445,'border color',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19446,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19446,'unlock',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19447,'�зָ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19447,'row sparator',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19448,'��ǰͼ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19448,'image befor row',8) 
/

INSERT INTO HtmlLabelIndex values(19469,'��ҳ��ʽ��û���棬���ݽ��ᶪʧ��ȷ��Ҫ�뿪��') 
/
INSERT INTO HtmlLabelInfo VALUES(19469,'��ҳ��ʽ��û���棬���ݽ��ᶪʧ��ȷ��Ҫ�뿪��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19469,'homepage style isn''t save. if you left data will be lost ,are you srue',8) 
/


INSERT INTO HtmlLabelIndex values(19484,'����д���»�����Ϣ') 
/
INSERT INTO HtmlLabelInfo VALUES(19484,'����д���»�����Ϣ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19484,'please fill the base info',8) 
/


INSERT INTO HtmlLabelIndex values(19486,'ϵͳԪ�ؿ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19486,'ϵͳԪ�ؿ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19486,'system element lib',8) 
/

INSERT INTO HtmlLabelIndex values(19487,'��Ӵ�Ԫ�ص�') 
/
INSERT INTO HtmlLabelInfo VALUES(19487,'��Ӵ�Ԫ�ص�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19487,'add this element to',8) 
/
 

INSERT INTO HtmlLabelIndex values(19491,'Ԫ�ر���') 
/
INSERT INTO HtmlLabelIndex values(19496,'��ʾ����') 
/
INSERT INTO HtmlLabelIndex values(19497,'��ǰҳ') 
/
INSERT INTO HtmlLabelIndex values(19498,'����ҳ') 
/
INSERT INTO HtmlLabelIndex values(19493,'��ʾ����') 
/
INSERT INTO HtmlLabelIndex values(19494,'���ӷ�ʽ') 
/
INSERT INTO HtmlLabelIndex values(19495,'��ʾ�ֶ�') 
/
INSERT INTO HtmlLabelIndex values(19492,'Ԫ��ͼ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19491,'Ԫ�ر���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19491,'Element title',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19492,'Ԫ��ͼ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19492,'element icon',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19493,'��ʾ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19493,'perpage',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19494,'���ӷ�ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19494,'link mode',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19495,'��ʾ�ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19495,'show field',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19496,'��ʾ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19496,'show where',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19497,'��ǰҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19497,'current page',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19498,'����ҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19498,'pop-up page',8) 
/




INSERT INTO HtmlLabelIndex values(19510,'�����ò��ֱ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19510,'�����ò��ֱ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19510,'please set the scale of layout',8) 
/

INSERT INTO HtmlLabelIndex values(19520,'����޸�ʱ��') 
/
INSERT INTO HtmlLabelIndex values(19521,'����޸�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19520,'����޸�ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19520,'the last modify time',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19521,'����޸�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19521,'the last modify date',8) 
/


INSERT INTO HtmlLabelIndex values(19524,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(19524,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19524,'word count',8) 

/
INSERT INTO HtmlLabelIndex values(19525,'�б�ʽ') 
/
INSERT INTO HtmlLabelIndex values(19526,'��ͼʽ') 
/
INSERT INTO HtmlLabelIndex values(19527,'��ͼʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(19525,'�б�ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19525,'list table mode',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19526,'��ͼʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19526,'the picture up mode',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19527,'��ͼʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19527,'the picture left mode',8) 
/


INSERT INTO HtmlLabelIndex values(19550,'�ƻ��������') 
/
INSERT INTO HtmlLabelIndex values(19551,'�ƻ����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19550,'�ƻ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19550,'the date all done',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19551,'�ƻ����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19551,'the time all done',8) 
/

INSERT INTO HtmlLabelIndex values(19552,'����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19552,'����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19552,'Distribute Time',8) 
/

INSERT INTO HtmlLabelIndex values(19553,'��/��Ԫ�ؿ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19553,'��/��Ԫ�ؿ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19553,'Show/Hide Element Lib',8) 
/

INSERT INTO HtmlLabelIndex values(19560,'���鿪ʼʱ��') 
/
INSERT INTO HtmlLabelIndex values(19559,'���鿪ʼ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19559,'���鿪ʼ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19559,'meeting begin date',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19560,'���鿪ʼʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19560,'meeting begin time',8) 
/
INSERT INTO HtmlLabelIndex values(19566,'ȡ��ʹ�ô�����') 
/
INSERT INTO HtmlLabelIndex values(19565,'ȷ��ʹ�ô�����') 
/
INSERT INTO HtmlLabelIndex values(19567,'������ҳ') 
/
INSERT INTO HtmlLabelInfo VALUES(19565,'ȷ��ʹ�ô�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19565,'confirm use this seeting',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19566,'ȡ��ʹ�ô�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19566,'cancel use this setting',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19567,'������ҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19567,'/ to the old page',8) 
/
INSERT INTO HtmlLabelIndex values(19568,'������ҳ') 
/
INSERT INTO HtmlLabelInfo VALUES(19568,'������ҳ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19568,'/ to the new homepage',8) 
/

UPDATE hpFieldElement   SET  linkurl = '/CRM/data/ViewCustomer.jsp?CustomerID=', isLimitlength = '1',  valuecolumn = 'id'    WHERE id = 23
/
UPDATE hpFieldElement   SET  transmethod = 'getCrmPlanStatusName'    WHERE id = 26
/


INSERT INTO HtmlLabelIndex values(19100,'��ҳ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19100,'��ҳ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19100,'Frontpage Set',8) 
/
