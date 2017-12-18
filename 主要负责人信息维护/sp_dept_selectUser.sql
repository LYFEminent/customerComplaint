USE [tcpc1]
GO
/****** Object:  StoredProcedure [dbo].[sp_dept_selectUser]    Script Date: 2017/11/2 9:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Young Yang
-- Create date: 2014-9-2
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_dept_selectUser]
    @plantid int 
	, @departmentId int = 0
	, @userName  nvarchar(10) = N''
AS
BEGIN
     SELECT userID, userName ,userNo, email
			FROM tcpc0.dbo.users 
			WHERE plantCode = @plantid 
			 And ( @departmentId = 0 or (departmentID = @departmentId )) 
			 And ( @userName = N'' or ( @userName <> N'' and userName like REPLACE(@userName,'*','%')))
			  AND deleted=0 AND isactive=1 AND leaveDate IS NULL  
			Order by right(cast('0000'+rtrim(userNo) as varchar(20)),5)
END
