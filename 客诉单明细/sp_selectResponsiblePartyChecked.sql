use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.1>
-- Description:	<取出选中的责任方信息>
-- =============================================
alter PROCEDURE [dbo].[sp_selectResponsiblePartyChecked] --exec sp_selectResponsiblePartyChecked "ZQL",'KS17120501'
	@dutyname nvarchar(200),
	@compNo nvarchar(50)
AS
BEGIN
  declare @checkDuty nvarchar(100),
		  @dutyID nvarchar(50)
		  --@desc nvarchar(100)
  --取出该单主表中的责任方	 
   select @checkDuty = ResParty
   from GuestComp_Mstr
   where GuestComplaintNo = @compNo

	select @dutyID = p.DutyID
	from responsibilityParty p
	inner JOIN TCPC0.DBO.Split(@dutyname) S ON P.DutyName =s.String	

	select a.DutyName as DutyName,max(a.ResDesc) as ResDesc,MAX(a.CreateDate) as CreateDate,MAX(a.CreateName) as CreateName,MAX(a.ResFileName) as ResFileName,MAX(a.ResFilePath) as ResFilePath,MAX(a.ResponsiblePersonName) as ResponsiblePersonName
	from
   	(
     select DISTINCT p.DutyName,p.ResponsiblePersonName,d.CreateName,NULL as ResDesc
	,d.ResFileName,d.ResFilePath,CONVERT(varchar(16), d.CreateDate, 120) as CreateDate
	from responsibilityParty P
	inner JOIN TCPC0.DBO.Split(@dutyname) S ON P.DutyName =s.String	
	left join GuestComp_ResPartyDet d on d.ResNo = @compNo	
	left  JOIN TCPC0.DBO.Split(@dutyname) n ON d.ResPartyName =n.String		
	left  join TCPC0.DBO.Split(@checkDuty)	c on c.String = d.ResPartyName
	where  (Endtime is null or Endtime = '')
	union 
	select ResPartyName as DutyName,r.ResponsiblePersonName as ResponsiblePersonName,p.CreateName as CreateName,ResMsg as ResDesc,p.ResFileName as ResFileName,p.ResFilePath as ResFilePath,CONVERT(varchar(16), p.CreateDate, 120) as CreateDate
	from GuestComp_ResPartyDet p
	left JOIN TCPC0.DBO.Split(@checkDuty) S ON p.ResPartyName =s.String	
    left join responsibilityParty r on r.DutyName = s.String
	where ResNo = @compNo) a
	group by DutyName

END
GO
