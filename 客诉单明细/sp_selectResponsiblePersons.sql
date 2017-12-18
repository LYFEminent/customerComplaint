use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.9>
-- Description:	<取出各个模块的处理人>
-- =============================================
alter PROCEDURE [dbo].[sp_selectResponsiblePersons] 
@moduleEnName nvarchar(50),
@handlePersonName nvarchar(500) output
AS
BEGIN

	select @handlePersonName =  HandlePersonName
	from handlePersons
	where ModuleEnName = @moduleEnName


END
GO
