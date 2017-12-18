use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.16>
-- Description:	<决定解决方式>
-- =============================================
alter PROCEDURE  [dbo].[sp_comp_DecideApproach]
	@id nvarchar(50),
	@isAgree nvarchar(50),
	@uid int,
	@uname nvarchar(20)
AS
BEGIN
	declare @approachId int,
	        @approachName nvarchar(50),
			@compNo nvarchar(50)
	if(@isAgree = N'同意')
	begin
		select @approachId = FinanceApproachID,@approachName = FinanceApproachName
		from ApproachDeciding
		where ID = @id
		and FinancePrice is not null

		update ApproachDeciding
		set DecideApproachID = @approachId,
		DecideApproachName = @approachName,
		DecideCreatedBy = @uid,
		DecideCreatedName = @uname,
		DecideCreatedDate = GETDATE()
		where ID = @id
		and FinancePrice is not null

		select @compNo = GuestCompNo
		from ApproachDeciding
		where ID = @id

		update GuestComp_Mstr
		set DecideApproach = @approachId,
		DecideResult = @isAgree,
		DecideApproachBy = @uid,
		DecideApproachName = @uname
		where GuestComplaintNo = @compNo
	end
	else
	begin
		select @approachId = FinanceApproachID,@approachName = FinanceApproachName
	from ApproachDeciding
	where ID = @id
	and FinancePrice is not null

	update ApproachDeciding
	set DecideApproachID = '',
	DecideApproachName = '',
	DecideCreatedBy = @uid,
	DecideCreatedName = @uname,
	DecideCreatedDate = GETDATE()
	where ID = @id
	and FinancePrice is not null

	select @compNo = GuestCompNo
	from ApproachDeciding
	where ID = @id

	update GuestComp_Mstr
	set DecideApproach = @approachId,
	DecideResult = @isAgree,
	DecideApproachBy = @uid,
	DecideApproachName = @uname
    where GuestComplaintNo = @compNo
	end
	
END
GO
