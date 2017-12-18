use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.30>
-- Description:	<检查财务填写价格是否全为空>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_checkALLPriceIsNull]
@GuestCompNo nvarchar(50)
AS
BEGIN
	declare @financePrice nvarchar(50)
	select @financePrice = FinancePrice
	from ApproachDeciding
	where GuestCompNo = @GuestCompNo

	IF(@financePrice is null)
	BEGIN
		SELECT 1                  
	END
	ELSE
	BEGIN
		SELECT 0                      
	END                      
END
GO
