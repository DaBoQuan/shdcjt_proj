alter table leftmenuinfo add module varchar(30)
/

alter table mainmenuinfo add module varchar(30)
/

/*���*/
/*��Ϣ����*/
update leftmenuinfo set module='info' where id=111
/

/*�ҵ�Э��*/
update leftmenuinfo set module='cwork' where id=80
/

/*�ҵ�����*/
update leftmenuinfo set module='workflow' where id=1
/

/*�ҵ�֪ʶ*/
update leftmenuinfo set module='doc' where id=2
/

/*�ҵĿͻ�*/
update leftmenuinfo set module='crm' where id=3
/

/* �ҵ�����*/
update leftmenuinfo set module='hrm' where id=5
/

/*�ҵ���Ŀ*/
update leftmenuinfo set module='proj' where id=4
/

/*�ҵ��ʲ�*/
update leftmenuinfo set module='cpt' where id=7
/

/*�ҵĻ���*/
update leftmenuinfo set module='meeting' where id=6
/

/*�ҵ�ͨ��*/
update leftmenuinfo set module='message' where id=107
/

/* �ҵı���*/
update leftmenuinfo set module='report' where id=110
/

/*�ҵ��ճ�*/
update leftmenuinfo set module='scheme' where id=140
/

/*��������*/
update leftmenuinfo set module='car' where id=144
/

/*�ҵ����*/
update leftmenuinfo set module='photo' where id=199
/

/*����*/
/*��������*/
update mainmenuinfo set module='workflow' where id=4
/

/*֪ʶ����*/
update mainmenuinfo set module='doc' where id=2
/

/*������Դ*/
update mainmenuinfo set module='hrm' where id=3
/

/*�ͻ�����*/
update mainmenuinfo set module='crm' where id=5
/

/*��Ŀ����*/
update mainmenuinfo set module='proj' where id=6
/

/*�������*/
update mainmenuinfo set module='finance' where id=7
/

/*�ʲ�����*/
update mainmenuinfo set module='cpt' where id=8
/

/*�Ż�����*/
update mainmenuinfo set module='portal' where id=624
/

/*��������*/
update mainmenuinfo set module='setting' where id=11
/
