Delete from MainMenuInfo where id=1148
/
call MMConfig_U_ByInfoInsert(1047,3)
/
call MMInfo_Insert(1148,28171,'΢��ģ������','/blog/BlogTemplateSetting.jsp','',1047,2,3,0,'',0,'',0,'','',0,'','',9)
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42554,'΢��ģ������','blog:templateSetting',1141) 
/

Delete from MainMenuInfo where id=1159
/
call MMConfig_U_ByInfoInsert (1047,4)
/
call MMInfo_Insert (1159,28205,'΢��ָ������','/blog/specified/blogSpecifiedShare.jsp','',1047,2,4,0,'',0,'',0,'','',0,'','',9)
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (42565,'΢��ָ������','blog:specifiedShare',1141) 
/