
/* �����ߣ������� �������ܣ�����ʱ״̬��Ա������λ�����á�״̬��������Դ��*/
INSERT INTO HtmlLabelIndex values(17509,'��������') 
/
INSERT INTO HtmlLabelIndex values(17511,'���ñ�ע') 
/
INSERT INTO HtmlLabelIndex values(17512,'����֪ͨ��') 
/
INSERT INTO HtmlLabelIndex values(17510,'��������') 
/
INSERT INTO HtmlLabelIndex values(17513,'��Ա����') 
/
INSERT INTO HtmlLabelInfo VALUES(17509,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17509,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17510,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17510,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17511,'���ñ�ע',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17511,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17512,'����֪ͨ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17512,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17513,'��Ա����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17513,'',8) 
/

INSERT INTO HtmlLabelIndex values(17514,'Ա������֪ͨ') 
/
INSERT INTO HtmlLabelInfo VALUES(17514,'Ա������֪ͨ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17514,'',8) 
/

INSERT INTO HtmlLabelIndex values(17515,'�ĵ�������־') 
/
INSERT INTO HtmlLabelInfo VALUES(17515,'�ĵ�������־',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17515,'',8) 
/

INSERT INTO HtmlLabelIndex values(17516,'������') 
/
INSERT INTO HtmlLabelIndex values(17517,'�ļ�����') 
/
INSERT INTO HtmlLabelIndex values(17519,'��������') 
/
INSERT INTO HtmlLabelIndex values(17518,'�����ĵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(17516,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17516,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17517,'�ļ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17517,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17518,'�����ĵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17518,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17519,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17519,'',8) 
/

INSERT INTO HtmlLabelIndex values(17528,'�ͻ����������޸�') 
/
INSERT INTO HtmlLabelInfo VALUES(17528,'�ͻ����������޸�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17528,'',8) 
/

INSERT INTO HtmlLabelIndex values(17529,'���������޸�') 
/
INSERT INTO HtmlLabelInfo VALUES(17529,'���������޸�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17529,'',8) 
/

INSERT INTO HtmlLabelIndex values(17530,'����') 
/
INSERT INTO HtmlLabelIndex values(17531,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(17530,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17530,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17531,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17531,'',8) 
/

INSERT INTO HtmlLabelIndex values(17534,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17534,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17534,'',8) 
/

INSERT INTO HtmlLabelIndex values(17535,'��ѵ����') 
/
INSERT INTO HtmlLabelInfo VALUES(17535,'��ѵ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17535,'',8) 
/


INSERT INTO HtmlLabelIndex values(17537,'ʱ�乤�ʻ���') 
/
INSERT INTO HtmlLabelIndex values(17538,'��Ա���ʻ���') 
/
INSERT INTO HtmlLabelIndex values(17536,'���ʱ���') 
/
INSERT INTO HtmlLabelInfo VALUES(17536,'���ʱ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17536,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17537,'ʱ�乤�ʻ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17537,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17538,'��Ա���ʻ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17538,'',8) 
/

create or REPLACE PROCEDURE HrmResource_Try
(id_1 integer,
 changedate_2 char,
 changereason_3 char,
 infoman_5 varchar2,
 oldjobtitleid_7 integer,
 type_n_8 char,  
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor)
 as
 begin
 INSERT INTO HrmStatusHistory
    (resourceid,
     changedate,
     changereason,
     infoman,
     oldjobtitleid,
     type_n  )
VALUES
    (id_1, 
     changedate_2,
     changereason_3,
     infoman_5,
     oldjobtitleid_7 ,
     type_n_8   );
end;
/

/*����������־*/
CREATE TABLE DownloadLog (
	userid integer NOT NULL ,
    username varchar2 (20) ,
	downloadtime char (19) ,
    imageid integer ,
    imagename varchar2(100) ,
    docid integer ,
    docname varchar2(200)
) 
/

/*�������֤����*/
alter table CRM_CustomerContacter add IDCard varchar2(20)
/

CREATE or REPLACE PROCEDURE CRM_CustomerContacter_Update 
 (id_1 	integer, 
 title_3 	integer,
 fullname_4 	varchar2,
 lastname_5 	varchar2,
 firstname_6 	varchar2, 
 jobtitle_7 	varchar2, 
 email_8 	varchar2, 
 phoneoffice_9 	varchar2,
 phonehome_10 	varchar2, 
 mobilephone_11 	varchar2,
 fax_12 	varchar2, 
 language_13 	integer, 
 manager_14 	integer, 
 main_15 	smallint, 
 picid_16 	integer, 
 interest_1	varchar2,
 hobby_1	varchar2,
 managerstr_1	varchar2,
 subordinate_1	varchar2,
 strongsuit_1	varchar2,
 age_1		integer, 
 birthday_1	varchar2,
 home_1	varchar2,
 school_1	varchar2,
 speciality_1	varchar2,
 nativeplace_1	varchar2,
 experience_1	varchar2,
 datefield1_17 	varchar2,
 datefield2_18 	varchar2,
 datefield3_19 	varchar2, 
 datefield4_20 	varchar2,
 datefield5_21 	varchar2, 
 numberfield1_22 	float, 
 numberfield2_23 	float,
 numberfield3_24 	float, 
 numberfield4_25 	float, 
 numberfield5_26 	float,
 textfield1_27 	varchar2, 
 textfield2_28 	varchar2, 
 textfield3_29 	varchar2, 
 textfield4_30 	varchar2,
 textfield5_31 	varchar2, 
 tinyintfield1_32 	smallint, 
 tinyintfield2_33 	smallint,
 tinyintfield3_34 	smallint,
 tinyintfield4_35 	smallint, 
 tinyintfield5_36 	smallint, 
 IDCard_37 	varchar2,
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor)   
 AS 
 begin
 UPDATE CRM_CustomerContacter  
 SET	 title	 = title_3, 
 fullname	 = fullname_4, 
 lastname	 = lastname_5, 
 firstname	 = firstname_6,
 jobtitle	 = jobtitle_7,
 email	 = email_8, 
 phoneoffice	 = phoneoffice_9, 
 phonehome	 = phonehome_10,
 mobilephone	 = mobilephone_11,
 fax	 = fax_12, 
 language	 = language_13, 
 manager	 = manager_14,
 main	 = main_15, picid	 = picid_16,
 datefield1	 = datefield1_17, 
 datefield2	 = datefield2_18, 
 datefield3	 = datefield3_19,
 datefield4	 = datefield4_20,
 datefield5	 = datefield5_21, 
 numberfield1	 = numberfield1_22,
 numberfield2	 = numberfield2_23,
 numberfield3	 = numberfield3_24,
 numberfield4	 = numberfield4_25,
 numberfield5	 = numberfield5_26,
 textfield1	 = textfield1_27, 
 textfield2	 = textfield2_28, 
 textfield3	 = textfield3_29,
 textfield4	 = textfield4_30,
 textfield5	 = textfield5_31,
 tinyintfield1	 = tinyintfield1_32, 
 tinyintfield2	 = tinyintfield2_33,
 tinyintfield3	 = tinyintfield3_34, 
 tinyintfield4	 = tinyintfield4_35, 
 tinyintfield5	 = tinyintfield5_36, 
 IDCard          = IDCard_37,
 interest	 = interest_1,
 hobby	 = hobby_1,
 managerstr	 = managerstr_1,
 subordinate	 = subordinate_1,
 strongsuit	 = strongsuit_1,
 age	 = age_1,
 birthday	 = birthday_1,
 home	 = home_1,
 school	 = school_1,
 speciality	 = speciality_1,
 nativeplace	 = nativeplace_1,
 experience	 = experience_1
WHERE ( id	 = id_1)  ;
end ;
/


CREATE or REPLACE PROCEDURE CRM_CustomerContacter_Insert 
 (customerid_1 	integer,
 title_2 	integer,
 fullname_3 	varchar2, 
 lastname_4 	varchar2,
 firstname_5 	varchar2,
 jobtitle_6 	varchar2,
 email_7 	varchar2, 
 phoneoffice_8 	varchar2,
 phonehome_9 	varchar2, 
 mobilephone_10 	varchar2, 
 fax_11 	varchar2,
 language_12 	integer,
 manager_13 	integer, 
 main_14 	smallint, 
 picid_15 	integer,
 interest_1	varchar2,
 hobby_1	varchar2,
 managerstr_1	varchar2,
 subordinate_1	varchar2,
 strongsuit_1	varchar2,
 age_1		integer, 
 birthday_1	varchar2,
 home_1	varchar2,
 school_1	varchar2,
 speciality_1	varchar2,
 nativeplace_1	varchar2,
 experience_1	varchar2,
 datefield1_16 	varchar2,
 datefield2_17 	varchar2,
 datefield3_18 	varchar2,
 datefield4_19 	varchar2, 
 datefield5_20 	varchar2, 
 numberfield1_21 	float, 
 numberfield2_22 	float, 
 numberfield3_23 	float, 
 numberfield4_24 	float, 
 numberfield5_25 	float,
 textfield1_26 	varchar2,
 textfield2_27 	varchar2,
 textfield3_28 	varchar2,
 textfield4_29 	varchar2, 
 textfield5_30 	varchar2,
 tinyintfield1_31 	smallint, 
 tinyintfield2_32 	smallint,
 tinyintfield3_33 	smallint, 
 tinyintfield4_34 	smallint,
 tinyintfield5_35 	smallint,
 IDCard_36 	varchar2,
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor )
 AS 
 begin
 INSERT INTO CRM_CustomerContacter
 ( customerid, title,
 fullname, lastname, firstname,
 jobtitle, email, phoneoffice,
 phonehome, mobilephone, fax, language,
 manager, main, picid, datefield1,
 datefield2, datefield3, datefield4,
 datefield5, numberfield1, numberfield2,
numberfield3, numberfield4, numberfield5, 
textfield1, textfield2, textfield3, textfield4, 
textfield5, tinyintfield1, tinyintfield2, tinyintfield3, 
tinyintfield4, tinyintfield5 ,interest ,hobby ,managerstr,subordinate,strongsuit,age,birthday,home,
school,speciality,nativeplace,experience,IDCard) 
 VALUES 
 ( customerid_1, title_2, fullname_3, lastname_4, 
 firstname_5, jobtitle_6, email_7, phoneoffice_8,
 phonehome_9, mobilephone_10, fax_11, language_12,
 manager_13, main_14, picid_15, datefield1_16, 
 datefield2_17, datefield3_18, datefield4_19,
 datefield5_20, numberfield1_21, numberfield2_22,
 numberfield3_23, numberfield4_24, numberfield5_25, 
 textfield1_26, textfield2_27, textfield3_28, 
 textfield4_29, textfield5_30, tinyintfield1_31,
 tinyintfield2_32, tinyintfield3_33, tinyintfield4_34,
 tinyintfield5_35, interest_1 , hobby_1 , 
 managerstr_1, subordinate_1 , strongsuit_1 ,
 age_1 , birthday_1 , home_1 , school_1 ,
 speciality_1 , nativeplace_1 , experience_1,IDCard_36) ; 
end;
/


/*��������*/


alter table CRM_CustomerContacter add isbirthdaynotify char
/
alter table CRM_CustomerContacter add  birthdaynotifydays char
/

 CREATE or REPLACE PROCEDURE CRM_CustomerContacter_Update 
 (id_1 	integer, 
 title_3 	integer,
 fullname_4 	varchar2,
 lastname_5 	varchar2,
 firstname_6 	varchar2, 
 jobtitle_7 	varchar2, 
 email_8 	varchar2, 
 phoneoffice_9 	varchar2,
 phonehome_10 	varchar2, 
 mobilephone_11 	varchar2,
 fax_12 	varchar2, 
 language_13 	integer, 
 manager_14 	integer, 
 main_15 	smallint, 
 picid_16 	integer, 
 interest_1	varchar2,
 hobby_1	varchar2,
 managerstr_1	varchar2,
 subordinate_1	varchar2,
 strongsuit_1	varchar2,
 age_1		integer, 
 birthday_1	varchar2,
 home_1	varchar2,
 school_1	varchar2,
 speciality_1	varchar2,
 nativeplace_1	varchar2,
 experience_1	varchar2,
 datefield1_17 	varchar2,
 datefield2_18 	varchar2,
 datefield3_19 	varchar2, 
 datefield4_20 	varchar2,
 datefield5_21 	varchar2, 
 numberfield1_22 	float, 
 numberfield2_23 	float,
 numberfield3_24 	float, 
 numberfield4_25 	float, 
 numberfield5_26 	float,
 textfield1_27 	varchar2, 
 textfield2_28 	varchar2, 
 textfield3_29 	varchar2, 
 textfield4_30 	varchar2,
 textfield5_31 	varchar2, 
 tinyintfield1_32 	smallint, 
 tinyintfield2_33 	smallint,
 tinyintfield3_34 	smallint,
 tinyintfield4_35 	smallint, 
 tinyintfield5_36 	smallint, 
 IDCard_37 	varchar2, 
 isbirthdaynotify_38   char,
 birthdaynotifydays_39 char,
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor)   
 AS 
 begin
 UPDATE CRM_CustomerContacter  
 SET	 title	 = title_3, 
 fullname	 = fullname_4, 
 lastname	 = lastname_5, 
 firstname	 = firstname_6,
 jobtitle	 = jobtitle_7,
 email	 = email_8, 
 phoneoffice	 = phoneoffice_9, 
 phonehome	 = phonehome_10,
 mobilephone	 = mobilephone_11,
 fax	 = fax_12, 
 language	 = language_13, 
 manager	 = manager_14,
 main	 = main_15, picid	 = picid_16,
 datefield1	 = datefield1_17, 
 datefield2	 = datefield2_18, 
 datefield3	 = datefield3_19,
 datefield4	 = datefield4_20,
 datefield5	 = datefield5_21, 
 numberfield1	 = numberfield1_22,
 numberfield2	 = numberfield2_23,
 numberfield3	 = numberfield3_24,
 numberfield4	 = numberfield4_25,
 numberfield5	 = numberfield5_26,
 textfield1	 = textfield1_27, 
 textfield2	 = textfield2_28, 
 textfield3	 = textfield3_29,
 textfield4	 = textfield4_30,
 textfield5	 = textfield5_31,
 tinyintfield1	 = tinyintfield1_32, 
 tinyintfield2	 = tinyintfield2_33,
 tinyintfield3	 = tinyintfield3_34, 
 tinyintfield4	 = tinyintfield4_35, 
 tinyintfield5	 = tinyintfield5_36, 
 IDCard          = IDCard_37,
 isbirthdaynotify   =isbirthdaynotify_38,
 birthdaynotifydays =birthdaynotifydays_39,
 interest	 = interest_1,
 hobby	 = hobby_1,
 managerstr	 = managerstr_1,
 subordinate	 = subordinate_1,
 strongsuit	 = strongsuit_1,
 age	 = age_1,
 birthday	 = birthday_1,
 home	 = home_1,
 school	 = school_1,
 speciality	 = speciality_1,
 nativeplace	 = nativeplace_1,
 experience	 = experience_1
WHERE ( id	 = id_1)  ;
end ;
/
CREATE or REPLACE PROCEDURE CRM_CustomerContacter_Insert 
 (customerid_1 	integer,
 title_2 	integer,
 fullname_3 	varchar2, 
 lastname_4 	varchar2,
 firstname_5 	varchar2,
 jobtitle_6 	varchar2,
 email_7 	varchar2, 
 phoneoffice_8 	varchar2,
 phonehome_9 	varchar2, 
 mobilephone_10 	varchar2, 
 fax_11 	varchar2,
 language_12 	integer,
 manager_13 	integer, 
 main_14 	smallint, 
 picid_15 	integer,
 interest_1	varchar2,
 hobby_1	varchar2,
 managerstr_1	varchar2,
 subordinate_1	varchar2,
 strongsuit_1	varchar2,
 age_1		integer, 
 birthday_1	varchar2,
 home_1	varchar2,
 school_1	varchar2,
 speciality_1	varchar2,
 nativeplace_1	varchar2,
 experience_1	varchar2,
 datefield1_16 	varchar2,
 datefield2_17 	varchar2,
 datefield3_18 	varchar2,
 datefield4_19 	varchar2, 
 datefield5_20 	varchar2, 
 numberfield1_21 	float, 
 numberfield2_22 	float, 
 numberfield3_23 	float, 
 numberfield4_24 	float, 
 numberfield5_25 	float,
 textfield1_26 	varchar2,
 textfield2_27 	varchar2,
 textfield3_28 	varchar2,
 textfield4_29 	varchar2, 
 textfield5_30 	varchar2,
 tinyintfield1_31 	smallint, 
 tinyintfield2_32 	smallint,
 tinyintfield3_33 	smallint, 
 tinyintfield4_34 	smallint,
 tinyintfield5_35 	smallint,
 IDCard_36 	varchar2,
 isbirthdaynotify_37   char,
 birthdaynotifydays_38 char,
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor )
 AS 
 begin
 INSERT INTO CRM_CustomerContacter
 ( customerid, title,
 fullname, lastname, firstname,
 jobtitle, email, phoneoffice,
 phonehome, mobilephone, fax, language,
 manager, main, picid, datefield1,
 datefield2, datefield3, datefield4,
 datefield5, numberfield1, numberfield2,
numberfield3, numberfield4, numberfield5, 
textfield1, textfield2, textfield3, textfield4, 
textfield5, tinyintfield1, tinyintfield2, tinyintfield3, 
tinyintfield4, tinyintfield5 ,interest ,hobby ,managerstr,subordinate,strongsuit,age,birthday,home,
school,speciality,nativeplace,experience,IDCard,isbirthdaynotify,birthdaynotifydays) 
 VALUES 
 ( customerid_1, title_2, fullname_3, lastname_4, 
 firstname_5, jobtitle_6, email_7, phoneoffice_8,
 phonehome_9, mobilephone_10, fax_11, language_12,
 manager_13, main_14, picid_15, datefield1_16, 
 datefield2_17, datefield3_18, datefield4_19,
 datefield5_20, numberfield1_21, numberfield2_22,
 numberfield3_23, numberfield4_24, numberfield5_25, 
 textfield1_26, textfield2_27, textfield3_28, 
 textfield4_29, textfield5_30, tinyintfield1_31,
 tinyintfield2_32, tinyintfield3_33, tinyintfield4_34,
 tinyintfield5_35, interest_1 , hobby_1 , 
 managerstr_1, subordinate_1 , strongsuit_1 ,
 age_1 , birthday_1 , home_1 , school_1 ,
 speciality_1 , nativeplace_1 , experience_1, IDCard_36, isbirthdaynotify_37, birthdaynotifydays_38 ); 
end;
/


/*��ӡ��ͻ�����ֱ������������Ȩ�ޡ���ע�⣬������ϵͳ�����а����Ȩ�޸�����صĽ�ɫ*/
insert into SystemRights (id,rightdesc,righttype) values (444,'�ͻ�����ֱ����������','0') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (444,7,'�ͻ�����ֱ����������','�ͻ�����ֱ����������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (444,8,'Customer Approve','Customer Approve') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3135,'�ͻ�����ֱ����������','MutiApproveCustomerNoRequest',444) 
/

INSERT INTO HtmlLabelIndex values(17548,'��ǰ') 
/
INSERT INTO HtmlLabelInfo VALUES(17548,'��ǰ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17548,'before',8) 
/

/*td:1040 ������༭�ͻ���ϵ����Ϣ�������������ڱ���С���������ڲ��ܱ���*/

/*��������*/

alter table CRM_CustomerContacter drop column birthdaynotifydays 
/
alter table CRM_CustomerContacter add birthdaynotifydays integer
/

CREATE or REPLACE PROCEDURE CRM_CustomerContacter_Update 
 (id_1 	integer, 
 title_3 	integer,
 fullname_4 	varchar2,
 lastname_5 	varchar2,
 firstname_6 	varchar2, 
 jobtitle_7 	varchar2, 
 email_8 	varchar2, 
 phoneoffice_9 	varchar2,
 phonehome_10 	varchar2, 
 mobilephone_11 	varchar2,
 fax_12 	varchar2, 
 language_13 	integer, 
 manager_14 	integer, 
 main_15 	smallint, 
 picid_16 	integer, 
 interest_1	varchar2,
 hobby_1	varchar2,
 managerstr_1	varchar2,
 subordinate_1	varchar2,
 strongsuit_1	varchar2,
 age_1		integer, 
 birthday_1	varchar2,
 home_1	varchar2,
 school_1	varchar2,
 speciality_1	varchar2,
 nativeplace_1	varchar2,
 experience_1	varchar2,
 datefield1_17 	varchar2,
 datefield2_18 	varchar2,
 datefield3_19 	varchar2, 
 datefield4_20 	varchar2,
 datefield5_21 	varchar2, 
 numberfield1_22 	float, 
 numberfield2_23 	float,
 numberfield3_24 	float, 
 numberfield4_25 	float, 
 numberfield5_26 	float,
 textfield1_27 	varchar2, 
 textfield2_28 	varchar2, 
 textfield3_29 	varchar2, 
 textfield4_30 	varchar2,
 textfield5_31 	varchar2, 
 tinyintfield1_32 	smallint, 
 tinyintfield2_33 	smallint,
 tinyintfield3_34 	smallint,
 tinyintfield4_35 	smallint, 
 tinyintfield5_36 	smallint, 
 IDCard_37 	varchar2, 
 isbirthdaynotify_38   char,
 birthdaynotifydays_39 integer,
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor)   
 AS 
 begin
 UPDATE CRM_CustomerContacter  
 SET	 title	 = title_3, 
 fullname	 = fullname_4, 
 lastname	 = lastname_5, 
 firstname	 = firstname_6,
 jobtitle	 = jobtitle_7,
 email	 = email_8, 
 phoneoffice	 = phoneoffice_9, 
 phonehome	 = phonehome_10,
 mobilephone	 = mobilephone_11,
 fax	 = fax_12, 
 language	 = language_13, 
 manager	 = manager_14,
 main	 = main_15, picid	 = picid_16,
 datefield1	 = datefield1_17, 
 datefield2	 = datefield2_18, 
 datefield3	 = datefield3_19,
 datefield4	 = datefield4_20,
 datefield5	 = datefield5_21, 
 numberfield1	 = numberfield1_22,
 numberfield2	 = numberfield2_23,
 numberfield3	 = numberfield3_24,
 numberfield4	 = numberfield4_25,
 numberfield5	 = numberfield5_26,
 textfield1	 = textfield1_27, 
 textfield2	 = textfield2_28, 
 textfield3	 = textfield3_29,
 textfield4	 = textfield4_30,
 textfield5	 = textfield5_31,
 tinyintfield1	 = tinyintfield1_32, 
 tinyintfield2	 = tinyintfield2_33,
 tinyintfield3	 = tinyintfield3_34, 
 tinyintfield4	 = tinyintfield4_35, 
 tinyintfield5	 = tinyintfield5_36, 
 IDCard          = IDCard_37,
 isbirthdaynotify   =isbirthdaynotify_38,
 birthdaynotifydays =birthdaynotifydays_39,
 interest	 = interest_1,
 hobby	 = hobby_1,
 managerstr	 = managerstr_1,
 subordinate	 = subordinate_1,
 strongsuit	 = strongsuit_1,
 age	 = age_1,
 birthday	 = birthday_1,
 home	 = home_1,
 school	 = school_1,
 speciality	 = speciality_1,
 nativeplace	 = nativeplace_1,
 experience	 = experience_1
WHERE ( id	 = id_1)  ;
end ;
/
CREATE or REPLACE PROCEDURE CRM_CustomerContacter_Insert 
 (customerid_1 	integer,
 title_2 	integer,
 fullname_3 	varchar2, 
 lastname_4 	varchar2,
 firstname_5 	varchar2,
 jobtitle_6 	varchar2,
 email_7 	varchar2, 
 phoneoffice_8 	varchar2,
 phonehome_9 	varchar2, 
 mobilephone_10 	varchar2, 
 fax_11 	varchar2,
 language_12 	integer,
 manager_13 	integer, 
 main_14 	smallint, 
 picid_15 	integer,
 interest_1	varchar2,
 hobby_1	varchar2,
 managerstr_1	varchar2,
 subordinate_1	varchar2,
 strongsuit_1	varchar2,
 age_1		integer, 
 birthday_1	varchar2,
 home_1	varchar2,
 school_1	varchar2,
 speciality_1	varchar2,
 nativeplace_1	varchar2,
 experience_1	varchar2,
 datefield1_16 	varchar2,
 datefield2_17 	varchar2,
 datefield3_18 	varchar2,
 datefield4_19 	varchar2, 
 datefield5_20 	varchar2, 
 numberfield1_21 	float, 
 numberfield2_22 	float, 
 numberfield3_23 	float, 
 numberfield4_24 	float, 
 numberfield5_25 	float,
 textfield1_26 	varchar2,
 textfield2_27 	varchar2,
 textfield3_28 	varchar2,
 textfield4_29 	varchar2, 
 textfield5_30 	varchar2,
 tinyintfield1_31 	smallint, 
 tinyintfield2_32 	smallint,
 tinyintfield3_33 	smallint, 
 tinyintfield4_34 	smallint,
 tinyintfield5_35 	smallint,
 IDCard_36 	varchar2,
 isbirthdaynotify_37   char,
 birthdaynotifydays_38 integer,
 flag out integer ,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor )
 AS 
 begin
 INSERT INTO CRM_CustomerContacter
 ( customerid, title,
 fullname, lastname, firstname,
 jobtitle, email, phoneoffice,
 phonehome, mobilephone, fax, language,
 manager, main, picid, datefield1,
 datefield2, datefield3, datefield4,
 datefield5, numberfield1, numberfield2,
numberfield3, numberfield4, numberfield5, 
textfield1, textfield2, textfield3, textfield4, 
textfield5, tinyintfield1, tinyintfield2, tinyintfield3, 
tinyintfield4, tinyintfield5 ,interest ,hobby ,managerstr,subordinate,strongsuit,age,birthday,home,
school,speciality,nativeplace,experience,IDCard,isbirthdaynotify,birthdaynotifydays) 
 VALUES 
 ( customerid_1, title_2, fullname_3, lastname_4, 
 firstname_5, jobtitle_6, email_7, phoneoffice_8,
 phonehome_9, mobilephone_10, fax_11, language_12,
 manager_13, main_14, picid_15, datefield1_16, 
 datefield2_17, datefield3_18, datefield4_19,
 datefield5_20, numberfield1_21, numberfield2_22,
 numberfield3_23, numberfield4_24, numberfield5_25, 
 textfield1_26, textfield2_27, textfield3_28, 
 textfield4_29, textfield5_30, tinyintfield1_31,
 tinyintfield2_32, tinyintfield3_33, tinyintfield4_34,
 tinyintfield5_35, interest_1 , hobby_1 , 
 managerstr_1, subordinate_1 , strongsuit_1 ,
 age_1 , birthday_1 , home_1 , school_1 ,
 speciality_1 , nativeplace_1 , experience_1, IDCard_36, isbirthdaynotify_37, birthdaynotifydays_38 ); 
end;
/

/*td��1065 ���ͻ���Ƭҳ��ġ�null���޸�Ϊ���ͻ����롿*/
INSERT INTO HtmlLabelIndex values(17080,'�ͻ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(17080,'�ͻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17080,'CustomerCode',8) 
/