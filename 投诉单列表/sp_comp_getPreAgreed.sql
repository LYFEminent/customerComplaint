use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.29>
-- Description:	<ȥ�����߳���ͬ���>
-- =============================================
CREATE PROCEDURE [dbo].[sp_comp_getPreAgreed]
	
AS
BEGIN
	select GuestComplaintNo
	from GuestComp_Mstr
	where PreResult like N'ͬ��'
END
GO
	