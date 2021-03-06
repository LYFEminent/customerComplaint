USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_selectModuleInfo]    Script Date: 2017/12/6 15:03:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.12.6>
-- Description:	<取出各个模块对应的处理人邮件>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_selectModuleEmail] --exec sp_comp_selectModuleEmail 'resParty','zql'
@moduleName nvarchar(50),
@remark nvarchar(50)
AS
BEGIN
	declare @personsID nvarchar(100)
	if(@moduleName = 'resParty')
	begin	
	select @personsID =
	(
		select ResponsiblePersonId + ';'  from 
	(
		SELECT DISTINCT(ResponsiblePersonId) FROM responsibilityParty r
		inner join tcpc0.dbo.Split(@remark) s on s.String = r.DutyName collate Chinese_PRC_CI_AS
		where moduleID = 8 and Endtime is null or Endtime = ''
	) AS tmp
		for xml path('')
	)

		select distinct email
		from tcpc0.dbo.Users u
 		inner join tcpc0.dbo.Split(@personsID) s on u.userID = s.String
		where u.leaveDate is null
	end
	else
	begin

		select @personsID = HandlePersonId
		from handlePersons 
		where ModuleEnName = @moduleName

		select email
		from tcpc0.dbo.Users u
 		inner join tcpc0.dbo.Split(@personsID) s on u.userID = s.String
		where u.leaveDate is null
	end

	
END
