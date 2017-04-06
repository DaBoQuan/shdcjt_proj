/*����֪�����ı�*/
CREATE TABLE DocSubscribe (
	id int  IDENTITY (1, 1) NOT NULL,
	docId int NULL  ,
	hrmId int NULL  ,
    ownerId int null,
    subscribeDate char(10) NULL ,
    approveDate  char(10) NULL ,
    searchCase     varchar(500) NULL,
    otherSubscribe  varchar(500) NULL,
    subscribeDesc  varchar(500) NULL,
    getBackDesc	   varchar(500) NULL,
	state char (1)   NULL 
) 
GO


/*��ID(���ı�)ѡ����Ӧ�Ķ�����Ϣ*/

CREATE PROCEDURE DocSubscribe_SelectById(
    @id int ,	
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	select * from DocSubscribe where id =  @id
 GO


 /*��(�ĵ���ID)ѡ����Ӧ�Ķ�����Ϣ*/

CREATE PROCEDURE DocSubscribe_SelectByDocId(
    @Docid int ,	
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	select * from DocSubscribe where docid =  @Docid
 GO



/*����Ա��IDѡ����Ӧ�Ķ�����Ϣ*/

CREATE PROCEDURE DocSubscribe_SelectByHrmId(
    @HrmId int ,	
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	select * from DocSubscribe where hrmId =  @HrmId
 GO



/*���ĵ�ID����Ա��IDѡ����Ӧ�Ķ�����Ϣ*/

CREATE PROCEDURE DocSubscribe_SByDIdAndHId(
    @Docid int,
    @HrmId int ,	
    @flag integer output , 
    @msg varchar(80) output 
    )
    AS
	select * from DocSubscribe where docid= @Docid and hrmId =  @HrmId
 GO



 /*�Զ��ı���и���*/
CREATE PROCEDURE DocSubscribe_update(
    @id int ,	
    @docId int ,	
    @hrmId int ,
    @ownerId int,
    @subscribeDate char(10),
    @approveDate char(10),
    @searchCase     varchar(500) ,
    @subscribeDesc  varchar(500) ,
    @otherSubscribe  varchar(500) ,
    @getBackDesc	   varchar(500) ,
    @state char(1),
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	update DocSubscribe set docId=@docId,hrmId=@hrmId,ownerId=@ownerId,subscribeDate=@subscribeDate,approveDate=@approveDate,state=@state,searchCase=@searchCase,subscribeDesc=@subscribeDesc,getBackDesc=@getBackDesc,otherSubscribe=@otherSubscribe where id =  @id
 GO


/*�Զ��ı���в���*/

CREATE PROCEDURE DocSubscribe_Insert(
    @docId int ,	
    @hrmId int ,	
    @ownerId int,
    @subscribeDate char(10),
    @approveDate char(10),
    @searchCase     varchar(500) ,
    @subscribeDesc  varchar(500) ,
    @getBackDesc	   varchar(500) ,
    @otherSubscribe  varchar(500) ,
    @state char(1),	
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	insert into DocSubscribe(docId,hrmId,ownerId,subscribeDate,approveDate,searchCase,subscribeDesc,getBackDesc,state,otherSubscribe) values (@docId,@hrmId,@ownerId,@subscribeDate,@approveDate,@searchCase,@subscribeDesc,@getBackDesc,@state,@otherSubscribe)
    select max(id) from DocSubscribe
 GO

 

/*�Զ��ı�id����ɾ��*/

CREATE PROCEDURE DocSubscribe_DeleteById(
    @id int ,	
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	delete DocSubscribe where id =  @id
 GO


/*ֻ��״̬�������ĵ�����������*/
CREATE PROCEDURE DocSubscribe_updateSandO(
    @id int ,	
    @state char(1) ,
    @otherSubscribe  varchar(500) ,
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	update DocSubscribe set state = @state,otherSubscribe=@otherSubscribe where id =  @id
 GO




 CREATE PROCEDURE DocSubscribe_UsateByDidSid(
    @docid int,	
    @hrmid int,	
    @state char(1) , 
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	update DocSubscribe set state = @state where docid =  @docid and hrmid = @hrmid
 GO



