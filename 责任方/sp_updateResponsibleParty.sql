use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.26>
-- Description:	<更新责任方信息>
-- =============================================
alter PROCEDURE [dbo].[sp_updateResponsibleParty]
	@id nvarchar(50),
	@dutyname nvarchar(20),
	@responsiblePerson nvarchar(50),
	--@endtime nvarchar(20),
	@uID int,
	@uName nvarchar(20),
	@retValue bit output
	
AS
BEGIN
    set @retValue = 0
	if(exists(select top 1 ID from responsibilityParty where Endtime is null and DutyName = @dutyname and ResponsiblePersonName = @responsiblePerson))
    begin 
		if(not exists(select top 1 ID from responsibilityParty where DutyName = @dutyname and ResponsiblePersonName = @responsiblePerson))
		begin
				update responsibilityParty
				set DutyName = @dutyname,
					ResponsiblePersonName = @responsiblePerson,
					CreatedBy = @uID,
					CreatedName = @uName,
				    Createdtime = GETDATE()
					--Endtime = @endtime
				where ID = @id
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				update responsibilityParty
				set DutyName = @dutyname,
					CreatedBy = @uID,
					CreatedName = @uName,
				    Createdtime = GETDATE()
					--Endtime = @endtime
				where ID = @id
	end
END
GO
