insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (370,7,'��ѵ�滮ά��','��ѵ�滮��ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (370,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (371,7,'��ѵ����ά��','��ѵ������ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (371,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (372,7,'��ѵ��Դά��','��ѵ��Դ��ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (372,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (373,7,'��ѵ�ά��','��ѵ���ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (373,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (374,7,'�ù�����ά��','�ù�������ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (374,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (375,7,'��Ƹ�ƻ�ά��','��Ƹ�ƻ���ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (375,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (381,7,'����ά��','����ά����ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (381,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (383,7,'��ͬ����ά��','��ͬ������ӣ��༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (383,8,'','')
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (384,7,'��ͬά��','��ͬ��ӣ��༭��ɾ��')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (384,8,'','')
/

insert into SystemRights (id,rightdesc,righttype) values (385,'CRM����ά��','0')
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3051,'CRM����ά��','DataCenter:Maintenance',385)
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (385,7,'CRM����ά��','CRM����ά��')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (385,8,'','')
/
insert into SystemRightToGroup (groupid,rightid) values (6,385)
/
insert into SystemRightRoles (rightid,roleid,rolelevel) values (385,8,'1')
/


insert into SystemRights (id,rightdesc,righttype) values (386,'������Դ��������ά��','3')
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3052,'������Դ���������½�','HrmCheckKindAdd:Add',386)
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3053,'������Դ��������༭','HrmCheckKindEdit:Edit',386)
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (386,7,'������Դ��������ά��','������Դ���������½����༭��ɾ��')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (386,8,'','')
/
insert into SystemRightToGroup (groupid,rightid) values (3,386)
/
insert into SystemRightRoles (rightid,roleid,rolelevel) values (386,4,'2')
/

insert into SystemRights (id,rightdesc,righttype) values (387,'������Դ������Ŀά��','3')
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3054,'������Դ������Ŀ�½�','HrmCheckItemAdd:Add',387)
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3055,'������Դ������Ŀ�༭','HrmCheckItemEdit:Edit',387)
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,7,'������Դ������Ŀά��','������Դ������Ŀ�½����༭��ɾ��')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,8,'','')
/
insert into SystemRightToGroup (groupid,rightid) values (3,387)
/
insert into SystemRightRoles (rightid,roleid,rolelevel) values (387,4,'2')
/


update workflow_groupdetail set objid = 5 where groupid = 2 
/

insert into SystemRights (id,rightdesc,righttype) values (388,'������Դ����ʵʩά��','3')
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3056,'������Դ����ʵʩά��','HrmCheckInfo:Maintenance',388)
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (388,7,'������Դ����ʵʩά��','������Դ����ʵʩά��')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (388,8,'','')
/
insert into SystemRightToGroup (groupid,rightid) values (3,388)
/
insert into SystemRightRoles (rightid,roleid,rolelevel) values (388,4,'2')
/


insert into SystemRights (id,rightdesc,righttype) values (389,'�ʼ�ģ��ά��','3')
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3057,'�ʼ�ģ���½�','DocMailMouldEdit:add',389)
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3058,'�ʼ�ģ���½�','DocMailMouldAdd:add',389)
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3059,'�ʼ�ģ��༭','DocMailMouldEdit:Edit',389)
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3060,'�ʼ�ģ��ɾ��','DocMailMouldEdit:Delete',389)
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3061,'�ʼ�ģ����־�鿴','DocMailMould:log',389)
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (389,7,'�ʼ�ģ��ά��','�ʼ�ģ���½����༭��ɾ������־�鿴')
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (389,8,'','')
/
insert into SystemRightToGroup (groupid,rightid) values (2,389)
/
insert into SystemRightRoles (rightid,roleid,rolelevel) values (389,3,'2')
/
