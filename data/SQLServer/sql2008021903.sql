INSERT INTO workflow_browserurl (id,labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 164,141,'int','/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp','Hrmsubcompany','subcompanyname','id','/hrm/company/HrmSubCompanyDsp.jsp?id=')
GO

ALTER PROCEDURE HrmResource_SelectAll
	(@flag integer output, @msg   varchar(80) output ) 
AS select 
	id,
	loginid,  
	lastname,
	sex,
	resourcetype,
	email,
	locationid,
	workroom, 
	departmentid,
	subcompanyid1,
	costcenterid,
	jobtitle,
	managerid,
	assistantid ,
	seclevel,
	joblevel,
	managerstr,
	status,
	account,
	mobile,
	password,
	systemLanguage,
	telephone
from HrmResource  
if @@error<>0 begin set @flag=1 set @msg='��ѯ������Դ��Ϣ�ɹ�' return end else begin set @flag=0 set @msg='��ѯ������Դ��Ϣʧ��' return end 

GO
