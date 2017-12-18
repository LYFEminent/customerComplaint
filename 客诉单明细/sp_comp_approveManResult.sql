use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.22>
-- Description:	<客诉总经理审批>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_approveManResult]
	@no nvarchar(50),
	@isAgree nvarchar(20),
	@uid int,
	@uname nvarchar(20),
	@retValue bit output
AS
BEGIN
	begin transaction
	if(@isAgree = N'同意')
	begin
		update GuestComp_Mstr
		set ManagerResult = @isAgree,
			ManagerResultBy = @uid,
			ManagerResultName = @uname
		where GuestComplaintNo = @no	
	end
	else
	begin
		update GuestComp_Mstr
		set ManagerResult = @isAgree,
			ManagerResultBy = @uid,
			ManagerResultName = @uname
		where GuestComplaintNo = @no

		delete from GuestCompDisposedDet
		where DisposedNo = @no and DisposedModuleID = 3
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
