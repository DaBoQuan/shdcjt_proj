create or replace  PROCEDURE LMConfig_U_ByInfoInsert(
	menuLevel_1	integer,
	parentId_1	integer,
	defaultIndex_1	integer
) 
AS
begin
IF(menuLevel_1=1)
	then
	UPDATE LeftMenuConfig SET viewIndex=viewIndex+1 
	WHERE infoId IN (SELECT id FROM LeftMenuInfo WHERE parentId IS NULL) AND viewIndex>=defaultIndex_1;
	ELSE
	UPDATE LeftMenuConfig SET viewIndex=viewIndex+1 
	WHERE infoId IN (SELECT id FROM LeftMenuInfo WHERE parentId=parentId_1) AND viewIndex>=defaultIndex_1;
end if;
end;
/
/*==============================Ŀ�꼨Ч==============================*/
/*Ŀ�꼨Ч*/
call LMConfig_U_ByInfoInsert(1,NULL,2)
/
call LMInfo_Insert(94,18027,NULL,NULL,1,NULL,2,9)
/
update LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/KPI.gif' where id=94
/
/*�ҵ�Ŀ��*/
call LMConfig_U_ByInfoInsert (2,94,1)
/
call LMInfo_Insert (95,18028,'/images_face/ecologyFace_2/LeftMenuIcon/MyKPI.gif','',2,94,1,9)
/
/*�ҵĿ���*/
call LMConfig_U_ByInfoInsert (2,94,0)
/
call LMInfo_Insert (96,18029,'/images_face/ecologyFace_2/LeftMenuIcon/MyAssess.gif','',2,94,0,9) 
/
/*�ҵļƻ�*/
call LMConfig_U_ByInfoInsert (2,94,2)
/
call LMInfo_Insert (97,2101,'/images_face/ecologyFace_2/LeftMenuIcon/MyPlan.gif','/workplan/data/WorkPlan.jsp',2,94,2,9) 
/
/*�ҵı���*/
call LMConfig_U_ByInfoInsert (2,94,3)
/
call LMInfo_Insert (98,6015,'/images_face/ecologyFace_2/LeftMenuIcon/MyReport.gif','',2,94,3,9) 
/
/*���ҵ��ձ�...��̬����˵������ҵı����£�����Ϊ�����˵�*/
update leftMenuInfo set parentid=98 where id=62 or id=63 or id=64 or id=65 or id=66 or id=67
/
update leftMenuInfo set menuLevel=3 where id=62 or id=63 or id=64 or id=65 or id=66 or id=67
/
/*���½��ƻ�...��ѯ�ƻ������ҵļƻ��£�����Ϊ�����˵�*/
update LeftMenuInfo Set parentId=97 where id=60 or id=59 or id=61
/
update leftMenuInfo SET menuLevel=3 where id=60 or id=59 or id=61
/
/*�ҵļƻ����ҵı���Ϊ�ϼ��˵���û������*/
UPDATE LeftMenuInfo SET linkAddress='javascript:void(0);' WHERE id=98 OR id=97
/



/*==============================��Ϣ����==============================*/
/*��Ϣ����*/
call LMConfig_U_ByInfoInsert (1,NULL,2)
/
call LMInfo_Insert (111,18051,NULL,NULL,1,NULL,2,9)
/
UPDATE LeftMenuInfo SET iconurl='/images_face/ecologyFace_2/LeftMenuIcon/InformationCenter.gif' WHERE id=111
/
/*�ҵ��ղ�*/
call LMConfig_U_ByInfoInsert (2,111,1)
/
call LMInfo_Insert (116,18030,'/images_face/ecologyFace_2/LeftMenuIcon/MyFavourite.gif','javascript:void(0);',2,111,1,9) 
/
/*�ⲿ�鱨*/
call LMConfig_U_ByInfoInsert (2,111,0)
/
call LMInfo_Insert (117,18031,'/images_face/ecologyFace_2/LeftMenuIcon/OuterAdviced.gif','javascript:void(0);',2,111,0,9) 
/




/*==============================�ҵ�Э��==============================*/
/*��ԭ�˵����Ƹ�Ϊ�ҵ�Э��*/
update LeftMenuInfo set labelid=18032 where id=80 or id=81
/
/*�½�Э��*/
call LMConfig_U_ByInfoInsert (2,80,1)
/
call LMInfo_Insert (99,18034,'/images_face/ecologyFace_2/LeftMenuIcon/AddAssistance.gif','',2,80,1,9) 
/
/*�½�Э���˵�����*/
UPDATE LeftmenuInfo SET linkAddress='/cowork/coworkview.jsp?flag=add' WHERE id=99
/
call LMConfig_U_ByInfoInsert (2,80,2)
/
call LMInfo_Insert (100,18035,'/images_face/ecologyFace_2/LeftMenuIcon/SearchAssistance.gif','',2,80,2,9) 
/
/*��ѯЭ���˵�����*/
UPDATE LeftmenuInfo SET linkAddress='/cowork/coworkview.jsp?flag=search' WHERE id=100
/



/*==============================�ҵ�����==============================*/
/*���̼��*/
call LMConfig_U_ByInfoInsert (2,1,7)
/
call LMInfo_Insert (101,16758,'/images_face/ecologyFace_2/LeftMenuIcon/WorkflowWatch.gif','',2,1,7,3)
/
/*���̼�ز˵�·��*/
UPDATE LeftMenuInfo SET linkAddress='/system/systemmonitor/workflow/WorkflowMonitor.jsp' where id=101
/



/*==============================�ҵ�֪ʶ==============================*/
/*�ĵ����*/
call LMConfig_U_ByInfoInsert (2,2,13)
/
call LMInfo_Insert (102,16757,'/images_face/ecologyFace_2/LeftMenuIcon/DocWatch.gif','',2,2,13,1) 
/
/*�ĵ���ز˵�����*/
update leftmenuInfo set linkAddress='/system/systemmonitor/docs/DocMonitor.jsp' where id=102
/
/*��������(doc)*/
call LMConfig_U_ByInfoInsert (2,2,9)
/
call LMInfo_Insert (112,18037,'/images_face/ecologyFace_2/LeftMenuIcon/DocBatchShare.gif','/docs/search/DocSearch.jsp?from=shareMutiDoc',2,2,9,1) 
/
/*�ƶ�����(doc)*/
call LMConfig_U_ByInfoInsert (2,2,11)
/
call LMInfo_Insert (113,18052,'/images_face/ecologyFace_2/LeftMenuIcon/DocMoveCopy.gif','/docs/tools/DocCopyMove.jsp?Action=INPUT',2,2,11,1) 
/



/*==============================�ҵĿͻ�==============================*/
/*��ϵ�˲�ѯ*/
call LMConfig_U_ByInfoInsert (2,3,8)
/
call LMInfo_Insert (103,18036,'/images_face/ecologyFace_2/LeftMenuIcon/LinkmanSearch.gif','',2,3,8,4)
/
/*��ϵ�˲�ѯ�˵�·��*/
UPDATE LeftMenuInfo SET linkAddress='/CRM/search/ContacterSearch.jsp' where id=103
/
/*��������*/
call LMConfig_U_ByInfoInsert (2,3,12)
/
call LMInfo_Insert (104,18037,'/images_face/ecologyFace_2/LeftMenuIcon/BatchShare.gif','',2,3,12,4) 
/
/*��������˵�·��*/
UPDATE LeftMenuInfo SET linkAddress='/CRM/search/SearchSimple.jsp?actionKey=batchShare' where id=104
/
/*�ͻ����*/
call LMConfig_U_ByInfoInsert (2,3,13)
/
call LMInfo_Insert (105,17648,'/images_face/ecologyFace_2/LeftMenuIcon/CRMWatch.gif','',2,3,13,4) 
/
/*�ͻ���ز˵�·��*/
update leftmenuInfo set linkAddress='/system/systemmonitor/crm/CustomerMonitor.jsp' where id=105
/
/*�ͻ�����*/
call LMConfig_U_ByInfoInsert (2,3,14)
/
call LMInfo_Insert (106,18038,'/images_face/ecologyFace_2/LeftMenuIcon/CRMImport.gif','',2,3,14,4) 
/
/*�ͻ�����˵�·��*/
UPDATE LeftMenuInfo SET linkAddress='/CRM/CrmExcelToDB.jsp' where id=106
/



/*==============================�ҵ�����==============================*/


/*==============================�ҵ���Ŀ==============================*/


/*==============================�ҵ��ʲ�==============================*/


/*==============================�ҵĻ���==============================*/


/*==============================�ҵ�ͨ��==============================*/
/*�ҵ�ͨ��*/
call LMConfig_U_ByInfoInsert (1,NULL,9)
/
call LMInfo_Insert (107,18033,NULL,NULL,1,NULL,9,9)
/
UPDATE LeftMenuInfo SET iconurl='/images_face/ecologyFace_2/LeftMenuIcon/MyContact.gif' WHERE id=107
/
/*�ҵ��ʼ������ҵ�ͨ��*/
update LeftMenuInfo SET parentId=107 where id=10
/
update leftMenuInfo SET menuLevel=3 where parentId=10
/

/*�ҵĶ���*/
Update LeftMenuInfo SET parentid=107 WHERE id=77
/
UPDATE LeftMenuInfo SET iconurl='/images_face/ecologyFace_2/LeftMenuIcon/MyNote.gif' WHERE id=77
/



/*==============================�ҵı���==============================*/
/* �ҵı��� */
call LMConfig_U_ByInfoInsert (1,NULL,12)
/
call LMInfo_Insert (110,18040,NULL,NULL,1,NULL,12,9)
/

/**/
update leftmenuInfo set linkAddress='javascript:void(0)' where id=95 or id=96 or id=97 or id=98 or id=10 or id=108
/
