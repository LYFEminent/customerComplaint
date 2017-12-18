USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_getModuleByUid]    Script Date: 2017/11/3 10:19:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.3>
-- Description:	<取出对应的模块>
-- =============================================
ALTER PROCEDURE [dbo].[sp_getModuleByUid] --exec sp_getModuleByUid '99868'
@uid int
--@moduleId nvarchar(20)
AS

BEGIN	
	select ModuledName,ModuleId
	from ApplyModules
	where CreatedBy = @uid
	and IsAgree = 1

END
