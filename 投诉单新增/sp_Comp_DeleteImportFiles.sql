use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.28>
-- Description:	<删除导入的文件>
-- =============================================
alter PROCEDURE [dbo].[sp_Comp_DeleteImportFiles]
 @ID nvarchar(100)
AS
BEGIN
	delete from comp_importDoc where FileID = @ID
END
GO
