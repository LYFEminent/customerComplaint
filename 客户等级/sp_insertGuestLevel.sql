use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.24>
-- Description:	<新增客户等级>
-- =============================================
alter PROCEDURE [dbo].[sp_insertGuestLevel] 
@levelname nvarchar(20),
@uID int,
@uName nvarchar(20),
@retValue bit output
AS
BEGIN
 declare @i int
 if(not exists(select top 1 LevelID
 from rmInspection.dbo.guestLevel))
 set @i= 0
 else
 set @i = (select top 1 LevelID
 from rmInspection.dbo.guestLevel
 order by LevelID desc)
 
	set @retValue = 0
	if(exists(select top 1 LevelID from guestLevel where Endtime is null and LevelName = @levelname))
    begin 
		if(not exists(select top 1 LevelID from guestLevel where LevelName = @levelname))
		begin
				insert into guestLevel (LevelID,LevelName,CreatedName,CreatedBy,Createdtime,Endtime)
	     		values (@i+1,@levelname,@uName,@uID,GETDATE(),null)
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				insert into guestLevel (LevelID,LevelName,CreatedName,CreatedBy,Createdtime,Endtime)
	    		values (@i+1,@levelname,@uName,@uID,GETDATE(),null)
	end

END
GO
