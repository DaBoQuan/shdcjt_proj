/* ���ݵ�����ڱ� */
CREATE TABLE Workflow_DataInput_entry(
    id  int NOT NULL IDENTITY (1, 1),
    WorkFlowID    int,
    TriggerFieldName   varchar(50)
)
GO
/* ���ݵ������� */
CREATE TABLE Workflow_DataInput_main(
    id  int NOT NULL IDENTITY (1, 1),
    entryID    int,
    WhereClause varchar(1000),
    IsCycle   int  default 1,
    OrderID	int  default 0
)
GO
/* ���ݵ�������� */
CREATE TABLE Workflow_DataInput_table(
    id  int NOT NULL IDENTITY (1, 1),
    DataInputID    int,
    TableName varchar(40),
    Alias   varchar(10)
)
GO
/* ���ݵ������������ */
CREATE TABLE Workflow_DataInput_field(
    id  int NOT NULL IDENTITY (1, 1),
    DataInputID    int,
    TableID	int,
    Type	int,
    DBFieldName   varchar(40),
    PageFieldName	varchar(40)
)
GO
/* ���ݵ��������� */
CREATE TABLE Workflow_DataInput_condition(
    id  int NOT NULL IDENTITY (1, 1),
    DataInputID    int,
    FieldName	varchar(40),
    Connection	int,
    Value   varchar(200)
)
GO

/*�������ӹ�ϵ��*/
CREATE TABLE Workflow_billdetailtable(
    id  int NOT NULL IDENTITY (1, 1),
    billid    int,
    tablename   varchar(50),
    title	varchar(200),
    orderid   int default 0
)
GO
/*����һ�д����ϸ�����*/
alter table workflow_billfield add  detailtable varchar(50) 
GO