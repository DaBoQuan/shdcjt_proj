insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) select id,'id','�Ա�id','sex id','int','1','2','0' from Sys_tabledict where tablename='hrmsex'
/
insert into Sys_fielddict(tabledictid,fieldname,fielddesc,fielddescen,fielddbtype,fieldhtmltype,type,dsporder) select id,'sexname','��Ա�Ա�','sex','varchar(10)','1','1','1' from Sys_tabledict where tablename='hrmsex'
/
