ALTER TABLE HrmRoles ADD  isdefault char(1) NULL /*�Ƿ���ϵͳ��ʼ���Ľ�ɫ*/
GO

UPDATE HrmRoles SET isdefault = 1 WHERE ID <=11 /*����ϵͳ��ʼ���Ľ�ɫ��isdefault�ֶ� Ϊ1
            ֻ����id<11�Ľ�ɫ����Ϊ��ߵ��п����Ǵ����ȥ�ģ�Id ����ȷ��
                        1           ��˾����Ա
                        2           ϵͳ����Ա
                        3           �ĵ�����Ա
                        4           ������Դ����Ա
                        5           �������Ա
                        6           ������Ա
                        7           �ʲ�����Ա
                        8           CRM����Ա
                        9           ��Ŀ����Ա
                        10          ����������Ա
                        11          �����ҹ���Ա*/
GO
