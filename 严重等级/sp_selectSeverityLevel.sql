use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.25>
-- Description:	<取出客诉严重等级>
-- =============================================
alter PROCEDURE [dbo].[sp_selectSeverityLevel] 
	@severityName nvarchar(200)
AS
BEGIN
	select SeverityID,SeverityName,CreatedName,CreatedBy,Convert(varchar(10),Createdtime,120) as Createdtime,Endtime
	from severityLevel
	where (@severityName = '' or (@severityName <> '' and SeverityName = @severityName))
	and (Endtime is null or Endtime = '')
END
GO
