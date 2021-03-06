USE [rmInspection]
GO
/****** Object:  StoredProcedure [dbo].[sp_selectComplaintSheetDetailById]    Script Date: 2017/11/20 15:21:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.31>
-- Description:	<通过客诉ID号初始化客诉明细>
-- =============================================
ALTER PROCEDURE [dbo].[sp_selectComplaintSheetDetailById] --exec sp_selectComplaintSheetDetailById '0e6f1707-7eeb-4c5c-af53-3fcf124210eb'
@complaintID nvarchar(50)
AS
BEGIN
	select GuestNo,GuestName,ReceivedDate,SeverityName,GuestLevel,ApproachNames,ShipPlanNo,ShipPartNo,ShipNum,ShipDate,ActualAmount,convert(nvarchar(10),FinishedDate,120) as FinishedDate
	,PreResult,PreResultName,ResParty,FinanceResult,FinanceResultName,DecideApproach,DecideResult,DecideApproachName,ManagerResult,ManagerResultName,FeedbackResult,FeedbackResultName,ExecuteResult,
	ExecuteName
	from GuestComp_Mstr
	where ID = @complaintID
END
