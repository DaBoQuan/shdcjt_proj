update HtmlLabelIndex set indexDesc='�ұ����' where id=19124
/

update HtmlLabelInfo  set labelName='�ұ����' where indexId=19124 and languageId=7
/

update HtmlLabelInfo  set labelName='Room Code' where indexId=19124 and languageId=8
/
update HtmlLabelIndex set indexDesc='��ֹ����' where id=19128
/

update HtmlLabelInfo  set labelName='��ֹ����' where indexId=19128 and languageId=7
/

update HtmlLabelInfo  set labelName='BeginEnd Archival Code' where indexId=19128 and languageId=8
/

INSERT INTO HtmlLabelIndex values(19933,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(19933,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19933,'Borrow Date',8) 
/

INSERT INTO HtmlLabelIndex values(19942,'������ѯ') 
/
INSERT INTO HtmlLabelInfo VALUES(19942,'������ѯ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19942,'For Reference Inquiry',8) 
/

INSERT INTO HtmlLabelIndex values(19963,'���ĵ�Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(19963,'���ĵ�Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19963,'By Catalog',8) 
/

delete from HtmlLabelIndex  where id=19689
/

delete from HtmlLabelInfo   where indexId=19689
/

INSERT INTO HtmlLabelIndex values(19689,'����ѡ������ļ�¼��') 
/
INSERT INTO HtmlLabelInfo VALUES(19689,'����ѡ������ļ�¼��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19689,'Please choose the operated record first!',8) 
/
delete from HtmlLabelIndex where id=18412
/
delete from HtmlLabelInfo where indexId=18412
/
INSERT INTO HtmlLabelIndex values(18412,'��ϲ�ѯ') 
/
INSERT INTO HtmlLabelInfo VALUES(18412,'��ϲ�ѯ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18412,'Condition Search',8) 
/