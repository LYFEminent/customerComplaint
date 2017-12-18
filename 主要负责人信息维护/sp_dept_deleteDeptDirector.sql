USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_dept_deleteDeptDirector]    Script Date: 2017/11/2 11:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lyf
-- Create date: 2017.11.2
-- Description:	<删除客诉主要操作者>
-- =============================================
ALTER PROCEDURE [dbo].[sp_dept_deleteDeptDirector]
	@id nvarchar(50) 
AS
BEGIN
    DELETE FROM dbo.comp_MainOperator
    WHERE Id=@id
END
