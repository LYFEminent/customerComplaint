use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.10>
-- Description:	<检查登陆者是否具有该模块的权限>
-- =============================================
alter PROCEDURE [dbo].[sp_checkIsAuthority]   --exec sp_checkIsAuthority 'a6890','99868',"resParty"
@preResultNames nvarchar(500),
@uid int,
@modleEnName nvarchar(50)
AS
BEGIN

	declare @handleLoginName nvarchar(50),
			@handleId nvarchar(50)

	select @handleId = HandlePersonId
	from handlePersons
	where  ModuleEnName = @modleEnName

	select @handleLoginName =  r.loginName
	from handlePersons h	
	inner join tcpc0.dbo.Users r on  r.userID = @uid
	inner join tcpc0.dbo.Split(@preResultNames) p on p.String = r.loginName
	inner join tcpc0.dbo.Split(@handleId) o on o.String = r.userID
	where h.ModuleEnName = @modleEnName
	 and r.leaveDate is null	

	if(@handleLoginName is  null)
	select 1
	else
	select 0
END
GO
