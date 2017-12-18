use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.15>
-- Description:	<取出各个模块信息>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Comp_selectModuleInfo]
@no nvarchar(50),
@moduleEnName nvarchar(50),
@message nvarchar(max) output
AS
BEGIN
	declare @state nvarchar(50)
    if(N'同意' = (select PreResult from GuestComp_Mstr where GuestComplaintNo = @no))
	set @state = 1
	else 
	
	set @message = (
						select  'Agree by' + d.PreResultName
										
						from GuestComp_Mstr d
						inner join modules m on m.moduleID = d.DisposedModuleID 

						where GuestComplaintNo = @no
						and  m.moduleEnName = @moduleEnName
						For Xml Path
					)
	select  @message
END
GO
