use rmInspection
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<lyf>
-- Create date: <2017.11.13>
-- Description:	<客诉excel导入>
-- =============================================
alter PROCEDURE [dbo].[sp_comp_importCompInfo]  --EXEC sp_comp_importCompInfo  '<CustPo>A</CustPo>\r\n    <PoLine>A</PoLine>\r\n    <CustPart>A</CustPart>\r\n    <DateCode>A</DateCode>\r\n    <UM>A</UM>\r\n    <Qad>16630427000090</Qad>\r\n    <Price>A</Price>\r\n    <Currency>A</Currency>\r\n    <Location>A</Location>\r\n    <Qty>A</Qty>',13,'KS17112802'
  @detail XML
  ,@uID int
  ,@compNo nvarchar(50)
  ,@custNo nvarchar(50)
AS
BEGIN
        begin transaction
		DECLARE @tableTemp TABLE (
				CustPo VARCHAR(20)
				,PoLine NVARCHAR(20)
				,CustPart VARCHAR(50)
				,DateCode VARCHAR(500)
				,UM NVARCHAR(20)
				,Qad NVARCHAR(200)
				,Price NVARCHAR(200)
				,Currency VARCHAR(50)
				,Location NVARCHAR(500)
				,Qty NVARCHAR(50)
				,ERROR NVARCHAR(2000)
			)


			INSERT INTO @tableTemp
			        ( CustPo,
					  PoLine,
			          CustPart,
			          DateCode,
			          UM,
					  Qad,
					  Price,
					  Currency,
					  Location,
					  Qty
			        )
				select Tab.Col.value('CustPo[1]','VARCHAR(50)') as CustPo
				,Tab.Col.value('PoLine[1]','VARCHAR(20)') as PoLine
			   ,Tab.Col.value('CustPart[1]','VARCHAR(50)') as CustPart
			   ,Tab.Col.value('DateCode[1]','VARCHAR(500)') as DateCode
			   ,Tab.Col.value('UM[1]','nvarchar(20)') as UM
			    ,Tab.Col.value('Qad[1]','nvarchar(200)') as Qad
				,Tab.Col.value('Price[1]','nvarchar(200)') as Price
				,Tab.Col.value('Currency[1]','nvarchar(50)') as Currency
				,Tab.Col.value('Location[1]','nvarchar(500)') as Location
				,Tab.Col.value('Qty[1]','nvarchar(50)') as Qty
			   from  @detail.nodes('//TempTable')as Tab(Col)



			/*校验数据的准确性*/
			UPDATE @tableTemp   
			SET ERROR = ''			       
			   			
	


			  UPDATE tt      
			  SET tt.ERROR += N'订单号必须填；' 
			  from @tableTemp tt
			  where tt.CustPo is null or tt.CustPo = '' 				

			  UPDATE tt      
			  SET tt.ERROR += N'行号必须填；' 
			  from @tableTemp tt
			  where tt.PoLine is null or tt.PoLine = ''

			  UPDATE tt      
			  SET tt.ERROR += N'位置必须填；' 
			  from @tableTemp tt
			  where tt.Location is null or tt.Location = ''

			  UPDATE tt      
			  SET tt.ERROR += N'数量必须填；' 
			  from @tableTemp tt
			  where tt.Qty is null or tt.Qty = ''

			  UPDATE tt      
			  SET tt.ERROR += N'周期章必须填；' 
			  from @tableTemp tt
			  where tt.DateCode is null or tt.DateCode = ''
				
			  UPDATE tt      
			  SET tt.ERROR += N'您导入的excel中有重复数据；' 
			  from @tableTemp tt 
			  WHERE EXISTS (
							SELECT * 
							FROM @tableTemp tr
							WHERE tt.QAD=tr.QAD
							AND tt.CustPo = tr.CustPo
							AND tt.PoLine = tr.PoLine
							HAVING COUNT(*)>=2	)			           

			  IF(EXISTS(
						SELECT *
						FROM @tableTemp
						WHERE ERROR <>''
							))
				BEGIN
					SELECT CustPo,
					  PoLine,
			          CustPart,
			          DateCode,
			          UM,
					  Qad,
					  Price,
					  Currency,
					  Location,
					  Qty,
					  error
					FROM @tableTemp
				END
				ELSE
				BEGIN																																					
					Declare
	                @CustPo VARCHAR(20)
					,@PoLine NVARCHAR(20)
					,@CustPart VARCHAR(50)
					,@DateCode VARCHAR(500)
					,@UM NVARCHAR(20)
					,@Qad NVARCHAR(200)
					,@Price NVARCHAR(200)
					,@Currency VARCHAR(50)
					,@Location NVARCHAR(500)
					,@Qty NVARCHAR(50)			
					,@Fob nvarchar(50)
					,@uName nvarchar(50)															
							 														  										
					select @uName = userName
					from tcpc0.dbo.Users
					where userID = @uID
																
					INSERT INTO dbo.comp_importDoc
							(   FileID,
								GuestComplaintNo,
							    CustPo 
								,PoLine
							    ,CustPart 
							    ,DateCode 
							    ,UM
								,Qad
							    ,Price 
							    ,Currency 
							    ,Location 
							    ,Qty 
								,FOB
								,CreateBy
								,CreateName,
								CreateDate
							)
					select  newid(),@compNo,temp.CustPo,temp.poLine,partNbr,temp.DateCode,d.um,d.qadPart,d.price,price.Pi_Currency,temp.Location,temp.Qty,price.Pi_price3,@uID,@uName,GETDATE()
					FROM @tableTemp temp
					inner join edi_db.dbo.EdiPoHrd h on temp.CustPo = h.poNbr 
					inner JOIN EDI_DB.dbo.EdiPoDet d ON d.hrd_id = h.id  and d.poLine = temp.PoLine							
					left JOIN tcpc0.dbo.Pi_PriceList price ON price.Pi_Cust=h.cusCode  AND price.Pi_QAD = d.qadPart
					left JOIN tcpc0.dbo.SID_det det on det.SID_so_nbr = h.poNbr AND det.SID_so_line = d.poLine 
					left JOIN tcpc0.dbo.SID_mstr mstr on mstr.SID_shipdate >= price.Pi_StartDate and mstr.SID_shipdate < price.Pi_EndDate and mstr.SID_id = det.SID_id
																						     												
			end
			IF(@@error <> 0)
			BEGIN
				ROLLBACK transaction
				SELECT 0                   
			END
			ELSE
			BEGIN
				COMMIT transaction
				SELECT 1                       
			END                                
END

