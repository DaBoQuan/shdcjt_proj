create table hrmsex(
id integer,
sexname varchar2(10)
)
/

insert into hrmsex values(0,'��')
/
insert into hrmsex values(1,'Ů')
/

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('hrmsex','��Ա�Ա��','sex of people',0,1,'��Ա�Ա��')
/

insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(46,'id','�Ա�id','sex id','int',1,2,0)
/
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(46,'sexname','��Ա�Ա�','sex','varchar(10)',1,1,1)
/

insert into Sys_fielddict values(1,'sex','�Ա�','sex','char(1)',1,1,50) 

/
 