use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.23>
-- Description:	<取出选中的责任方>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_selectCompCheckedDutyByNo] --exec sp_comp_selectCompCheckedDutyByNo 'KS17111601'
@compNo nvarchar(50),
@checkduty nvarchar(100) output
AS
BEGIN
	select @checkduty = ResParty
	from GuestComp_Mstr
	where GuestComplaintNo = @compNo
END
GO
