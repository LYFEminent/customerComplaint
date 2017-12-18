use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.17>
-- Description:	<取出创建该订单的人>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_getOrderCreateBy] 
@GuestCompNo nvarchar(50),
@OrderCreateBy  nvarchar(500) output
AS
BEGIN
	select @OrderCreateBy =  u.loginName+'--'+ g.CreateName
	from GuestComp_Mstr g
	inner join tcpc0.dbo.Users u on u.userID = g.CreateBy
	where GuestComplaintNo = @GuestCompNo
END
GO
