insert into ErrorMsgIndex values (45,'����usb����') 
/
insert into ErrorMsgInfo values (45,'�����usb����',7) 
/
insert into ErrorMsgInfo values (45,'please insert your usb token',8) 
/

insert into ErrorMsgIndex values (46,'usb����') 
/
insert into ErrorMsgInfo values (46,'δ��װusb������������',7) 
/
insert into ErrorMsgInfo values (46,'usb token''s driver hasn''t been installed',8) 
/

insert into ErrorMsgIndex values (47,'usb���ƴ���') 
/
insert into ErrorMsgInfo values (47,'usb���ƴ���',7) 
/
insert into ErrorMsgInfo values (47,'incorrect usb token',8) 
/

insert into ErrorMsgIndex values (48,'����������') 
/
insert into ErrorMsgInfo values (48,'������usb����δ׼����',7) 
/
insert into ErrorMsgInfo values (48,'incorrect server side usb token',8) 
/

INSERT INTO HtmlLabelIndex values(17588,'Ӳ������') 
/
INSERT INTO HtmlLabelInfo VALUES(17588,'Ӳ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17588,'hardware encrypt',8) 
/
 
INSERT INTO HtmlLabelIndex values(17589,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(17589,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17589,'encrypt',8) 
/
 
INSERT INTO HtmlLabelIndex values(17590,'ȡ������') 
/
INSERT INTO HtmlLabelInfo VALUES(17590,'ȡ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17590,'cancel encrypt',8) 
/

INSERT INTO SystemLogItem VALUES(89,17588,'Ӳ������') 
/

INSERT INTO HtmlLabelIndex values(17591,'������־') 
/
INSERT INTO HtmlLabelInfo VALUES(17591,'������־',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17591,'encrypt log',8) 
/

INSERT INTO HtmlLabelIndex values(17592,'����usb����') 
/
INSERT INTO HtmlLabelInfo VALUES(17592,'����usb����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17592,'update usb token',8) 
/

INSERT INTO HtmlLabelIndex values(17593,'ʹ��usb����') 
/
INSERT INTO HtmlLabelInfo VALUES(17593,'ʹ��usb����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17593,'use usb token',8) 
/
alter table HrmResource add needusb integer
/
alter table HrmResource add serial char(10)
/

drop table HrmOtherSettings
/
create table HrmOtherSettings(remindperiod char(4),
                              valid char(1),
                              birthremindperiod char(4), 
                              birthvalid char(1),
                              congratulation varchar2(50),
                              birthremindmode char(1),
                              needusb char(1),
                              firmcode char(10),
                              usercode char(10),
                              relogin char(1)
                              )
/

insert into HrmOtherSettings values('30','1','3','1', 'ף$���տ���', '1','0','10','13','0') 
/

CREATE OR REPLACE PROCEDURE HrmResourceSystemInfo_Insert 
(id_1 integer,
loginid_2 varchar2,
password_3 varchar2,
systemlanguage_4 integer,
seclevel_5 integer, 
email_6 varchar2,
needusb1 integer,
serial1 char, 
flag	out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)

AS 
count_1 integer;
oldpass varchar(60);
chgpasswddate char(10); 

begin 
select password into oldpass from HrmResource where id=id_1;
if (oldpass is null and password_3!='0' ) or oldpass!=password_3 then 
    chgpasswddate:=to_char(sysdate,'yyyy-mm-dd');
end if;
if loginid_2 is not null and loginid_2 != 'sysadmin' then 
    select count(id)  into count_1 from HrmResource where id != id_1 and loginid = loginid_2; 
end if; 
if ( count_1 is not null and count_1 > 0 ) or loginid_2 = 'sysadmin' then 
    open thecursor for select 0 from dual; 
else  
UPDATE HrmResource_Trigger SET seclevel = seclevel_5 WHERE id = id_1;  
  if password_3 = '0' then 
     if serial1='0' then 
        UPDATE HrmResource SET loginid = loginid_2, systemlanguage = systemlanguage_4, seclevel = seclevel_5, email = email_6,passwdchgdate =chgpasswddate,needusb=needusb1 WHERE id = id_1; 
     else
        UPDATE HrmResource SET loginid = loginid_2, systemlanguage = systemlanguage_4, seclevel = seclevel_5, email = email_6,passwdchgdate =chgpasswddate,needusb=needusb1,serial=serial1 WHERE id = id_1;
     end if;     
  else 
     if serial1='0' then 
        UPDATE HrmResource SET loginid = loginid_2, password = password_3, systemlanguage = systemlanguage_4, seclevel = seclevel_5, email = email_6,passwdchgdate =chgpasswddate,needusb=needusb1 WHERE id = id_1; 
     else
        UPDATE HrmResource SET loginid = loginid_2, password = password_3, systemlanguage = systemlanguage_4, seclevel = seclevel_5, email = email_6,passwdchgdate =chgpasswddate,needusb=needusb1,serial=serial1 WHERE id = id_1;  
     end if;
  end if; 
end if; 
end;
/