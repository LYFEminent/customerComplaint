use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.12.1>
-- Description:	<取出责任方已完成的信息>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_selectResponsiblePartyFinished] --exec sp_comp_selectResponsiblePartyFinished 'KS17120801','YQL'
@compNo nvarchar(50),
@dutyName nvarchar(50)
AS
BEGIN
	  declare @checkDuty nvarchar(100)
	 
	select @checkDuty = ResParty
	from GuestComp_Mstr
	where GuestComplaintNo = @compNo

	--select a.CreateName as CreateName,max(a.ResDesc) as ResDesc,max(a.ResFileName) as ResFileName,max(a.ResFilePath) as ResFilePath,max(a.CreateDate) as CreateDate
	--from
	--(
	select p.CreateName as CreateName,ResMsg as ResDesc,p.ResFileName as ResFileName,p.ResFilePath as ResFilePath,CONVERT(varchar(16), p.CreateDate, 120) as CreateDate
	from GuestComp_ResPartyDet p
	left JOIN TCPC0.DBO.Split(@checkDuty) S ON p.ResPartyName =s.String	
    left join responsibilityParty r on r.DutyName = s.String
	where ResNo = @compNo
	and   p.ResPartyName = @dutyName
	--union
	--select p.CreateName as CreateName,ResMsg as ResDesc,p.ResFileName as ResFileName,p.ResFilePath as ResFilePath,CONVERT(varchar(16), p.CreateDate, 120) as CreateDate
	--from GuestComp_ResPartyDet p
	--left JOIN TCPC0.DBO.Split(@checkDuty) S ON p.ResPartyName =s.String	
 --   left join responsibilityParty r on r.DutyName = s.String
	--where ResNo = @compNo
	--and   p.ResPartyName = @dutyName
	--and (r.Endtime <> '' and r.Endtime<=GETDATE())
	--)a
	--group by CreateName
END
GO
