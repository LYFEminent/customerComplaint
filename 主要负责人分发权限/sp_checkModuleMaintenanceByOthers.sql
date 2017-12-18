use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.8>
-- Description:	<���ô������ѱ�������ά��>
-- =============================================
alter PROCEDURE [dbo].[sp_checkModuleMaintenanceByOthers]
@moduleId nvarchar(20),
@uid int
AS
BEGIN
    declare @handlepersonname nvarchar(50)
    select @handlepersonname =  HandlePersonName
	from handlePersons
	where @moduleId = ModuleId
	and @uid <> CreatedBy

END
GO
