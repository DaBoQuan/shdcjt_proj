Delete HtmlLabelIndex where id=20288
GO
Delete HtmlLabelInfo where indexid=20288
GO
INSERT INTO HtmlLabelIndex values(20288,'�·�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20288,'�·�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20288,'New Back Workflow',8) 
GO
insert into hpbaseelement (id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc)
values(21,1,'�·�������','/images/homepage/element/Nbw.gif',5,2,'getNewBackWorkflow','��ѯ��ǰ�������ύ��,����δ�鿴��ǩ�����������')
GO
insert into hpWhereElement(id,elementid,settingshowmethod,getwheremethod) 
values (21,21,'getNewBackWorkflow_mSettingStr','')
go

INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 56,21,'229','requestname','0','getRequestNewLink','*','','','1',1)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 57,21,'882','creater','0','getHrmStr','50','','','0',2)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 58,21,'17994','receivedate','1','','76','','','0',3)
GO
INSERT INTO hpFieldElement( id,elementid,fieldname,fieldColumn,isDate,transMethod,fieldwidth,linkurl,valuecolumn,isLimitLength,ordernum) 
VALUES ( 59,21,'18002','receivetime','1','','62','','','0',4)
GO


insert into hpSqlElement(elementid,sppbmethod)
values (21,'getNewBackWorkflowSppb')
GO