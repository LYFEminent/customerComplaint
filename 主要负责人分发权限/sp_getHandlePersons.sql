USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_getHandlePersons]    Script Date: 2017/11/7 13:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.3>
-- Description:	<取出处理人信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_getHandlePersons]--exec sp_getHandlePersons '','1','13'
@handlePersons nvarchar(500),
@moduleID nvarchar(50),
@uid int
AS
BEGIN
    declare @handlename nvarchar(500)
	if((select count(ID)
	from handlePersons
	where ModuleId = @moduleID)>=2)
	begin
	select distinct @handlename  = a.HandlePersonName+ ';'+b.HandlePersonName 
	from handlePersons a,handlePersons b
	where a.ModuleId = b.ModuleId and a.ModuleId = @moduleID
	  and a.CreatedBy <> b.CreatedBy 
	end
	else
	begin
	select @handlename = HandlePersonName
	from handlePersons
	where ModuleId = @moduleID
	--and CreatedBy = @uid
	end

	--select @handlename

	select distinct m.ModuledName as moduleName,h.HandlePersonId as HandlePersonId,@handlename as HandlePersonName,h.Id as id,m.ModuleId,m.IsAgree isAgree
	from handlePersons h
	inner join ApplyModules  m on h.ModuleId = m.ModuleId 
	--and m.CreatedBy = @uid
	where  m.ModuleId=@moduleId
	and h.ApplyId = m.ID
END
