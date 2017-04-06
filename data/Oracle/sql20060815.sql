insert into SystemRights (id,rightdesc,righttype,detachable) values (664,'н�����','3',1) 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (664,7,'н�����','н�����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (664,8,'Compensation Manager','Compensation Manager') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4165,'н�����Ȩ��','Compensation:Manager',664) 
/
INSERT INTO HtmlLabelIndex values(19554,'���ʵ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19554,'���ʵ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19554,'Date of the payroll',8) 
/
INSERT INTO HtmlLabelIndex values(19555,'�Ƿ��ѷ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19555,'�Ƿ��ѷ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19555,'Whether Sent',8) 
/
INSERT INTO HtmlLabelIndex values(19556,'���ʵ�״̬') 
/
INSERT INTO HtmlLabelInfo VALUES(19556,'���ʵ�״̬',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19556,'Payroll State',8) 
/
INSERT INTO HtmlLabelIndex values(19557,'δ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19557,'δ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19557,'Unsent',8) 
/
INSERT INTO HtmlLabelIndex values(19558,'�ѷ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19558,'�ѷ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19558,'Sent',8) 
/
INSERT INTO HtmlLabelIndex values(19575,'�رչ��ʵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19575,'�رչ��ʵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19575,'Close the payroll',8) 
/
INSERT INTO HtmlLabelIndex values(19576,'��ʷ���ʵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19576,'��ʷ���ʵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19576,'History the payroll',8) 
/
INSERT INTO HtmlLabelIndex values(19577,'���ʵ��Ѿ����ڣ��Ƿ�Ҫ�������ɣ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19577,'���ʵ��Ѿ����ڣ��Ƿ�Ҫ�������ɣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19577,'Payroll already existed,create payroll again?',8) 
/
INSERT INTO HtmlLabelIndex values(19578,'�������ɹ��ʵ������Ե�...') 
/
INSERT INTO HtmlLabelInfo VALUES(19578,'�������ɹ��ʵ������Ե�...',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19578,'Building payroll,Please wait...',8) 
/
INSERT INTO HtmlLabelIndex values(19580,'����н������') 
/
INSERT INTO HtmlLabelInfo VALUES(19580,'����н������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19580,'Change salary set',8) 
/
INSERT INTO HtmlLabelIndex values(19581,'��ȷ��Ҫ����н��������') 
/
INSERT INTO HtmlLabelInfo VALUES(19581,'��ȷ��Ҫ����н��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19581,'Change salary set,are you sure?',8) 
/
INSERT INTO HtmlLabelIndex values(19583,'û���޸��') 
/
INSERT INTO HtmlLabelInfo VALUES(19583,'û���޸��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19583,'No changed items!',8) 
/
INSERT INTO HtmlLabelIndex values(19586,'��ȷ��Ҫ���͹��ʵ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19586,'��ȷ��Ҫ���͹��ʵ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19586,'Will send payroll,are you sure?',8) 
/
INSERT INTO HtmlLabelIndex values(19590,'���ʵ��б�') 
/
INSERT INTO HtmlLabelInfo VALUES(19590,'���ʵ��б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19590,'Payroll list',8) 
/
INSERT INTO HtmlLabelIndex values(19592,'���ʵ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(19592,'���ʵ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19592,'Payroll changed',8) 
/
INSERT INTO HtmlLabelIndex values(19594,'���ɹ��ʵ�ʧ�ܣ������������ԣ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19594,'���ɹ��ʵ�ʧ�ܣ������������ԣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19594,'Create payroll error,Please check data and create again!',8) 
/

alter table HrmSalarypaydetail add departmentid integer
/
alter table HrmSalarypaydetail add status integer default(0)
/
alter table HrmSalarypaydetail add sent integer default(0)
/
/* н�������ļ�¼ */
CREATE TABLE HRMSalaryPayLog(
    id int NOT NULL ,
    changid integer,/*�޸���*/
    userid integer,/*���޸���*/
    changedate    varchar2(10),/*�޸�����*/
    changetime   varchar2(8),/*�޸�ʱ��*/
    payid integer,/*���ʵ�id*/
    itemid varchar2(10),/*������*/
    oldvalue number(15,2),/*�޸�ǰֵ*/
    newvalue number(15,2), /*�޸ĺ�ֵ*/
    changedset integer /*�Ƿ�Ӧ�õ�н������*/
)

/
create sequence  HRMSalaryPayLog_id                                      
		start with 1
		increment by 1
		nomaxvalue
		nocycle 
/
create or replace trigger HRMSalaryPayLog_trigger		
	before insert on HRMSalaryPayLog
	for each row
	begin
	select HRMSalaryPayLog_id.nextval into :new.id from dual;
	end ;
/