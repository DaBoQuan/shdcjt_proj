update systemrights set detachable=1 where id=37
/
update systemrights set detachable=1 where id=381
/

insert into systemrighttogroup(groupid,rightid) values(3,381)
/
update systemrights set rightdesc='��������ά��' where id=37
/
update SystemRightsLanguage set rightname='��������ά��',rightdesc='��������ά��' where id=37 and languageid=7
/
update mainmenuinfo set linkaddress='/hrm/schedule/HrmScheduleDiff_frm.jsp' where id=82
/
INSERT INTO HtmlLabelIndex values(19374,'Ӧ�÷�Χ')
/
INSERT INTO HtmlLabelIndex values(19375,'�Կ����¼�¼����')
/
INSERT INTO HtmlLabelInfo VALUES(19374,'Ӧ�÷�Χ',7)
/
INSERT INTO HtmlLabelInfo VALUES(19374,'apply scope',8)
/
INSERT INTO HtmlLabelInfo VALUES(19375,'�Կ����¼�¼����',7)
/
INSERT INTO HtmlLabelInfo VALUES(19375,'calculate by month record',8)
/
alter table hrmschedulediff add diffscope int
/
alter table hrmschedulediff add subcompanyid int
/
INSERT INTO HtmlLabelIndex values(19397,'�����¼�¼')
/
INSERT INTO HtmlLabelInfo VALUES(19397,'�����¼�¼',7)
/
INSERT INTO HtmlLabelInfo VALUES(19397,'time check record monthly',8)
/
CALL MMConfig_U_ByInfoInsert (47,4)
/
CALL MMInfo_Insert (514,19397,'','/hrm/schedule/HrmScheduleMonth_frm.jsp','mainFrame',47,2,4,0,'',0,'',0,'','',0,'','',2)
/
create table HrmScheduleMonth (hrmid integer,
                                 difftype integer,
                                 hours float,
                                 theyear char(4),
                                 themonth char(2))
/
INSERT INTO HtmlLabelIndex values(19421,'�ҵĿ���')
/
INSERT INTO HtmlLabelInfo VALUES(19421,'�ҵĿ���',7)
/
INSERT INTO HtmlLabelInfo VALUES(19421,'my roll',8)
/
CALL LMConfig_U_ByInfoInsert (2,5,8)
/
CALL LMInfo_Insert (162,19421,'/images_face/ecologyFace_1/LeftMenuIcon/HRM_9.gif','/hrm/schedule/HrmScheduleMonthPersonal.jsp',2,5,8,2)
/
INSERT INTO HtmlLabelIndex values(19428,'�������Ѵ���')
/
INSERT INTO HtmlLabelInfo VALUES(19428,'��ѡ�������Ѵ��ڣ�������ѡ��',7)
/
INSERT INTO HtmlLabelInfo VALUES(19428,'the month has existed,please reselect.',8)
/
declare detachable_1 integer;
        defaultsubcom_1 integer;
        minsubcom_1 integer;

begin
select detachable into detachable_1   from systemset;
select dftsubcomid into defaultsubcom_1 from systemset;

if(detachable_1<>null and defaultsubcom_1<>null) then
update  hrmschedulediff set diffscope=0,subcompanyid=defaultsubcom_1;
else
select min(id) into minsubcom_1 from hrmsubcompany;
update  hrmschedulediff set diffscope=0,subcompanyid=minsubcom_1;
end if;
end;
/