insert into HtmlNoteIndex (id,indexdesc) values (55,'����ʱ�������ڿ�ʼʱ�䣡') 
/

insert into HtmlNoteInfo (indexid,notename,languageid) values (55, '����ʱ�������ڿ�ʼʱ�䣡', 7) 
/
insert into HtmlNoteInfo (indexid,notename,languageid) values (55, 'The end time must later than the start time!', 8) 
/
insert into HtmlNoteIndex (id,indexdesc) values (54,'�������ڱ�����ڿ�ʼ���ڣ�') 
/

insert into HtmlNoteInfo (indexid,notename,languageid) values (54, '�������ڱ�����ڿ�ʼ���ڣ�', 7) 
/
insert into HtmlNoteInfo (indexid,notename,languageid) values (54, 'The end date must later than the start date!', 8) 
/
ALTER TABLE HrmResource ADD countryid integer DEFAULT 1
/

UPDATE HrmResource SET countryid = 1
/