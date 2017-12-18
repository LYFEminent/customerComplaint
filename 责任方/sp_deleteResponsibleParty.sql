use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.10.26>
-- Description:	<删除责任方信息>
-- =============================================
alter PROCEDURE [dbo].[sp_deleteResponsibleParty]
@id nvarchar(50)
AS
BEGIN
	delete from responsibilityParty where ID = @id
END
GO
