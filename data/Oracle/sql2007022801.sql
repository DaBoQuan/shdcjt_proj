DELETE FROM HtmlLabelIndex WHERE id >= 20216 and id<=20220
/
DELETE FROM HtmlLabelInfo WHERE  indexId>= 20216 and indexId<=20220
/
DELETE FROM HtmlLabelIndex WHERE id >= 20222 and id<=20224
/
DELETE FROM HtmlLabelInfo WHERE  indexId>= 20222 and indexId<=20224
/
DELETE FROM HtmlLabelIndex WHERE id = 20198
/
DELETE FROM HtmlLabelInfo WHERE indexId = 20198
/
DELETE FROM HtmlLabelIndex WHERE id = 20201
/
DELETE FROM HtmlLabelInfo WHERE indexId = 20201
/
DELETE FROM HtmlLabelIndex WHERE id = 20200
/
DELETE FROM HtmlLabelInfo WHERE indexId = 20200
/

DELETE FROM HtmlLabelIndex WHERE id = 20202
/
DELETE FROM HtmlLabelInfo WHERE indexId = 20202
/
INSERT INTO HtmlLabelIndex values(20198,'中盐公文转换') 
/
INSERT INTO HtmlLabelInfo VALUES(20198,'中盐公文转换',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20198,'Zhong Yan Archives Convert',8) 
/  
INSERT INTO HtmlLabelIndex values(20201,'中盐公文盖章') 
/
INSERT INTO HtmlLabelInfo VALUES(20200,'中盐公文套红',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20200,'Zhong Yan Archive Templet',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20201,'中盐公文盖章',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20201,'Zhong Yan Archive Stamp',8) 
/
INSERT INTO HtmlLabelIndex values(20200,'中盐公文套红') 
/
INSERT INTO HtmlLabelIndex values(20202,'中盐公文发文') 
/
INSERT INTO HtmlLabelInfo VALUES(20202,'中盐公文发文',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20202,'Zhong Yan Archive Public',8) 
/
INSERT INTO HtmlLabelIndex values(20197,'中盐公文流转单') 
/
INSERT INTO HtmlLabelIndex values(20216,'发文单位') 
/
INSERT INTO HtmlLabelIndex values(20218,'发文类型') 
/
INSERT INTO HtmlLabelIndex values(20217,'收文单位') 
/
INSERT INTO HtmlLabelIndex values(20219,'打印份数') 
/
INSERT INTO HtmlLabelInfo VALUES(20197,'中盐公文流转单',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20216,'发文单位',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20217,'收文单位',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20218,'发文类型',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20219,'打印份数',7) 
/
INSERT INTO HtmlLabelIndex values(20220,'公文附件') 
/
INSERT INTO HtmlLabelInfo VALUES(20220,'公文附件',7) 
/

INSERT INTO HtmlLabelIndex values(20222,'中盐公文收文单') 
/
INSERT INTO HtmlLabelIndex values(20223,'中盐公文收文') 
/
INSERT INTO HtmlLabelIndex values(20224,'中盐公文附件') 
/
INSERT INTO HtmlLabelInfo VALUES(20222,'中盐公文收文单',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20223,'中盐公文收文',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20223,'',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20224,'中盐公文附件',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20224,'中盐公文附件',8) 
/