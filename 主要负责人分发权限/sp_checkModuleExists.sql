use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.8>
-- Description:	<�����ģ���Ƿ��ѱ����û��ַ�Ȩ��>
-- =============================================
alter PROCEDURE [dbo].[sp_checkModuleExists] 
@moduleId int,
@uid int
AS
BEGIN
  
	IF EXISTS(SELECT * FROM dbo.handlePersons WHERE  ModuleId = @moduleId)
	SELECT 1
	ELSE 
    SELECT 0
END
GO
