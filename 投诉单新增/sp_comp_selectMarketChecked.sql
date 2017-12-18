use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.27>
-- Description:	<取出销售部选中的方式>
-- =============================================
CREATE PROCEDURE [dbo].[sp_comp_selectMarketChecked]  
@compNo nvarchar(50),
@checkApproach nvarchar(max)
AS
BEGIN
	select a.ApproachID
	from complaintApproach a
	inner join tcpc1.dbo.Split(@checkApproach) s on s.String = a.ApproachName
	inner join GuestComp_Mstr m on m.ApproachNames is not null
	where m.GuestComplaintNo = @compNo
END
GO
