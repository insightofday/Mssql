USE [ILSUNGEz]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Roll_DefectList]    Script Date: 2024-03-28 오후 4:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






ALTER FUNCTION [dbo].[fn_Roll_DefectList](@OrderID as CHAR(9), @RollID AS int, @DefectGubun as int ) RETURNS NVARCHAR(500)
AS
BEGIN

		DECLARE @DefectList NVARCHAR(500) , @sOrderID CHAR(9), @sRollID Int, @DefectID  VARCHAR(3)
		DECLARE @KDefect NVARCHAR(30)
		DECLARE @EDefect NVARCHAR(30)
		DECLARE @Cnt     int
		
		DECLARE @sFlag AS SMALLINT

		SET @DefectList=''


		DECLARE DefectList CURSOR FOR 
		  SELECT A.OrderID, A.RollID, A.DefectID, B.KDefect, B.EDefect, Count(A.DefectID) DefecCnt
			FROM ds25 A 
			INNER JOIN DS04 B ON A.DefectID=B.DefectID
			WHERE A.OrderID=@OrderID
			  AND A.RollID=@RollID
			GROUP BY A.OrderID, A.RollID, A.DefectID, B.KDefect, B.EDefect

		OPEN DefectList
			FETCH NEXT FROM DefectList INTO  @sOrderID, @sRollID, @DefectID, @KDefect, @EDefect,@Cnt

			SET @sFlag = 0

			WHILE @@FETCH_STATUS = 0  
			BEGIN

				IF @sFlag = 0 
					BEGIN
						IF @DefectGubun=0        -- 한글명
							BEGIN
								SET @DefectList =@KDefect
							END
						ELSE					  --영문명
							BEGIN
								SET @DefectList =@EDefect
							END

						IF @Cnt >1
						   BEGIN
						    SET @DefectList =@DefectList+ ':' + CAST(@Cnt AS VARCHAR)
						   END
						SET @sFlag=1
					END
				ELSE 
					BEGIN
						IF @DefectGubun=0        -- 한글명
							BEGIN
								SET @DefectList =@DefectList+','+@KDefect
							END
						ELSE					  --영문명
							BEGIN
								SET @DefectList =@DefectList+','+@EDefect
							END
					
						IF @Cnt >1
						   BEGIN
						    SET @DefectList =@DefectList+ ':' + CAST(@Cnt AS VARCHAR)
						   END
				    END
				FETCH NEXT FROM DefectList INTO @sOrderID, @sRollID, @DefectID, @KDefect, @EDefect,@Cnt
			END
	
		CLOSE DefectList
	
		DEALLOCATE DefectList
		RETURN @DefectList


END

