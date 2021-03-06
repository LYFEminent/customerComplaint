USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_dept_updateDeptDirector]    Script Date: 2017/11/3 8:58:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lyf
-- Create date: 2017.11.2
-- Description:	<更新客诉主要操作者信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_dept_updateDeptDirector]
	@id nvarchar(50) 
   ,@directorId VARCHAR(50)
   ,@viceDirectorId VARCHAR(50)
   ,@modifiedBy INT 
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
    
    UPDATE dbo.comp_MainOperator SET 
    DirectorId=@directorId,
    DirectorName=@directorName,
    ViceDirectorId=@viceDirectorId,
    ViceDirectorName=@viceDirectorName,
    ModifiedBy=@modifiedBy,
    ModifiedDate=GETDATE()
    WHERE Id=@id
END
