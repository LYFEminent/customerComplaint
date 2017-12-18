use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.25>
-- Description:	<删除严重等级信息>
-- =============================================
alter PROCEDURE [dbo].[sp_deleteSeverityLevel] 
@severityid int,
@retValue bit output
AS
BEGIN
	set @retValue = 0
	begin transaction delserverity
	
	update severityLevel
	set  Endtime  = GETDATE()
	where SeverityID = @severityid
	if(@@ERROR <> 0)
	begin 
		rollback transaction delserverity
	end
	else
	begin
		set @retValue = 1
		commit transaction delserverity
	end
END
GO
