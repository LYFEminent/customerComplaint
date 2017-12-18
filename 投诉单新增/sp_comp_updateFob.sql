use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.12.1>
-- Description:	<¸üÐÂFOB¼Û>
-- =============================================
CREATE PROCEDURE [dbo].[sp_comp_updateFob] 
@fileid nvarchar(50),
@fob nvarchar(20),
@retValue bit output 
AS
BEGIN
	update comp_importDoc
	set FOB = @fob
	where FileID = @fileid

	if(@@ERROR <> 0)
	begin
		set @retValue = 1
	end
	else
	begin
		set @retValue = 0
	end
END
GO
