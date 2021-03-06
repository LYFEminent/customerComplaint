USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_getModuleId]    Script Date: 2017/11/6 15:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.3>
-- Description:	<取出模块号>
-- =============================================
ALTER PROCEDURE [dbo].[sp_getModuleId] --exec sp_getModuleId '13'
@uid nvarchar(20)
AS
BEGIN
    declare @moduleID int
	select  @moduleID = moduleID
	from ApplyModules
	where CreatedBy = @uid 
	and   IsAgree = 1
END
