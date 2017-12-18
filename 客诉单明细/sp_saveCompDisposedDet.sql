use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.14>
-- Description:	<保存客诉模块明细>
-- =============================================
alter PROCEDURE [dbo].[sp_saveCompDisposedDet]
  @disposedNo varchar(50)
	, @disposedModuleID int
	, @msg nvarchar(300)
	, @fileName nvarchar(50)
	, @filePath nvarchar(100)
	, @uID int
	, @uName nvarchar(10)
	, @retValue bit OUTPUT 

AS
BEGIN
	   INSERT INTO [dbo].[GuestCompDisposedDet]
			   ([DisposedID]
			   ,[DisposedNo]
			   ,[DisposedModuleID]
			   ,[DisposedMsg]
			   ,[DisposedFileName]
			   ,[DisposedFilePath]
			   ,[CreateBy]
			   ,[CreateName]
			   ,[CreateDate])
		 VALUES
			   (NEWID()
			   ,@disposedNo
			   ,@disposedModuleID
			   ,@msg
			   ,@fileName
			   ,@filePath
			   ,@uID
			   ,@uName
			   ,GETDATE()
			   )

   

	--update GuestComp_Mstr
	--set PreResultBy = @uID,
	--	PreResultName = @uName
	--where GuestComplaintNo = @disposedNo

    if(@@ERROR <> 0)
	Begin
		Set @retValue = 0
	End
	Else
	Begin
		Set @retValue = 1
	end
END
GO
