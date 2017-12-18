use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.26>
-- Description:	<新增责任方信息>
-- =============================================
alter PROCEDURE [dbo].[sp_insertResponsibleParty]  --exec sp_insertResponsibleParty 't','12,13','13','管理员',output
	@dutyname nvarchar(20),
	@responsiblePersonId nvarchar(50),
	@uID int,
	@uName nvarchar(20),
	@retValue bit output
AS
BEGIN
 declare @i int,
		 @responsiblePersonName NVARCHAR(500)
 if(not exists(select top 1 DutyID
 from rmInspection.dbo.responsibilityParty))
 set @i= 0
 else
 set @i = (select top 1 DutyID
 from rmInspection.dbo.responsibilityParty
 order by DutyID desc)
 
  SELECT @responsiblePersonName=ISNULL(@responsiblePersonName+';','')+u.userNo+'--'+u.userName 
    FROM tcpc0.dbo.Split(@responsiblePersonId) a
    INNER JOIN tcpc0.dbo.Users u
    ON a.String =u.userID

	set @retValue = 0
	if(exists(select top 1 ID from responsibilityParty where Endtime is null and DutyName = @dutyname))
    begin 
		if(not exists(select top 1 ID from responsibilityParty where DutyName = @dutyname))
		begin
				insert into responsibilityParty (ID,DutyID,DutyName,ResponsiblePersonId,ResponsiblePersonName,CreatedName,CreatedBy,Createdtime,Endtime)
	     		values (newID(),@i+1,@dutyname,@responsiblePersonId,@responsiblePersonName,@uName,@uID,GETDATE(),null)
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				insert into responsibilityParty (ID,DutyID,DutyName,ResponsiblePersonId,ResponsiblePersonName,CreatedName,CreatedBy,Createdtime,Endtime)
	    		values (newID(),@i+1,@dutyname,@responsiblePersonId,@responsiblePersonName,@uName,@uID,GETDATE(),null)
	end
END
GO
