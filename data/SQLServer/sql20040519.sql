/*FOR BUG 517*/
INSERT INTO HtmlLabelIndex values(17428,'ϵͳ��֧��10�����ϵ���֯�ṹ') 
GO
INSERT INTO HtmlLabelInfo VALUES(17428,'ϵͳ��֧��10�����ϵ���֯�ṹ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17428,'The system doesn''t support 10 level of department',8) 
GO
/*FOR BUG 454*/
UPDATE Meeting SET meetingstatus = 2 WHERE isapproved >=2
GO
