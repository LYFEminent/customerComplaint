use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.20>
-- Description:	<同意反馈信息>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_approvefeedback] 
	@no nvarchar(50),
	@isAgree nvarchar(20),
	@shipNo nvarchar(50),
	@shipPartNo nvarchar(max),
	@shipNum int,
	@shipDate nvarchar(20),
	@uid int,
	@uname nvarchar(20),
	@retValue bit output
AS
BEGIN
	begin transaction
	if(@isAgree = N'同意')
	begin
		update GuestComp_Mstr
		set FeedbackResult = @isAgree,
			ShipPlanNo = @shipNo,
			ShipPartNo = @shipPartNo,
			ShipNum = @shipNum,
			ShipDate = @shipDate,
			FeedbackResultBy = @uid,
			FeedbackResultName = @uname
		where GuestComplaintNo = @no
	end
	else
	begin
		update GuestComp_Mstr
		set FeedbackResult = @isAgree,
			ShipPlanNo = null,
			ShipPartNo = null,
			ShipNum = null,
			ShipDate = null,
			FeedbackResultBy = @uid,
			FeedbackResultName = @uname
		where GuestComplaintNo = @no

		delete from GuestCompDisposedDet
		where DisposedNo = @no and DisposedModuleID = 2


	end
    

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
