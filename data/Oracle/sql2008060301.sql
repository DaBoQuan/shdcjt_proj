delete from SystemRights where id=397
/
delete from SystemRightsLanguage where id=397
/
delete from SystemRightDetail where id=3086
/
insert into SystemRights (id,rightdesc,righttype) values (397,'��������ά��','0') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (397,7,'��������ά��','��������ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (397,8,'','') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3086,'��������ά��','DataCenter:Maintenance',397) 
/
delete from HtmlLabelIndex where id=16889
/
delete from  HtmlLabelInfo where indexid= 16889
/
INSERT INTO HtmlLabelIndex values(16889,'��') 
/
INSERT INTO HtmlLabelInfo VALUES(16889,'��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16889,'',8) 
/
delete from HtmlLabelIndex where id=16890
/
delete from  HtmlLabelInfo where indexid= 16890
/

INSERT INTO HtmlLabelIndex values(16890,'ͳ����ά��') 
/
INSERT INTO HtmlLabelInfo VALUES(16890,'ͳ����ά��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16890,'',8) 
/

INSERT INTO HtmlLabelIndex values(16894,'��ʱ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16894,'��ʱ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16894,'',8) 
/
delete from HtmlLabelIndex where id=16895
/
delete from  HtmlLabelInfo where indexid= 16895
/
delete from HtmlLabelIndex where id=16896
/
delete from  HtmlLabelInfo where indexid= 16896
/
INSERT INTO HtmlLabelIndex values(16895,'������ҵ') 
/
INSERT INTO HtmlLabelInfo VALUES(16895,'������ҵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16895,'',8) 
/
INSERT INTO HtmlLabelIndex values(16896,'ȡǰ') 
/
INSERT INTO HtmlLabelInfo VALUES(16896,'ȡǰ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16896,'',8) 
/

delete from HtmlLabelIndex where id in (16901,16902,16903)
/
delete from  HtmlLabelInfo where indexid in (16901,16902,16903)
/
INSERT INTO HtmlLabelIndex values(16901,'ͳ��ͼ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16901,'ͳ��ͼ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16901,'',8) 
/
INSERT INTO HtmlLabelIndex values(16902,'���㵥λ') 
/
INSERT INTO HtmlLabelInfo VALUES(16902,'���㵥λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16902,'',8) 
/
INSERT INTO HtmlLabelIndex values(16903,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(16903,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16903,'',8) 
/

delete from HtmlLabelIndex where id in (17028,17029)
/
delete from  HtmlLabelInfo where indexid in (17028,17029)
/
INSERT INTO HtmlLabelIndex values(17028,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(17028,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17028,'last month',8) 
/
INSERT INTO HtmlLabelIndex values(17029,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(17029,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17029,'last year',8) 
/
delete from HtmlLabelIndex where id in (17030,17031,17032)
/
delete from  HtmlLabelInfo where indexid in (17030,17031,17032)
/
INSERT INTO HtmlLabelIndex values(17030,'�����') 
/
INSERT INTO HtmlLabelInfo VALUES(17030,'�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17030,'Input modify',8) 
/
INSERT INTO HtmlLabelIndex values(17031,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(17031,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17031,'Monthly modify',8) 
/
INSERT INTO HtmlLabelIndex values(17032,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(17032,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17032,'Year modify',8) 
/

delete HtmlLabelIndex where id = 16538 
/
delete HtmlLabelInfo where indexid = 16538 
/
INSERT INTO HtmlLabelIndex values(16538,'��ϸ����') 
/
INSERT INTO HtmlLabelInfo VALUES(16538,'��ϸ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16538,'Detail Report',8) 
/
delete HtmlLabelIndex where id = 17070 
/
delete HtmlLabelInfo where indexid = 17070 
/
INSERT INTO HtmlLabelIndex values(17070,'���򱨱�') 
/
INSERT INTO HtmlLabelInfo VALUES(17070,'���򱨱�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17070,'Ordinal Report',8) 
/

delete from HtmlLabelIndex where id=17496
/
delete from  HtmlLabelInfo where indexid= 17496
/

INSERT INTO HtmlLabelIndex values(17496,'ģ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(17496,'ģ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17496,'Mould Design',8) 
/

delete from HtmlLabelIndex where id=16892
/
delete from  HtmlLabelInfo where indexid= 16892
/
delete from HtmlLabelIndex where id=16893
/
delete from  HtmlLabelInfo where indexid= 16893
/
INSERT INTO HtmlLabelIndex values(16892,'����ͳ����') 
/
INSERT INTO HtmlLabelInfo VALUES(16892,'����ͳ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16892,'',8) 
/
INSERT INTO HtmlLabelIndex values(16893,'ͳ����') 
/
INSERT INTO HtmlLabelInfo VALUES(16893,'ͳ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16893,'',8) 
/
delete from HtmlLabelIndex where id=16894
/
delete from  HtmlLabelInfo where indexid= 16894
/
