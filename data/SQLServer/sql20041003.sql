alter procedure HrmResourceDateCheck
 (@today_1 char(10),
  @flag int output, @msg varchar(60) output)
 as 
 /* ���������ڵ��˵���Ա��Ϊ��Ч״̬ */
 update HrmResource set status = 7 where (status = 0 or status = 1 or status = 2 or status = 3) and enddate < @today_1 and enddate <>'' and enddate is not null
 
 /* ���������ڵ��˵���Ա��Ϊ��������״̬ */
 update HrmResource set status = 3 where status = 0 and probationenddate < @today_1 and probationenddate<>'' and probationenddate is not null

 /* ����������δ������Ա���������ڸĻ�����״̬ */
 update HrmResource set status = 0 where status = 3 and (probationenddate >= @today_1 or probationenddate='' or probationenddate is null)
GO

