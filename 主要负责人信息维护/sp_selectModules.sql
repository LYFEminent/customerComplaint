use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.2>
-- Description:	<取出客诉模块>
-- =============================================
CREATE PROCEDURE [dbo].[sp_selectModules] 

AS
BEGIN
	select * from modules 
	where isActive = 1
END
GO
