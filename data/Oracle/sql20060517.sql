INSERT INTO HtmlLabelIndex values(18990,'���������ģ���ָ��״̬') 
/
INSERT INTO HtmlLabelInfo VALUES(18990,'���������ģ���ָ��״̬',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18990,'Firstly, delete the appointed status',8) 
/

CREATE TABLE SystemTemplateSubComp(
    subcompanyid integer,
    templateid integer
)
/
insert into SystemTemplateSubComp (subcompanyid,templateid) select id,-1 from HrmSubCompany
/

insert into SysPoppupInfo values (11,'/cpt/search/CptInstockSearch.jsp','�ʲ������������','y','�ʲ������������')
/  
INSERT INTO HtmlLabelIndex values(18993,'������') 
/
INSERT INTO HtmlLabelIndex values(18995,'�ܷ�') 
/
INSERT INTO HtmlLabelIndex values(18996,'ƽ����') 
/
INSERT INTO HtmlLabelIndex values(18998,'һ����') 
/
INSERT INTO HtmlLabelIndex values(18999,'���˴��') 
/
INSERT INTO HtmlLabelIndex values(18992,'ƽ����') 
/
INSERT INTO HtmlLabelIndex values(18991,'�����ǰ�ĵ����') 
/
INSERT INTO HtmlLabelIndex values(18994,'������д�����۵�ԭ��') 
/
INSERT INTO HtmlLabelIndex values(18997,'��ϸ���') 
/
INSERT INTO HtmlLabelInfo VALUES(18991,'�����ǰ�ĵ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18991,'Please mark the current doc',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18992,'ƽ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18992,'Insipid',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18993,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18993,'Conspicuous',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18994,'������д�����۵�ԭ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18994,'Write the reason of this evaluation below',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18995,'�ܷ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18995,'Total',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18996,'ƽ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18996,'Average',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18997,'��ϸ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18997,'Detail',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18998,'һ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18998,'Totally',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18999,'���˴��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18999,'people marked',8) 
/

INSERT INTO HtmlLabelIndex values(19003,'�������') 
/
INSERT INTO HtmlLabelIndex values(19002,'�����') 
/
INSERT INTO HtmlLabelIndex values(19000,'�����Ҫѡ��÷��������ύ��') 
/
INSERT INTO HtmlLabelIndex values(19001,'û��ѡ����Ҫ���ĵ��ĵ�����鿴��ش�����־��') 
/
INSERT INTO HtmlLabelInfo VALUES(19000,'�����Ҫѡ��÷��������ύ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19000,'You must choose a point to submit!',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19001,'û��ѡ����Ҫ���ĵ��ĵ�����鿴��ش�����־��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19001,'No choosing doc to read,please check the related error log!',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19002,'�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19002,'Marker',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19003,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19003,'Mark Date',8) 
/

update Htmllabelinfo set labelname='Value of Point' where indexid=18093 and languageid=8
/
