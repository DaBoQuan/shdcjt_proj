CREATE TABLE DocHandwrittenColor ( 
    id int NOT NULL ,
    nameCn varchar(40) NULL,
    nameEn varchar(40) NULL,
    hexRGB char(7) NULL
)  
GO

insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(1,'��ɫ','red','#FF0000')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(2,'��ɫ','blue','#0000FF')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(3,'��ɫ','green','#008000')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(4,'������','blueviolet','#8A2BE2')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(5,'�ۺ�','pink','#FFC0CB')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(6,'���(�����ɫ)','crimson','#DC143C')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(7,'����','turquoise','#40E0D0')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(8,'����(���ɫ)','lime','#00FF00')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(9,'��ɫ','cyan','#00FFFF')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(10,'����(����ɫ)','darkblue','#00008B')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(11,'���(���ƺ�ɫ)','darkkhaki','#BDB76B')
GO
insert into DocHandwrittenColor(id,nameCn,nameEn,hexRGB)  values(12,'��ɫ-50%(����ɫ)','darkgray','#A9A9A9')
GO


CREATE TABLE DocHandwrittenDetail ( 
    id int identity (1, 1) NOT NULL ,
    docId int NULL,
    docEditionId int NULL,
    userName varchar(40) NULL,
    colorId int NULL
)  
GO
