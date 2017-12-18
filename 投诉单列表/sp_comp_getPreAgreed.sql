use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.29>
-- Description:	<去除客诉初判同意的>
-- =============================================
CREATE PROCEDURE [dbo].[sp_comp_getPreAgreed]
	
AS
BEGIN
	select GuestComplaintNo
	from GuestComp_Mstr
	where PreResult like N'同意'
END
GO
	