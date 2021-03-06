USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_updateComplainApproach]    Script Date: 2017/10/24 16:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.24>
-- Description:	<更新客诉方式>
-- =============================================
ALTER PROCEDURE [dbo].[sp_updateComplainApproach]
@approachid int,
@approachname nvarchar(200),
--@endtime datetime,
@uID int,
@uName nvarchar(20),
@retValue bit output

AS
BEGIN
	
	set @retValue = 0
	if(exists(select top 1 ApproachID from complaintApproach where Endtime is null and ApproachName = @approachname))
    begin 
		if(not exists(select top 1 ApproachID from complaintApproach where ApproachName = @approachname))
		begin
				update complaintApproach
				set ApproachName = @approachname,
					CreatedBy = @uID,
					CreatedName = @uName,
				    Createdtime = GETDATE()
				   -- Endtime = @endtime
				where ApproachID = @approachid
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				update complaintApproach
				set ApproachName = @approachname,
					CreatedBy = @uID,
					CreatedName = @uName,
				   -- Endtime = @endtime
				   Createdtime = GETDATE()
				where ApproachID = @approachid
	end
END
