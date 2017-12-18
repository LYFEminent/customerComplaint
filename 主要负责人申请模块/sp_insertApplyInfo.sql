use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.6>
-- Description:	<新增申请模块信息>
-- =============================================
alter PROCEDURE [dbo].[sp_insertApplyInfo] 
@moduleId int,
@createdBy int,
@createdName nvarchar(20)
AS
BEGIN
	declare @moduleName nvarchar(50)
	set @moduleName = (
	       select moduleName from  modules where moduleID = @moduleId
		)
	INSERT INTO [dbo].[ApplyModules]
           ([ID]
           ,[ModuleId]
           ,[ModuledName]
           ,[CreatedBy]
           ,[CreatedName]
		   ,Createdtime)
     VALUES
           (NEWID()
           ,@moduleId
           ,@moduleName
           ,@createdBy
           ,@createdName
		   ,GETDATE()
		   )

END
GO
