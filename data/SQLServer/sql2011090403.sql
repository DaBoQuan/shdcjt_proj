update extendHomepage set extendName='ecology7����ģ��', extenddesc='ecology7����ģ��',extendurl='/portal/plugin/homepage/ecology7theme' where id=3
GO

CREATE TABLE extandHpTheme (
	id int identity,
	templateId int,
	subcompanyid int
)
GO

CREATE TABLE extandHpThemeItem (
	id int identity,
	extandHpThemeId int,
	theme nvarchar(100),
	skin nvarchar(100),
	logoTop nvarchar(100),
	logoBottom nvarchar(100),
	isopen int,
	islock int
)
GO
