INSERT INTO HtmlLabelIndex values(17626,'�ͻ������Ѵ���,�����¶�����������') 
/
INSERT INTO HtmlLabelInfo VALUES(17626,'�ͻ������Ѵ���,�����¶�����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17626,'customer type has exist',8) 
/
insert into CRM_CustomerType (fullname,description,candelete,canedit,workflowid)values('�����û�','�����û�','n','n',null)
/

INSERT INTO HtmlLabelIndex values(17706,'�����û�') 
/
INSERT INTO HtmlLabelInfo VALUES(17706,'�����û�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17706,'personal customer',8) 
/

ALTER TABLE CRM_CustomerInfo ADD  Sex  smallint  DEFAULT (0)
/
ALTER TABLE CRM_CustomerInfo ADD IDCardNo  varchar2(50) NULL
/

/*td:1548*/
insert into ErrorMsgIndex values (49,'����ҵ�Ѿ������ͻ�,����ɾ��')
/
insert into ErrorMsgInfo values (49,'����ҵ�Ѿ������ͻ�,����ɾ��!',7)
/
insert into ErrorMsgInfo values (49,'associated with one client,can''t delete',8)
/
insert into ErrorMsgIndex values (50,'����ҵ������ҵ,����ɾ��')
/
insert into ErrorMsgInfo values (50,'����ҵ������ҵ,����ɾ��',7)
/
insert into ErrorMsgInfo values (50,'It has the subordinate profession, can''t delete',8)
/