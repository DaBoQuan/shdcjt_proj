alter table leftmenuinfo add module varchar(30)
GO

alter table mainmenuinfo add module varchar(30)
GO

/*���*/
/*��Ϣ����*/
update leftmenuinfo set module='info' where id=111
GO

/*�ҵ�Э��*/
update leftmenuinfo set module='cwork' where id=80
GO

/*�ҵ�����*/
update leftmenuinfo set module='workflow' where id=1
GO

/*�ҵ�֪ʶ*/
update leftmenuinfo set module='doc' where id=2
GO

/*�ҵĿͻ�*/
update leftmenuinfo set module='crm' where id=3
GO

/* �ҵ�����*/
update leftmenuinfo set module='hrm' where id=5
GO

/*�ҵ���Ŀ*/
update leftmenuinfo set module='proj' where id=4
GO

/*�ҵ��ʲ�*/
update leftmenuinfo set module='cpt' where id=7
GO

/*�ҵĻ���*/
update leftmenuinfo set module='meeting' where id=6
GO

/*�ҵ�ͨ��*/
update leftmenuinfo set module='message' where id=107
GO

/* �ҵı���*/
update leftmenuinfo set module='report' where id=110
GO

/*�ҵ��ճ�*/
update leftmenuinfo set module='scheme' where id=140
GO

/*��������*/
update leftmenuinfo set module='car' where id=144
GO

/*�ҵ����*/
update leftmenuinfo set module='photo' where id=199
GO

/*����*/
/*��������*/
update mainmenuinfo set module='workflow' where id=4
GO

/*֪ʶ����*/
update mainmenuinfo set module='doc' where id=2
GO

/*������Դ*/
update mainmenuinfo set module='hrm' where id=3
GO

/*�ͻ�����*/
update mainmenuinfo set module='crm' where id=5
GO

/*��Ŀ����*/
update mainmenuinfo set module='proj' where id=6
GO

/*�������*/
update mainmenuinfo set module='finance' where id=7
GO

/*�ʲ�����*/
update mainmenuinfo set module='cpt' where id=8
GO

/*�Ż�����*/
update mainmenuinfo set module='portal' where id=624
GO

/*��������*/
update mainmenuinfo set module='setting' where id=11
GO
