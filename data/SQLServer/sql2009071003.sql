create table hrmsex(
id int,
sexname varchar(10)
)
GO

insert into hrmsex values(0,'��')
GO
insert into hrmsex values(1,'Ů')
GO

insert into Sys_tabledict(tablename,tabledesc,tabledescen,tabletype,modetype,memo) values('hrmsex','��Ա�Ա��','sex of people',0,1,'��Ա�Ա��')
GO

insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(46,'id','�Ա�id','sex id','int',1,2,0)
GO
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) values(46,'sexname','��Ա�Ա�','sex','varchar(10)',1,1,1)
GO

insert into Sys_fielddict values(1,'sex','�Ա�','sex','char(1)',1,1,50) 

GO
 
 