CREATE TABLE workflow_urgerdetail(
    id int NOT NULL IDENTITY (1, 1),
    workflowid int,/*������ID*/
    utype int,/*����������*/
    objid int,/*��������ID*/
    level_n int,/*�㼶1*/
    level2_n int,/*�㼶2*/
    conditions varchar(1000),/*����*/
    conditioncn varchar(1000)/*��������*/
)
GO

alter table workflow_monitor_bound add isview int default(0)
GO
