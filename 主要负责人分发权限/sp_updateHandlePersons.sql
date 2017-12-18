use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.3>
-- Description:	<更新客诉处理人>
-- =============================================
ALTER PROCEDURE [dbo].[sp_updateHandlePersons] 
	@id nvarchar(50) 
   ,@handlepersonId VARCHAR(50)
   ,@modifyName NVARCHAR(50)
   ,@modifiedBy INT 
AS
BEGIN
 DECLARE @handlePersonName NVARCHAR(200)
    SELECT @handlePersonName=ISNULL(@handlePersonName+';','')+u.userNo+'--'+u.userName 
    FROM tcpc0.dbo.Split(@handlepersonId) a
    INNER JOIN tcpc0.dbo.Users u
    ON a.String =u.userID
    
    
    UPDATE dbo.handlePersons SET 
    HandlePersonId=@handlepersonId,
    HandlePersonName=@handlePersonName,
    ModifiedBy=@modifiedBy,
	ModifyName = @modifyName,
    ModifiedDate=GETDATE()
    WHERE Id=@id
END
GO
