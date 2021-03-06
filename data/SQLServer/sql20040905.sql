/* by 王金永 增加新功能：自定义人力资源的个人信息和工作信息字段*/
CREATE TABLE cus_treeform (
    scope varchar(50) NOT NULL ,
    formlabel varchar(50) NOT NULL ,
    id int NOT NULL ,
	parentid int NOT NULL ,
    viewtype char(1) ,
    scopeorder int
)
GO

delete from cus_treeform where scope='HrmCustomFieldByInfoType' and id in(1,3)

insert into cus_treeform(scope,formlabel,id,parentid,viewtype,scopeorder) values('HrmCustomFieldByInfoType','个人信息',1,0,0,10)
go
insert into cus_treeform(scope,formlabel,id,parentid,viewtype,scopeorder) values('HrmCustomFieldByInfoType','工作信息',3,0,0,10)
go

CREATE TABLE HrmRpSubDefine (
	id int IDENTITY (1, 1) NOT NULL ,
    scopeid int ,
	resourceid int  ,
	colname varchar (30)  ,
	showorder int ,
	header varchar (60)  
) 
GO

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 119,803,'int','/systeminfo/BrowserMain.jsp?url=/hrm/speciality/SpecialityBrowser.jsp','HrmSpeciality','name','id','')
GO

INSERT INTO HtmlLabelIndex values(17549,'信息种类') 
GO
INSERT INTO HtmlLabelInfo VALUES(17549,'信息种类',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17549,'info type',8) 
GO
INSERT INTO HtmlLabelIndex values(17550,'新建子信息') 
GO
INSERT INTO HtmlLabelInfo VALUES(17550,'新建子信息',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17550,'new sub info',8) 
GO
delete from HtmlLabelIndex where id=17088
go
delete from HtmlLabelInfo where indexid =17088
go
INSERT INTO HtmlLabelIndex values(17088,'自定义信息') 
GO
INSERT INTO HtmlLabelInfo VALUES(17088,'自定义信息',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17088,'User Definition',8) 
GO

alter table HrmSearchMould add birthdayyear int,birthdaymonth int,birthdayday int,educationlevelto int
GO

alter table HrmSearchMould alter column educationlevel int
go

alter PROCEDURE HrmSearchMould_Insert
	(@mouldname_1 	varchar(200),
	 @userid_2 	int,
	 @resourceid_3 	int,
	 @resourcename_4 	varchar(60),
	 @jobtitle_5 	int,
	 @activitydesc_6 	varchar(200),
	 @jobgroup_7 	int,
	 @jobactivity_8 	int,
	 @costcenter_9 	int,
	 @competency_10 	int,
	 @resourcetype_11 	char(1),
	 @status_12 	char(1),
	 @subcompany1_13 	int,
	 @department_14 	int,
	 @location_15 	int,
	 @manager_16 	int,
	 @assistant_17 	int,
	 @roles_18 	int,
	 @seclevel_19 	tinyint,
	 @joblevel_20 	tinyint,
	 @workroom_21 	varchar(60),
	 @telephone_22 	varchar(60),
	 @startdate_23 	char(10),
	 @enddate_24 	char(10),
	 @contractdate_25 	char(10),
	 @birthday_26 	char(10),
	 @sex_27 	char(1),
	 @seclevelTo_28 	tinyint,
	 @joblevelTo_29 	tinyint,
	 @startdateTo_30 	char(10),
	 @enddateTo_31 	char(10),
	 @contractdateTo_32 	char(10),
	 @birthdayTo_33 	char(10),
	 @age_34 	int,
	 @ageTo_35 	int,
	 @resourceidfrom_36 	int,
	 @resourceidto_37 	int,
	 @workcode_38 	varchar(60),
	 @jobcall_39 	int,
	 @mobile_40 	varchar(60),
	 @mobilecall_41 	varchar(60),
	 @fax_42 	varchar(60),
	 @email_43 	varchar(60),
	 @folk_44 	varchar(30),
	 @nativeplace_45 	varchar(100),
	 @regresidentplace_46 	varchar(60),
	 @maritalstatus_47 	char(1),
	 @certificatenum_48 	varchar(60),
	 @tempresidentnumber_49 	varchar(60),
	 @residentplace_50 	varchar(60),
	 @homeaddress_51 	varchar(100),
	 @healthinfo_52 	char(1),
	 @heightfrom_53 	int,
	 @heightto_54 	int,
	 @weightfrom_55 	int,
	 @weightto_56 	int,
	 @educationlevel_57 	int,
	 @degree_58 	varchar(30),
	 @usekind_59 	int,
	 @policy_60 	varchar(30),
	 @bememberdatefrom_61 	char(10),
	 @bememberdateto_62 	char(10),
	 @bepartydatefrom_63 	char(10),
	 @bepartydateto_64 	char(10),
	 @islabouunion_65 	char(1),
	 @bankid1_66 	int,
	 @accountid1_67 	varchar(100),
	 @accumfundaccount_68 	varchar(30),
	 @loginid_69 	varchar(60),
	 @systemlanguage_70 	int,
     @birthdayyear_71   int,
     @birthdaymonth_72  int,
     @birthdayday_73    int,
     @educationlevelto_74   int,
	 @flag int output, @msg varchar(60) output)

AS INSERT INTO HrmSearchMould 
	 ( mouldname,
	 userid,
	 resourceid,
	 resourcename,
	 jobtitle,
	 activitydesc,
	 jobgroup,
	 jobactivity,
	 costcenter,
	 competency,
	 resourcetype,
	 status,
	 subcompany1,
	 department,
	 location,
	 manager,
	 assistant,
	 roles,
	 seclevel,
	 joblevel,
	 workroom,
	 telephone,
	 startdate,
	 enddate,
	 contractdate,
	 birthday,
	 sex,
	 seclevelTo,
	 joblevelTo,
	 startdateTo,
	 enddateTo,
	 contractdateTo,
	 birthdayTo,
	 age,
	 ageTo,
	 resourceidfrom,
	 resourceidto,
	 workcode,
	 jobcall,
	 mobile,
	 mobilecall,
	 fax,
	 email,
	 folk,
	 nativeplace,
	 regresidentplace,
	 maritalstatus,
	 certificatenum,
	 tempresidentnumber,
	 residentplace,
	 homeaddress,
	 healthinfo,
	 heightfrom,
	 heightto,
	 weightfrom,
	 weightto,
	 educationlevel,
	 degree,
	 usekind,
	 policy,
	 bememberdatefrom,
	 bememberdateto,
	 bepartydatefrom,
	 bepartydateto,
	 islabouunion,
	 bankid1,
	 accountid1,
	 accumfundaccount,
	 loginid,
	 systemlanguage,
     birthdayyear,
     birthdaymonth,
     birthdayday,
     educationlevelto) 
 
VALUES 
	( @mouldname_1,
	 @userid_2,
	 @resourceid_3,
	 @resourcename_4,
	 @jobtitle_5,
	 @activitydesc_6,
	 @jobgroup_7,
	 @jobactivity_8,
	 @costcenter_9,
	 @competency_10,
	 @resourcetype_11,
	 @status_12,
	 @subcompany1_13,
	 @department_14,
	 @location_15,
	 @manager_16,
	 @assistant_17,
	 @roles_18,
	 @seclevel_19,
	 @joblevel_20,
	 @workroom_21,
	 @telephone_22,
	 @startdate_23,
	 @enddate_24,
	 @contractdate_25,
	 @birthday_26,
	 @sex_27,
	 @seclevelTo_28,
	 @joblevelTo_29,
	 @startdateTo_30,
	 @enddateTo_31,
	 @contractdateTo_32,
	 @birthdayTo_33,
	 @age_34,
	 @ageTo_35,
	 @resourceidfrom_36,
	 @resourceidto_37,
	 @workcode_38,
	 @jobcall_39,
	 @mobile_40,
	 @mobilecall_41,
	 @fax_42,
	 @email_43,
	 @folk_44,
	 @nativeplace_45,
	 @regresidentplace_46,
	 @maritalstatus_47,
	 @certificatenum_48,
	 @tempresidentnumber_49,
	 @residentplace_50,
	 @homeaddress_51,
	 @healthinfo_52,
	 @heightfrom_53,
	 @heightto_54,
	 @weightfrom_55,
	 @weightto_56,
	 @educationlevel_57,
	 @degree_58,
	 @usekind_59,
	 @policy_60,
	 @bememberdatefrom_61,
	 @bememberdateto_62,
	 @bepartydatefrom_63,
	 @bepartydateto_64,
	 @islabouunion_65,
	 @bankid1_66,
	 @accountid1_67,
	 @accumfundaccount_68,
	 @loginid_69,
	 @systemlanguage_70,
     @birthdayyear_71   ,
     @birthdaymonth_72  ,
     @birthdayday_73    ,
     @educationlevelto_74      
     )
select max(id) from HrmSearchMould if @@error<>0 begin set @flag=1 set @msg='插入储存过程失败' return end else begin set @flag=0 set @msg='插入储存过程成功' return end

GO

alter PROCEDURE HrmSearchMould_Update
	(@id_1 	int,
	 @userid_2 	int,
	 @resourceid_3 	int,
	 @resourcename_4 	varchar(60),
	 @jobtitle_5 	int,
	 @activitydesc_6 	varchar(200),
	 @jobgroup_7 	int,
	 @jobactivity_8 	int,
	 @costcenter_9 	int,
	 @competency_10 	int,
	 @resourcetype_11 	char(1),
	 @status_12 	char(1),
	 @subcompany1_13 	int,
	 @department_14 	int,
	 @location_15 	int,
	 @manager_16 	int,
	 @assistant_17 	int,
	 @roles_18 	int,
	 @seclevel_19 	tinyint,
	 @joblevel_20 	tinyint,
	 @workroom_21 	varchar(60),
	 @telephone_22 	varchar(60),
	 @startdate_23 	char(10),
	 @enddate_24 	char(10),
	 @contractdate_25 	char(10),
	 @birthday_26 	char(10),
	 @sex_27 	char(1),
	 @seclevelTo_28 	tinyint,
	 @joblevelTo_29 	tinyint,
	 @startdateTo_30 	char(10),
	 @enddateTo_31 	char(10),
	 @contractdateTo_32 	char(10),
	 @birthdayTo_33 	char(10),
	 @age_34 	int,
	 @ageTo_35 	int,
	 @resourceidfrom_36 	int,
	 @resourceidto_37 	int,
	 @workcode_38 	varchar(60),
	 @jobcall_39 	int,
	 @mobile_40 	varchar(60),
	 @mobilecall_41 	varchar(60),
	 @fax_42 	varchar(60),
	 @email_43 	varchar(60),
	 @folk_44 	varchar(30),
	 @nativeplace_45 	varchar(100),
	 @regresidentplace_46 	varchar(60),
	 @maritalstatus_47 	char(1),
	 @certificatenum_48 	varchar(60),
	 @tempresidentnumber_49 	varchar(60),
	 @residentplace_50 	varchar(60),
	 @homeaddress_51 	varchar(100),
	 @healthinfo_52 	char(1),
	 @heightfrom_53 	int,
	 @heightto_54 	int,
	 @weightfrom_55 	int,
	 @weightto_56 	int,
	 @educationlevel_57 	int,
	 @degree_58 	varchar(30),
	 @usekind_59 	int,
	 @policy_60 	varchar(30),
	 @bememberdatefrom_61 	char(10),
	 @bememberdateto_62 	char(10),
	 @bepartydatefrom_63 	char(10),
	 @bepartydateto_64 	char(10),
	 @islabouunion_65 	char(1),
	 @bankid1_66 	int,
	 @accountid1_67 	varchar(100),
	 @accumfundaccount_68 	varchar(30),
	 @loginid_69 	varchar(60),
	 @systemlanguage_70 	int,
     @birthdayyear_71   int,
     @birthdaymonth_72  int,
     @birthdayday_73    int,
     @educationlevelto_74   int,
	 @flag int output, @msg varchar(60) output)

AS UPDATE HrmSearchMould 

SET      userid	 = @userid_2,
	 resourceid	 = @resourceid_3,
	 resourcename	 = @resourcename_4,
	 jobtitle	 = @jobtitle_5,
	 activitydesc	 = @activitydesc_6,
	 jobgroup	 = @jobgroup_7,
	 jobactivity	 = @jobactivity_8,
	 costcenter	 = @costcenter_9,
	 competency	 = @competency_10,
	 resourcetype	 = @resourcetype_11,
	 status	 = @status_12,
	 subcompany1	 = @subcompany1_13,
	 department	 = @department_14,
	 location	 = @location_15,
	 manager	 = @manager_16,
	 assistant	 = @assistant_17,
	 roles	 = @roles_18,
	 seclevel	 = @seclevel_19,
	 joblevel	 = @joblevel_20,
	 workroom	 = @workroom_21,
	 telephone	 = @telephone_22,
	 startdate	 = @startdate_23,
	 enddate	 = @enddate_24,
	 contractdate	 = @contractdate_25,
	 birthday	 = @birthday_26,
	 sex	 = @sex_27,
	 seclevelTo	 = @seclevelTo_28,
	 joblevelTo	 = @joblevelTo_29,
	 startdateTo	 = @startdateTo_30,
	 enddateTo	 = @enddateTo_31,
	 contractdateTo	 = @contractdateTo_32,
	 birthdayTo	 = @birthdayTo_33,
	 age	 = @age_34,
	 ageTo	 = @ageTo_35,
	 resourceidfrom	 = @resourceidfrom_36,
	 resourceidto	 = @resourceidto_37,
	 workcode	 = @workcode_38,
	 jobcall	 = @jobcall_39,
	 mobile	 = @mobile_40,
	 mobilecall	 = @mobilecall_41,
	 fax	 = @fax_42,
	 email	 = @email_43,
	 folk	 = @folk_44,
	 nativeplace	 = @nativeplace_45,
	 regresidentplace	 = @regresidentplace_46,
	 maritalstatus	 = @maritalstatus_47,
	 certificatenum	 = @certificatenum_48,
	 tempresidentnumber	 = @tempresidentnumber_49,
	 residentplace	 = @residentplace_50,
	 homeaddress	 = @homeaddress_51,
	 healthinfo	 = @healthinfo_52,
	 heightfrom	 = @heightfrom_53,
	 heightto	 = @heightto_54,
	 weightfrom	 = @weightfrom_55,
	 weightto	 = @weightto_56,
	 educationlevel	 = @educationlevel_57,
	 degree	 = @degree_58,
	 usekind	 = @usekind_59,
	 policy	 = @policy_60,
	 bememberdatefrom	 = @bememberdatefrom_61,
	 bememberdateto	 = @bememberdateto_62,
	 bepartydatefrom	 = @bepartydatefrom_63,
	 bepartydateto	 = @bepartydateto_64,
	 islabouunion	 = @islabouunion_65,
	 bankid1	 = @bankid1_66,
	 accountid1	 = @accountid1_67,
	 accumfundaccount	 = @accumfundaccount_68,
	 loginid	 = @loginid_69,
	 systemlanguage	 = @systemlanguage_70 ,
     birthdayyear   =   @birthdayyear_71   ,
     birthdaymonth  =   @birthdaymonth_72  ,
     birthdayday    =   @birthdayday_73    ,
     educationlevelto   =   @educationlevelto_74 

WHERE 
	( id	 = @id_1)
if @@error<>0 begin set @flag=1 set @msg='插入储存过程失败' return end else begin set @flag=0 set @msg='插入储存过程成功' return end

GO