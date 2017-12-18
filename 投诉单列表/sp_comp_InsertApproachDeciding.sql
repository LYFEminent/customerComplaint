use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.16>
-- Description:	<将销售部选中的方式保存>
-- =============================================
CREATE PROCEDURE [dbo].[sp_comp_InsertApproachDeciding] 
@complaintNo nvarchar(50),
@approachId  int

AS
BEGIN
	declare @approachName nvarchar(50)
	select @approachName = ApproachName
	from complaintApproach
	where ApproachID = @approachId

	insert into ApproachDeciding
	(ID,GuestCompNo,FinanceApproachID,FinanceApproachName)
	values(NEWID(),@complaintNo,@approachId,@approachName)
END
GO
