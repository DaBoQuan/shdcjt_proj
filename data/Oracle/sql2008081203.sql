CREATE TABLE DocHandwrittenColor ( 
    id integer NOT NULL ,
    nameCn varchar2(40) NULL,
    nameEn varchar2(40) NULL,
    hexRGB char(7) NULL
)  
/

insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(1,'��ɫ','red','#FF0000')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(2,'��ɫ','blue','#0000FF')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(3,'��ɫ','green','#008000')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(4,'������','blueviolet','#8A2BE2')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(5,'�ۺ�','pink','#FFC0CB')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(6,'���(�����ɫ)','crimson','#DC143C')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(7,'����','turquoise','#40E0D0')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(8,'����(���ɫ)','lime','#00FF00')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(9,'��ɫ','cyan','#00FFFF')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(10,'����(����ɫ)','darkblue','#00008B')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(11,'���(���ƺ�ɫ)','darkkhaki','#BDB76B')
/
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(12,'��ɫ-50%(����ɫ)','darkgray','#A9A9A9')
/


CREATE TABLE DocHandwrittenDetail ( 
    id integer NOT NULL ,
    docId integer NULL,
    docEditionId integer NULL,
    userName varchar2(40) NULL,
    colorId integer NULL
)  
/

create sequence DocHandwrittenDetail_id
start with 1
increment by 1
nomaxvalue
nocycle
/


create or replace trigger DocHandwrittenDetail_Tri
before insert on DocHandwrittenDetail
for each row
begin
select DocHandwrittenDetail_id.nextval into :new.id from dual;
end;
/