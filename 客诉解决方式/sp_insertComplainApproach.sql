USE [rmInspection]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.23>
-- Description:	<新增客诉解决方式>
-- =============================================
alter PROCEDURE [dbo].[sp_insertComplainApproach]
	@approachname nvarchar(20)
   ,@uID  int
   ,@uName nvarchar(20)
   ,@retValue bit output
AS
BEGIN

 declare @i int
 if(not exists(select top 1 ApproachID
 from rmInspection.dbo.complaintApproach))
 set @i= 0
 else
 set @i = (select top 1 ApproachID
 from rmInspection.dbo.complaintApproach
 order by ApproachID desc)

	set @retValue = 0
	if(exists(select top 1 ApproachID from complaintApproach where Endtime is null and ApproachName = @approachname))
    begin 
		if(not exists(select top 1 ApproachID from complaintApproach where ApproachName = @approachname))
		begin
				insert into complaintApproach (ApproachID,ApproachName,CreatedName,CreatedBy,Createdtime,Endtime)
	     		values (@i+1,@approachname,@uName,@uID,GETDATE(),null)
		end
		else
		begin
				set @retValue = 1
				
		end
	end
	else
	begin
				insert into complaintApproach (ApproachID,ApproachName,CreatedName,CreatedBy,Createdtime,Endtime)
	    		values (@i+1,@approachname,@uName,@uID,GETDATE(),null)
	end
END
GO
