use rmInspection

-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.16>
-- Description:	<ȡ�����ڴ���ķ���>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_selectDecidingApproach] --exec sp_comp_selectDecidingApproach 'KS17112801'
@GuestCompNo nvarchar(50)
AS
BEGIN
	select ID,FinanceApproachID,FinanceApproachName,FinancePrice
	from ApproachDeciding
	where GuestCompNo = @GuestCompNo
END
GO
