insert into HtmlNoteIndex (id,indexdesc) values (55,'����ʱ�������ڿ�ʼʱ�䣡') 
GO

insert into HtmlNoteInfo (indexid,notename,languageid) values (55, '����ʱ�������ڿ�ʼʱ�䣡', 7) 
GO
insert into HtmlNoteInfo (indexid,notename,languageid) values (55, 'The end time must later than the start time!', 8) 
GO
insert into HtmlNoteIndex (id,indexdesc) values (54,'�������ڱ�����ڿ�ʼ���ڣ�') 
go

insert into HtmlNoteInfo (indexid,notename,languageid) values (54, '�������ڱ�����ڿ�ʼ���ڣ�', 7) 
go
insert into HtmlNoteInfo (indexid,notename,languageid) values (54, 'The end date must later than the start date!', 8) 
go
ALTER TABLE HrmResource ADD countryid int DEFAULT 1
GO

UPDATE HrmResource SET countryid = 1
go