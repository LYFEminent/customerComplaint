use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.3>
-- Description:	<ɾ�����ߴ�������Ϣ>
-- =============================================
CREATE PROCEDURE [dbo].[sp_deleteHandlePersons]
	@id nvarchar(50) 
AS
BEGIN
    DELETE FROM dbo.handlePersons
    WHERE Id=@id
END
GO
