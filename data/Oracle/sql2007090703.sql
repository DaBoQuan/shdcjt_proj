Delete hpbaseelement where id=25
/
Delete hpWhereElement where id=25
/
Delete hpextelement where id=25
/
insert into hpbaseelement (id,elementtype,title,logo,perpage,linkmode,moreurl,elementdesc)
values(25,2,'�ĵ�����','/images/homepage/element/DocContent.gif',-1,1,'getDoccontentMore','���԰��ĵ�������ʾ������Ԫ��')
/
insert into hpWhereElement(id,elementid,settingshowmethod,getwheremethod) 
values (25,25,'getDoccontentSettingStr','')
/
insert into hpextelement(id,extsettinge,extopreate,extshow,description)
values(25,'','','DocContent.jsp','��ʾ�ĵ�����')
/
