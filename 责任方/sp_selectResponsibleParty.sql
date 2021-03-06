USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_selectResponsibleParty]    Script Date: 2017/11/20 16:42:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.26>
-- Description:	<取出责任方信息>
-- =============================================
ALTER PROCEDURE [dbo].[sp_selectResponsibleParty]  --exec sp_selectResponsibleParty '',''
	@dutyname nvarchar(20),
	@responsiblename nvarchar(500)
AS
BEGIN	
	--select MAX(a.ID) as ID,max(a.DutyID) as DutyID,a.DutyName as DutyName,max(a.CreatedName) as CreatedName,max(a.CreatedBy) as CreatedBy,max(a.Createdtime) as Createdtime,max(a.Endtime) as Endtime,max(a.ResponsiblePersonName) as ResponsiblePersonName
	--from(
	select ID,DutyID,DutyName,CreatedName,CreatedBy,Convert(varchar(10),Createdtime,120) as Createdtime,Endtime,ResponsiblePersonName
	from responsibilityParty 
	where (@dutyname = '' or (@dutyname <> '' and DutyName like '%'+@dutyname+'%'))
	and  (@responsiblename = '' or (@responsiblename <> '' and ResponsiblePersonName like  '%'+@responsiblename+'%'))
	and (Endtime = '' or Endtime  is null)
	--union 
	--select cast (ID as nvarchar(50)) as ID,DutyID,DutyName,CreatedName,CreatedBy,Convert(varchar(10),Createdtime,120) as Createdtime,Endtime,ResponsiblePersonName
	--from responsibilityParty	
	--where (@dutyname = '' or (@dutyname <> '' and DutyName like '%'+@dutyname+'%'))
	--and  (@responsiblename = '' or (@responsiblename <> '' and ResponsiblePersonName like  '%'+@responsiblename+'%'))
	--and (Endtime <> '' and Endtime<=GETDATE())
	--)a
	--group by DutyName
END
