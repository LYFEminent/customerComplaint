USE rmInspection
GO
/****** Object:  StoredProcedure [dbo].[sp_dept_checkDeptDirectorExists]    Script Date: 2017/11/2 10:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lyf
-- Create date: 2017.11.2
-- Description:	<��������Ҫ�������Ƿ����>
-- =============================================
create PROCEDURE [dbo].[sp_dept_checkMainOperatorExists]
	@moduleId INT 
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.comp_MainOperator WHERE ModuleId=@moduleId)
	SELECT 1
	ELSE 
    SELECT 0
END
