alter table menucenter add subcompanyid varchar(5)
GO
update mainmenuinfo set linkAddress='/page/maint/menu/MenuMaint.jsp' where menuname='��¼��˵�'
GO
