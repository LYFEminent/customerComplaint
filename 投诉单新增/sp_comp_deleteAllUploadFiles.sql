use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.29>
-- Description:	<����ύ���޸�ʧ�ܽ�ɾ��֮ǰ�ϴ��ɹ��������ļ�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_comp_deleteAllUploadFiles]
@GuestComplaintNo nvarchar(50)
AS
BEGIN
	delete from comp_importDoc where GuestComplaintNo = @GuestComplaintNo
	delete from GuestComp_FileList where GuestComp_No = @GuestComplaintNo
END
GO
