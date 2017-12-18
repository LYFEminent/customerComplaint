use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.6>
-- Description:	<É¾³ýÉêÇëÄ£¿éÐÅÏ¢>
-- =============================================
alter PROCEDURE [dbo].[sp_deleteApplyModuleInfo]
 @id nvarchar(500),
 @retValue bit output
AS
BEGIN
	set @retValue = 0
	begin transaction delApply
		delete from rmInspection.dbo.ApplyModules where ID = @id
	if(@@ERROR <> 0)
	begin
		rollback transaction delApply
	end
	else	
	begin
		set @retValue = -1
		commit transaction delApply
	end
END
GO
