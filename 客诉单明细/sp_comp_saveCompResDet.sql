USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_saveCompResDet]    Script Date: 2017/11/27 15:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.20>
-- Description:	<保存责任方明细>
-- =============================================
ALTER PROCEDURE [dbo].[sp_comp_saveCompResDet]
    @resNo varchar(50)
	, @resModuleID int
	,@resDutyName nvarchar(30)
	, @msg nvarchar(300)
	, @fileName nvarchar(50)
	, @filePath nvarchar(100)
	, @uID int
	, @uName nvarchar(10)
	, @retValue bit OUTPUT 
AS
BEGIN

	 -- declare @preFileName nvarchar(max),
		--  @preFilePath  nvarchar(max)
	 -- select @preFileName = ResFileName,@preFilePath = ResFilePath 
	 -- from GuestComp_ResPartyDet 
	 -- where ResNo = @resNo and ResModuleID = @resModuleID and ResPartyName = @resDutyName
	 --if(not exists(select * from GuestComp_ResPartyDet where ResNo = @resNo and ResModuleID = @resModuleID and  ResPartyName = @resDutyName))
  --   begin
	INSERT INTO [dbo].[GuestComp_ResPartyDet]
           ([ID]
           ,[ResNo]
           ,[ResPartyName]
           ,[ResModuleID]
           ,[ResMsg]
           ,[ResFileName]
           ,[ResFilePath]
           ,[CreateBy]
           ,[CreateName]
           ,[CreateDate])
     VALUES
           (NEWID()
           ,@resNo
           ,@resDutyName
           ,@resModuleID
           ,@msg
           ,@fileName
           ,@filePath
           ,@uID
           ,@uName
           ,GETDATE()
		   )
  -- end
  -- else
  -- begin
		--update GuestComp_ResPartyDet
		--set ResFileName =@preFileName+';'+ @fileName,
		--    ResFilePath =@preFilePath+';'+@filePath
		--where ResNo = @resNo and ResModuleID = @resModuleID and ResPartyName = @resDutyName
  -- end
	if(@@ERROR <> 0)
	Begin
		Set @retValue = 0
	End
	Else
	Begin
		Set @retValue = 1
	end
END
