CREATE table codemain (
    id int IDENTITY(1,1),
    titleImg Varchar(20),  /*����ͼƬ*/
    titleName Varchar(20),
    isUse char(1),/*1:Ϊ���� 2:Ϊ������*/
    allowStr varchar(20) /*Ȩ���ж��ַ���*/

)
GO

CREATE table codedetail (
    id int IDENTITY(1,1),
    codemainid int not null, /*�����ID*/
    showname varchar(20), 
    showtype char(1), /*1:checkbox  3:input  3.year */
    value varchar(20), /*0:��ѡ�� 1:ѡ��  ��Ϊyearʱ 1|1 ��ʾ���ã�������Ϊ������ 1|0��ʾ��Ϊ������*/
    codeorder int
)
GO



INSERT INTO  codemain (titleImg,titleName,isUse,allowStr) VALUES ('/images/sales.gif','��Ŀ����',1,'ProjCode:Maintenance')
GO

INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'����ǰ׺',2,'proj',1)
GO

INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'�ͻ����ͱ���',1,'1',2)
GO

INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��Ŀ���ͱ���',1,'1',3)
GO


INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'�������ͱ���',1,'1',4)
GO


INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��',3,'1|1',5)
GO
INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��',1,'1',6)
GO

INSERT INTO  codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��',1,'1',7)
GO


INSERT INTO codedetail(codemainid,showname,showtype,value,codeorder) 
VALUES (1,'��ˮ��λ��',2,'4',8)
GO


/*�޸���Ŀ��������ӵ�ַ����������*/
update MainMenuInfo set linkAddress='/system/codeMaint.jsp?codemainid=1' where  linkAddress='/proj/CodeFormat/CodeFormatView.jsp'
Go
/*�������ͱ���빤�����ͱ���*/
ALTER  TABLE Prj_WorkType ADD worktypeCode varchar(50)
GO


alter PROCEDURE Prj_WorkType_Insert (
@fullname_1 	varchar(50), 
@description_2 	varchar(150),
@worktypecode varchar(50),
@flag	int	output, @msg	varchar(80)	output) 
AS
INSERT INTO Prj_WorkType ( fullname, description,worktypecode) 
VALUES ( @fullname_1, @description_2,@worktypecode) 
set @flag = 1 set @msg = 'OK!'
GO


alter PROCEDURE Prj_WorkType_Update (
@id	 	int,
 @fullname 	varchar(50),
 @description 	varchar(150), 
 @worktypecode varchar(50),
 @flag	int	output, @msg	varchar(80)	output) 
  AS 
  UPDATE Prj_WorkType  
  SET  fullname	 = @fullname, description = @description,worktypecode= @worktypecode  
   WHERE ( id	 = @id) 
    set @flag = 1 set @msg = 'OK!'


GO
