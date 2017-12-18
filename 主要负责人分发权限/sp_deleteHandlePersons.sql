use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.3>
-- Description:	<删除客诉处理人信息>
-- =============================================
CREATE PROCEDURE [dbo].[sp_deleteHandlePersons]
	@id nvarchar(50) 
AS
BEGIN
    DELETE FROM dbo.handlePersons
    WHERE Id=@id
END
GO
