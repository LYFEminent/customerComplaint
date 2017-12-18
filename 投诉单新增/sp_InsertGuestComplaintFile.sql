use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.30>
-- Description:	<新增上传文件的信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_InsertGuestComplaintFile] 
	@labGuestComplaintNo varchar(20)
	, @fname nvarchar(100)
	, @fpath nvarchar(100)
	, @uID int
	, @uName nvarchar(15)
AS
BEGIN
Begin Transaction
		Insert Into GuestComp_FileList(ID,GuestComp_No
								,GuestComp_FileName
								,GuestComp_FilePath
								,createBy
								,createName
								,createDate)
		Values(NEWID()
			  ,@labGuestComplaintNo
			  , @fname
			  , @fpath
			  , @uID
			  , @uName
			  , getdate())
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
GO
