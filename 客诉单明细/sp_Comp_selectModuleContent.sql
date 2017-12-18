use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.15>
-- Description:	<客诉取出各个模块的内容>
-- =============================================
alter PROCEDURE [dbo].[sp_Comp_selectModuleContent]
@no nvarchar(50),
@moduleEnName nvarchar(50),
@content nvarchar(max) output
AS
BEGIN
	begin
	set @content = (
							select td = d.CreateName + N'			' + CONVERT(varchar(16), d.CreateDate, 120) + N'\n' 
									+   d.DisposedMsg
									+	N'\n' 
									+	case isnull(d.DisposedFileName,'') when '' then ''
																	else N'Attachment:' + N'/ahref' + d.DisposedFilePath + N'-atarget' + d.DisposedFileName + N'\ao'
										end
						from GuestCompDisposedDet d
						inner join modules m on m.moduleID = d.DisposedModuleID
						where DisposedNo = @no
						and  m.moduleEnName = @moduleEnName
						For Xml Path
					)
	    Set @content = Replace(@content, '\n', '<br />&nbsp;&nbsp;&nbsp;&nbsp;')
		Set @content = Replace(@content, '/ahref', '<a href="')
		Set @content = Replace(@content, '-atarget', '"  target="_blank">')
		Set @content = Replace(@content, '\ao', '</a>')
		Set @content = Replace(@content, '</td>', '<br />')
		Set @content = Replace(@content, '<row>', '')
		Set @content = Replace(@content, '</row>', '')
		Set @content = Replace(@content, '<td>', '') 
		end
		select  @content
END
GO
