/*删除信息中心里的外部情报二级菜单*/
DELETE FROM LeftMenuInfo WHERE id=117
/


/*Label*/
INSERT INTO HtmlLabelIndex values(18482,'查询日程') 
/
INSERT INTO HtmlLabelIndex values(18484,'日程周报') 
/
INSERT INTO HtmlLabelIndex values(18485,'日程月报') 
/
INSERT INTO HtmlLabelIndex values(18486,'日程季报') 
/
INSERT INTO HtmlLabelIndex values(18487,'日程年报') 
/
INSERT INTO HtmlLabelIndex values(18480,'我的日程') 
/
INSERT INTO HtmlLabelIndex values(18488,'动态报表') 
/
INSERT INTO HtmlLabelIndex values(18489,'日程报告') 
/
INSERT INTO HtmlLabelIndex values(18481,'新建日程') 
/
INSERT INTO HtmlLabelIndex values(18483,'日程日报') 
/
INSERT INTO HtmlLabelInfo VALUES(18480,'我的日程',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18480,'My Schedule',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18481,'新建日程',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18481,'New Schedule',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18482,'查询日程',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18482,'Search Schedule',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18483,'日程日报',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18483,'Schedule Daily Report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18484,'日程周报',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18484,'Schedule Weekly Report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18485,'日程月报',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18485,'Schedule Monthly Report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18486,'日程季报',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18486,'Schedule Season Report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18487,'日程年报',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18487,'Schedule Yearly Report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18488,'动态报表',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18488,'Dynamic Report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(18489,'日程报告',7) 
/
INSERT INTO HtmlLabelInfo VALUES(18489,'Schedule Report',8) 
/




/*添加我的日程顶级菜单*/
call LMConfig_U_ByInfoInsert (1,NULL,15)
/
call LMInfo_Insert (140,18480,NULL,NULL,1,NULL,15,2)
/
UPDATE LeftMenuInfo SET iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyPlan.gif' WHERE id=140
/

/*更新我的日程二、三级菜单*/
UPDATE LeftMenuInfo SET labelId=18480,iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyPlan.gif',parentId=140 WHERE id=97
/
UPDATE LeftMenuInfo SET labelId=18481 WHERE id=59
/
UPDATE LeftMenuInfo SET labelId=18480 WHERE id=60
/
UPDATE LeftMenuInfo SET labelId=18482 WHERE id=61
/

/*更新日程报告二、三级菜单*/
UPDATE LeftMenuInfo SET labelId=18489,iconUrl='/images_face/ecologyFace_2/LeftMenuIcon/MyReport.gif',parentId=140 WHERE id=98
/
UPDATE LeftMenuInfo SET labelId=18483,parentId=98 WHERE id=62
/
UPDATE LeftMenuInfo SET labelId=18484,parentId=98 WHERE id=63
/
UPDATE LeftMenuInfo SET labelId=18485,parentId=98 WHERE id=64
/
UPDATE LeftMenuInfo SET labelId=18486,parentId=98 WHERE id=65
/
UPDATE LeftMenuInfo SET labelId=18487,parentId=98 WHERE id=66
/
UPDATE LeftMenuInfo SET labelId=18488,parentId=98 WHERE id=67
/

UPDATE LeftMenuInfo SET linkAddress='javascript:void(0)' WHERE id=97 OR id=98
/