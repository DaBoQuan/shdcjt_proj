insert into SystemRights (id,rightdesc,righttype,detachable) values (664,'н�����','3',1) 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (664,7,'н�����','н�����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (664,8,'Compensation Manager','Compensation Manager') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4165,'н�����Ȩ��','Compensation:Manager',664) 
GO
INSERT INTO HtmlLabelIndex values(19554,'���ʵ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19554,'���ʵ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19554,'Date of the payroll',8) 
GO
INSERT INTO HtmlLabelIndex values(19555,'�Ƿ��ѷ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19555,'�Ƿ��ѷ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19555,'Whether Sent',8) 
GO
INSERT INTO HtmlLabelIndex values(19556,'���ʵ�״̬') 
GO
INSERT INTO HtmlLabelInfo VALUES(19556,'���ʵ�״̬',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19556,'Payroll State',8) 
GO
INSERT INTO HtmlLabelIndex values(19557,'δ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19557,'δ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19557,'Unsent',8) 
GO
INSERT INTO HtmlLabelIndex values(19558,'�ѷ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19558,'�ѷ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19558,'Sent',8) 
GO
INSERT INTO HtmlLabelIndex values(19575,'�رչ��ʵ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19575,'�رչ��ʵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19575,'Close the payroll',8) 
GO
INSERT INTO HtmlLabelIndex values(19576,'��ʷ���ʵ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19576,'��ʷ���ʵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19576,'History the payroll',8) 
GO
INSERT INTO HtmlLabelIndex values(19577,'���ʵ��Ѿ����ڣ��Ƿ�Ҫ�������ɣ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19577,'���ʵ��Ѿ����ڣ��Ƿ�Ҫ�������ɣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19577,'Payroll already existed,create payroll again?',8) 
GO
INSERT INTO HtmlLabelIndex values(19578,'�������ɹ��ʵ������Ե�...') 
GO
INSERT INTO HtmlLabelInfo VALUES(19578,'�������ɹ��ʵ������Ե�...',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19578,'Building payroll,Please wait...',8) 
GO
INSERT INTO HtmlLabelIndex values(19580,'����н������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19580,'����н������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19580,'Change salary set',8) 
GO
INSERT INTO HtmlLabelIndex values(19581,'��ȷ��Ҫ����н��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19581,'��ȷ��Ҫ����н��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19581,'Change salary set,are you sure?',8) 
GO
INSERT INTO HtmlLabelIndex values(19583,'û���޸��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19583,'û���޸��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19583,'No changed items!',8) 
GO
INSERT INTO HtmlLabelIndex values(19586,'��ȷ��Ҫ���͹��ʵ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19586,'��ȷ��Ҫ���͹��ʵ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19586,'Will send payroll,are you sure?',8) 
GO
INSERT INTO HtmlLabelIndex values(19590,'���ʵ��б�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19590,'���ʵ��б�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19590,'Payroll list',8) 
GO
INSERT INTO HtmlLabelIndex values(19592,'���ʵ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19592,'���ʵ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19592,'Payroll changed',8) 
GO
INSERT INTO HtmlLabelIndex values(19594,'���ɹ��ʵ�ʧ�ܣ������������ԣ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19594,'���ɹ��ʵ�ʧ�ܣ������������ԣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19594,'Create payroll error,Please check data and create again!',8) 
GO

alter table HrmSalarypaydetail add departmentid int
GO
alter table HrmSalarypaydetail add status int default(0)
GO
alter table HrmSalarypaydetail add sent int default(0)
GO
/* н�������ļ�¼ */
CREATE TABLE HRMSalaryPayLog(
    id int NOT NULL IDENTITY (1, 1),
    changid int,/*�޸���*/
    userid int,/*���޸���*/
    changedate    varchar(10),/*�޸�����*/
    changetime   varchar(8),/*�޸�ʱ��*/
    payid int,/*���ʵ�id*/
    itemid varchar(10),/*������*/
    oldvalue decimal(15,2),/*�޸�ǰֵ*/
    newvalue decimal(15,2), /*�޸ĺ�ֵ*/
    changedset int /*�Ƿ�Ӧ�õ�н������*/
)

go