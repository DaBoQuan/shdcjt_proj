/*修改workflow_nodelink表结构，记录中文条件*/
ALTER TABLE workflow_nodelink ADD conditioncn varchar(200) NULL
/
/*更新中文条件为原有英文条件，防止原有流程的条件显示为空*/
UPDATE workflow_nodelink SET conditioncn=condition
/
