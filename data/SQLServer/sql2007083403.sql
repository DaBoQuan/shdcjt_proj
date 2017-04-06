

create table workflow_custom (
id int IDENTITY(1,1) NOT NULL,
formID int null ,
isBill char(1) null
)
go


CREATE TABLE Workflow_CustomDspField(
	id int IDENTITY(1,1) NOT NULL,
	customid int NULL,
	fieldid int NULL,
	ifquery char(1)  NULL,
	ifshow char(1)  NULL,
	showorder int null
	)

go

 create  PROCEDURE Workflow_CustomDspField_Insert
(@reportid_1    int, @fieldid_2   int,  @dborder_3     char(1) , @shows char(1), @compositororder  varchar(10), @flag   int   output, @msg    varchar(80)   output) AS 
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) VALUES ( @reportid_1, @fieldid_2, @dborder_3, @shows, @compositororder) 

go

create  PROCEDURE Workflow_CustomDspField_Init
(@reportid_1    int, @flag   int   output, @msg    varchar(80)   output) AS 

begin
/*
 ��ʼ����������   -3
 ��ǰ�ڵ�         -6
 ������           -4
 ��������         -7
 ������           -5
 ��ǰ״��         -8
 �����̶�         -2
 δ������         -9
 ����˵��         -1
*/
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -9,'0','1',9) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -8,'0','1',8) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -7,'0','1',7) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -6,'0','1',6) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -5,'1','1',5) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -4,'1','1',4) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -3,'1','1',3) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -2,'1','1',2) ;
INSERT INTO Workflow_CustomDspField ( customid, fieldid, ifquery, ifshow,showorder) 
VALUES ( @reportid_1, -1,'1','1',1) ;
end 

go



