use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.27>
-- Description:	<判断责任方是否有权限>
-- =============================================
alter PROCEDURE [dbo].[sp_checkDutyIsAuthority] --exec sp_checkDutyIsAuthority 'yQL','99868','a6890'
	@dutyName nvarchar(50),
	@uid int,
	@names nvarchar(100)
AS
BEGIN
	declare @handleLoginName nvarchar(50)

	select @handleLoginName =  r.loginName
	from responsibilityParty h	
	inner join tcpc0.dbo.Users r on  r.userID = @uid
	inner join tcpc0.dbo.Split(@names) p on p.String = r.loginName
	where r.leaveDate is null	

	if(@handleLoginName is  null)
	select 1
	else
	select 0
END
GO
