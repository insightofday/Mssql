---1
 SELECT SUM(B.CurrstockQty) SearchStockQty, dbo.dfn_GetTotalArticleStock() TotStockQty                              
   FROM (SELECT A.ArticleID, A.Article, A.Article1, B.SeqNo , B.barcode, B.ArticleOption, B.GradeClss, B.Memo       
          FROM mt_Article A                                                                                         
          LEFT JOIN mt_ArticleOption B ON A.ArticleID=B.ArticleID                                                   
            INNER JOIN (SELECT A.ArticleID, A.Article_Barcode                                    
                          FROM vw_ProcessCard_Product_Worker A                                   
                          WHERE A.ScheduleDate >=REPLACE(CONVERT(VARCHAR,GetDate(),23),'-','')   
                          GROUP BY A.ArticleID, A.Article_Barcode) H ON  B.ArticleID =H.ArticleID              
                                                                     AND B.BarCode =H.Article_Barcode          
         WHERE 1=1                                                             
               AND A.UseClss<>'*'                                 
               AND B.UseClss<>'*'                                 
        )A                                                        
  INNER JOIN vw_Article_Stock B ON A.ArticleID=B.ArticleID        
                               AND A.SeqNo =B.SeqNo               


							   ---2
 SELECT  A.ArticleID, A.SeqNo, A.BarCode, NULL HeadBlick,  NULL AS Article_Img,
         A.Article, 0 ChkButton, B.ArticleOption, B.Size,  dbo.[dfn_SoldOut](B.SoldOutClss,0),     
         0 FunButton1, 0 FunButton2, IIF(ISNULL(D.Qty,0)<>0, '固惯价 : '+CAST(D.Qty AS VARCHAR) +' 俺','') NotSend, 
         dbo.dfn_GetArticle_WorkPlan(A.ArticleID,A.Barcode,0) JaeBon_WorkQty,      
         dbo.dfn_GetArticle_WorkPlan(A.ArticleID,A.Barcode,1) WorkPlan,            
         dbo.dfn_GetArticle_WorkPlan(A.ArticleID,A.Barcode,2) Pack_StandByQty,     
         dbo.dfn_GetArticle_WorkPlan(A.ArticleID,A.Barcode,3) ScheduleDate,        
        REPLACE(REPLACE(REPLACE(ISNULL(A.Memo,''),CHAR(13)+Char(10),CHAR(10)),CHAR(13),CHAR(10)), CHAR(9),'')    Memo,                             
         CASE A.GradeClss WHEN 0 THEN '老馆包府' WHEN 1 THEN '快荐包府' WHEN 2 THEN '漂喊包府' ELSE '固涝仿' END AS GradeClss, 
         B.ShowCaseQty, B.WhStockQty_A, B.WhStockQty_B, B.CurrStockQty, B.UsableStockQty, B.SafeStock, B.SalePrice, B.CostPrice,                           
         0 FunButton3, 0 FunButton4, 0 FunButton5
   FROM (


