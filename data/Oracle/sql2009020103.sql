CREATE TABLE XmlReport (
	id number NOT NULL ,	/*�޸���־�ֶ�id��������*/
	rptType varchar2(1) NULL,	/*�������� 0:�ձ�;1:�ܱ�;2:�±�;3:����;4:���걨;5:�걨*/
	rptFlag varchar2(250) NULL,
	rptDate varchar2(10) NULL,	/*��������*/
	rptTitle varchar2(250)  NULL ,	/*��������*/
	rptName varchar2(250)  NULL ,	/*��������*/
	updateDate varchar2(10)  NULL		/*�޸�������*/
)
/
create sequence XmlReport_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger XmlReport_Tri
before insert on XmlReport
for each row
begin
select XmlReport_id.nextval into :new.id from dual;
end;
/
CREATE TABLE XmlReport_ShareInfo
(
  ID            INTEGER not null,
  RELATEDITEMID varchar2(250),
  SHARETYPE     INTEGER,
  SECLEVEL      INTEGER,
  ROLELEVEL     INTEGER,
  SHARELEVEL    INTEGER,
  USERID        INTEGER,
  DEPARTMENTID  INTEGER,
  ROLEID        INTEGER,
  FORALLUSER    INTEGER,
  CRMID         INTEGER default 0
)
/
create sequence XmlReport_ShareInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger XmlReport_ShareInfo_Tri
before insert on XmlReport_ShareInfo
for each row
begin
select XmlReport_ShareInfo_id.nextval into :new.id from dual;
end;
/
/*���湲��*/
CREATE OR REPLACE PROCEDURE XmlReport_ShareInfo_Insert(relateditemid_1 varchar2,
                                                 sharetype_1     smallint,
                                                 seclevel_1      smallint,
                                                 rolelevel_1     smallint,
                                                 sharelevel_1    smallint,
                                                 userid_1        integer,
                                                 departmentid_1  integer,
                                                 roleid_1        integer,
                                                 foralluser_1    smallint,
                                                 flag            out integer,
                                                 msg             out varchar2,
                                                 thecursor       IN OUT cursor_define.weavercursor) AS
BEGIN
  INSERT INTO XmlReport_ShareInfo
    (relateditemid,
     sharetype,
     seclevel,
     rolelevel,
     sharelevel,
     userid,
     departmentid,
     roleid,
     foralluser)
  VALUES
    (relateditemid_1,
     sharetype_1,
     seclevel_1,
     rolelevel_1,
     sharelevel_1,
     userid_1,
     departmentid_1,
     roleid_1,
     foralluser_1);
end;
/
/*ɾ������*/
CREATE OR REPLACE PROCEDURE XmlReport_ShareInfo_Delete(id1       integer,
                                                 flag      out integer,
                                                 msg       out varchar2,
                                                 thecursor IN OUT cursor_define.weavercursor) AS
begin
  DELETE from XmlReport_ShareInfo WHERE (id = id1);
end;
/
/*���ҹ���*/
CREATE OR REPLACE PROCEDURE XmlReport_ShareInfo_SbyRid(relateditemid1 varchar2,
                                                           flag           out integer,
                                                           msg            out varchar2,
                                                           thecursor      IN OUT cursor_define.weavercursor) as
begin
  open thecursor for
    SELECT *
      from XmlReport_ShareInfo
     where (relateditemid = relateditemid1)
     order by sharetype;
end;
/
