CREATE TABLE secCreaterDocPope (
    id  int identity(1,1) NOT NULL,
	secid int NOT NULL ,  /*��Ŀ¼��ID �����ֺͷ�Ŀ¼���ID�����*/ 
	PCreater int NOT NULL ,   /*�����˵�Ȩ��*/
	PCreaterManager int NOT NULL , /*�����˵�ֱ���ϼ���Ȩ��*/
	PCreaterJmanager int NOT NULL , /*�����˵ļ���ϼ���Ȩ��*/
	PCreaterDownOwner int NOT NULL , /*�����˵�������Ȩ��*/
	PCreaterSubComp int NOT NULL , /*�����˵ķֲ���Ȩ��*/
	PCreaterDepart int NOT NULL , /*�����˵Ĳ��ŵ�Ĭ�ϵ�Ȩ��*/
	PCreaterDownOwnerLS int NOT NULL , /*�����˵������İ�ȫ����ʼ��*/
	PCreaterSubCompLS int NOT NULL , /*�����˵ķֲ��İ�ȫ����ʼ��*/	
	PCreaterDepartLS int NOT NULL , /*�����˵Ĳ��ŵİ�ȫ����ʼ��*/

    PCreaterW int NOT NULL ,   /*�ⲿ�����˵�Ȩ��*/
	PCreaterManagerW int NOT NULL , /*�ⲿ�����˵ľ����Ȩ��*/
	PCreaterJmanagerW int NOT NULL  /*�ⲿ�����˵ľ�����ϼ���Ȩ��*/
)
GO

/*�Ƿ������޸����ڲ���Ա�����ĵ�ʱ��ԭĬ�Ϲ��� 1:����  0:������*/
alter table DocSecCategory add allownModiMShareL int 
GO

 /*�Ƿ������޸����ⲿ��Ա�����ĵ�ʱ��ԭĬ�Ϲ��� 1:����  0:������*/
alter table DocSecCategory add allownModiMShareW int
go


/*��ʼ����ǰ�ĵ�������е�����*/
update docsharedetail set sharelevel=3 where sharelevel=2
go

update docshare set sharetype=3 where sharetype=2
go
alter table docshare add  isSecDefaultShare char(1)/*��Ȩ���Ƿ���Ŀ¼��Ĭ��Ȩ��  1:�� 0:����*/
go