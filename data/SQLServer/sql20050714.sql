/*FOR BUG 2264 �������������Ƿ����ò��ܱ�ɾ����*/
ALTER PROCEDURE FnaBudgetfeeType_Delete 
(@id int, @flag int output, 
@msg varchar(80) output)
AS
DECLARE @typeId integer
IF EXISTS (SELECT feetypeid FROM bill_expensedetail WHERE feetypeid = @id) OR
EXISTS (SELECT id FROM FnaBudgetCheckDetail WHERE budgettypeid = @id)
BEGIN
SELECT -1 RETURN
END
ELSE
DELETE fnaBudgetfeetype WHERE id = @id 
GO