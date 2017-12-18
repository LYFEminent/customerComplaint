use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.16>
-- Description:	<更新价格>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_updateDecidingApproach]
	@id nvarchar(50),
	@price float,
	@uID int,
	@uName nvarchar(20)
	
AS
BEGIN
	update ApproachDeciding
	set FinancePrice = @price,
	    FinanceCreatedBy = @uID,
		FinanceCreatedName = @uName,
		FinanceCreatedDate = GETDATE()
	where ID = @id 

END
GO
