Delete hpbaseelement where id=25
GO
Delete hpWhereElement where id=25
GO
Delete hpextelement where id=25
GO
insert into hpbaseelement (id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc)
values(25,2,'�ĵ�����','/images/homepage/element/DocContent.gif',-1,1,'getDoccontentMore','���԰��ĵ�������ʾ������Ԫ��')
GO
insert into hpWhereElement(id,elementid,settingshowmethod,getwheremethod) 
values (25,25,'getDoccontentSettingStr','')
GO
insert into hpextelement(id,extsettinge,extopreate,extshow,description)
values(25,'','','DocContent.jsp','��ʾ�ĵ�����')
GO
