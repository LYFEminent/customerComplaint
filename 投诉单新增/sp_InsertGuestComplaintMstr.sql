USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertGuestComplaintMstr]    Script Date: 2017/11/14 10:02:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.27>
-- Description:	<新增客诉信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_InsertGuestComplaintMstr]
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
     INSERT INTO [dbo].[GuestComp_Mstr]
           (ID,GuestComplaintNo,GuestNo,GuestName,ReceivedDate,SeverityName,ProblemContent,GuestLevel,ApproachNames,CreateBy ,CreateName ,CreateDate)
     VALUES
           (NEWID(),
		   @GuestComplaintNo
           ,@guestNo
           ,@guestName
           ,@receivedDate
           ,@severityName
           ,@problemContent
		   ,@guestLevel
		   ,@approachNames
           ,@uID
           ,@uName
           ,GETDATE()
		   )
	update GuestComp_Mstr 
	set GuestComp_Staus = 0
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
