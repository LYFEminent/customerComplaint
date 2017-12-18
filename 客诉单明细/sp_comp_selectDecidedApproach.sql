use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.16>
-- Description:	<显示财务填写价格后信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_comp_selectDecidedApproach] --exec sp_comp_selectDecidedApproach 'KS17113001',1
	@GuestCompNo nvarchar(50),
	@isHavePrice  int
AS
BEGIN
	if(@isHavePrice = 0)
	begin
		select ID,FinanceApproachID,FinanceApproachName,FinancePrice
		from ApproachDeciding
		where FinancePrice > 0
		and GuestCompNo = @GuestCompNo
		and DecideApproachID is null
	end
	else
	begin
		select ID,FinanceApproachID,FinanceApproachName,FinancePrice
		from ApproachDeciding
		where FinancePrice > 0
		and GuestCompNo = @GuestCompNo
		and DecideApproachID is not null
		and FinancePrice is not null
	end
END
GO
