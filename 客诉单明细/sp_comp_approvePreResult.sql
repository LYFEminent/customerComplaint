use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.15>
-- Description:	<同意客诉初判结果>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_approvePreResult]
@no nvarchar(50),
@isAgree nvarchar(20),
@checkedDutys nvarchar(200),
@uid int,
@uname nvarchar(20),
@retValue bit output
AS
BEGIN
	begin transaction
	if(@isAgree = N'同意')
	begin
		update GuestComp_Mstr
		set PreResult = @isAgree,
			PreResultBy = @uid,
			PreResultName = @uname,
			ResParty = @checkedDutys
		where GuestComplaintNo = @no
	end
	else		
	begin
		update GuestComp_Mstr
		set PreResult = @isAgree,
			PreResultBy = @uid,
			PreResultName = @uname,
			ResParty = null
		where GuestComplaintNo = @no

		delete from GuestCompDisposedDet
		where DisposedNo = @no and DisposedModuleID = 6
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
