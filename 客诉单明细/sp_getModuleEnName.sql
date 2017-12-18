use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.9>
-- Description:	<取出模块的英文名>
-- =============================================
alter PROCEDURE [dbo].[sp_getModuleEnName]  --exec sp_getModuleEnName  1, 0
@moduleID int,
@moduleEnName  nvarchar(50) output
AS
BEGIN

		select @moduleEnName = ModuleEnName
	    from modules
	    where moduleID = @moduleID
END
GO
