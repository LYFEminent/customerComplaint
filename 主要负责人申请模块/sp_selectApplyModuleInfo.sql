use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.6>
-- Description:	<显示申请模块信息>
-- =============================================
alter PROCEDURE [dbo].[sp_selectApplyModuleInfo]
@moduleId int
AS
BEGIN
	select ID,ModuleId,ModuledName,CreatedBy,CreatedName,convert(nvarchar(10),Createdtime,120) as Createdtime,IsAgree
	from ApplyModules
	where @moduleId = '' or (@moduleId <> '' and @moduleId = ModuleId)
END
GO
