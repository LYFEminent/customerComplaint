use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.24>
-- Description:	<删除客户等级信息>
-- =============================================
alter PROCEDURE [dbo].[sp_deleteGuestLevel]
@levelid int,
@retValue bit output
AS
BEGIN
	set @retValue = 0
	begin transaction delLevel	
	
	update guestLevel
	set Endtime = GETDATE()
	where LevelID = @levelid
	if(@@ERROR <> 0)
	begin
		rollback transaction delLevel
	end
	else
	begin
		set @retValue = 1
		commit transaction delLevel
	end
END
GO
