delete from HtmlLabelIndex where id=21723 
/
delete from HtmlLabelInfo where indexid=21723 
/
INSERT INTO HtmlLabelIndex values(21723,'ͶƱ�󲻿ɲ鿴���') 
/
INSERT INTO HtmlLabelInfo VALUES(21723,'ͶƱ�󲻿ɲ鿴���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21723,'After the voting results can not be read',8) 
/
delete from HtmlLabelIndex where id=21724 
/
delete from HtmlLabelInfo where indexid=21724 
/
INSERT INTO HtmlLabelIndex values(21724,'ͶƱ�ѳɹ���лл���룡') 
/
INSERT INTO HtmlLabelInfo VALUES(21724,'ͶƱ�ѳɹ���лл���룡',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21724,'Vote has been successful, thank you participate!',8) 
/
delete from HtmlLabelIndex where id=21725 
/
delete from HtmlLabelInfo where indexid=21725 
/
INSERT INTO HtmlLabelIndex values(21725,'��ѡ����') 
/
INSERT INTO HtmlLabelInfo VALUES(21725,'��ѡ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21725,'Can be few options',8) 
/
delete from HtmlLabelIndex where id=21726 
/
delete from HtmlLabelInfo where indexid=21726 
/
INSERT INTO HtmlLabelIndex values(21726,'��ѡȡ����涨,������ѡȡ') 
/
INSERT INTO HtmlLabelInfo VALUES(21726,'��ѡȡ����涨,������ѡȡ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21726,'You can select the items over, please re-select',8) 
/
delete from HtmlLabelIndex where id=21727 
/
delete from HtmlLabelInfo where indexid=21727 
/
INSERT INTO HtmlLabelIndex values(21727,'��ͶƱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(21727,'��ͶƱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21727,'Voters have',8) 
/
delete from HtmlLabelIndex where id=21728 
/
delete from HtmlLabelInfo where indexid=21728 
/
INSERT INTO HtmlLabelIndex values(21728,'δͶƱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(21728,'δͶƱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21728,'People did not vote',8) 
/

delete from SystemRights where id=792
/
insert into SystemRights (id,rightdesc,righttype) values (792,'����ɾ��Ȩ��','1') 
/
delete from SystemRightsLanguage where id=792
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (792,7,'����ɾ��Ȩ��','����ɾ��Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (792,8,'votingDelete','votingDelete') 
/
delete from SystemRightDetail where id=4302
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4302,'����ɾ��Ȩ��','voting:delete',792) 
/
delete from SystemRights where id=793
/
insert into SystemRights (id,rightdesc,righttype) values (793,'������ϸ��Ϣ�鿴Ȩ��','1') 
/
delete from SystemRightsLanguage where id=793
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (793,7,'������ϸ��Ϣ�鿴Ȩ��','������ϸ��Ϣ�鿴Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (793,8,'votingParticular','votingParticular') 
/
delete from SystemRightDetail where id=4303
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4303,'������ϸ��Ϣ�鿴Ȩ��','voting:particular',793) 
/

delete from HtmlLabelIndex where id=21765 
/
delete from HtmlLabelInfo where indexid=21765 
/
INSERT INTO HtmlLabelIndex values(21765,'���������0������!') 
/
INSERT INTO HtmlLabelInfo VALUES(21765,'���������0������!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21765,'Please enter the number greater than 0!',8) 
/