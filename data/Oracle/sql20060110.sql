/*����iconUrl�ֶ�*/
ALTER TABLE MainMenuInfo ADD iconUrl VARCHAR2(100) NULL
/

/**/
ALTER TABLE LeftMenuInfo ADD isCustom CHAR(1) DEFAULT '0'
/

/*��¼ģ���*/
CREATE TABLE SystemLoginTemplate (
	loginTemplateId integer  NOT NULL ,
	loginTemplateName varchar2 (100) NULL ,
	loginTemplateTitle varchar2 (50) NULL ,
	templateType char (1) NULL ,
	imageId varchar2 (100) NULL ,
	isCurrent char (1) NULL
)
/
create sequence SystemLogin_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger SystemLogin_Trigger
before insert on SystemLoginTemplate
for each row
begin
select SystemLogin_Id.nextval into :new.loginTemplateId from dual;
end;
/


/*ϵͳģ���*/
CREATE TABLE SystemTemplate (
	id integer  NOT NULL ,
	templateName varchar2 (50) NOT NULL ,
	companyId integer NULL ,
	logo varchar2 (100) NULL ,
	topBgColor varchar2 (50) NULL ,
	topBgImage varchar2 (100) NULL ,
	toolbarBgColor varchar2 (50) NULL ,
	toolbarBgImage varchar2 (100) NULL ,
	leftbarBgColor varchar2 (50) NULL ,
	leftbarBgImage varchar2 (100) NULL ,
	leftbarBgImageH varchar2 (100) NULL ,
	leftbarFontColor varchar2 (50) NULL ,
	leftMenuBgColor varchar2 (50) NULL ,
	leftMenuFontColor varchar2 (50) NULL ,
	menubarBgColor varchar2 (50) NULL ,
	menubtnBgColor varchar2 (50) NULL ,
	menubtnBgColorActive varchar2 (50) NULL ,
	menubtnBgColorHover varchar2 (50) NULL ,
	menubtnFontColor varchar2 (50) NULL ,
	menubtnBorderColorActive varchar2 (50) NULL ,
	menubtnBorderColorHover varchar2 (50) NULL ,
	templateTitle varchar2 (50) NULL ,
	isOpen char (1) NULL ,
	isShowMainMenu char (1) NULL 
)
/
create sequence SysTemp_Id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger SysTemp_Trigger
before insert on SystemTemplate
for each row
begin
select SysTemp_Id.nextval into :new.id from dual;
end;
/

/*ϵͳģ���û���*/
CREATE TABLE SystemTemplateUser (
	userId integer NOT NULL ,
	templateId integer NOT NULL 
)
/

/* ���һ��Ĭ��ģ�� */
INSERT INTO SystemTemplate (templateName,companyId,logo,topBgColor,topBgImage,toolbarBgColor,toolbarBgImage,leftbarBgColor,leftbarBgImage,leftbarBgImageH,leftbarFontColor,menubarBgColor,menubtnBgColor,menubtnBgColorActive,menubtnBgColorHover,menubtnFontColor,menubtnBorderColorActive,menubtnBorderColorHover,templateTitle,isOpen,isShowMainMenu) VALUES ('EcologyĬ��ģ��',0,'','#172971','','#DDDDDD','','#C4C4C4','','','#444444','#172971','#172971','#42549E','#42549E','#FFFFFF','#172971','#172971','��ЧԴ��Эͬ','1','1')
/

/* Ϊ��ͨ�û����Ĭ��ģ��(HrmResource) */
DECLARE
userid_1 integer ;
begin
FOR c in(SELECT id FROM HrmResource)
loop
	userid_1 := c.id;
	INSERT INTO SystemTemplateUser (userId,templateId) VALUES (userid_1,1);
END loop;
end;
/
/* Ϊ��ͨ�û����Ĭ��ģ��(HrmResource) */
DECLARE
userid_1 integer ;
begin
FOR c in(SELECT id FROM HrmResourceManager)
loop
	userid_1 := c.id;
	INSERT INTO SystemTemplateUser (userId,templateId) VALUES (userid_1,1);
END loop;
end;
/


/**/
INSERT INTO SystemModule (id,moduleName,moduleReleased) VALUES (12,'�Զ���˵�','1')
/



/* ���ģ��ά��Ȩ�� */
insert into SystemRights (id,rightdesc,righttype) values (599,'ģ��ά��','7') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (599,8,'TemplateManage','TemplateManage') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (599,7,'ģ��ά��','ģ��ά��') 
/
/* ����Ϊ�ɷ�Ȩ */
UPDATE SystemRights SET detachable='1' WHERE id=599
/

/* ���ģ��ά��Ȩ����ϸ */
INSERT INTO SystemRightDetail (id,rightdetailname,rightdetail,rightid) VALUES (4098,'ģ��ά��','SystemTemplate:Edit',599)
/
