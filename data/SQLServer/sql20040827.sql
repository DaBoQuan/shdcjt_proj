/*������������������'�ջ�����ʹ�����'�ֶΣ���ƽ*/
INSERT INTO HtmlLabelIndex values(17546,'�ջ�����ʹ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17546,'�ջ�����ʹ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17546,'blank meeting room use case',8) 
GO

INSERT INTO workflow_browserurl 
	(id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl)
VALUES 	( 118,17546,'','\meeting\maint\blankMeentingRoomBrowser.jsp','','','','')
go

INSERT INTO workflow_billfield 
	( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) 
VALUES 	(85,'viewMeetRoomUseCase',2193,'varchar(100)',3,118,10,0)
go
alter  TABLE Bill_Meeting add  viewMeetRoomUseCase varchar(100)
go