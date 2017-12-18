use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.3>
-- Description:	<新增处理人>
-- =============================================
alter PROCEDURE [dbo].[sp_insertHandlePersons]
@moduleId nvarchar(20),
@handlepersonId nvarchar(50),
@createdBy int,
@createdName nvarchar(50)
AS
BEGIN
	DECLARE @handlePersonName NVARCHAR(200),
			@applyId nvarchar(50),
			@moduleEnName nvarchar(50)
    SELECT @handlePersonName=ISNULL(@handlePersonName+';','')+u.userNo+'--'+u.userName 
    FROM tcpc0.dbo.Split(@handlepersonId) a
    INNER JOIN tcpc0.dbo.Users u
    ON a.String =u.userID

	select @applyId = ID
	from ApplyModules
	where ModuleId = @moduleId and CreatedBy = @createdBy

	select @moduleEnName = moduleEnName
	from modules
	where moduleID = @moduleId
    
	INSERT INTO [dbo].[handlePersons]
           ([Id]
		   ,ApplyId
           ,[ModuleId]
		   ,ModuleEnName
           ,[HandlePersonId]
           ,[HandlePersonName]
           ,[CreatedBy]
           ,[CreatedName]
           ,[CreatedDate])
     VALUES
           (NEWID()
		   ,@applyId
           ,@moduleId
		   ,@moduleEnName
           ,@handlepersonId
           ,@handlePersonName
           ,@createdBy
           ,@createdName
           ,GETDATE()
		   )
END
GO
