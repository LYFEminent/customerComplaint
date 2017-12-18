use rmInspection
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.6>
-- Description:	<Í¬ÒâÉêÇëÄ£¿é>
-- =============================================
alter PROCEDURE [dbo].[sp_updateApplyModules]
@ID nvarchar(500),
@uID int,
@uName nvarchar(20)

AS
BEGIN
	
	update ApplyModules
	set IsAgree = 1,
		AgreeBy = @uID,
		AgreeName = @uName,
		AgreeDate = getdate()
	where exists (select m.ID
				from ApplyModules m
				inner join tcpc0.dbo.Split(@ID) s on m.ID = s.String
				)
	 

END
GO
