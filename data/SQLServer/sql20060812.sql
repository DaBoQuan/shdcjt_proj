create table hpBaseElement(
	id int  NOT NULL,
	elementtype	Char(1)	Not null,
	title	Varchar(200)	null,
	logo	Varchar(500)	null,
	perpage	Int	null,
	linkmode	Char(1)	null,
	moreurl	Varchar(500)	null,
	elementdesc	Varchar(1000)	null
)
GO

INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 1,'2','RSS�Ķ���
','/images/homepage/element/1.gif',5,'2','getRssMore','����ֱ���RSS��ַ�Լ�RSS����')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 7,'2','��������
','/images/homepage/element/3.gif',5,'2','getNews','ϵͳ�����е�����')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 8,'1','��������
','/images/homepage/element/4.gif',5,'2','getNoreadFlow','ϵͳ���̲��ֵĴ�������')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 11,'1','���¿ͻ�
','/images/homepage/element/7.gif',5,'3','getNewCrmMore','��������˵���µĿͻ�')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 12,'1','���»���
','/images/homepage/element/8.gif',5,'2','getNewMettingMore','���µĻ���')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 6,'1','δ���ĵ�
','/images/homepage/element/2.gif',5,'2','getNoReadDoc','ϵͳ�����е�δ���ĵ�!')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 13,'1','δ��Э��
','/images/homepage/element/9.gif',5,'2','getNoReadCword','δ��Э��')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 14,'1','����Ŀ��
','/images/homepage/element/10.gif',5,'2','getMoreTarget','����Ŀ��')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 15,'1','���ռƻ�
','/images/homepage/element/11.gif',5,'2','getWorkPlanMore','���ռƻ�')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 16,'2','�ҵ��ʼ�
','/images/homepage/element/12.gif',5,'2','getMyMail','�ҵ��ʼ�')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 9,'1','��Ϣ����
','/images/homepage/element/5.gif',5,'2','getNoteMore','ϵͳ�е���Ϣ����')
GO
INSERT INTO hpBaseElement( id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc) VALUES ( 10,'1','�ҵ���Ŀ
','/images/homepage/element/6.gif',5,'2','getNewProj','���ܿ���������ͨ�����һ�û�н�������Ŀ')
GO



create table hpFieldElement(
	id int  NOT NULL,
	elementid	Int	Not null,
	fieldname	Varchar(30)	Not null,
	fieldColumn	Varchar(300)	Not null,
	isDate	Char(1)	Not null,
	transMethod	Varchar(300)	null,
	fieldwidth Varchar(10)	Not null,
	linkurl	Varchar(300)	Null,
	valuecolumn	Varchar(50)	null,
	isLimitLength	char(1)	null,
	ordernum int	Not null
)
GO

INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 1,1,'229','subject','0','','*','','','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 2,1,'1339','createtime','1','','62','','','',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 7,7,'229','docdocsubject','0','','*','/docs/docs/DocDsp.jsp?id=','id','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 4,6,'229','docsubject','0','','*','/docs/docs/DocDsp.jsp?id=','id','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 5,6,'19521','doclastmoddate','1','','76','','','',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 6,6,'19520','doclastmodtime','1','','62','','','',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 8,7,'19521','doclastmoddate','1','','76','','','',4)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 9,7,'19520','doclastmodtime','1','','62','','','',5)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 10,7,'341','summary','0','','','','','1',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 11,7,'74','img','0','','','','','0',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 12,8,'229','requestname','0','getRequestNewLink','*','','','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 13,8,'882','creater','0','getHrmStr','50','','','0',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 14,8,'17994','receivedate','1','','76','','','0',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 15,8,'18002','receivetime','1','','62','','','0',4)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 16,9,'195','typedescription','0','getInfoRemindLable','*','','','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 17,9,'16816','count','0','getInfoRemindStr','20','','','0',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 27,12,'2151','name','0','','*','/meeting/data/ViewMeeting.jsp?meetingid=','id','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 28,12,'780','address','0','','50','/meeting/Maint/MeetingRoom.jsp?id=','address','',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 29,12,'19559','begindate','1','','76','','','',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 30,12,'19560','begintime','1','','62','','','',4)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 31,13,'195','name','0','','*','/cowork/ViewCoWork.jsp?id=','id','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 32,13,'271','creater','0','getHrmStr','50','','','',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 33,13,'722','createdate','1','','76','','','',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 34,13,'1339','createtime','1','','62','','','',4)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 35,16,'344','subject','0','','*','/email/WeavermailDetail.jsp?msgid=','','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 36,16,'2034','priority','0','','40','','','0',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 37,16,'2035','senddate','0','','126','','','',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 40,15,'195','name','0','','*','/workplan/data/WorkPlanDetail.jsp?workid=','','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 41,15,'15534','urgentLevel','0','getWorkPlanStatusName','40','','','0',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 42,15,'1035','enddate','1','','76','','','0',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 43,15,'1036','endtime','1','','62','','','0',4)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 44,14,'18238','goalname','0','','*','','','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 45,14,'6071','percent_n','0','','40','','','0',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 18,1,'722','createdate','1','','76','','','0',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 19,10,'229','name','0','','*','/proj/data/ViewProject.jsp?ProjID=','id','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 20,10,'587','status','0','getProjStatusName','40','','','',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 21,10,'19550','planenddate','0','','76','','','',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 22,10,'19551','planendtime','0','','62','','','',4)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 23,11,'16857','name','0','','*','','','',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 24,11,'18901','movedate','1','','76','','','',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 25,11,'19552','movetime','1','','62','','','',4)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 26,11,'15078','status','0','','50','','','',2)
GO



create table hpWhereElement(
	id int NOT NULL,
	elementid	Int	Not null,
	settingshowmethod	Varchar(300)	Not null,
	getwheremethod	Varchar(300)	Not null
)
GO

INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 2,1,'getRssSettingStr','')
GO
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 6,7,'getNewsSettingStr','')
GO
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 9,8,'getWfSettingStr','')
GO
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 11,9,'getInfoRemindSettingStr','')
GO
INSERT INTO hpWhereElement( id,elementid,settingshowmethod,getwheremethod) VALUES ( 13,13,'getCworkSettingStr','')
GO



create table hpSqlElement(
	id int IDENTITY (1, 1) NOT NULL,
	elementid	Int	Not null,
	sppbMethod	Varchar(1000)	null
)
GO

INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 6,'getNoReadDocSpb')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 8,'getNoReadWfSpb')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 9,'getInfoRemaind')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 10,'getProjectSppb')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 12,'getNewMeetingSppb')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 13,'getNewCworkSppb')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 14,'getMonthTargetSppb')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 11,'getNewCrmSppb')
GO
INSERT INTO hpSqlElement( elementid,sppbMethod) VALUES ( 15,'getDayPlanSppb')
GO



create table hpextelement(
   id int not null,
   extsettinge varchar(300) null,
   extopreate varchar(300) null,
   extshow varchar(300) null,
   description   varchar(300) null
)
GO

INSERT INTO hpextelement( id,extsettinge,extopreate,extshow,description) VALUES ( 1,'','','getRssContent','rss���⴦��')
GO
INSERT INTO hpextelement( id,extsettinge,extopreate,extshow,description) VALUES ( 7,'','','getNewsContent','�������ݵ���ʾ')
GO
INSERT INTO hpextelement( id,extsettinge,extopreate,extshow,description) VALUES ( 16,'','','getEmailContent','�ʼ����ݵ���ʾ')
GO



create clustered index hpextelement_id_clu on hpextelement (id)
GO



create table  hpElement(
	id int IDENTITY (1, 1) NOT NULL,
	title	Varchar(30)	null,
	logo	Varchar(500)	null,
	islocked	Char(1)	Not null,
	strsqlwhere	Varchar(2000)	null,
	ebaseid	Int	Not null,	
	isSysElement	Char(1)	Not null,
	hpid	Int 	Not null
)
GO


create table  hpElementSettingDetail(
	id int IDENTITY (1, 1) NOT NULL,
	userid	Int	Not null,
	usertype	Int	Not null,
	eid	Int	Not null,
	perpage	Int	Not null,
	linkmode	Int	Not null,
	showfield	Varchar(500)	null,
	sharelevel       char(1),
	hpid            int null
)
GO


create table hpFieldLength(
	id int IDENTITY (1, 1) NOT NULL,
	eid	Int	Not null,
	userid	Int	Null,
	usertype	Int	Null,
	efieldid	int	Not null,
	charnum	int	Not null
)
GO

alter table SystemSet  add  defUseNewHomepage Char(1)
GO

update  systemSet  set defUseNewHomepage='1'
GO



create table  hpinfo(
	id int IDENTITY (1, 1) NOT NULL,
	infoname	Varchar(50)	Not null,
	infodesc	Varchar(500)	null,
	styleid	int	Not null,
	layoutid	int	Not null,
	Subcompanyid	int	Not null,
	isUse	Char(1)	Not null
)
GO



create table  hpsubcompanyappiont(
	id int IDENTITY (1, 1) NOT NULL,
	subcompanyid	Int	Not null,
	infoid	Int	Not null 
)
GO



create table  hpuserselect(
	id int IDENTITY (1, 1) NOT NULL,
	userid	Int	Not null,
	infoid	Int	Not null
)
GO




create table  hpBaseLayout(
	id int  NOT NULL,
	layoutname	Varchar(50)	Not null,
	layoutdesc	Varchar(500)	null,
	layoutimage	Varchar(200)	Not null,
	layoutcode	Varchar(2000)	Not null,
	allowArea	Varchar(50)	Not null
)
GO


insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(1,'һ������','һ������','\images\homepage\layout\layout_01.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td id=area_A  width=W$_A  valign=top  areaflag=A><TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td></tr></table>','A')
GO

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(2,'��������','��������','\images\homepage\layout\layout_02.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td id=area_A  width=W$_A  valign=top  areaflag=A><TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td><td id=area_B  width=W$_B  
valign=top  areaflag=B><!--E$_B--></td></tr></table>','A,B')
GO


insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(3,'��������','��������','\images\homepage\layout\layout_03.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td id=area_A  width=W$_A  valign=top  areaflag=A><TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td><td id=area_B  width=W$_B  
valign=top  areaflag=B><!--E$_B--></td><td id=area_C  width=W$_C  valign=top  areaflag=C><!--E$_C--></td></tr></table>','A,B,C')
GO

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(4,'��������1','��������1','\images\homepage\layout\layout_04.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable><tr><td colspan=2 id=area_A  width=W$_A  valign=top  areaflag=A> <TABLE width=100% id=tblInfo style=''font-size:12px; 
border:1px solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A-->  </td>   <td rowspan=2 
id=area_B  width=W$_B  valign=top  areaflag=B><!--E$_B--></td>  </tr>  <tr>    <td id=area_C  width=W$_C  valign=top  
areaflag=C><!--E$_C--></td>    <td id=area_D  width=W$_D  valign=top  areaflag=D><!--E$_D--></td>  </tr></table>','A,B,C,D')
GO

insert into hpbaselayout(id,layoutname,layoutdesc,layoutimage,layoutcode,allowarea )
values(5,'��������2','��������2','\images\homepage\layout\layout_05.png','<table border=0 cellpadding=0 cellspacing=10 width=100%  
id=parentTable> <tr><td id=area_A  width=W$_A  valign=top  areaflag=A>	<TABLE width=100% id=tblInfo style=''font-size:12px; border:1px 
solid #bdbebd;margin-bottom:10px;display:none''><TR><TD  id=tdInfo></TD></TR></TABLE><!--E$_A--></td>    <td id=area_B  width=W$_B  
valign=top  areaflag=B><!--E$_B--></td>    <td rowspan="2" id=area_C width=W$_C  valign=top  areaflag=C><!--E$_C--></td>  </tr>  <tr>    
 <td colspan="2" id=area_D  width=W$_D valign=top areaflag=D><!--E$_D--></td>  </tr></table>','A,B,C,D')
GO



create table  hpLayout(
	id	Int	IDENTITY (1, 1) NOT NULL,
	hpid	Int	Not null,
	layoutbaseid	Int	null,
	areaflag	Varchar(50)	Not null,
	areasize	Varchar(50)	null,
        areaElements    varchar(500)    default '',
	userid	Int	null,
        usertype	Int	null

 )
GO


create table hpstyle(
	id int  IDENTITY (1, 1)  NOT NULL,
	stylename	Varchar(50)	Not null,
	styledesc	Varchar(500)	null,
	hpbgimg	Varchar(100)	null,
	hpbgcolor	Varchar(20)	null,
	etitlebgimg	Varchar(100)	null,
	etitlebgcolor	Varchar(20)	null,
	ebgimg	Varchar(100)	null,
	ebgcolor	Varchar(20) null,
	etitlecolor	Varchar(20)	null,
	ecolor	Varchar(20)	null,
	ebordercolor	Varchar(20)	null,
	edatemode	Varchar(1)	null,
	etimemode	Varchar(1)	null,
	elockimg1	Varchar(100)	null,
	elockimg2	Varchar(100)	null,
	eunlockimg1	Varchar(100)	null,
	eunlockimg2	Varchar(100)	null,
	erefreshimg1	Varchar(100)	Null,
	erefreshimg2	Varchar(100)	Null,
	esettingimg1	Varchar(100)	Null,
	esettingimg2	Varchar(100)	Null,
	ecoloseimg1	Varchar(100)	Null,
	ecoloseimg2	Varchar(100)	Null,
	emoreimg1	Varchar(100)	Null,
	emoreimg2	Varchar(100)	Null,
	esparatorimg	Varchar(100)	Null,
	esymbol	Varchar(100)	Null,
	issystemdefualt char(1) default '0'
)
GO

INSERT INTO hpstyle(stylename,styledesc,hpbgimg,hpbgcolor,etitlebgimg,etitlebgcolor,ebgimg,ebgcolor,etitlecolor,ecolor,ebordercolor,edatemode,etimemode,elockimg1,elockimg2,eunlockimg1,eunlockimg2,erefreshimg1,erefreshimg2,esettingimg1,esettingimg2,ecoloseimg1,ecoloseimg2,emoreimg1,emoreimg2,esparatorimg,esymbol,issystemdefualt) VALUES ('ϵͳ��ʽһ','ϵͳ��ʽһ','','','','#BBE3F9','','','#000000','#000000','#BBE3F9','','','/images/homepage/style/style1/lock1.gif','/images/homepage/style/style1/lock2.gif','/images/homepage/style/style1/unlock1.gif','/images/homepage/style/style1/unlock2.gif','/images/homepage/style/style1/refresh1.gif','/images/homepage/style/style1/refresh2.gif','/images/homepage/style/style1/setting1.gif','/images/homepage/style/style1/setting2.gif','/images/homepage/style/style1/close1.gif','/images/homepage/style/style1/close2.gif','/images/homepage/style/style1/more1.gif','/images/homepage/style/style1/more2.gif','/images/homepage/style/style1/esparatorimg.gif','/images/homepage/style/style1/esymbol.gif','1')
GO




insert into hpinfo (infoname,infodesc,styleid,layoutid,subcompanyid,isuse)
values ('ϵͳĬ����ҳ1','ϵͳĬ����ҳ1',1,1,0,2)
GO

insert into hpinfo (infoname,infodesc,styleid,layoutid,subcompanyid,isuse)
values ('ϵͳĬ����ҳ2','ϵͳĬ����ҳ2',1,1,0,2)
GO


insert into hplayout(hpid,layoutbaseid,areaflag,areasize,areaelements,userid,usertype)
values (1,1,'A','100%','',1,4)
GO


insert into hplayout(hpid,layoutbaseid,areaflag,areasize,areaelements,userid,usertype)
values (2,1,'A','100%','',1,4)
GO


insert into SystemRights (id,rightdesc,righttype,detachable) values (659,'��ҳά��Ȩ��','7',1) 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (659,7,'��ҳά��Ȩ��','��ҳά��Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (659,8,'homepage maintenance','homepage maintenance') 
GO


insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4159,'��ҳά��Ȩ��','homepage:Maint',659) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4162,'��ҳ��ʽά��','homepage:styleMaint',659) 
GO
insert into SystemRightToGroup (groupid, rightid) values (1,659)
GO



EXECUTE MMConfig_U_ByInfoInsert 11,20
GO
EXECUTE MMInfo_Insert 515,19100,'��ҳ����
','/homepage/maint/HomepageManit.jsp','mainFrame',11,1,20,0,'',0,'',0,'','',0,'','',9
GO


EXECUTE MMConfig_U_ByInfoInsert 11,20
GO
EXECUTE MMInfo_Insert 519,19439,'��ҳ��ʽά��
','/homepage/style/HomepageStyleList.jsp','mainFrame',11,1,20,0,'',0,'',0,'','',0,'','',9
GO




INSERT INTO HtmlLabelIndex values(19405,'��ҳ����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19405,'��ҳ����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19405,'homepage compatibility setting',8) 
GO


INSERT INTO HtmlLabelIndex values(19406,'Ĭ��ʹ������ҳ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19406,'Ĭ��ʹ������ҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19406,'default use new homepage',8) 
GO


INSERT INTO HtmlLabelIndex values(19407,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19407,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19407,'layout',8) 
GO


INSERT INTO HtmlLabelIndex values(19408,'Ԫ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19408,'Ԫ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19408,'Element',8) 
GO


INSERT INTO HtmlLabelIndex values(19419,'����Զ���Ԫ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19419,'����Զ���Ԫ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19419,'Add new customer element',8) 
GO

INSERT INTO HtmlLabelIndex values(19420,'������������ѡ�����ҳ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19420,'������������ѡ�����ҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19420,'It`s allow you selected follow this',8) 
GO

INSERT INTO HtmlLabelIndex values(19422,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19422,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19422,'reference',8) 
GO


INSERT INTO HtmlLabelIndex values(19423,'��ѡ�������õ���ҳ') 
GO
INSERT INTO HtmlLabelIndex values(19425,'��ѡ�������õ���ʽ') 
GO
INSERT INTO HtmlLabelIndex values(19424,'��ѡ�������õĲ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19423,'��ѡ�������õ���ҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19423,'please select a homepage',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19424,'��ѡ�������õĲ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19424,'please select a layout',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19425,'��ѡ�������õ���ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19425,'please select a style',8) 
GO


INSERT INTO HtmlLabelIndex values(19426,'Ч��ͼ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19426,'Ч��ͼ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19426,'effect picture',8) 
GO


INSERT INTO HtmlLabelIndex values(19431,'�����Ҫѡ��һ����ҳ�����ύ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19431,'�����Ҫѡ��һ����ҳ�����ύ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19431,'before commit you must select a homepage!',8) 
GO


INSERT INTO HtmlLabelIndex values(19433,'�½���ҳ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19433,'�½���ҳ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19433,'new homepage guide',8) 
GO

INSERT INTO HtmlLabelIndex values(19434,'�½��Զ�����ʽ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19434,'�½��Զ�����ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19434,'create new style',8) 
GO


INSERT INTO HtmlLabelIndex values(19439,'��ҳ��ʽά��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19439,'��ҳ��ʽά��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19439,'homepage style maintance',8) 
GO



INSERT INTO HtmlLabelIndex values(19440,'��ҳ��ʽ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19440,'��ҳ��ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19440,'homepage style',8) 
GO
 

INSERT INTO HtmlLabelIndex values(19443,'����������') 
GO
INSERT INTO HtmlLabelIndex values(19446,'������') 
GO
INSERT INTO HtmlLabelIndex values(19448,'��ǰͼ��') 
GO
INSERT INTO HtmlLabelIndex values(19444,'ʱ����ʾ��ʽ') 
GO
INSERT INTO HtmlLabelIndex values(19445,'�߿���ɫ') 
GO
INSERT INTO HtmlLabelIndex values(19447,'�зָ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19443,'����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19443,'title backgroud',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19444,'ʱ����ʾ��ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19444,'time format',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19445,'�߿���ɫ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19445,'border color',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19446,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19446,'unlock',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19447,'�зָ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19447,'row sparator',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19448,'��ǰͼ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19448,'image befor row',8) 
GO

INSERT INTO HtmlLabelIndex values(19469,'��ҳ��ʽ��û���棬���ݽ��ᶪʧ��ȷ��Ҫ�뿪��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19469,'��ҳ��ʽ��û���棬���ݽ��ᶪʧ��ȷ��Ҫ�뿪��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19469,'homepage style isn''t save. if you left data will be lost ,are you 
srue',8) 
GO


INSERT INTO HtmlLabelIndex values(19484,'����д���»�����Ϣ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19484,'����д���»�����Ϣ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19484,'please fill the base info',8) 
GO


INSERT INTO HtmlLabelIndex values(19486,'ϵͳԪ�ؿ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19486,'ϵͳԪ�ؿ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19486,'system element lib',8) 
GO

INSERT INTO HtmlLabelIndex values(19487,'��Ӵ�Ԫ�ص�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19487,'��Ӵ�Ԫ�ص�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19487,'add this element to',8) 
GO
 

INSERT INTO HtmlLabelIndex values(19491,'Ԫ�ر���') 
GO
INSERT INTO HtmlLabelIndex values(19496,'��ʾ����') 
GO
INSERT INTO HtmlLabelIndex values(19497,'��ǰҳ') 
GO
INSERT INTO HtmlLabelIndex values(19498,'����ҳ') 
GO
INSERT INTO HtmlLabelIndex values(19493,'��ʾ����') 
GO
INSERT INTO HtmlLabelIndex values(19494,'���ӷ�ʽ') 
GO
INSERT INTO HtmlLabelIndex values(19495,'��ʾ�ֶ�') 
GO
INSERT INTO HtmlLabelIndex values(19492,'Ԫ��ͼ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19491,'Ԫ�ر���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19491,'Element title',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19492,'Ԫ��ͼ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19492,'element icon',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19493,'��ʾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19493,'perpage',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19494,'���ӷ�ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19494,'link mode',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19495,'��ʾ�ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19495,'show field',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19496,'��ʾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19496,'show where',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19497,'��ǰҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19497,'current page',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19498,'����ҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19498,'pop-up page',8) 
GO




INSERT INTO HtmlLabelIndex values(19510,'�����ò��ֱ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19510,'�����ò��ֱ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19510,'please set the scale of layout',8) 
GO

INSERT INTO HtmlLabelIndex values(19520,'����޸�ʱ��') 
GO
INSERT INTO HtmlLabelIndex values(19521,'����޸�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19520,'����޸�ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19520,'the last modify time',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19521,'����޸�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19521,'the last modify date',8) 
GO


INSERT INTO HtmlLabelIndex values(19524,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19524,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19524,'word count',8) 

GO
INSERT INTO HtmlLabelIndex values(19525,'�б�ʽ') 
GO
INSERT INTO HtmlLabelIndex values(19526,'��ͼʽ') 
GO
INSERT INTO HtmlLabelIndex values(19527,'��ͼʽ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19525,'�б�ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19525,'list table mode',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19526,'��ͼʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19526,'the picture up mode',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19527,'��ͼʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19527,'the picture left mode',8) 
GO


INSERT INTO HtmlLabelIndex values(19550,'�ƻ��������') 
GO
INSERT INTO HtmlLabelIndex values(19551,'�ƻ����ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19550,'�ƻ��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19550,'the date all done',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19551,'�ƻ����ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19551,'the time all done',8) 
GO

INSERT INTO HtmlLabelIndex values(19552,'����ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19552,'����ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19552,'Distribute Time',8) 
GO

INSERT INTO HtmlLabelIndex values(19553,'��/��Ԫ�ؿ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19553,'��/��Ԫ�ؿ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19553,'Show/Hide Element Lib',8) 
GO

INSERT INTO HtmlLabelIndex values(19560,'���鿪ʼʱ��') 
GO
INSERT INTO HtmlLabelIndex values(19559,'���鿪ʼ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19559,'���鿪ʼ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19559,'meeting begin date',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19560,'���鿪ʼʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19560,'meeting begin time',8) 
GO
INSERT INTO HtmlLabelIndex values(19566,'ȡ��ʹ�ô�����') 
GO
INSERT INTO HtmlLabelIndex values(19565,'ȷ��ʹ�ô�����') 
GO
INSERT INTO HtmlLabelIndex values(19567,'������ҳ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19565,'ȷ��ʹ�ô�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19565,'confirm use this seeting',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19566,'ȡ��ʹ�ô�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19566,'cancel use this setting',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19567,'������ҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19567,'go to the old page',8) 
GO
INSERT INTO HtmlLabelIndex values(19568,'������ҳ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19568,'������ҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19568,'go to the new homepage',8) 
GO

UPDATE hpFieldElement   SET  linkurl = '/CRM/data/ViewCustomer.jsp?CustomerID=', isLimitlength = '1',  valuecolumn = 'id'    WHERE id = 23
GO
UPDATE hpFieldElement   SET  transmethod = 'getCrmPlanStatusName'    WHERE id = 26
GO


INSERT INTO HtmlLabelIndex values(19100,'��ҳ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19100,'��ҳ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19100,'Frontpage Set',8) 
GO
