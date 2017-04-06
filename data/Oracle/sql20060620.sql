INSERT INTO HtmlLabelIndex values(19309,'���ĵ�λ') 
/
INSERT INTO HtmlLabelIndex values(19310,'�ϼ���λ') 
/
INSERT INTO HtmlLabelIndex values(19311,'����Ա') 
/
INSERT INTO HtmlLabelIndex values(19312,'�½�ͬ����λ') 
/
INSERT INTO HtmlLabelIndex values(19313,'�½��¼���λ') 
/
INSERT INTO HtmlLabelInfo VALUES(19309,'���ĵ�λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19309,'Receive Unit',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19310,'�ϼ���λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19310,'Superior Unit',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19311,'����Ա',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19311,'Receiver',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19312,'�½�ͬ����λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19312,'New Peer Unit',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19313,'�½��¼���λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19313,'New Lower Unit',8) 
/
INSERT INTO HtmlLabelIndex values(19315,'�ϼ���λ����Ϊ����λ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19315,'�ϼ���λ����Ϊ����λ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19315,'The superior unit cann''t be this unit!',8) 
/

INSERT INTO HtmlLabelIndex values(19319,'ϵͳ��֧��10�����ϵ����ĵ�λ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19319,'ϵͳ��֧��10�����ϵ����ĵ�λ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19319,'The system doesn''t support 10 level of receive unit!',8) 
/

INSERT INTO HtmlLabelIndex values(19323,'����ȫѡ') 
/
INSERT INTO HtmlLabelIndex values(19324,'�ر�ȫѡ') 
/
INSERT INTO HtmlLabelInfo VALUES(19323,'����ȫѡ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19323,'Open Check All',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19324,'�ر�ȫѡ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19324,'Close Check All',8) 
/


call MMConfig_U_ByInfoInsert (20,5)
/
call MMInfo_Insert (510,19309,'','/docs/sendDoc/DocReceiveUnitFrame.jsp','mainFrame',20,2,5,0,'',0,'',0,'','',0,'','',1)
/

INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 142,19309,'varchar2(400)','/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/DocReceiveUnitBrowserMulti.jsp','DocReceiveUnit','receiveUnitName','id','/docs/sendDoc/DocReceiveUnitDsp.jsp?id=')
/

INSERT INTO HtmlLabelIndex values(19365,'��ǰ��λ���¼���λ������ɾ����') 
/
INSERT INTO HtmlLabelInfo VALUES(19365,'��ǰ��λ���¼���λ������ɾ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19365,'Current unit has subunit,can''t be deleted.',8) 
/
INSERT INTO HtmlLabelIndex values(19366,'ͬ����λ���Ʋ����ظ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19366,'ͬ����λ���Ʋ����ظ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19366,'The names of peer units couldn''t be repeated.',8) 
/

update ErrorMsgInfo set msgName='�ü�¼�����ã�����ɾ����' where indexid=20 and languageid=7
/




CREATE TABLE DocReceiveUnit (
	id integer  NOT NULL ,
	receiveUnitName varchar2(200) NULL ,
	superiorUnitId integer NULL ,
	receiverIds varchar2(200) NULL ,
	allSuperiorUnitId varchar2(80) NULL ,
	unitLevel integer NULL ,
    showOrder integer NULL 
)
/
create sequence DocReceiveUnit_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger DocReceiveUnit_Trigger
before insert on DocReceiveUnit
for each row
begin
select DocReceiveUnit_Id.nextval into :new.id from dual;
end;
/
