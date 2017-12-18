use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.27>
-- Description:	<取出投诉单号>
-- =============================================
alter PROCEDURE [dbo].[sp_selectGuestCompNo]  --exec sp_selectGuestCompNo 13
	@uID int  
As
Begin
	

	
	Declare @no varchar(15)
		, @noid int
		, @nolen int = 2
		, @suppNo nvarchar(20)
	Select top 1 @no = GuestComplaintNo 
	From GuestComp_Mstr
	--Select  top 1 @no = supplier_No from supplier_FileQualification_det
	Where Convert(varchar(100),GETDATE(),12) = SUBSTRING(GuestComplaintNo, 3, 6)
	order by GuestComplaintNo desc
	set  @no =SUBSTRING(@no, 9, 2)
	--Select @no
	set @noid = cast(@no as int) + 1
	--Select @noid
	if (@noid is null)
	Begin
		Set @noid = 01
	End
	select 'KS' + CONVERT(varchar(100), GETDATE(), 12) + right('0000000000' + cast(@noid as varchar(10)), @nolen)
END
GO
