use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.12.1>
-- Description:	<检查是否所有的责任方已完成>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_checkISAllPartyFinished] --exec sp_comp_checkISAllPartyFinished 'KS17121103'
@GuestCompNo nvarchar(50)
AS
BEGIN
    declare @isNull nvarchar(500),
			@duty nvarchar(100),
			@num1 int,
			@duty1 nvarchar(100),
			@num2 int
	select @duty =  ResParty+';'
	from GuestComp_Mstr
	where GuestComplaintNo = @GuestCompNo

	set @num1 = sum(len(@duty)-len(replace(@duty,';',''))+1)

	set @duty1 = (select ResPartyName + ';'  from 
	(
	SELECT DISTINCT(ResPartyName) FROM GuestComp_ResPartyDet
	where ResNo = @GuestCompNo
	) AS tmp
	order by ResPartyName desc
		for xml path(''))

	set @num2 = sum(len(@duty1)-len(replace(@duty1,';',''))+1)
	if(@num1 = @num2)
	BEGIN
		SELECT 1                  
	END
	ELSE
	BEGIN
		SELECT 0                      
	END 
END
GO
