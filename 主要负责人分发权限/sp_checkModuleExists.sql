use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.8>
-- Description:	<检验该模块是否已被该用户分发权限>
-- =============================================
alter PROCEDURE [dbo].[sp_checkModuleExists] 
@moduleId int,
@uid int
AS
BEGIN
  
	IF EXISTS(SELECT * FROM dbo.handlePersons WHERE  ModuleId = @moduleId)
	SELECT 1
	ELSE 
    SELECT 0
END
GO
