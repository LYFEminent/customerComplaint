USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_dept_selectMainOperator]    Script Date: 2017/11/3 8:56:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lyf
-- Create date: 2017.11.2
-- Description:	<取出客诉主要操作者信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_dept_selectMainOperator]
	@moduleId INT 
   ,@directorName NVARCHAR(200)
   ,@viceDirectorName NVARCHAR(200) 
AS
BEGIN
    SELECT  dd.Id,
	        dd.moduleID,
            dd.DirectorId ,
            REPLACE(dd.DirectorName,';','<br/>') AS Director,
            dd.ViceDirectorId ,
            REPLACE(dd.ViceDirectorName ,';','<br/>') AS ViceDirector,
            d.moduleName AS moduleName
    FROM dbo.comp_MainOperator dd
    INNER JOIN dbo.modules d
    ON dd.ModuleId=d.moduleID
    WHERE (@moduleId=0 OR (@moduleId<>0 AND dd.ModuleId=@moduleId))
    AND (@directorName='' OR (@directorName<>'' AND dd.DirectorName LIKE '%'+@directorName+'%'))
    AND (@viceDirectorName='' OR (@viceDirectorName<>'' AND dd.ViceDirectorName LIKE '%'+@viceDirectorName+'%'))
END
