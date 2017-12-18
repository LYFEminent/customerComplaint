use rmInspection
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.30>
-- Description:	<É¾³ý¿ÍËßÐÅÏ¢>
-- =============================================
alter PROCEDURE [dbo].[sp_DeleteGuestCompMstr]
@id uniqueidentifier
AS
BEGIN
	Begin Transaction
	   declare @no nvarchar(50)
	   select @no = GuestComplaintNo
	   from GuestComp_Mstr
	   where ID = @id

		Delete
		From GuestComp_Mstr
		Where ID= @id

		DELETE FROM ApproachDeciding
		WHERE GuestCompNo = @no

		delete from GuestComp_ResPartyDet
		where ResNo  = @no
		
		delete from GuestCompDisposedDet
		where DisposedNo = @no
		
		delete from GuestComp_FileList
		where GuestComp_No = @no
		
		delete from comp_importDoc
		where GuestComplaintNo = @no 

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
