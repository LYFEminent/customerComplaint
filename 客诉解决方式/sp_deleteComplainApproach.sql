USE [rmInspection]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.24>
-- Description:	<删除客诉解决方式>
-- =============================================
alter PROCEDURE [dbo].[sp_deleteComplainApproach]
 @approachid int,
 @retValue bit output
AS
BEGIN
	set @retValue = 0
	begin transaction delApproach
		update rmInspection.dbo.complaintApproach
		set Endtime = GETDATE()
		 where ApproachID = @approachid
	if(@@ERROR <> 0)
	begin
		rollback transaction delApproach
	end
	else	
	begin
		set @retValue = -1
		commit transaction delApproach
	end
END
GO
