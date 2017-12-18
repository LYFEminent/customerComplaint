use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.25>
-- Description:	<更新严重等级信息>
-- =============================================
CREATE PROCEDURE [dbo].[sp_updateServerityLevel] 
	@severityid int,
	@serverityname nvarchar(200),
	--@endtime datetime,
	@uID int,
	@uName nvarchar(20),
	@retValue bit output
AS
BEGIN
	 set @retValue = 0
	if(exists(select top 1 SeverityID from severityLevel where Endtime is null and SeverityName = @serverityname))
    begin 
		if(not exists(select top 1 SeverityID from severityLevel where SeverityName = @serverityname))
		begin
				update severityLevel
				set SeverityName = @serverityname,
					CreatedBy = @uID,
					CreatedName = @uName,
				    Createdtime = GETDATE()
					--Endtime = @endtime
				where SeverityID = @severityid
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				update severityLevel
				set SeverityName = @serverityname,
					CreatedBy = @uID,
					CreatedName = @uName,
				    Createdtime = GETDATE()
					--Endtime = @endtime
				where SeverityID = @severityid
	end
END
GO
