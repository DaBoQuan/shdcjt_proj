CREATE TABLE secCreaterDocPope (
    id  integer  NOT NULL,
	secid integer NOT NULL ,  /*��Ŀ¼��ID �����ֺͷ�Ŀ¼���ID�����*/ 
	PCreater integer NOT NULL ,   /*�����˵�Ȩ��*/
	PCreaterManager integer NOT NULL , /*�����˵�ֱ���ϼ���Ȩ��*/
	PCreaterJmanager integer NOT NULL , /*�����˵ļ���ϼ���Ȩ��*/
	PCreaterDownOwner integer NOT NULL , /*�����˵�������Ȩ��*/
	PCreaterSubComp integer NOT NULL , /*�����˵ķֲ���Ȩ��*/
	PCreaterDepart integer NOT NULL , /*�����˵Ĳ��ŵ�Ĭ�ϵ�Ȩ��*/
	PCreaterDownOwnerLS integer NOT NULL , /*�����˵������İ�ȫ����ʼ��*/
	PCreaterSubCompLS integer NOT NULL , /*�����˵ķֲ��İ�ȫ����ʼ��*/	
	PCreaterDepartLS integer NOT NULL , /*�����˵Ĳ��ŵİ�ȫ����ʼ��*/

    PCreaterW integer NOT NULL ,   /*�ⲿ�����˵�Ȩ��*/
	PCreaterManagerW integer NOT NULL , /*�ⲿ�����˵ľ����Ȩ��*/
	PCreaterJmanagerW integer NOT NULL  /*�ⲿ�����˵ľ�����ϼ���Ȩ��*/
)
/
create sequence secCreDocPop_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger secCreDocPop_Trigger
before insert on secCreaterDocPope
for each row
begin
select secCreDocPop_id.nextval into :new.id from dual;
end;
/

/*�Ƿ������޸����ڲ���Ա�����ĵ�ʱ��ԭĬ�Ϲ��� 1:����  0:������*/
alter table DocSecCategory add allownModiMShareL integer 
/

 /*�Ƿ������޸����ⲿ��Ա�����ĵ�ʱ��ԭĬ�Ϲ��� 1:����  0:������*/
alter table DocSecCategory add allownModiMShareW integer
/

/*��ʼ����ǰ�ĵ�������е�����*/
update docsharedetail set sharelevel=3 where sharelevel=2
/
update docshare set sharetype=3 where sharetype=2
/
alter table docshare add  isSecDefaultShare char(1)/*��Ȩ���Ƿ���Ŀ¼��Ĭ��Ȩ��  1:�� 0:����*/
/