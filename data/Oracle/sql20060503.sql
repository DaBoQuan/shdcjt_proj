INSERT INTO HtmlLabelIndex values(18818,'��ʱ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18818,'��ʱ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18818,'overtime setting',8) 
/
INSERT INTO HtmlLabelIndex values(18842,'��ʱ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18842,'��ʱ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18842,'overtime remind',8) 
/
INSERT INTO HtmlLabelIndex values(18843,'��ǰ����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18843,'��ǰ����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18843,'remind time',8) 
/
INSERT INTO HtmlLabelIndex values(18844,'����������') 
/
INSERT INTO HtmlLabelIndex values(18845,'�ʼ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(18844,'����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18844,'workflow remind',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18845,'�ʼ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18845,'e-mail remind',8) 
/
INSERT INTO HtmlLabelIndex values(18846,'ָ������') 
/
INSERT INTO HtmlLabelIndex values(18847,'ָ����Ԥ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18846,'ָ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18846,'select object',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18847,'ָ����Ԥ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18847,'select intervenor',8) 
/
INSERT INTO HtmlLabelIndex values(18848,'��ʱ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18848,'��ʱ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18848,'overtime process',8) 
/
INSERT INTO HtmlLabelIndex values(18849,'�Զ���ת����һ������') 
/
INSERT INTO HtmlLabelInfo VALUES(18849,'�Զ���ת����һ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18849,'to move with next operator',8) 
/
INSERT INTO HtmlLabelIndex values(18850,'������������') 
/
INSERT INTO HtmlLabelInfo VALUES(18850,'������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18850,'node link condition setting',8) 
/
INSERT INTO HtmlLabelIndex values(18853,'�������ýڵ㳬ʱʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18853,'�������ýڵ㳬ʱʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18853,'please,first setting node overtime',8) 
/
INSERT INTO HtmlLabelIndex values(18854,'����ʱ�䲻�ܴ��ڽڵ㳬ʱʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(18854,'����ʱ�䲻�ܴ��ڽڵ㳬ʱʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18854,'remind time can not over node pass time',8) 
/
INSERT INTO HtmlLabelIndex values(18868,'��ѡ��������') 
/
INSERT INTO HtmlLabelIndex values(18869,'��ѡ����ʽ') 
/
INSERT INTO HtmlLabelIndex values(18867,'��ѡ�����ѷ�ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(18867,'��ѡ�����ѷ�ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18867,'please,select remind mode',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18868,'��ѡ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18868,'please,select remind object',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18869,'��ѡ����ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18869,'please,select process mode',8) 
/
INSERT INTO HtmlLabelIndex values(18910,'���̳�ʱ����') 
/
INSERT INTO HtmlLabelInfo VALUES(18910,'���̳�ʱ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18910,'workflow overtime remind',8) 
/
INSERT INTO HtmlLabelIndex values(18911,'����ʱ') 
/
INSERT INTO HtmlLabelInfo VALUES(18911,'����ʱ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18911,'will overtime',8) 
/
INSERT INTO HtmlLabelIndex values(18912,'����ͼ') 
/
INSERT INTO HtmlLabelInfo VALUES(18912,'����ͼ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18912,'workflow chart',8) 
/
INSERT INTO HtmlLabelIndex values(18913,'���̸�Ԥ') 
/
INSERT INTO HtmlLabelInfo VALUES(18913,'���̸�Ԥ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18913,'workflow intervenor',8) 
/
INSERT INTO HtmlLabelIndex values(18914,'��ת���ڵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(18914,'��ת���ڵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18914,'flow to node',8) 
/
INSERT INTO HtmlLabelIndex values(18915,'��ת���ڵ������') 
/
INSERT INTO HtmlLabelInfo VALUES(18915,'��ת���ڵ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18915,'flow to node operator',8) 
/


alter table workflow_nodelink add nodepasshour integer 
/

alter table workflow_nodelink add nodepassminute integer 
/

alter table workflow_nodelink add isremind char(1) 
/

alter table workflow_nodelink add remindhour integer
/

alter table workflow_nodelink add remindminute integer
/

alter table workflow_nodelink add FlowRemind char(1) 
/

alter table workflow_nodelink add MsgRemind char(1) 
/

alter table workflow_nodelink add MailRemind char(1) 
/

alter table workflow_nodelink add isnodeoperator char(1) 
/

alter table workflow_nodelink add iscreater char(1) 
/

alter table workflow_nodelink add ismanager char(1) 
/

alter table workflow_nodelink add isother char(1) 
/

alter table workflow_nodelink add remindobjectids varchar2(100) 
/


alter table workflow_nodelink add isautoflow char(1) 
/

alter table workflow_nodelink add flownextoperator char(1) 
/

alter table workflow_nodelink add flowobjectids varchar2(100) 
/

alter table workflow_currentoperator add isreminded char(1)
/

alter table workflow_currentoperator add isprocessed char(1)
/
insert into syspoppupinfo(type,link,description,statistic,typedescription) values(10,'/workflow/search/WFSearchTemp.jsp?overtime=1','��������ʱ����','y','��������ʱ����')
/

CREATE TABLE workflow_modeview ( 
    formid integer,	
    nodeid integer,	
    isbill integer,	
    fieldid integer,	
    isview char(1),	
    isedit char(1),
    ismandatory char(1)	
)
/
