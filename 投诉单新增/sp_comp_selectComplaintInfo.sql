use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.12.5>
-- Description:	<取出邮件信息>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_selectComplaintInfo]--exec sp_comp_selectComplaintInfo 'ks17120601','13','executor'
@compNo nvarchar(50),
@uid int,
@moduleName nvarchar(50)
AS
BEGIN
	select u.email as email,m.GuestComplaintNo as GuestComplaintNo,m.ProblemContent as ProblemContent,d.moduleName as moduleName
	from GuestComp_Mstr m
	inner join tcpc0.dbo.Users u on u.userID = @uid
	inner join modules d on d.moduleEnName = @moduleName
	where GuestComplaintNo = @compNo
	and u.leaveDate is null
END
GO
