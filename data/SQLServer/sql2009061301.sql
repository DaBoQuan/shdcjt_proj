delete from SystemRightDetail where rightid = 855
GO
delete from SystemRightsLanguage where id = 855
GO
delete from SystemRights where id = 855
GO
insert into SystemRights (id,rightdesc,righttype) values (855,'�ⲿ���ݴ�����������','5') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (855,7,'�ⲿ���ݴ�����������','�ⲿ���ݴ�����������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (855,8,'workflow for outside data setting','workflow for outside data setting') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (855,9,'�ⲿ�����|�l�����O��','�ⲿ�����|�l�����O��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4370,'�ⲿ���ݴ�����������','OutDataInterface:Setting',855) 
GO

delete from HtmlLabelIndex where id=23076 
GO
delete from HtmlLabelInfo where indexid=23076 
GO
INSERT INTO HtmlLabelIndex values(23076,'�ⲿ���ݴ�����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(23076,'�ⲿ���ݴ�����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23076,'workflow for outside data setting',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23076,'�ⲿ�����|�l�����O��',9) 
GO

delete from HtmlLabelIndex where id=19928 
GO
delete from HtmlLabelInfo where indexid=19928 
GO
INSERT INTO HtmlLabelIndex values(19928,'�ⲿ�ӿ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19928,'�ⲿ�ӿ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19928,'Interface Setting',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19928,'�ⲿ�ӿ��O��',9) 
GO

delete from HtmlLabelIndex where id=21900 
GO
delete from HtmlLabelInfo where indexid=21900 
GO
INSERT INTO HtmlLabelIndex values(21900,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(21900,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21900,'Table Name',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21900,'����',9) 
GO

delete from HtmlLabelIndex where id=23107 
GO
delete from HtmlLabelInfo where indexid=23107 
GO
INSERT INTO HtmlLabelIndex values(23107,'�ⲿ�����д����') 
GO
INSERT INTO HtmlLabelInfo VALUES(23107,'�ⲿ�����д����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23107,'setting of writing outer main table',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23107,'�ⲿ����،��O��',9) 
GO
delete from HtmlLabelIndex where id=23108 
GO
delete from HtmlLabelInfo where indexid=23108 
GO
INSERT INTO HtmlLabelIndex values(23108,'���̴����ɹ�ʱ') 
GO
INSERT INTO HtmlLabelInfo VALUES(23108,'���̴����ɹ�ʱ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23108,'when workflow is created successful',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23108,'�����|�l�ɹ��r',9) 
GO

delete from HtmlLabelIndex where id=23109 
GO
delete from HtmlLabelInfo where indexid=23109 
GO
INSERT INTO HtmlLabelIndex values(23109,'���̴���ʧ��ʱ') 
GO
INSERT INTO HtmlLabelInfo VALUES(23109,'���̴���ʧ��ʱ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23109,'when workflow is created unsuccessful',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23109,'�����|�lʧ���r',9) 
GO

delete from HtmlLabelIndex where id=23111 
GO
delete from HtmlLabelInfo where indexid=23111 
GO
INSERT INTO HtmlLabelIndex values(23111,'����˵��1') 
GO
delete from HtmlLabelIndex where id=23110 
GO
delete from HtmlLabelInfo where indexid=23110 
GO
INSERT INTO HtmlLabelIndex values(23110,'����˵��2') 
GO
INSERT INTO HtmlLabelInfo VALUES(23110,'�����ԡ�where����ͷ���磺��where fieldname1=1 and fieldname2=''value2''������д�����ԡ�set����ͷ���磺��set flag=1,isok=true����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23110,'condition begin with "where",such as "where where fieldname1=1 and fieldname2=''''''''value2''''''''",return sql begin with "set",such as "set flag=1,isok=true"',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23110,'�l���ԡ�where���_�^���磺��where fieldname1=1 and fieldname2=''value2''�����،��O���ԡ�set���_�^���磺��set flag=1,isok=true����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(23111,'˵�����������Զ�����ʱ���������ⲿ�������������ⲿ�����ж�������¼���������������̣��������ֶε�ֵ��Դ���ⲿ������ÿ�����̵ĸ���ϸֵ���ֱ������ϸ������������ϸ��õ��Ľ�����и�ֵ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23111,'remark:',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23111,'�f����ԓ�����Ԅ��|�l�r���������ⲿ����l�������ⲿ�����ж��ٗlӛ䛼��|�l���ٗl���̣��������ֶε�ֵ��Դ��ⲿ������ÿ�l���̵ĸ�����ֵ���քe����������l������������õ��ĽY���M���xֵ��',9) 
GO

delete from HtmlLabelIndex where id=23112 
GO
delete from HtmlLabelInfo where indexid=23112 
GO
INSERT INTO HtmlLabelIndex values(23112,'������������') 
GO
INSERT INTO HtmlLabelInfo VALUES(23112,'������������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23112,'period setting of trigger',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23112,'�|�l�����O��',9) 
GO

delete from HtmlLabelIndex where id=23136 
GO
delete from HtmlLabelInfo where indexid=23136 
GO
INSERT INTO HtmlLabelIndex values(23136,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(23136,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23136,'period of trigger',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23136,'�|�l����',9) 
GO

delete from HtmlLabelIndex where id=23137 
GO
delete from HtmlLabelInfo where indexid=23137 
GO
INSERT INTO HtmlLabelIndex values(23137,'�Է���Ϊ��λ') 
GO
INSERT INTO HtmlLabelInfo VALUES(23137,'�Է���Ϊ��λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23137,'by minute',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23137,'�Է�犞��λ',9) 
GO

delete from HtmlLabelIndex where id=23113 
GO
delete from HtmlLabelInfo where indexid=23113 
GO
INSERT INTO HtmlLabelIndex values(23113,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(23113,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23113,'workflow that is triggered',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23113,'�|�l����',9) 
GO

delete from HtmlLabelIndex where id=23123 
GO
delete from HtmlLabelInfo where indexid=23123 
GO
INSERT INTO HtmlLabelIndex values(23123,'˵����ѡ���ⲿ�ֶ��������ֶ�һһ��Ӧ���ڽ��ⲿ�ֶθ�ֵ�Ĺ����У�����ⲿ�ֶε����ݿ������������ֶ����Ͳ�ƥ�佫�����¹�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(23123,'˵����ѡ���ⲿ�ֶ��������ֶ�һһ��Ӧ���ڽ��ⲿ�ֶθ�ֵ�Ĺ����У�����ⲿ�ֶε����ݿ������������ֶ����Ͳ�ƥ�佫�����¹�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23123,'Note: Select the external field-one correspondence with the flow field, external field in the process of assignment, if the external database field types and field types do not match the process according to the following rules:',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23123,'�f�����x���ⲿ�ֶ��c�����ֶ�һһ�������ڌ��ⲿ�ֶ��xֵ���^���У�����ⲿ�ֶεĔ���������c�����ֶ���Ͳ�ƥ�䌢������Ҏ�t̎��',9) 
GO

delete from HtmlLabelIndex where id=23124 
GO
delete from HtmlLabelInfo where indexid=23124 
GO
INSERT INTO HtmlLabelIndex values(23124,'1�������ֶ����ַ��ͣ�����ⲿ���ݳ���������ⲿ���ݽ��н�λ��ֵ�������ֶΣ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(23124,'1�������ֶ����ַ��ͣ�����ⲿ���ݳ���������ⲿ���ݽ��н�λ��ֵ�������ֶΣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23124,'1: flow field is character, if the long external data, external data on post-cut-off value to the process field;',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23124,'1�������ֶ����ַ��ͣ�����ⲿ�������L���t���ⲿ�����M�н�λ���xֵ�o�����ֶΣ�',9) 
GO

delete from HtmlLabelIndex where id=23125 
GO
delete from HtmlLabelInfo where indexid=23125 
GO
INSERT INTO HtmlLabelIndex values(23125,'2�������ֶ������ͻ򸡵��ͣ�����ⲿ����Ϊ�ַ�����ֵ-1�������ֶΡ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(23125,'2�������ֶ������ͻ򸡵��ͣ�����ⲿ����Ϊ�ַ�����ֵ-1�������ֶΡ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23125,'2: flow field is integer or floating-point type, if the external data for the characters, -1 is assigned to the flow field.',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23125,'2�������ֶ������ͻ��c�ͣ�����ⲿ�������ַ����t�xֵ-1�o�����ֶΡ�',9) 
GO

delete from HtmlLabelIndex where id=23126 
GO
delete from HtmlLabelInfo where indexid=23126 
GO
INSERT INTO HtmlLabelIndex values(23126,'ת������ת������ֻ���������Դ����򣬲��������ͷֲ���������ѡ����ת�����򣬽�����ת�������ֶ����ⲿ�ֶζ�Ӧ����ͨ��ת���ֶ��ҵ�������Դ����򣬲��������ͷֲ�������Ӧ��ֵ��') 
GO
delete from HtmlLabelIndex where id=23127 
GO
delete from HtmlLabelInfo where indexid=23127 
GO
INSERT INTO HtmlLabelIndex values(23127,'���̱��⣺����ѡ��ĳ���ⲿ�ֶ���Ϊ���̱������Դ�����ûѡ�����̱��ⰴ��������-��������-���ڡ��ĸ�ʽ�Զ����ɡ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(23126,'ת������ת������ֻ���������Դ����򣬲��������ͷֲ���������ѡ����ת�����򣬽�����ת�������ֶ����ⲿ�ֶζ�Ӧ����ͨ��ת���ֶ��ҵ�������Դ����򣬲��������ͷֲ�������Ӧ��ֵ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23126,'Conversion rules: transformation rules only browser frame for human resources, departments, divisions browser browser box and the box, if you select the conversion rules, conversion rules will be in accordance with the external field and the corresponding',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23126,'�D�QҎ�t���D�QҎ�tֻᘌ������YԴ�g�[�򣬲��T�g�[��ͷֲ��g�[������x�����D�QҎ�t���������D�QҎ�t�ֶ��c�ⲿ�ֶΌ�������ͨ�^�D�Q�ֶ��ҵ������YԴ�g�[�򣬲��T�g�[��ͷֲ��g�[�򌦑���ֵ��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(23127,'���̱��⣺����ѡ��ĳ���ⲿ�ֶ���Ϊ���̱������Դ�����ûѡ�����̱��ⰴ��������-��������-���ڡ��ĸ�ʽ�Զ����ɡ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23127,'Process Title: can choose an external flow field as the source of the title, if not choice, the process according to the title of "the process of - the creation of names - the date" format automatically.',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23127,'���̘��}�������x��ĳ���ⲿ�ֶ��������̘��}�ā�Դ������]�x�����̘��}����������-��������-���ڡ��ĸ�ʽ�Ԅ����ɡ�',9) 
GO

delete from HtmlLabelIndex where id=23128 
GO
delete from HtmlLabelInfo where indexid=23128 
GO
INSERT INTO HtmlLabelIndex values(23128,'ת������') 
GO
INSERT INTO HtmlLabelInfo VALUES(23128,'ת������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23128,'Conversion rules',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23128,'�D�QҎ�t',9) 
GO

delete from HtmlLabelIndex where id=23135 
GO
delete from HtmlLabelInfo where indexid=23135 
GO
INSERT INTO HtmlLabelIndex values(23135,'�鵵ʱ�Ƿ��д') 
GO
INSERT INTO HtmlLabelInfo VALUES(23135,'�鵵ʱ�Ƿ��д',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23135,'if write back when the workflow is over',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23135,'�w�n�r�Ƿ�،�',9) 
GO

delete from HtmlLabelIndex where id=23138 
GO
delete from HtmlLabelInfo where indexid=23138 
GO
INSERT INTO HtmlLabelIndex values(23138,'���ĺ���Ҫ�������������Ч') 
GO
INSERT INTO HtmlLabelInfo VALUES(23138,'���ĺ���Ҫ�������������Ч',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(23138,'it is only actived when restart the service after it is changed',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(23138,'��������Ҫ�؆����ղ�����Ч',9) 
GO
