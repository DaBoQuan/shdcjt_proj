/*�޸�workflow_nodelink��ṹ����¼��������*/
ALTER TABLE workflow_nodelink ADD conditioncn varchar(200) NULL
/
/*������������Ϊԭ��Ӣ����������ֹԭ�����̵�������ʾΪ��*/
UPDATE workflow_nodelink SET conditioncn=condition
/
