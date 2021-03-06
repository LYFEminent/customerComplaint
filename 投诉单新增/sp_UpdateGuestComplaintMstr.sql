USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGuestComplaintMstr]    Script Date: 2017/11/27 17:29:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.27>
-- Description:	<更新客诉信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UpdateGuestComplaintMstr]
@GuestComplaintNo varchar(50),
@guestNo varchar(50),
@guestName nvarchar(200),
@receivedDate datetime,
@severityName nvarchar(50),
@problemContent  nvarchar(MAX),
@guestLevel nvarchar(20),
@approachNames nvarchar(200),
@uID int,
@uName nvarchar(50)
AS
BEGIN
	update GuestComp_Mstr
	set GuestName = @guestName,
		ReceivedDate = @receivedDate,
		ApproachNames  = @approachNames,
		SeverityName = @severityName,
		GuestLevel = @guestLevel,
		ProblemContent = @problemContent,
		CreateBy = @uID,
		CreateName = @uName,
		CreateDate = GETDATE()
	where GuestComplaintNo = @GuestComplaintNo

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
