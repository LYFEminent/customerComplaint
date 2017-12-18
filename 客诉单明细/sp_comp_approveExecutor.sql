use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.20>
-- Description:	<客诉保存执行信息>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_approveExecutor]
	@no nvarchar(50),
	@isAgree nvarchar(20),
	@actualPrice decimal(18,2),
	@finishedDate nvarchar(20),
	@uid int,
	@uname nvarchar(20),
	@retValue bit output
AS
BEGIN
	begin transaction
    update GuestComp_Mstr
	set ExecuteResult = @isAgree,
		ActualAmount = @actualPrice,
		FinishedDate = @finishedDate,
		ExecuteBy = @uid,
		ExecuteName = @uname,
		GuestComp_Staus = 1
	where GuestComplaintNo = @no

	if(@@ERROR <> 0)
	begin
		set @retValue = 0
		rollback transaction
	end
	else
	begin
		set @retValue = 1
		commit transaction
	end
END
GO
