use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.25>
-- Description:	<增加客诉严重等级信息>
-- =============================================
alter PROCEDURE [dbo].[sp_insertSeverityLevel] 
	@severityname nvarchar(200)
   ,@uID  int
   ,@uName nvarchar(20)
   ,@retValue bit output
AS
BEGIN
 declare @i int
 if(not exists(select top 1 SeverityID
 from rmInspection.dbo.severityLevel))
 set @i= 0
 else
 set @i = (select top 1 SeverityID
 from rmInspection.dbo.severityLevel
 order by SeverityID desc)

	set @retValue = 0
	if(exists(select top 1 SeverityID from severityLevel where Endtime is null and SeverityName = @severityname))
    begin 
		if(not exists(select top 1 SeverityID from severityLevel where SeverityName = @severityname))
		begin
				insert into severityLevel (SeverityID,SeverityName,CreatedName,CreatedBy,Createdtime,Endtime)
	     		values (@i+1,@severityname,@uName,@uID,GETDATE(),null)
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				insert into severityLevel (SeverityID,SeverityName,CreatedName,CreatedBy,Createdtime,Endtime)
	    		values (@i+1,@severityname,@uName,@uID,GETDATE(),null)
	end
END
GO
