use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.24>
-- Description:	<更新客户等级信息>
-- =============================================
alter PROCEDURE [dbo].[sp_updateGuestLevel]
	@levelid int,
	@levelname nvarchar(200),
	@uID int,
	@uName nvarchar(20),
	@retValue bit output
	
AS
BEGIN
    set @retValue = 0
	if(exists(select top 1 LevelID from guestLevel where Endtime is null and LevelName = @levelname))
    begin 
		if(not exists(select top 1 LevelID from guestLevel where LevelName = @levelname and Endtime is null))
		begin
				update guestLevel
				set LevelName = @levelname,
					CreatedBy = @uID,
					CreatedName = @uName,
				    Createdtime = GETDATE()			
				where LevelID = @levelid
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				update guestLevel
				set LevelName = @levelname,
					CreatedBy = @uID,
					CreatedName = @uName,
				    Createdtime = GETDATE()
				where LevelID = @levelid
	end

END
GO
