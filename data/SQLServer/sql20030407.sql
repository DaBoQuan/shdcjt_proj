alter table license add software varchar(20) default 'ALL'
go

update license set software='ALL'
go

update workflow_browserurl set columname = 'lastname' where id = '1'
go

update workflow_browserurl set columname = 'lastname' where id = '17'
go

insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��˾���',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��˾�ƶ�',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��������',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('����',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��˾�ļ�',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('�����ļ�',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��������',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��Դ֧��',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('Ա��ɳ��',0,2)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('���Ź���',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��ҵ���',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('ϵͳʹ��',0,1)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��˾֪ʶ��',0,3)
GO
insert into DocMainCategory (categoryname,categoryiconid,categoryorder) values ('��������',0,3)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (1,'�ɳ��㼣',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (1,'���¼�',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (1,'�滮��ͼ',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (2,'��ҵ����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (2,'��֯�ṹ',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (3,'�����ƶ�',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (4,'����ְ��',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (4,'��λְ��',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (5,'��������',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (6,'�ⲿ����',0,'1','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',31)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (7,'��˾����',0,'1','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',31)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (8,'��˾����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (9,'��˾����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (10,'�ɹ���ͬ',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (10,'���ۺ�ͬ',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (11,'����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (12,'��������',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (13,'�칫����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (14,'��Ϣ�ο�',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (15,'���ɷ���',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (16,'��˾��ѵ',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (17,'����Ӳֿ�',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (18,'����ָ��',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (19,'������ʾ',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (20,'��Ѷ�����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (21,'���������',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (22,'��Ա��ָ��',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (23,'ҵ�����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (24,'ս�Թ滮',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (25,'��Ⱦ�ӪĿ��',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (26,'��Ӫ����',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (27,'ϵͳʹ�ù淶',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (28,'ϵͳ���ܽ���',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (29,'��ҵ��̬',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (30,'���¼���',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (31,'��ҵ��Ϣ',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (32,'����ʱ��',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSecCategory (subcategoryid,categoryname,docmouldid,publishable,replyable,shareable,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3,hasaccessory,accessorynum,hasasset,assetlabel,hasitems,itemlabel,hashrmres,hrmreslabel,hascrm,crmlabel,hasproject,projectlabel,hasfinance,financelabel,approveworkflowid) values (33,'̸��˵��',0,'0','1','1','0',10,0,10,0,10,0,'0',0,'0',0,'0','1',2,' ','',' ','','1','',' ','',' ','',' ','',0)
GO
insert into DocSubCategory (maincategoryid,categoryname) values (1,'��ʷ��չ')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (1,'��ҵ�Ļ�')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (2,'�����ƶ�')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (2,'����ְ��')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (3,'��������')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (4,'�ⲿ����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (4,'��˾����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (5,'��˾����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (5,'��˾����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (6,'��ͬЭ��')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (6,'����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (7,'��������')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (8,'�칫����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (8,'��Ϣ�ο�')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (8,'���ɷ���')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (8,'��˾��ѵ')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (9,'����Ӳֿ�')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (9,'����ָ��')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (9,'������ʾ')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (9,'��Ѷ�����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (9,'���������')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (9,'��Ա��ָ��')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (10,'ҵ�����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (10,'ս�Թ滮')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (11,'��Ⱦ�ӪĿ��')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (11,'��Ӫ����')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (12,'ϵͳʹ�ù淶')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (12,'ϵͳ���ܽ���')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (13,'��ҵ��̬')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (13,'���¼���')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (13,'��ҵ��Ϣ')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (14,'����ʱ��')
GO
insert into DocSubCategory (maincategoryid,categoryname) values (14,'̸��˵��')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (1,1,1,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (1,1,1,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (2,1,1,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (2,1,1,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (3,1,1,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (4,1,2,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (4,1,2,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (5,1,2,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (5,1,2,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (7,2,4,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (7,2,4,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (8,2,4,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (8,2,4,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (9,3,5,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (9,3,5,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (11,4,7,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (11,4,7,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (14,6,10,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (14,6,10,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (15,6,10,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (15,6,10,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (16,6,11,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (16,6,11,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (17,7,12,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (17,7,12,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (18,8,13,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (18,8,13,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (19,8,14,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (19,8,14,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (22,9,17,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (22,9,17,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (23,9,18,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (23,9,18,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (24,9,19,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (24,9,19,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (27,9,22,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (27,9,22,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (28,10,23,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (28,10,23,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (29,10,24,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (29,10,24,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (32,12,27,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (32,12,27,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (34,13,29,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (34,13,29,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (35,13,30,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (35,13,30,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (37,14,32,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (37,14,32,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (38,14,33,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (38,14,33,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (3,1,1,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (6,2,3,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (6,2,3,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (10,4,6,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (10,4,6,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (12,5,8,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (12,5,8,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (13,5,9,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (13,5,9,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (20,8,15,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (20,8,15,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (21,8,16,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (21,8,16,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (25,9,20,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (25,9,20,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (26,9,21,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (26,9,21,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (30,11,25,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (30,11,25,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (31,11,26,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (31,11,26,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (33,12,28,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (33,12,28,2,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (36,13,31,1,'0')
GO
insert into DocUserCategory (secid,mainid,subid,userid,usertype) values (36,13,31,2,'0')
GO

/* 2003 �� 3 �� 28�� Ϊ������Դ����ģ�� */

drop table HrmSalaryItem
GO

/*������Ŀ��*/
CREATE TABLE HrmSalaryItem  (           
id	int IDENTITY (1, 1) NOT NULL primary key,
itemname	varchar(50) ,               /*����������*/
itemcode  varchar(50) ,                 /*���������*/
itemtype  char(1),                     
/* ��Ŀ���� 
1:����
2:����
3:˰��
4:����
*/
personwelfarerate   int ,               /*�������˷���*/
companywelfarerate    int ,             /*������˾����*/
taxrelateitem          int ,            /*˰�ջ�׼��Ŀ*/
amountecp             varchar(200),     /*���㹫ʽ*/
feetype             int ,               /*��������*/
isshow	char(1) default '1',            /*�Ƿ���ʾ*/
showorder	int default 1 ,             /*��ʾ˳��*/
ishistory  Char(1) default '0'            /*�Ƿ��¼��ʷ�䶯*/
)
GO

drop table HrmSalaryRank
GO

/*������Ŀ�ȼ���(����,�����ȼ�)*/
create table  HrmSalaryRank (
id	int IDENTITY (1, 1) NOT NULL  primary key,
itemid  int ,                           /*������Ŀid*/
jobid   int ,                           /*��λid*/
joblevelfrom  int ,                     /*�����*/
joblevelto    int ,                     /*����*/
amount  decimal(10,2)                   /*�ܽ��*/
)
GO

drop table HrmSalaryRate
GO

/*˰�ջ�׼��*/
create table HrmSalaryTaxbench (
id	int IDENTITY (1, 1) NOT NULL  primary key,
itemid    int,                          /*������Ŀid*/
cityid    int,                          /*����id*/
taxbenchmark  int                       /*˰�ջ�׼*/
)
GO

/*˰��˰�ʼ����*/
create table HrmSalaryTaxrate (
id	int IDENTITY (1, 1) NOT NULL  primary key,
benchid  int ,                          /*��׼id*/
ranknum  int ,                          /*����*/
ranklow  int ,                          /*��˰���� ��*/
rankhigh int ,                          /*��˰���� ��*/
taxrate  int                            /*˰��*/
)
GO


create table HrmSalaryChange (
id	int IDENTITY (1, 1) NOT NULL  primary key,
multresourceid  varchar(255) ,                  /*��������*/
itemid          int ,                           /*������Ŀ*/               
changedate  char(10) ,                          /*��������*/
changetype  char(1) ,                           /*��������*/
salary      decimal(10,2) ,                     /*�������*/
changeresion  text,                             /*����ԭ��*/
changeuser    int                               /*������*/
)
GO

create NONCLUSTERED INDEX HrmSalaryChange_multresid_in on HrmSalaryChange(multresourceid)
GO

drop table HrmSalaryResult
GO

create table HrmSalaryPay (
id	int IDENTITY (1, 1) NOT NULL  primary key,
paydate 	varchar(7),
isvalidate int default 0
)
GO

create table HrmSalaryPaydetail (
payid   int ,
itemid	varchar(6),
hrmid	int,
salary	decimal(12,2) default 0
)
GO

create NONCLUSTERED INDEX HrmSalaryPaydetail_payid_in on HrmSalaryPaydetail(payid)
GO
create NONCLUSTERED INDEX HrmSalaryPaydetail_hrmid_in on HrmSalaryPaydetail(hrmid)
GO

alter PROCEDURE HrmSalaryItem_Insert
	(@itemname_1 	varchar(50),
	 @itemcode_2 	varchar(50),
	 @itemtype_3 	char(1),
	 @personwelfarerate_4 	int,
	 @companywelfarerate_5 	int,
	 @taxrelateitem_6 	int,
	 @amountecp_7 	varchar(200),
	 @feetype_8 	int,
	 @isshow_9 	char(1),
	 @showorder_10 	int,
	 @ishistory_11 	char(1),
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryItem 
	 (itemname,
	 itemcode,
	 itemtype,
	 personwelfarerate,
	 companywelfarerate,
	 taxrelateitem,
	 amountecp,
	 feetype,
	 isshow,
	 showorder,
	 ishistory) 
 
VALUES 
	( @itemname_1,
	 @itemcode_2,
	 @itemtype_3,
	 @personwelfarerate_4,
	 @companywelfarerate_5,
	 @taxrelateitem_6,
	 @amountecp_7,
	 @feetype_8,
	 @isshow_9,
	 @showorder_10,
	 @ishistory_11)

select max(id) from HrmSalaryItem
GO



alter PROCEDURE HrmSalaryItem_Update
	(@id_1 	int,
	 @itemname_2 	varchar(50),
	 @itemcode_3 	varchar(50),
	 @itemtype_4 	char(1),
	 @personwelfarerate_5 	int,
	 @companywelfarerate_6 	int,
	 @taxrelateitem_7 	int,
	 @amountecp_8 	varchar(200),
	 @feetype_9 	int,
	 @isshow_10 	char(1),
	 @showorder_11 	int,
	 @ishistory_12 	char(1) ,
     @flag          integer output, 
     @msg           varchar(80) output)

AS 
declare @olditemtype_1 char(1) 
declare @benchid_1 int

select @olditemtype_1 = itemtype from HrmSalaryItem where id = @id_1 
UPDATE HrmSalaryItem 
SET  itemname	 = @itemname_2,
	 itemcode	 = @itemcode_3,
	 itemtype	 = @itemtype_4,
	 personwelfarerate	 = @personwelfarerate_5,
	 companywelfarerate	 = @companywelfarerate_6,
	 taxrelateitem	 = @taxrelateitem_7,
	 amountecp	 = @amountecp_8,
	 feetype	 = @feetype_9,
	 isshow	 = @isshow_10,
	 showorder	 = @showorder_11,
	 ishistory	 = @ishistory_12 

WHERE 
	( id	 = @id_1)

if @olditemtype_1 = '1' or @olditemtype_1 = '2'
    delete from HrmSalaryRank where itemid = @id_1
else if @olditemtype_1 = '3'
begin
    declare benchid_cursor cursor for
    select id from HrmSalaryTaxbench where itemid = @id_1 
    open benchid_cursor 
    fetch next from benchid_cursor into @benchid_1
    while @@fetch_status=0
    begin 
        delete from HrmSalaryTaxrate where benchid = @benchid_1
        delete from HrmSalaryTaxbench where id = @benchid_1
        fetch next from benchid_cursor into @benchid_1
    end
    close benchid_cursor deallocate benchid_cursor
end
GO

alter PROCEDURE HrmSalaryItem_Delete
	(@id_1 	int ,
     @flag          integer output, 
     @msg           varchar(80) output)
AS 
declare @olditemtype_1 char(1) 
declare @benchid_1 int
select @olditemtype_1 = itemtype from HrmSalaryItem where id = @id_1 

DELETE HrmSalaryItem 
WHERE ( id	 = @id_1)

if @olditemtype_1 = '1' or @olditemtype_1 = '2'
    delete from HrmSalaryRank where itemid = @id_1
else if @olditemtype_1 = '3'
begin
    declare benchid_cursor cursor for
    select id from HrmSalaryTaxbench where itemid = @id_1 
    open benchid_cursor 
    fetch next from benchid_cursor into @benchid_1
    while @@fetch_status=0
    begin 
        delete from HrmSalaryTaxrate where benchid = @benchid_1
        delete from HrmSalaryTaxbench where id = @benchid_1
        fetch next from benchid_cursor into @benchid_1
    end
    close benchid_cursor deallocate benchid_cursor
end
GO

alter PROCEDURE HrmSalaryRank_Insert
	(@itemid_1 	int,
	 @jobid_2 	int,
	 @joblevelfrom_3 	int,
	 @joblevelto_4 	int,
	 @amount_5 	decimal(10,2),
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryRank 
	 ( itemid,
	 jobid,
	 joblevelfrom,
	 joblevelto,
	 amount) 
 
VALUES 
	( @itemid_1,
	 @jobid_2,
	 @joblevelfrom_3,
	 @joblevelto_4,
	 @amount_5)
GO

CREATE PROCEDURE HrmSalaryTaxbench_Insert
	(@itemid_1 	int,
	 @cityid_2 	int,
	 @taxbenchmark_3 	int,
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryTaxbench 
	 ( itemid,
	 cityid,
	 taxbenchmark) 
 
VALUES 
	( @itemid_1,
	 @cityid_2,
	 @taxbenchmark_3)

select max(id) from HrmSalaryTaxbench
GO

CREATE PROCEDURE HrmSalaryTaxrate_Insert
	(@benchid_1 	int,
	 @ranknum_2 	int,
	 @ranklow_3 	int,
	 @rankhigh_4 	int,
	 @taxrate_5 	int,
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryTaxrate 
	 ( benchid,
	 ranknum,
	 ranklow,
	 rankhigh,
	 taxrate) 
 
VALUES 
	( @benchid_1,
	 @ranknum_2,
	 @ranklow_3,
	 @rankhigh_4,
	 @taxrate_5)
GO


CREATE PROCEDURE HrmSalaryPay_Insert
	(@paydate_1 	varchar(7),
	 @isvalidate_2 	int,
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryPay 
	 ( paydate,
	 isvalidate) 
 
VALUES 
	( @paydate_1,
	 @isvalidate_2)

select max(id) from HrmSalaryPay
GO


CREATE PROCEDURE HrmSalaryPay_Update
	(@id_1 	int,
	 @isvalidate_2 	int,
     @flag          integer output, 
     @msg           varchar(80) output)

AS UPDATE HrmSalaryPay 

SET  isvalidate	 = @isvalidate_2 

WHERE 
	( id	 = @id_1)
GO


CREATE PROCEDURE HrmSalaryPaydetail_Insert
	(@payid_1 	int,
	 @itemid_2 	varchar(6),
	 @hrmid_3 	int,
	 @salary_4 	decimal(10,2),
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryPaydetail 
	 ( payid,
	 itemid,
	 hrmid,
	 salary) 
 
VALUES 
	( @payid_1,
	 @itemid_2,
	 @hrmid_3,
	 @salary_4)
GO


CREATE PROCEDURE HrmSalaryPaydetail_Update
	(@payid_1 	int,
	 @itemid_2 	varchar(6),
	 @hrmid_3 	int,
	 @salary_4 	decimal(10,2),
     @flag          integer output, 
     @msg           varchar(80) output)

AS UPDATE HrmSalaryPaydetail 

SET  salary	 = @salary_4 

WHERE 
	( payid	 = @payid_1 AND
	 itemid	 = @itemid_2 AND
	 hrmid	 = @hrmid_3)
GO


CREATE PROCEDURE HrmSalaryChange_Insert
	(@multresourceid_1 	varchar(255),
	 @itemid_2 	int,
	 @changedate_3 	char(10),
	 @changetype_4 	char(1),
	 @salary_5 	decimal(10,2),
	 @changeresion_6 	text,
	 @changeuser_7 	int,
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryChange 
	 ( multresourceid,
	 itemid,
	 changedate,
	 changetype,
	 salary,
	 changeresion,
	 changeuser) 
 
VALUES 
	( @multresourceid_1,
	 @itemid_2,
	 @changedate_3,
	 @changetype_4,
	 @salary_5,
	 @changeresion_6,
	 @changeuser_7)
GO

CREATE TABLE CRM_SellStatus (
	id int IDENTITY (1, 1) NOT NULL ,
	fullname varchar (50)  NULL ,
	description varchar (150)  NULL 
)
GO

CREATE TABLE CRM_SellChance (
	id int IDENTITY (1, 1) NOT NULL ,
	creater int null,
	subject varchar (50) null,
	customerid int null,
	comefromid int null,
	sellstatusid int null,
	endtatusid char(1) null,
	predate char(10) null,
	preyield decimal(18,2) null,
	currencyid int null,
	probability decimal(8,2) null,
	createdate char(10) null,
	createtime char(8) null,
	content text null,
	approver int default 0,
	approvedate char(10) null,
	approvetime char(10) null,
	approvestatus char(1) default 0
	)
GO

CREATE TABLE CRM_ProductTable(
	sellchanceid int null,
	productid int null,
	assetunitid int null,
	currencyid int null,
	salesprice decimal(12,2) null,
	salesnum int null,
	totelprice decimal(18,2) null
)
GO

 CREATE PROCEDURE CRM_SellStatus_SelectAll 
 (@flag	int	output,
 @msg	varchar(80)	output)
 AS
 SELECT * FROM CRM_SellStatus
GO

 CREATE PROCEDURE CRM_SellStatus_Insert 
 (@fullname 	varchar(50), 
 @description 	varchar(150), 
 @flag	int	output, 
 @msg	varchar(80)	output)  
 AS 
 INSERT INTO 
 CRM_SellStatus 
 ( fullname, description) 
 VALUES ( @fullname, @description) 
GO


 CREATE PROCEDURE CRM_SellStatus_SelectByID 
 (@id 	int, 
 @flag	int	output,
 @msg	varchar(80)	output) 
 AS 
 SELECT * FROM CRM_SellStatus
 WHERE ( id	 = @id)  
GO

CREATE PROCEDURE CRM_SellChance_SByCustomerID
 (
 @id_1 int,
 @flag	int	output,
 @msg	varchar(80)	output)
 AS
 SELECT * FROM CRM_SellChance WHERE customerid =@id_1 order by predate desc 
GO


 CREATE PROCEDURE CRM_SellStatus_Update 
 (@id	 	int, 
 @fullname 	varchar(50),
 @description 	varchar(150),  
@flag	int	output, @msg	varchar(80)	output) 
AS 
UPDATE CRM_SellStatus  
SET  fullname	 = @fullname,
description	 = @description
WHERE ( id	 = @id)   
GO


 CREATE PROCEDURE CRM_SellStatus_Delete 
 (@id 	int,
 @flag	int	output,
 @msg	varchar(80)	output) 
 AS DELETE CRM_SellStatus  WHERE ( id	 = @id) 
 GO


/*���ۻ���*/
CREATE PROCEDURE CRM_SellChance_SelectAll
 (
 @flag	int	output,
 @msg	varchar(80)	output)
 AS
 SELECT * FROM CRM_SellChance 
GO


CREATE PROCEDURE CRM_SellChance_SelectByID
 (
 @id_1 int,
 @flag	int	output,
 @msg	varchar(80)	output)
 AS
 SELECT * FROM CRM_SellChance WHERE id=@id_1
GO


CREATE PROCEDURE CRM_SellChance_insert
(
	@creater_1 int ,
	@subject_1 varchar (50) ,
	@customerid_1 int ,
	@comefromid_1 int ,
	@sellstatusid_1 int ,
	@endtatusid_1 char(1) ,
	@predate_1 char(10) ,
	@preyield_1 decimal(18,2) ,
	@currencyid_1 int ,
	@probability_1 decimal(8,2) ,
	@createdate_1 char(10) ,
	@createtime_1 char(8) ,
	@content_1 text ,
	@flag	int	output,
	@msg	varchar(80)	output)
as
insert INTO CRM_SellChance
(
	creater ,
	subject ,
	customerid ,
	comefromid ,
	sellstatusid ,
	endtatusid ,
	predate ,
	preyield ,
	currencyid ,
	probability ,
	createdate ,
	createtime ,
	content )
	values
	(
	@creater_1  ,
	@subject_1  ,
	@customerid_1  ,
	@comefromid_1  ,
	@sellstatusid_1  ,
	@endtatusid_1  ,
	@predate_1  ,
	@preyield_1  ,
	@currencyid_1  ,
	@probability_1 ,
	@createdate_1  ,
	@createtime_1  ,
	@content_1 )
GO


CREATE PROCEDURE CRM_SellChance_SMAXID
 (
 @flag	int	output,
 @msg	varchar(80)	output)
 AS
 SELECT max(id) as sellchanceid FROM CRM_SellChance 
GO


CREATE PROCEDURE CRM_ProductTable_insert
(
	@sellchanceid_1 int ,
	@productid_1 int ,
	@assetunitid_1 int ,
	@currencyid_1 int ,
	@salesprice_1 decimal(12,2) ,
	@salesnum_1 int ,
	@totelprice_1 decimal(18,2) ,
	@flag	int	output,
	@msg	varchar(80)	output)
as
insert INTO CRM_ProductTable
(
	sellchanceid ,
	productid ,
	assetunitid,
	currencyid ,
	salesprice ,
	salesnum,
	totelprice )
	values
(
	@sellchanceid_1  ,
	@productid_1  ,
	@assetunitid_1  ,
	@currencyid_1  ,
	@salesprice_1 ,
	@salesnum_1  ,
	@totelprice_1 
	)
GO


CREATE PROCEDURE CRM_Product_SelectByID
 (
 @id_1 int,
 @flag	int	output,
 @msg	varchar(80)	output)
 AS
 SELECT * FROM CRM_ProductTable WHERE sellchanceid =@id_1
GO




CREATE PROCEDURE CRM_SellChance_Update
(
	@creater_1 int ,
	@subject_1 varchar (50) ,
	@customerid_1 int ,
	@comefromid_1 int ,
	@sellstatusid_1 int ,
	@endtatusid_1 char(1) ,
	@predate_1 char(10) ,
	@preyield_1 decimal(18,2) ,
	@currencyid_1 int ,
	@probability_1 decimal(8,2) ,
	@content_1 text ,
	@id_1 int,
	@flag	int	output,
	@msg	varchar(80)	output)
as
update CRM_SellChance set

	creater = @creater_1,
	subject = @subject_1,
	customerid =@customerid_1,
	comefromid =@comefromid_1,
	sellstatusid=@sellstatusid_1 ,
	endtatusid =@endtatusid_1,
	predate=@predate_1 ,
	preyield =@preyield_1,
	currencyid =@currencyid_1,
	probability =@probability_1,
	content= @content_1
WHERE id=@id_1
GO


CREATE PROCEDURE CRM_Product_Delete
(
	@id_1 int,
	@flag	int	output,
	@msg	varchar(80)	output)
as 
delete CRM_ProductTable WHERE sellchanceid=@id_1
GO


CREATE PROCEDURE CRM_SellChance_Delete
(
	@id_1 int,
	@flag	int	output,
	@msg	varchar(80)	output)
as 
delete CRM_SellChance WHERE id=@id_1
GO

CREATE PROCEDURE CRM_SellChance_Statistics
(
	@flag	int	output,
	@msg	varchar(80)	output)
as
declare
@result_1 int,
@sucess_1 int,
@failure_1 int,
@nothing_1 int

create table #temp( result  int , sucess  int, failure	int, nothing	int)
select @result_1= count(*) from CRM_SellChance 
select @sucess_1= count(id)  from CRM_SellChance  WHERE endtatusid ='1'
select @failure_1= count(id)  from CRM_SellChance WHERE endtatusid ='2'
select @nothing_1= count(id)  from  CRM_SellChance WHERE endtatusid ='0'
insert INTO #temp(result,sucess,failure,nothing) values(@result_1,@sucess_1,@failure_1,@nothing_1)
select * from #temp
go

insert into HtmlLabelInfo (indexid,labelname,languageid) values (2227,'',8)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (2227,'���ۻ���',7)
GO
insert into HtmlLabelIndex (id,indexdesc) values (2227,'���ۻ���')
go


create table HrmContractTemplet
(id int identity(1,1) not null,
 templetname varchar(200) null,
 templetdocid int null)
go

create table HrmContractType
(id int identity(1,1) not null,
 typename varchar(200) null,
 contracttempletid int null,
 saveurl varchar(200) null,
 ishirecontract char(1) null,
 remindaheaddate int null,
 remindman varchar(200)
 )
go

create table HrmContract
(id int identity(1,1) not null,
 contractname varchar(200) null,
 contractman int null,
 contracttypeid int null,
 contractstartdate char(10) null,
 contractenddate char(10) null,
 contractdocid int null)
go

alter table HrmTrainType add
 typecontent text null,
 typeaim text null,
 typedocurl varchar(200) null,
 typetesturl varchar(200) null,
 typeoperator varchar(200) null
go

create table HrmTrainLayout
(id int identity(1,1) not null,
 layoutname varchar(60) null,
 typeid int null,
 layoutstartdate char(10) null,
 layoutenddate char(10) null,
 layoutcontent text null,
 layoutaim text null,
 layouttestdate char(10) null,
 layoutassessor varchar(200))
go

create table HrmTrainLayoutAssess
(id int identity(1,1) not null,
 layoutid int null,
 assessorid int null,
 assessdate char(10) null,
 implement char(1) null,
 explain text null,
 advice text null)
go

create table HrmTrainPlan
(id int identity(1,1) not null,
 planname varchar(60) null,
 layoutid int null,
 planorganizer varchar(200) null,
 planstartdate char(10) null,
 planenddate char(10) null,
 plancontent text null,
 planaim text null,
 planaddress varchar(200) null,
 planresource varchar(200) null,
 planactor text null,
 planbudget float null,
 planbudgettype char(1) null,
 openrange varchar(200) null,
 createrid int null,
 createdate char(10) null)
go

create table HrmTrainPlanDay
(id int identity(1,1) not null,
 planid int null,
 plandate char(10) null,
 plandaycontent text null,
 plandayaim text null)
go

create table HrmTrain
(id int identity(1,1) not null,
 name varchar(200) null,
 planid int null,
 organizer varchar(200) null,
 startdate char(10) null,
 enddate char(10) null,
 content text null,
 aim text null,
 resource_n varchar(200) null,
 address varchar(200) null,
 testdate char(10) null,
 createrid int null,
 summarizer int null,
 summarizedate char(10) null,
 fare float null,
 faretype int null,
 advice text null)
go

alter table HrmContract add
  proenddate char(10) null
go

alter table HrmLanguageAbility drop
  column createid,
  column createdate,
  column createtime,
  column lastmoderid,
  column lastmoddate,
  column lastmodtime
go


create procedure HrmInfoStatus_Finish
(@id_1 int,
 @flag int output, @msg varchar(60) output)
as update HrmInfoStatus set
  status = 1
where
  hrmid = @id_1
go

create procedure HrmResourceDateCheck
 (@today_1 char(10),
  @flag int output, @msg varchar(60) output)
 as update HrmResource set
   status = 7
 where
    (status = 0 or status = 1 or status = 2 or status = 3) and enddate > @today_1 and enddate <>''
 update HrmResource set
   status = 3
 where
   status = 0 and probationenddate > @today_1
 go

 CREATE PROCEDURE HrmConType_Insert
(@typename_1 varchar(200),
 @contracttempletid_2 int,
 @saveurl_3 varchar(200),
 @ishirecontract_4 char(1),
 @remindaheaddate_5 int,
 @remindman_6 varchar(200),
 @flag int output, @msg varchar(200) output)
AS INSERT HrmContractType
(typename,
 contracttempletid,
 saveurl,
 ishirecontract,
 remindaheaddate,
 remindman)
VALUES
(@typename_1,
 @contracttempletid_2,
 @saveurl_3,
 @ishirecontract_4,
 @remindaheaddate_5,
 @remindman_6)
GO

CREATE PROCEDURE HrmConType_Update
(@id_1 int,
 @typename_2 varchar(200),
 @contracttempletid_3 int,
 @saveurl_4 varchar(200),
 @ishirecontract_5 char(1),
 @remindaheaddate_6 int,
 @remindman_7 varchar(200),
 @flag int output, @msg varchar(200) output)
AS UPDATE HrmContractType SET
 typename = @typename_2,
 contracttempletid = @contracttempletid_3,
 saveurl = @saveurl_4,
 ishirecontract = @ishirecontract_5,
 remindaheaddate = @remindaheaddate_6 ,
 remindman = @remindman_7
WHERE
 id = @id_1
GO

CREATE PROCEDURE HrmConType_Delete
(@id_1 int,
 @flag int output, @msg varchar(60) output)
AS DELETE FROM HrmContractType
WHERE
  id = @id_1
GO





ALTER PROCEDURE HrmTrainType_Update
(@id_1 int,
 @name_2 varchar(60),
 @description_3 varchar(60),
 @typecontent_4 text ,
 @typeaim_5 text ,
 @typedocurl_6 varchar(200) ,
 @typetesturl_7 varchar(200) ,
 @typeoperator_8 varchar(200) ,
 @flag int output, @msg varchar(60) output
 )
AS UPDATE HrmTrainType SET
  name = @name_2,
  description = @description_3,
  typecontent = @typecontent_4,
  typeaim = @typeaim_5,
  typedocurl = @typedocurl_6,
  typetesturl = @typetesturl_7,
  typeoperator = @typeoperator_8
WHERE
  id = @id_1
GO

ALTER PROCEDURE HrmTrainType_Insert
(@name_2 varchar(60),
 @description_3 varchar(60),
 @typecontent_4 text ,
 @typeaim_5 text ,
 @typedocurl_6 varchar(200) ,
 @typetesturl_7 varchar(200) ,
 @typeoperator_8 varchar(200) ,
 @flag int output, @msg varchar(60) output)
AS INSERT HrmTrainType
( name,
  description ,
  typecontent ,
  typeaim ,
  typedocurl ,
  typetesturl,
  typeoperator)
VALUES
( @name_2,
  @description_3,
  @typecontent_4,
  @typeaim_5,
  @typedocurl_6,
  @typetesturl_7,
  @typeoperator_8)
GO

create procedure HrmTrainLayout_Insert
(@layoutname_1 varchar(60),
 @typeid_2 int,
 @layoutstartdate_3 char(10),
 @layoutenddate_4 char(10),
 @layoutcontent_5 text,
 @layoutaim_6 text,
 @layouttestdate_7 char(10),
 @layoutassessor_8 varchar(200),
 @flag int output, @msg varchar(60) output)
as insert HrmTrainLayout
 (layoutname ,
 typeid ,
 layoutstartdate ,
 layoutenddate,
 layoutcontent,
 layoutaim,
 layouttestdate,
 layoutassessor
)
values
(@layoutname_1 ,
 @typeid_2 ,
 @layoutstartdate_3 ,
 @layoutenddate_4 ,
 @layoutcontent_5 ,
 @layoutaim_6 ,
 @layouttestdate_7 ,
 @layoutassessor_8 
 )
go

create procedure HrmTrainLayout_Update
(@layoutname_1 varchar(60),
 @typeid_2 int,
 @layoutstartdate_3 char(10),
 @layoutenddate_4 char(10),
 @layoutcontent_5 text,
 @layoutaim_6 text,
 @layouttestdate_7 char(10),
 @layoutassessor_8 varchar(200),
 @id_9 int,
 @flag int output, @msg varchar(60) output)
as update HrmTrainLayout set
 layoutname = @layoutname_1,
 typeid = @typeid_2,
 layoutstartdate = @layoutstartdate_3,
 layoutenddate = @layoutenddate_4,
 layoutcontent = @layoutcontent_5,
 layoutaim = @layoutaim_6,
 layouttestdate = @layouttestdate_7,
 layoutassessor = @layoutassessor_8
where 
  id = @id_9
go

create procedure HrmTrainLayout_Delete
(@id_1 int,
 @flag int output, @msg varchar(60) output)
as delete from HrmTrainLayout 
where
 id = @id_1
go

create procedure TrainLayoutAssess_Insert
(@layoutid_1 int,
 @assessorid_2 int,
 @assessdate_3 char(10),
 @implement_4 char(1),
 @explain_5 text,
 @advice_6 text,
 @flag int output, @msg varchar(60) output)
as insert into HrmTrainLayoutAssess
(layoutid,
 assessorid,
 assessdate,
 implement,
 explain,
 advice)
values
(@layoutid_1,
 @assessorid_2,
 @assessdate_3,
 @implement_4,
 @explain_5,
 @advice_6)
go

create procedure HrmTrainPlan_Update
(@planname_1 varchar(60),
 @layoutid_2 int,
 @planorganizer_3 varchar(200),
 @planstartdate_4 char(10),
 @planenddate_5 char(10),
 @plancontent_6 text,
 @planaim_7 text,
 @planaddress_8 varchar(200),
 @planresource_9 varchar(200),
 @planactor_10 text,
 @planbudget_11 float,
 @planbudgettype_12 char(1),
 @openrange_13 varchar(200),
 @id_14 int,
 @flag int output , @msg varchar(60) output)
as Update HrmTrainPlan set
 planname = @planname_1,
 layoutid = @layoutid_2,
 planorganizer = @planorganizer_3 ,
 planstartdate = @planstartdate_4,
 planenddate = @planenddate_5,
 plancontent = @plancontent_6,
 planaim = @planaim_7,
 planaddress = @planaddress_8,
 planresource = @planresource_9,
 planactor = @planactor_10,
 planbudget =  @planbudget_11,
 planbudgettype = @planbudgettype_12,
 openrange = @openrange_13
where
(id = @id_14)
go

create procedure HrmTrainPlan_Insert
(@planname_1 varchar(60),
 @layoutid_2 int,
 @planorganizer_3 varchar(200),
 @planstartdate_4 char(10),
 @planenddate_5 char(10),
 @plancontent_6 text,
 @planaim_7 text,
 @planaddress_8 varchar(200),
 @planresource_9 varchar(200),
 @planactor_10 text,
 @planbudget_11 float,
 @planbudgettype_12 char(1),
 @openrange_13 varchar(200),
 @createrid_14 int,
 @createdate_15 char(10),
 @flag int output , @msg varchar(60) output)
as insert HrmTrainPlan 
 (planname,
 layoutid ,
 planorganizer,
 planstartdate,
 planenddate,
 plancontent,
 planaim,
 planaddress,
 planresource,
 planactor,
 planbudget,
 planbudgettype,
 openrange,
 createrid,
 createdate)
values
(@planname_1,
 @layoutid_2,
 @planorganizer_3,
 @planstartdate_4,
 @planenddate_5,
 @plancontent_6,
 @planaim_7,
 @planaddress_8,
 @planresource_9,
 @planactor_10,
 @planbudget_11,
 @planbudgettype_12,
 @openrange_13,
 @createrid_14,
 @createdate_15)
go

create procedure HrmTrainPlan_Delete
(@id_1 int,
 @flag int output, @msg varchar(60) output)
as delete from HrmTrainPlan
where
 id = @id_1
go

create procedure TrainPlanDay_Insert
(@planid_1 int,
 @plandate_2 char(10),
 @plandaycontent_3 text,
 @plandayaim_4 text,
 @flag int output, @msg varchar(60) output)
as insert into HrmTrainPlanDay
(planid,
 plandate,
 plandaycontent,
 plandayaim)
values
(@planid_1,
 @plandate_2,
 @plandaycontent_3,
 @plandayaim_4)
go

create procedure TrainPlanDay_Delete
(@id_1 int,
 @flag int output, @msg varchar(60) output)
as delete from HrmTrainPlanDay
where
 planid = @id_1
go

insert into HtmlLabelIndex (id,indexdesc) values (6084,'�ֳɱ�����')
go
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6084,'�ֳɱ�����',7)
go
insert into HtmlLabelIndex (id,indexdesc) values (6086,'��λ')
go
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6086,'��λ',7)
go
insert into HtmlLabelIndex (id,indexdesc) values (6087,'����')
go
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6087,'����',7)
go
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6087,'Personal',8)
go

 alter PROCEDURE HrmCostcenter_SelectByDeptID 
 @id varchar(100) , 
 @groupby varchar(100) , 
 @flag integer output , @msg varchar(80) output 
 AS if convert(int,@groupby)=1 begin select ccsubcategory1 from HrmCostcenter 
 where departmentid =convert(int, @id) group by ccsubcategory1 end 
 set  @flag = 0 set  @msg = '��ѯ�洢���̳ɹ�' 
GO

 alter PROCEDURE HrmLanguageAbility_Insert 
	(@resourceid_1 	[int],
	 @language_2 	[varchar](30),
	 @level_3 	[char](1),
	 @memo_4 	[text],	 
         @flag integer output,
	 @msg varchar(80) output)
AS INSERT INTO [HrmLanguageAbility] 
	 ( [resourceid],
	 [language],
	 [level_n],
	 [memo]) 
 
VALUES 
	( @resourceid_1,
	 @language_2,
	 @level_3,
	 @memo_4)

GO

create procedure HrmContract_UpdateByHrm
(@id_1 int,
 @startdate_2 char(10),
 @enddate_3 char(10),
 @proenddate_4 char(10),
 @flag int output, @msg varchar(60) output)
as update HrmContract set
 contractstartdate = @startdate_2,
 contractenddate = @enddate_3,
 proenddate = @proenddate_4
where
 contractman = @id_1
go

alter PROCEDURE HrmResourceContactInfo_Update
(@id_1 int, 
 @locationid_15 int, 
 @workroom_16 varchar(60), 
 @telephone_17 varchar(60), 
 @mobile_18 varchar(60),
 @mobilecall_19 varchar(30) , 
 @fax_20 varchar(60), 
 @systemlanguage_21 int,
 @email_22 varchar(60),
 @flag int output, @msg varchar(60) output)
 AS UPDATE HrmResource SET
 locationid =   @locationid_15,
 workroom =   @workroom_16, 
 telephone =   @telephone_17, 
 mobile =   @mobile_18, 
 mobilecall =   @mobilecall_19, 
 fax =   @fax_20,
 email = @email_22,
 systemlanguage = @systemlanguage_21
 WHERE
 id =  @id_1 
 GO

insert into HtmlLabelIndex (id,indexdesc) values (6088,'ת��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6088,'ת��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6088,'Hire',8)
GO


insert into HtmlLabelIndex (id,indexdesc) values (6089,'��ǩ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6089,'��ǩ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6089,'Extend',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6090,'����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6090,'����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6090,'Redeploy',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6091,'��ְ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6091,'��ְ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6091,'Dismiss',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6092,'����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6092,'����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6092,'Retire',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6093,'��Ƹ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6093,'��Ƹ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6093,'Rehire',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6094,'��Ƹ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6094,'��Ƹ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6094,'Fire',8)
GO

create procedure HrmResource_CreateInfo
(@id_1 int,
 @createrid_2 int,
 @createdate_3 char(10),
 @lastmodid_4 int,
 @lastmoddate_5 char(10),
 @flag int output, @msg varchar(60) output)
as update HrmResource set
 createrid = @createrid_2,
 createdate = @createdate_3,
 lastmodid = @lastmodid_4,
 lastmoddate = @lastmoddate_5
where
 id = @id_1
go

create procedure HrmResource_ModInfo
(@id_1 int,
 @lastmodid_2 int,
 @lastmoddate_3 char(10),
 @flag int output, @msg varchar(60) output)
as update HrmResource set
 lastmodid = @lastmodid_2,
 lastmoddate = @lastmoddate_3
where
 id = @id_1
go

insert into HtmlLabelIndex (id,indexdesc) values (6096,'�ܳɱ�����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6096,'�ܳɱ�����',7)
GO

delete HrmSubCompany where companyid != 1
GO
delete HrmCostcenterSubCategory where ccmaincategoryid != 1
GO

create procedure HrmInfoStatus_UpdateSystem
(@id_1 int,
 @flag int output, @msg varchar(60) output)
 as update HrmInfoStatus set
 status = 1
 where 
 itemid = 1 and hrmid = @id_1
 go
 
 create procedure HrmInfoStatus_UpdateFinance
 (@id_1 int,
  @flag int output, @msg varchar(60) output)
 as update HrmInfoStatus set
   status = 1
 where
  itemid = 2 and hrmid = @id_1
 go
 
 create procedure HrmInfoStatus_UpdateCapital
 (@id_1 int,
  @flag int output, @msg varchar(60) output)
 as update HrmInfoStatus set
   status = 1
 where
  itemid = 3 and hrmid = @id_1
 go

  alter PROCEDURE HrmResource_SCountBySubordinat 
 (@id_1 [int], 
  @flag integer output, @msg  varchar(80) output ) 
  AS select count(*) from HrmResource 
  where 
   managerid = @id_1 
   and (status =0 or status = 1 or status =2 or status =3)
  if @@error<>0 begin set @flag=1 set @msg='��ѯ������Դ����������Ϣ�ɹ�' return end else begin set @flag=0 set @msg='��ѯ������Դ����������Ϣʧ��' return end 
GO

alter PROCEDURE HrmResource_SelectByManagerID 
 (@id_1 [int], 
  @flag integer output, @msg varchar(80) output ) 
  AS select * from HrmResource 
  where 
    managerid = @id_1 
    and (status =0 or status = 1 or status =2 or status =3)
  if @@error<>0 begin set @flag=1 set @msg='��ѯ������Դ��Ϣ�ɹ�' return end else begin set @flag=0 set @msg='��ѯ������Դ��Ϣʧ��' return end 
GO
 
 alter PROCEDURE HrmResource_Rehire
(@id_1 int,
 @changedate_2 char(10),
 @changeenddate_3 char(10),
 @changereason_4 char(10),
 @changecontractid_5 int,
 @infoman_6 varchar(255),
 @oldjobtitleid_7 int,
 @type_n_8 char(1),
 @flag int output, @msg varchar(60) output)
AS INSERT INTO HrmStatusHistory 
(resourceid,
 changedate,
 changeenddate,
 changereason,
 changecontractid,
 infoman,
 oldjobtitleid,
 type_n
)
VALUES
(@id_1, 
 @changedate_2,
 @changeenddate_3,
 @changereason_4,
 @changecontractid_5,
 @infoman_6,
 @oldjobtitleid_7 ,
 @type_n_8
 )
UPDATE HrmResource SET 
 startdate = @changedate_2,
 enddate = @changeenddate_3
WHERE
 id = @id_1
GO

alter PROCEDURE HrmResource_Retire
(@id_1 int,
 @changedate_2 char(10),
 @changereason_3 char(10),
 @changecontractid_4 int,
 @infoman_5 varchar(255),
 @oldjobtitleid_7 int,
 @type_n_8 char(1),
 @flag int output, @msg varchar(60) output)
AS INSERT INTO HrmStatusHistory 
(resourceid,
 changedate,
 changereason,
 changecontractid,
 infoman,
 oldjobtitleid,
 type_n)
VALUES
(@id_1, 
 @changedate_2,
 @changereason_3,
 @changecontractid_4,
 @infoman_5,
 @oldjobtitleid_7,
 @type_n_8)
UPDATE HrmResource SET
 enddate = @changedate_2
WHERE
 id = @id_1
GO

alter procedure HrmResource_Dismiss
(@id_1 int,
 @changedate_2 char(10),
 @changereason_3 char(10),
 @changecontractid_4 int,
 @infoman_5 varchar(255),
 @oldjobtitleid_7 int,
 @type_n_8 char(1), 
 @flag int output, @msg varchar(60) output)
AS INSERT INTO HrmStatusHistory 
(resourceid,
 changedate,
 changereason,
 changecontractid,
 infoman,
 oldjobtitleid,
 type_n)
VALUES
(@id_1, 
 @changedate_2,
 @changereason_3,
 @changecontractid_4,
 @infoman_5,
 @oldjobtitleid_7,
 @type_n_8)
UPDATE HrmResource SET 
 enddate = @changedate_2
WHERE
 id = @id_1
GO

alter PROCEDURE HrmResource_Hire
(@id_1 int,
 @changedate_2 char(10),
 @changereason_3 char(10),
 @infoman_5 varchar(255),
 @oldjobtitleid_7 int,
 @type_n_8 char(1),  
 @flag int output, @msg varchar(60) output)
AS INSERT INTO HrmStatusHistory
(resourceid,
 changedate,
 changereason,
 infoman,
 oldjobtitleid,
 type_n  )
VALUES
(@id_1, 
 @changedate_2,
 @changereason_3,
 @infoman_5,
 @oldjobtitleid_7 ,
 @type_n_8   )
GO

alter PROCEDURE HrmResource_Fire
(@id_1 int,
 @changedate_2 char(10),
 @changereason_3 char(10),
 @changecontractid_4 int,
 @infoman_5 varchar(255),
 @oldjobtitleid_7 int,
 @type_n_8 char(1),  
 @flag int output, @msg varchar(60) output)
AS INSERT INTO HrmStatusHistory 
(resourceid,
 changedate,
 changereason,
 changecontractid,
 infoman,
 oldjobtitleid,
 type_n)
VALUES
(@id_1, 
 @changedate_2,
 @changereason_3,
 @changecontractid_4,
 @infoman_5,
 @oldjobtitleid_7 ,
 @type_n_8 )
UPDATE HrmResource SET 
 enddate = @changedate_2
WHERE
 id = @id_1
GO

/* �ͻ���ͬ����ά�� */
CREATE TABLE [CRM_ContractType] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (100)  NULL ,
	[contractdesc] [varchar] (200)  NULL ,
	[workflowid] [int] NULL 
)
GO


/* �ͻ���ͬά�� */
CREATE TABLE [CRM_Contract] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (100)  NULL ,
	[typeId] [int] NULL ,	
	[docId] [int] NULL ,
	[price] [decimal](10, 2) NULL ,
	[crmId] [int] NULL ,
	[contacterId] [int] NULL ,
	[startDate] [char] (10)  NULL ,
	[endDate] [char] (10)  NULL ,
	[manager] [int] NULL ,
	[status] [int] NULL ,
	[isRemind] [int] NULL ,
	[remindDay] [int] NULL ,
	[creater] [int] NULL ,
	[createDate] [char] (10)  NULL ,
	[createTime] [char] (10)  NULL
)
GO

CREATE TABLE [CRM_ContractProduct] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[contractId] [int] NULL ,
	[productId] [int] NULL ,	
	[unitId] [int] NULL ,
	[number_n] [int] NULL ,
	[price] [decimal](10, 2) NULL ,
	[currencyId] [int] NULL ,
	[depreciation] [int] NULL , /*�ۿ�*/
	[sumPrice] [decimal](10, 2) NULL ,
	[planDate] [char] (10)  NULL ,
	[factnumber_n] [int] NULL ,
	[factDate] [char] (10)  NULL ,
	[isFinish] [int] NULL ,
	[isRemind] [int] NULL 
)
GO


CREATE TABLE [CRM_ContractPayMethod] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[contractId] [int] NULL ,
	[prjName] [varchar] (100)  NULL ,
	[typeId] [int] NULL ,	
	[payPrice] [decimal](10, 2) NULL ,
	[payDate] [char] (10)  NULL ,
	[factPrice] [decimal](10, 2) NULL ,
	[factDate] [char] (10)  NULL ,
	[qualification] [varchar] (200)  NULL ,  /*��������*/	
	[isFinish] [int] NULL ,
	[isRemind] [int] NULL 
	
)
GO

CREATE TABLE [CRM_CustomerCredit] (
	[CreditAmount] [decimal](10, 2) NULL ,
	[CreditTime] [int] NULL  
)
GO

ALTER TABLE CRM_CustomerInfo add CreditAmount decimal(10, 2)  /* ���ö�� */
GO

ALTER TABLE CRM_CustomerInfo add CreditTime int /* �ͻ���Ƭ�������ڼ�  */
GO


CREATE TABLE [CRM_Contract_Exchange] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[contractId] [int] NULL ,
	[name] [varchar] (200)  NULL ,
	[remark] [text]  NULL ,
	[creater] [int] NULL ,
	[createDate] [char] (10)  NULL ,
	[createTime] [char] (10)  NULL
)
GO

/* �ͻ���ͬ����ά�� */

CREATE PROCEDURE CRM_ContractType_Select
	(
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_ContractType 
GO

CREATE PROCEDURE CRM_ContractType_SelectById
	(@id_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_ContractType  where id = @id_1 	
GO


CREATE PROCEDURE CRM_ContractType_Insert 
	(@name_1 	[varchar](100),
	 @contractdesc_1	[varchar](200),
	 @workflowid_1  [int],
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO [CRM_ContractType] 
	 ([name],
	 [contractdesc],
	 [workflowid]) 
 
VALUES 
	( @name_1,
	 @contractdesc_1,
	 @workflowid_1)
GO

CREATE PROCEDURE CRM_ContractType_Delete
	(@id_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)
AS DELETE [CRM_ContractType] 
WHERE 
	( [id]	 = @id_1)

GO

CREATE PROCEDURE CRM_ContractType_Update 
	(@id_1 	[int] ,
	 @name_1 	[varchar](100),
	 @contractdesc_1	[varchar](200),
	 @workflowid_1  [int],
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
UPDATE CRM_ContractType SET name = @name_1, contractdesc = @contractdesc_1 , workflowid = @workflowid_1 where id = @id_1
GO


/* ��ͬά�� */

CREATE PROCEDURE CRM_Contract_SelectAll
	(
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_Contract 
GO

CREATE PROCEDURE CRM_Contract_Select
	(@crmId_1 [int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_Contract  where crmId = @crmId_1
GO

CREATE PROCEDURE CRM_Contract_SelectById
	(@id_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_Contract  where id = @id_1 	
GO


CREATE PROCEDURE CRM_Contract_Insert 
	(@name_1  [varchar] (100)   ,
	 @typeId_1  [int]  ,	
	 @docId_1  [int]  ,
	 @price_1  [decimal](10, 2)  ,
	 @crmId_1  [int]  ,
	 @contacterId_1  [int]  ,
	 @startDate_1  [char] (10)   ,
	 @endDate_1  [char] (10)   ,
	 @manager_1  [int]  ,
	 @status_1  [int]  ,
	 @isRemind_1  [int]  ,
	 @remindDay_1  [int]  ,
	 @creater_1  [int]  ,
	 @createDate_1  [char] (10)   ,
	 @createTime_1  [char] (10)  ,
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO [CRM_Contract] 
	 (name , 
	 typeId , 
	 docId , price , crmId , contacterId , startDate , endDate , manager , status , isRemind , remindDay , creater , createDate , createTime) 
 
VALUES 
	( @name_1,
	 @typeId_1,
	 @docId_1, @price_1 , @crmId_1 , @contacterId_1 , @startDate_1 , @endDate_1 , @manager_1 , @status_1 , @isRemind_1 , @remindDay_1 , @creater_1 , @createDate_1 , @createTime_1)
select top 1 * from CRM_Contract order by id desc
GO


CREATE PROCEDURE CRM_Contract_Update 
	(@id_1 	[int] ,
	 @name_1  [varchar] (100)   ,
	 @typeId_1  [int]  ,	
	 @docId_1  [int]  ,
	 @price_1  [decimal](10, 2)  ,
	 @crmId_1  [int]  ,
	 @contacterId_1  [int]  ,
	 @startDate_1  [char] (10)   ,
	 @endDate_1  [char] (10)   ,
	 @manager_1  [int]  ,
	 @status_1  [int]  ,
	 @isRemind_1  [int]  ,
	 @remindDay_1  [int]  ,
	 @flag integer output,
	 @msg varchar(80) output)

AS
UPDATE CRM_Contract SET name = @name_1, typeId = @typeId_1 , docId = @docId_1 , price = @price_1 , crmId = @crmId_1 , contacterId = @contacterId_1 , startDate = @startDate_1 , endDate = @endDate_1 , manager = @manager_1 , status = @status_1 , isRemind = @isRemind_1 , remindDay = @remindDay_1  where id = @id_1
GO

CREATE PROCEDURE CRM_Contract_UpdateRemind
	(@id_1 	[int] ,	 
	 @isRemind_1  [int] , 
	 @remindDay_1  [char] (10)  ,	
	 @flag integer output,
	 @msg varchar(80) output)

AS
UPDATE CRM_Contract SET isRemind = @isRemind_1, remindDay = @remindDay_1   where id = @id_1
GO

/**/
CREATE PROCEDURE CRM_ContractProduct_Select
	(@contractId_1 [int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_ContractProduct where contractId = @contractId_1
GO

CREATE PROCEDURE CRM_ContractProduct_Delete
	(@id_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)
AS DELETE [CRM_ContractProduct] 
WHERE 
	( [id]	 = @id_1)

GO

CREATE PROCEDURE CRM_ContractProduct_DelAll
	(@contractId_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)
AS DELETE [CRM_ContractProduct] 
WHERE 
	( [contractId]	 = @contractId_1)

GO


CREATE PROCEDURE CRM_ContractProduct_Insert 
	(
	 @contractId_1  [int]  ,	
	 @productId_1  [int]  ,
	 @unitId_1  [int]  ,
	 @number_n_1  [int]  ,
	 @price_1  [decimal](10, 2)  ,
	 @currencyId_1  [int]  ,
	 @depreciation_1  [int]  ,
	 @sumPrice_1  [decimal](10, 2)  ,
	 @planDate_1  [char] (10)   ,
	 @factnumber_n_1   [int]  ,
	 @factDate_1  [char] (10)  ,
	 @isFinish_1  [int]  ,
	 @isRemind_1  [int]  ,
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO [CRM_ContractProduct] 
	 (contractId , 
	 productId , 
	 unitId , number_n , price , currencyId , depreciation , sumPrice , planDate , factnumber_n , factDate , isFinish , isRemind ) 
 
VALUES 
	( @contractId_1,
	 @productId_1,
	 @unitId_1, @number_n_1 , @price_1 , @currencyId_1 , @depreciation_1 , @sumPrice_1 , @planDate_1 , @factnumber_n_1 , @factDate_1 , @isFinish_1 , @isRemind_1)
GO

CREATE PROCEDURE CRM_ContractProduct_Update 
	(@id_1 	[int] ,
	 @factnumber_n_1  [int] ,
	 @factDate_1  [char] (10)  ,	
	 @isFinish_1  [int]  ,
	 @isRemind_1  [int] , 
	 @flag integer output,
	 @msg varchar(80) output)

AS
UPDATE CRM_ContractProduct SET factnumber_n = @factnumber_n_1, factDate = @factDate_1 , isFinish = @isFinish_1 , isRemind = @isRemind_1  where id = @id_1
GO

/**/
CREATE PROCEDURE CRM_ContractPayMethod_Select
	(@contractId_1 [int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_ContractPayMethod  where contractId = @contractId_1
GO

CREATE PROCEDURE CRM_ContractPayMethod_Delete
	(@id_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)
AS DELETE [CRM_ContractPayMethod] 
WHERE 
	( [id]	 = @id_1)

GO

CREATE PROCEDURE CRM_ContractPayMethod_DelAll
	(@contractId_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)
AS DELETE [CRM_ContractPayMethod] 
WHERE 
	( [contractId]	 = @contractId_1)

GO

CREATE PROCEDURE CRM_ContractPayMethod_Insert 
	(
	 @contractId_1  [int]  ,	
	 @prjName_1  [varchar] (100)   ,
	 @typeId_1  [int]  ,
	 @payPrice_1  [decimal](10, 2)  ,
	 @payDate_1  [char] (10)   ,
	 @factPrice_1  [decimal](10, 2)  ,
	 @factDate_1  [char] (10)  ,
	 @qualification_1 [varchar] (200) ,
	 @isFinish_1  [int]  ,
	 @isRemind_1  [int]  ,
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO [CRM_ContractPayMethod] 
	 (contractId , 
	 prjName , 
	 typeId , payPrice , payDate , factPrice , factDate , qualification , isFinish , isRemind ) 
 
VALUES 
	(@contractId_1,
	 @prjName_1,
	 @typeId_1, @payPrice_1 , @payDate_1 , @factPrice_1 , @factDate_1 , @qualification_1 , @isFinish_1 , @isRemind_1)
GO

CREATE PROCEDURE CRM_ContractPayMethod_Update 
	(@id_1 	[int] ,
	 @factPrice_1  [decimal](10, 2)  ,
	 @factDate_1  [char] (10)  ,	
	 @isFinish_1  [int]  ,
	 @isRemind_1  [int] , 
	 @flag integer output,
	 @msg varchar(80) output)

AS
UPDATE CRM_ContractPayMethod SET factPrice = @factPrice_1, factDate = @factDate_1 , isFinish = @isFinish_1 , isRemind = @isRemind_1  where id = @id_1
GO

CREATE PROCEDURE CRM_CustomerCredit_Insert 
	(@CreditAmount_1  [decimal](10, 2)  ,	
	 @CreditTime_1  [int]  ,
	 @flag integer output,
	 @msg varchar(80) output)

AS
INSERT INTO [CRM_CustomerCredit] 
	    (CreditAmount,CreditTime)
VALUES(@CreditAmount_1, @CreditTime_1 )
GO



ALTER PROCEDURE CRM_CustomerInfo_Insert 
 (@name 		[varchar](50), @language 	[int], @engname 	[varchar](50), @address1 	[varchar](250), @address2 	[varchar](250), @address3 	[varchar](250), @zipcode 	[varchar](10), @city	 	[int], @country 	[int], @province 	[int], @county 	[varchar](50), @phone 	[varchar](50), @fax	 	[varchar](50), @email 	[varchar](150), @website 	[varchar](150), @source 	[int], @sector 	[int], @size_n	 	[int], @manager 	[int], @agent 	[int], @parentid 	[int], @department 	[int], @subcompanyid1 	[int], @fincode 	[int], @currency 	[int], @contractlevel	[int], @creditlevel 	[int], @creditoffset 	[varchar](50), @discount 	[real], @taxnumber 	[varchar](50), @bankacount 	[varchar](50), @invoiceacount	[int], @deliverytype 	[int], @paymentterm 	[int], @paymentway 	[int], @saleconfirm 	[int], @creditcard 	[varchar](50), @creditexpire 	[varchar](10), @documentid 	[int], @seclevel 	[int], @picid 	[int], @type 		[int], @typebegin 	[varchar](10), @description 	[int], @status 	[int], @rating 	[int], @introductionDocid [int],  @CreditAmount [decimal](10, 2) , @CreditTime [int], @datefield1 	[varchar](10), @datefield2 	[varchar](10), @datefield3 	[varchar](10), @datefield4 	[varchar](10), @datefield5 	[varchar](10), @numberfield1 	[float], @numberfield2 	[float], @numberfield3 	[float], @numberfield4 	[float], @numberfield5 	[float], @textfield1 	[varchar](100), @textfield2 	[varchar](100), @textfield3 	[varchar](100), @textfield4 	[varchar](100), @textfield5 	[varchar](100), @tinyintfield1 [tinyint], @tinyintfield2 [tinyint], @tinyintfield3 [tinyint], @tinyintfield4 [tinyint], @tinyintfield5 [tinyint], @createdate 	[varchar](10), @flag	[int]	output, @msg	[varchar](80)	output)  AS INSERT INTO [CRM_CustomerInfo] ( [name], [language], [engname], [address1], [address2], [address3], [zipcode], [city], [country], [province], [county], [phone], [fax], [email], [website], [source], [sector], [size_n], [manager], [agent], [parentid], [department], [subcompanyid1], [fincode], [currency], [contractlevel], [creditlevel], [creditoffset], [discount], [taxnumber], [bankacount], [invoiceacount], [deliverytype], [paymentterm], [paymentway], [saleconfirm], [creditcard], [creditexpire], [documentid], [seclevel], [picid], [type], [typebegin], [description], [status], [rating], [datefield1], [datefield2], [datefield3], [datefield4], [datefield5], [numberfield1], [numberfield2], [numberfield3], [numberfield4], [numberfield5], [textfield1], [textfield2], [textfield3], [textfield4], [textfield5], [tinyintfield1], [tinyintfield2], [tinyintfield3], [tinyintfield4], [tinyintfield5], [deleted], [createdate],introductionDocid,CreditAmount,CreditTime)  VALUES ( @name, @language, @engname, @address1, @address2, @address3, @zipcode, @city, @country, @province, @county, @phone, @fax, @email, @website, @source, @sector, @size_n, @manager, @agent, @parentid, @department, @subcompanyid1, @fincode, @currency, @contractlevel, @creditlevel, convert(money,@creditoffset), @discount, @taxnumber, @bankacount, @invoiceacount, @deliverytype, @paymentterm, @paymentway, @saleconfirm, @creditcard, @creditexpire, @documentid, @seclevel, @picid, @type, @typebegin, @description, @status, @rating, @datefield1, @datefield2, @datefield3, @datefield4, @datefield5, @numberfield1, @numberfield2, @numberfield3, @numberfield4, @numberfield5, @textfield1, @textfield2, @textfield3, @textfield4, @textfield5, @tinyintfield1, @tinyintfield2, @tinyintfield3, @tinyintfield4, @tinyintfield5, 0, @createdate, @introductionDocid, @CreditAmount , @CreditTime )  SELECT top 1 id from CRM_CustomerInfo ORDER BY id DESC set @flag = 1 set @msg = 'OK!' 


GO


 ALTER PROCEDURE CRM_CustomerInfo_Update 
 (@id 		[int], @name 		[varchar](50), @language 	[int], @engname 	[varchar](50), @address1 	[varchar](250), @address2 	[varchar](250), @address3 	[varchar](250), @zipcode 	[varchar](10), @city	 	[int], @country 	[int], @province 	[int], @county 	[varchar](50), @phone 	[varchar](50), @fax	 	[varchar](50), @email 	[varchar](150), @website 	[varchar](150), @source 	[int], @sector 	[int], @size_n	 	[int], @manager 	[int], @agent 	[int], @parentid 	[int], @department 	[int], @subcompanyid1 	[int], @fincode 	[int], @currency 	[int], @contractlevel	[int], @creditlevel 	[int], @creditoffset 	[varchar](50), @discount 	[real], @taxnumber 	[varchar](50), @bankacount 	[varchar](50), @invoiceacount [int], @deliverytype 	[int], @paymentterm 	[int], @paymentway 	[int], @saleconfirm 	[int], @creditcard 	[varchar](50), @creditexpire 	[varchar](10), @documentid 	[int], @seclevel 	[int], @picid 	[int], @type	 	[int], @typebegin 	[varchar](10), @description 	[int], @status 	[int], @rating 	[int], @introductionDocid [int],  @CreditAmount [decimal](10, 2) , @CreditTime [int], @datefield1 	[varchar](10), @datefield2 	[varchar](10), @datefield3 	[varchar](10), @datefield4 	[varchar](10), @datefield5 	[varchar](10), @numberfield1 	[float], @numberfield2 	[float], @numberfield3 	[float], @numberfield4 	[float], @numberfield5 	[float], @textfield1 	[varchar](100), @textfield2 	[varchar](100), @textfield3 	[varchar](100), @textfield4 	[varchar](100), @textfield5 	[varchar](100), @tinyintfield1 	[tinyint], @tinyintfield2 	[tinyint], @tinyintfield3 	[tinyint], @tinyintfield4 	[tinyint], @tinyintfield5 	[tinyint], @flag	[int]	output, @msg	[varchar](80)	output) AS UPDATE [CRM_CustomerInfo]  SET  	 [name]	 	 = @name, [language]	 = @language, [engname]	 = @engname, [address1]	 = @address1, [address2]	 = @address2, [address3]	 = @address3, [zipcode]	 = @zipcode, [city]	 = @city, [country]	 = @country, [province]	 = @province, [county]	 = @county, [phone]	 = @phone, [fax]	 = @fax, [email]	 = @email, [website]	 = @website, [source]	 = @source, [sector]	 = @sector, [size_n]	 = @size_n, [manager]	 = @manager, [agent]	 = @agent, [parentid]	 = @parentid, [department]	 = @department, [subcompanyid1]	 = @subcompanyid1, [fincode]	 = @fincode, [currency]	 = @currency, [contractlevel] = @contractlevel, [creditlevel]	 = @creditlevel, [creditoffset]	 = convert(money,@creditoffset), [discount]	 = @discount, [taxnumber]	 = @taxnumber, [bankacount]	 = @bankacount, [invoiceacount]	 = @invoiceacount, [deliverytype]	 = @deliverytype, [paymentterm]	 = @paymentterm, [paymentway]	 = @paymentway, [saleconfirm]	 = @saleconfirm, [creditcard]	 = @creditcard, [creditexpire]	 = @creditexpire, [documentid]	 = @documentid, [seclevel] = @seclevel, [picid]	 = @picid, [type]	 = @type, [typebegin]	 = @typebegin, [description]	 = @description, [status]	 = @status, [rating]	 = @rating, [datefield1]	 = @datefield1, [datefield2]	 = @datefield2, [datefield3]	 = @datefield3, [datefield4]	 = @datefield4, [datefield5]	 = @datefield5, [numberfield1]	 = @numberfield1, [numberfield2]	 = @numberfield2, [numberfield3]	 = @numberfield3, [numberfield4]	 = @numberfield4, [numberfield5]	 = @numberfield5, [textfield1]	 = @textfield1, [textfield2]	 = @textfield2, [textfield3]	 = @textfield3, [textfield4]	 = @textfield4, [textfield5]	 = @textfield5, [tinyintfield1]	 = @tinyintfield1, [tinyintfield2]	 = @tinyintfield2, [tinyintfield3]	 = @tinyintfield3, [tinyintfield4]	 = @tinyintfield4, [tinyintfield5]	 = @tinyintfield5  , introductionDocid = @introductionDocid ,  CreditAmount = @CreditAmount , CreditTime = @CreditTime WHERE ( [id]	 = @id) set @flag = 1 set @msg = 'OK!' 

GO



CREATE PROCEDURE CRM_ContractExch_Insert 
	(@contractId_1 [int]  ,
	 @name_1  [varchar] (200)   ,
	 @remark_1 [text]  ,
	 @creater_1  [int]  ,
	 @createDate_1  [char] (10)   ,
	 @createTime_1  [char] (10)  ,
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO [CRM_Contract_Exchange] 
	 (contractId ,
	 name , 
	 remark , 
	 creater , createDate , createTime) 
 
VALUES 
	(@contractId_1 ,
	 @name_1,
	 @remark_1,
	 @creater_1 , @createDate_1 , @createTime_1)
GO

CREATE PROCEDURE CRM_ContractExch_Select
	(@contractId_1 [int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
SELECT * FROM CRM_Contract_Exchange where contractId = @contractId_1 order by createDate desc, createTime
GO

/* �ͻ���ͬ����ά�� */
insert into SystemRights(id,rightdesc,righttype) values(352,'�ͻ���ͬ����ά��','0')
GO

insert into SystemRightsLanguage(id,languageid,rightname,rightdesc) values(352,7,'�ͻ���ͬ����ά��','�ͻ���ͬ����ά��')
GO

insert into SystemRightsLanguage(id,languageid,rightname,rightdesc) values(352,8,'','')
GO

insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid) values(2058,'�ͻ���ͬ�������','CRM_ContractTypeAdd:Add',352)
GO
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid) values(2059,'�ͻ���ͬ���ʱ༭','CRM_ContractTypeEdit:Edit',352)
GO
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid) values(2060,'�ͻ���ͬ����ɾ��','CRM_ContractTypeDelete:Delete',352)
GO
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid) values(2061,'�ͻ���ͬ������־','CRM_ContractType:Log',352)
GO

insert into SystemRightRoles (rightid,roleid,rolelevel) values (352,8,'1')
GO

insert into SystemRightToGroup (groupid,rightid) values (6,352)
GO


/* �ͻ����ö��/�ڼ�ά�� */
insert into SystemRights(id,rightdesc,righttype) values(353,'�ͻ����ö��/�ڼ�ά��','0')
GO

insert into SystemRightsLanguage(id,languageid,rightname,rightdesc) values(353,7,'�ͻ����ö��/�ڼ�ά��','�ͻ����ö��/�ڼ�ά��')
GO

insert into SystemRightsLanguage(id,languageid,rightname,rightdesc) values(353,8,'','')
GO

insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid) values(2062,'�ͻ���ͬ�������','CRM_CustomerCreditAdd:Add',353)

insert into SystemRightRoles (rightid,roleid,rolelevel) values (353,8,'1')
GO

insert into SystemRightToGroup (groupid,rightid) values (6,353)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6083	,'��ͬ����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6083,'��ͬ����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6083,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6095	,'ǩ��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6095,'ǩ��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6095,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6097	,'���ö��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6097,'���ö��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6097,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6098	,'�����ڼ�')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6098,'�����ڼ�',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6098,'',8)
GO

insert into CRM_ContractType (name,contractdesc,workflowid) values ('��Ʒ���ۺ�ͬ','��Ʒ���ۺ�ͬ','0')
GO
insert into CRM_ContractType (name,contractdesc,workflowid) values ('�����ͬ','�����ͬ','0')
GO

insert into CRM_CustomerCredit (CreditAmount,CreditTime) values ('1000000','30')
GO

update HrmInfoMaintenance set hrmid='2'
GO

delete FROM HomePageDesign where id = 11
GO