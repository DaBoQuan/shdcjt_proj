DELETE FROM HtmlNoteIndex WHERE id = 91
/

DELETE FROM HtmlNoteInfo WHERE indexId = 91
/

INSERT INTO HtmlNoteIndex(id, indexdesc)
VALUES(91, '���Ѿ����������û��������޷��������̴���')
/

INSERT INTO HtmlNoteInfo(indexId, noteName, languageId)
VALUES(91, '���Ѿ������������û������̣��޷��������̴���', 7)
/

INSERT INTO HtmlNoteInfo(indexId, noteName, languageId)
VALUES(91, 'You cannot use this function because you have substituted some work flows of other user.', 8)
/