UPDATE SystemTemplate SET menubtnFontColor='#FFFFFF' WHERE id=1
GO

EXECUTE MMConfig_U_ByInfoInsert 11,15
GO
EXECUTE MMInfo_Insert 428,18022,'ģ��ά��','/systeminfo/template/templateList.jsp','mainFrame',11,1,15,0,'',0,'',0,'','',0,'','',9
GO

EXECUTE MMConfig_U_ByInfoInsert 11,15
GO
EXECUTE MMInfo_Insert 429,18024,'��¼ҳģ��','/systeminfo/template/LoginTemplateFrame.jsp','mainFrame',11,1,15,0,'',0,'',0,'','',0,'','',9
GO

/*������Ϣ*/
EXECUTE LMConfig_U_ByInfoInsert 1,NULL,5
GO
EXECUTE LMInfo_Insert 115,18121,NULL,NULL,1,NULL,5,3
GO
UPDATE LeftMenuInfo SET parentId=111 WHERE id=115
GO
/*���Ź���*/
EXECUTE LMConfig_U_ByInfoInsert 2,111,2
GO
EXECUTE LMInfo_Insert 118,18124,'/images_face/ecologyFace_2/LeftMenuIcon/NewsBulletin.gif','javascript:void(0);',2,111,2,1 
GO
/*���ϵ���*/
EXECUTE LMConfig_U_ByInfoInsert 2,111,3
GO
EXECUTE LMInfo_Insert 119,17599,'/images_face/ecologyFace_2/LeftMenuIcon/Invest.gif','javascript:void(0);',2,111,3,1 
GO




UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/CheckTask.gif' WHERE id=38
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/CheckProject.gif' WHERE id=37
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/NewProject.gif' WHERE id=35
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/SearchProject.gif' WHERE id=41
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/ProjectPerform.gif' WHERE id=36
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/CurrentTask.gif' WHERE id=39
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/OverdueTask.gif' WHERE id=40
GO
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyMail.gif' WHERE id=10
GO



UPDATE LeftMenuInfo SET parentId=11,menuLevel=3 WHERE id=77
GO
UPDATE LeftMenuInfo SET parentId=11,menuLevel=3 WHERE id=79
GO
UPDATE LeftMenuInfo SET parentId=11,menuLevel=3 WHERE id=78
GO
/*���� LeftMenuInfo ��ĸ��ģ����������û� LeftMenuConfig ������Ϣ*/
ALTER TRIGGER Tri_ULeftMenuConfig_ByInfo ON LeftMenuInfo
FOR INSERT, UPDATE, DELETE 
AS
Declare @id_1 int,
        @defaultIndex_1 int,
        @countdelete   int,
        @countinsert   int,
        @userId int,
	@isCustom char(1)


SELECT @countdelete = count(*) FROM deleted
SELECT @countinsert = count(*) FROM inserted

/*����ʱ @countinsert >0 AND @countdelete = 0 */
/*ɾ��ʱ @countinsert =0 */
/*����ʱ @countinsert >0 AND @countdelete > 0 */

/*����*/
IF (@countinsert > 0 AND @countdelete = 0) BEGIN

    SELECT @id_1 = id , @defaultIndex_1 = defaultIndex, @isCustom=isCustom FROM inserted

    if(@isCustom<>'1') BEGIN
	    /*ϵͳ����Ա*/
	    DECLARE hrmResourcemanager_cursor CURSOR FOR
	    SELECT id FROM HrmResourceManager order by id
	
	    OPEN hrmResourcemanager_cursor
	    FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId
	
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(@userId,@id_1,1,@defaultIndex_1)
	        FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId
	    END
	    CLOSE hrmResourcemanager_cursor
	    DEALLOCATE hrmResourcemanager_cursor
	
	    /*�û�*/    
	    DECLARE hrmResource_cursor CURSOR FOR
	    SELECT id FROM HrmResource order by id
	
	    OPEN hrmResource_cursor
	    FETCH NEXT FROM hrmResource_cursor INTO @userId
	
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(@userId,@id_1,1,@defaultIndex_1)
	        FETCH NEXT FROM hrmResource_cursor INTO @userId
	    END
	    CLOSE hrmResource_cursor
	    DEALLOCATE hrmResource_cursor
     end
END

/*ɾ��*/
IF (@countinsert = 0) BEGIN

    SELECT @id_1 = id FROM deleted
    
    DELETE FROM LeftMenuConfig WHERE infoId = @id_1
END

GO


INSERT INTO HtmlLabelIndex values(18024,'��¼ҳģ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18024,'��¼ҳģ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18024,'LoginTemplate',8) 
GO

INSERT INTO HtmlLabelIndex values(18121,'������Ϣ') 
GO
INSERT INTO HtmlLabelIndex values(18124,'���Ź���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18121,'������Ϣ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18121,'RemindInfo',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18124,'���Ź���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18124,'NewsBulletin',8) 
GO


UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyReport.gif' WHERE id=110
GO


UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/FinReport.gif' WHERE id=205
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/ProjReport.gif' WHERE id=202
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MsgReport.gif' WHERE id=210
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/CRMReport.gif' WHERE id=204
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/LgcReport.gif' WHERE id=206
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/DataCenterReport.gif' WHERE id=209
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/WorkflowReport.gif' WHERE id=203
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/DOCReport.gif' WHERE id=207
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/HRMReport.gif' WHERE id=200
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MeetingReport.gif' WHERE id=208
GO
ALTER TABLE SystemLoginTemplate ALTER COLUMN imageId VARCHAR(100) null
GO
INSERT INTO SystemLoginTemplate (LoginTemplateName,loginTemplateTitle,templateType,isCurrent) VALUES ('EcologyĬ�ϵ�¼ҳģ��V','��΢Эͬ����ϵͳ','V','0')
GO
INSERT INTO SystemLoginTemplate (LoginTemplateName,loginTemplateTitle,templateType,isCurrent) VALUES ('EcologyĬ�ϵ�¼ҳģ��H','��΢Эͬ����ϵͳ','H','1')
GO

UPDATE LeftMenuInfo SET parentId=107 WHERE id=11
GO

UPDATE MainMenuInfo SET linkAddress='/systeminfo/template/loginTemplateList.jsp' WHERE id=429
GO

UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyNote.gif' WHERE id=11
GO

/*���ϵͳ���ò˵�*/
EXECUTE LMConfig_U_ByInfoInsert 1,NULL,18
GO
EXECUTE LMInfo_Insert 114,774,NULL,NULL,1,NULL,18,9
GO

UPDATE LeftMenuInfo SET linkAddress='javascript:void(0);' WHERE id=11
GO




INSERT INTO HtmlLabelIndex values(18168,'��Ա������־') 
GO
INSERT INTO HtmlLabelInfo VALUES(18168,'��Ա������־',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18168,'UserLoginLog',8) 
GO

INSERT INTO HtmlLabelIndex values(18180,'�ͻ�������־') 
GO
INSERT INTO HtmlLabelInfo VALUES(18180,'�ͻ�������־',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18180,'CRMLoginLog',8) 
GO

/*ϵͳ��־*/
EXECUTE MMConfig_U_ByInfoInsert 10,8
GO
EXECUTE MMInfo_Insert 444,775,'ϵͳ��־','','',10,1,8,0,'',0,'',0,'','',0,'','',9
GO
UPDATE MainMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/SysReport.gif',linkAddress='javascript:void(0);' WHERE id=444
GO
/*�ĵ�������־*/
UPDATE MainMenuInfo SET defaultParentId=444 WHERE id=23
GO
/*��Ա������־*/
UPDATE MainMenuInfo SET defaultParentId=444,labelId=18168 WHERE id=211
GO
/*�ͻ�������־*/
EXECUTE MMConfig_U_ByInfoInsert 444,1
GO
EXECUTE MMInfo_Insert 447,18180,'�ͻ�������־','/CRM/report/CRMLoginLogRp.jsp','mainFrame',444,2,1,0,'',0,'',0,'','',0,'','',4
GO
/*����˳��*/
UPDATE MainMenuInfo SET defaultIndex=1 WHERE id=23
GO
UPDATE MainMenuInfo SET defaultIndex=2 WHERE id=447
GO
UPDATE MainMenuInfo SET defaultIndex=3 WHERE id=211
GO
/*������˵�˳��*/
UPDATE LeftMenuInfo SET defaultIndex=1 WHERE id=94
GO
UPDATE LeftMenuInfo SET defaultIndex=2 WHERE id=111
GO
UPDATE LeftMenuInfo SET defaultIndex=3 WHERE id=80
GO
UPDATE LeftMenuInfo SET defaultIndex=4 WHERE id=1
GO
UPDATE LeftMenuInfo SET defaultIndex=5 WHERE id=2
GO
UPDATE LeftMenuInfo SET defaultIndex=6 WHERE id=3
GO
UPDATE LeftMenuInfo SET defaultIndex=7 WHERE id=5
GO
UPDATE LeftMenuInfo SET defaultIndex=8 WHERE id=4
GO
UPDATE LeftMenuInfo SET defaultIndex=9 WHERE id=7
GO
UPDATE LeftMenuInfo SET defaultIndex=10 WHERE id=6
GO
UPDATE LeftMenuInfo SET defaultIndex=11 WHERE id=107
GO
UPDATE LeftMenuInfo SET defaultIndex=12 WHERE id=110
GO
UPDATE LeftMenuInfo SET defaultIndex=13 WHERE id=114
GO



/*�ҵ��ղ�*/
DELETE FROM LeftMenuInfo WHERE id=116
GO
/*�ⲿ�鱨*/
DELETE FROM LeftMenuInfo WHERE id=117
GO
/*������Ϣ*/
DELETE FROM LeftMenuInfo WHERE id=115
GO
/*�ҵ�Ŀ��*/
DELETE FROM LeftMenuInfo WHERE id=95
GO
/*�ҵĿ���*/
DELETE FROM LeftMenuInfo WHERE id=96
GO
/*�ҵļƻ�*/
DELETE FROM LeftMenuInfo WHERE id=8
GO
/*�ҵı���*/
DELETE FROM LeftMenuInfo WHERE id=9
GO

/*����ϵͳ����ͼ��*/
UPDATE leftmenuinfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/SystemSetting.gif' WHERE id=114
GO

/*�򿪼ƻ������棬�ʼ������Ų˵�*/
UPDATE LeftMenuConfig SET visible='1' WHERE infoid BETWEEN 59 AND 79
GO


INSERT INTO HtmlLabelIndex values(18124,'���Ź���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18124,'���Ź���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18124,'NewsBulletin',8) 
GO
update mainmenuinfo set linkaddress='/systeminfo/template/templateFrame.jsp' where id=428
go


/*�ҵĿ�Ƭ*/
UPDATE LeftMenuInfo SET linkAddress='/hrm/resource/HrmResource.jsp' WHERE id=43
GO
/*�ҵ�����*/
UPDATE LeftMenuInfo SET linkAddress='/hrm/search/HrmResourceView.jsp' WHERE id=44
GO
/*��ѵ����*/
UPDATE LeftMenuInfo SET linkAddress='/hrm/resource/HrmResourceTrainRecord.jsp' WHERE id=45
GO
/*��ѵ����*/
UPDATE LeftMenuInfo SET linkAddress='/hrm/resource/HrmResourceTrainRecord.jsp' WHERE id=46
GO
/*�ҵĹ���*/
UPDATE LeftMenuInfo SET linkAddress='/hrm/resource/HrmResourceFinanceView.jsp?isView=1' WHERE id=47
GO
/*���˽���*/
UPDATE LeftMenuInfo SET linkAddress='/hrm/resource/HrmResourceRewardsRecord.jsp' WHERE id=48
GO

/*�½��ƻ�*/
UPDATE LeftMenuInfo SET linkAddress='/workplan/data/WorkPlan.jsp?add=1' WHERE id=59
GO
/*�ҵļƻ�*/
UPDATE LeftMenuInfo SET linkAddress='/workplan/data/WorkPlan.jsp' WHERE id=60
GO