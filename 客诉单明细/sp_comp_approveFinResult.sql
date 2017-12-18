use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.22>
-- Description:	<���߲�������>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_approveFinResult]
	@no nvarchar(50),
	@isAgree nvarchar(20),
	@uid int,
	@uname nvarchar(20),
	@retValue bit output
AS
BEGIN
	begin transaction
	if(@isAgree = N'ͬ��')
	begin
		update GuestComp_Mstr
		set FinanceResult = @isAgree,
			FinanceResultBy = @uid,
			FinanceResultName = @uname
		where GuestComplaintNo = @no
	end
	else
	begin
	    --�޸Ĳ���۸�Ϊnull
		update ApproachDeciding
		set FinancePrice = null
		where GuestCompNo = @no

		update GuestComp_Mstr
		set FinanceResult = @isAgree,			
			FinanceResultBy = @uid,
			FinanceResultName = @uname
		where GuestComplaintNo = @no
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
