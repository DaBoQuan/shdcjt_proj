alter table sap_service add loadDate integer
/
update sap_service set loadDate=0
/  
update int_dataInter set dataname='WEBSERVICE���ݽ���',datadesc='�칹ϵͳ�����ͬһ��׼��ͨ������������WEBSERVICE��ʵ��ϵͳ������ݽ�����' where id=2 
/