USE [Choyang]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[xp_Order_sOrderOne]
		@OrderID = N'2024010138'

SELECT	'Return Value' = @return_value

GO
--가공주의사항:finishkind//사용면:stuffwidthname(??)
--작업중량:stuffweight