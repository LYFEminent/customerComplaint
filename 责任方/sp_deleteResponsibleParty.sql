use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.26>
-- Description:	<ɾ�����η���Ϣ>
-- =============================================
alter PROCEDURE [dbo].[sp_deleteResponsibleParty]
@id nvarchar(50)
AS
BEGIN
	delete from responsibilityParty where ID = @id
END
GO
