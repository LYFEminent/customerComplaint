use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.27>
-- Description:	<客诉列表导出>
-- =============================================
alter PROCEDURE [dbo].[sp_SelectGuestCompMstrExport]
	@no varchar(20)
	, @cust nvarchar(100)
	--, @order nvarchar(100)
	, @createdate nvarchar(100) = ''
	, @status int
AS
BEGIN
	SELECT 
      [GuestComplaintNo]
      ,[GuestNo]
      ,[GuestName]
	  ,SeverityName
	  ,GuestLevel
      ,convert(nvarchar(10),ReceivedDate,120) as ReceivedDate
      ,[ProblemContent]
	  ,d.name + '--'+[CreateName] as [CreateName]
      ,convert(varchar(10), createDate, 120) as createDate
	  ,PreResult
	  ,d.name + '--'+PreResultName  as PreResultName
	  ,ResParty,
	  FinanceResult,
	  d.name + '--'+ FinanceResultName as FinanceResultName,
	  c.ApproachName as  DecideApproach,
	  d.name + '--'+DecideApproachName as DecideApproachName,
	  ManagerResult,
	  d.name + '--'+ManagerResultName as ManagerResultName,
	  FeedbackResult,
	  d.name + '--'+FeedbackResultName as FeedbackResultName,
	  ExecuteResult,
	  d.name + '--'+ExecuteName as ExecuteName

    FROM [dbo].[GuestComp_Mstr] m
	left join tcpc0.dbo.users u on u.userID = m.PreResultBy or u.userID = m.DecideApproachBy or u.userID = m.ExecuteBy or u.userID = m.FeedbackResultBy 
	or u.userID = m.FinanceResultBy or u.userID = m.ManagerResultBy or u.userID = CreateBy
	left join tcpc1.dbo.Departments d on d.departmentID = u.departmentID 
	left join complaintApproach c on c.ApproachID = m.DecideApproach
	Where (@no = '' Or (@no <> '' And GuestComplaintNo = @no))
		And (@cust = '' Or (@cust <> '' And GuestName = @cust))
		--And (@order = '' Or (@order <> '' And PreNo = @order))
		And (@createdate = '' Or (@createdate <> '' And convert(varchar(10), createDate, 120) = @createdate))
		And (@status = 0 Or 
			(@status = 1 And isnull(GuestComp_Staus,0) = 1) Or 
			(@status = 2 And isnull(GuestComp_Staus,0) = 0))
	Order by createDate
END
GO
