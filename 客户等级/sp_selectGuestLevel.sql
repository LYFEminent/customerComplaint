USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_selectGuestLevel]    Script Date: 2017/10/24 15:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.24>
-- Description:	<取出客户等级信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_selectGuestLevel] --exec  sp_selectGuestLevel ''
@levelName nvarchar(20)
AS
BEGIN
	--select max(a.LevelID) as LevelID,a.LevelName as LevelName,max(a.CreatedName) as CreatedName,max(a.CreatedBy) as CreatedBy,max(a.Createdtime) as Createdtime,max(a.Endtime) as Endtime
	--from
	--(
	select LevelID,LevelName,CreatedName,CreatedBy,Convert(varchar(10),Createdtime,120) as Createdtime,Endtime
	from   rmInspection.dbo.guestLevel
	where  (@levelName = '' or (@levelName <> '' and LevelName = @levelName))
		  and (Endtime is  null or Endtime = '')
	--union
	--select LevelID,LevelName,CreatedName,CreatedBy,Convert(varchar(10),Createdtime,120) as Createdtime,Endtime
	--from   rmInspection.dbo.guestLevel
	--where  (@levelName = '' or (@levelName <> '' and LevelName = @levelName))
	--	  and (Endtime <> '' and Endtime<=GETDATE())
	--)a
	--group by LevelName
	order by LevelName
END
