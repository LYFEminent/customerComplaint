use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.27>
-- Description:	<删除上传文件信息>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GuestComp_DeleteFile]
@ID  uniqueidentifier
AS
BEGIN
	Begin
	Begin Transaction
		Delete
		From GuestComp_FileList
		Where ID= @ID
	If @@ERROR<>0
	Begin
		Select 0
		Rollback Transaction
	End
	Else
	Begin
		Select 1
		Commit Transaction 
	End
	END
END
GO
