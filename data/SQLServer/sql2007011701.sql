DELETE FROM HtmlNoteIndex WHERE id = 91
GO

DELETE FROM HtmlNoteInfo WHERE indexId = 91
GO

INSERT INTO HtmlNoteIndex(id, indexdesc)
VALUES(91, '���Ѿ����������û��������޷��������̴���')
GO

INSERT INTO HtmlNoteInfo(indexId, noteName, languageId)
VALUES(91, '���Ѿ������������û������̣��޷��������̴���', 7)
GO

INSERT INTO HtmlNoteInfo(indexId, noteName, languageId)
VALUES(91, 'You cannot use this function because you have substituted some work flows of other user.', 8)
GO