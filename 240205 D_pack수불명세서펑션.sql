--USE [DMB_Pack]
--GO
/****** Object:  UserDefinedFunction [dbo].[DSF06]    Script Date: 2024-02-05 오후 3:51:50 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
-- drop function [DSF06]

--ALTER        FUNCTION  [dbo].[DSF06] (  @sDate             CHAR(8)
 --                                       , @nChkCustom        SMALLINT = 0
   --                                     , @CustomID          CHAR(4)  =''   
     --                                   , @nChkArticle       SMALLINT = 0
       --                                 , @ArticleID         CHAR(4)  = '' 
		--	, @nChkOrder	SMALLINT = 0
			--, @OrderID	CHAR(10) = ''
             --                          )  RETURNS TABLE
--AS

  --      RETURN  ( 




  --dbo.DSF06('20240101',1, '0065',0, '',0, '' )
-- dbo.DSF06(@sDate, @nChkCustom, @CustomID, @nChkArticle, @ArticleID, @nChkOrderID, @OrderID ) 	
		 SELECT BASE.CustomID, BASE.ArticleID, BASE.OrderID
                        , ProcInClss = ISNULL(ProcInClss,''),  StockClss = ISNULL(StockClss,'')
                        , StockQty = ISNULL(StockQty,0), StockUnitClss = ISNULL(StockUnitClss, '')
                        , StuffINQty = ISNULL(StuffINQty,0)
                        , OutQty = ISNULL(OutQty,0)
                    FROM (  SELECT DISTINCT CustomID, ArticleID, OrderID
                              FROM DS30 AA
                             WHERE BasisDate = '20061130'
                               AND ( ( @nChkCustom = 0 )
                                  OR ( @nChkCustom = 1 AND CustomID = @CustomID ) )
                               AND ( ( @nChkArticle = 0 )
                                  OR ( @nChkArticle = 1 AND ArticleID = @ArticleID ) )
		    AND ( (@nChkOrder = 0 )
		       OR ( @nChkOrder = 1 AND OrderID = @OrderID))

                             UNION   -- 중복되는 것 제거


                            SELECT DISTINCT CustomID, ArticleID, aa.OrderID
                              FROM DS22 AA, DS20 BB
                             WHERE AA.OrderID = BB.OrderID and StuffDate > '20061130'
                               AND StuffDate < @sDate 
                               AND ( ( @nChkCustom = 0 )
                                  OR ( @nChkCustom = 1 AND CustomID = @CustomID ) )
                               AND ( ( @nChkArticle = 0 )
                                  OR ( @nChkArticle = 1 AND ArticleID = @ArticleID ) )
		    AND ( (@nChkOrder = 0 )
		       OR ( @nChkOrder = 1 AND aa.OrderID = @OrderID))
                               AND OrderFlag = '0'


                             UNION  -- 중복되는 것 제거

                            SELECT DISTINCT BB.CustomID, BB.ArticleID, BB.OrderID
                              FROM DS26 AA, [DS20] BB, [DS01] CC
                             WHERE AA.OrderID = BB.OrderID
                               AND BB.ArticleID = CC.ArticleID 
                               AND AA.OutDate > '20061130'
                               AND AA.OutDate < @sDate  
                               AND ( ( @nChkCustom = 0 )
                                  OR ( @nChkCustom = 1 AND BB.CustomID = @CustomID ) )
                               AND ( ( @nChkArticle = 0 )
                                  OR ( @nChkArticle = 1 AND CC.ArticleID = @ArticleID ) )
		    AND ( (@nChkOrder = 0 )
		       OR ( @nChkOrder = 1 AND BB.OrderID = @OrderID))
                               AND BB.OrderFlag = '0'
                         ) AS BASE  

                         LEFT OUTER JOIN  ( SELECT CustomID, ArticleID, OrderID, ProcInClss, StockClss, StockQty, StockUnitClss
                                              FROM [DS30] AA
                                             WHERE BasisDate = '20061130'
                                               AND ( ( @nChkCustom = 0 )
                                                  OR ( @nChkCustom = 1 AND CustomID = @CustomID ) )
                                               AND ( ( @nChkArticle = 0 )
                                                  OR ( @nChkArticle = 1 AND ArticleID = @ArticleID ) )
			    AND ( (@nChkOrder = 0 )
			       OR ( @nChkOrder = 1 AND OrderID = @OrderID))
                                          ) AS Stock  
                        ON BASE.CustomID = Stock.CustomID  AND Base.ArticleID = Stock.ArticleID AND BASE.OrderID = Stock.OrderID

                        LEFT OUTER JOIN  ( SELECT CustomID, ArticleID, aa.OrderID, StuffINQty=SUM(StuffQty)
                                             FROM [DS22] AA, [DS20] BB
                                            WHERE AA.OrderID = BB.OrderID AND StuffDate > '20061130'
                                              AND StuffDate < @sDate 
                                              AND OrderFlag = '0'
                                         GROUP BY CustomID, ArticleID, aa.OrderID 
                                         ) AS  StuffIN
                        ON BASE.CustomID = StuffIN.CustomID  AND Base.ArticleID = StuffIN.ArticleID AND Base.OrderID = StuffIn.OrderID


                        LEFT OUTER JOIN (  SELECT BB.CustomID, BB.ArticleID, BB.OrderID, OutQty=SUM(AA.OutRealQty)
                                             FROM [DS26] AA, [DS20] BB, [DS01] CC
                                            WHERE AA.OrderID = BB.OrderID
                                              AND BB.ArticleID = CC.ArticleID 
                                              AND AA.OutDate > '20061130'
                                              AND AA.OutDate < @sDate  
                                              AND BB.OrderFlag = '0'
                                         GROUP BY BB.CustomID, BB.ArticleID, BB.OrderID
                                        ) AS OutWare
                        ON BASE.CustomID = OutWare.CustomID  AND Base.ArticleID = OutWare.ArticleID AND Base.OrderID = OutWare.OrderID
                --)







