USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_selectGuestComplainApproach]    Script Date: 2017/10/26 14:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.23>
-- Description:	<取出客诉解决方式 >
-- =============================================
ALTER PROCEDURE [dbo].[sp_selectGuestComplainApproach] --exec sp_selectGuestComplainApproach ''
@approachName nvarchar(20)
--@checkeditem nvarchar(20)
AS
BEGIN
	select ApproachID,ApproachName,CreatedName,Convert(varchar(10),Createdtime,120) as Createdtime,CreatedBy,Endtime
	from  rmInspection.dbo.complaintApproach
	where (@approachName = '' or (@approachName <> '' and @approachName = ApproachName))
		and Endtime is null
		--and (@checkeditem = 0 or (@checkeditem <> 0 and ApproachID = convert(int,@checkeditem))) 
END
