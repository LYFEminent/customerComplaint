USE rmInspection
GO
/****** Object:  StoredProcedure [dbo].[sp_dept_insertDeptDirector]    Script Date: 2017/11/2 9:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lyf
-- Create date: 2017.11.2
-- Description:	<新增客诉主要操作人信息>
-- =============================================
alter PROCEDURE [dbo].[sp_dept_insertDeptDirector]
	@moduleId INT 
   ,@directorId VARCHAR(50)
   ,@viceDirectorId VARCHAR(50)
   ,@createdBy INT 
AS
BEGIN
    DECLARE @directorName NVARCHAR(200)
    DECLARE @viceDirectorName NVARCHAR(200)
    SELECT @directorName=ISNULL(@directorName+';','')+u.userNo+'--'+u.userName 
    FROM tcpc0.dbo.Split(@directorId) a
    INNER JOIN tcpc0.dbo.Users u
    ON a.String =u.userID
    
    SELECT @viceDirectorName=ISNULL(@viceDirectorName+';','')+u.userNo+'--'+u.userName 
    FROM tcpc0.dbo.Split(@viceDirectorId) a
    INNER JOIN tcpc0.dbo.Users u
    ON a.String =u.userID
	INSERT INTO dbo.comp_MainOperator
	        (Id,
			 ModuleId,
	          DirectorId ,
	          DirectorName ,
	          ViceDirectorId ,
	          ViceDirectorName ,
	          CreatedBy ,
	          CreatedDate 
	        )
	VALUES  (NEWID(),
			 @moduleId , -- DepartmentId - int
	          @directorId , -- DirectorId - varchar(50)
	          @directorName , -- DirectorName - nvarchar(200)
	          @viceDirectorId , -- ViceDirectorId - varchar(50)
	          @viceDirectorName , -- ViceDirectorName - nvarchar(200)
	          @createdBy , -- CreatedBy - int
	          GETDATE()  -- CreatedDate - datetime
	        )
END
