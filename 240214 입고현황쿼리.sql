--printstuffinbydate
     DECLARE @FromDate   CHAR(8)                                                             
     SET @FromDate = LEFT( '20240214', 6 ) + '01'                                                                
                                                                     
     SET NOCOUNT ON                                                              
     SELECT StuffDate, kCustom = ( SELECT KCustom FROM [DS02] BB WHERE AA.CustomID1 = BB.CustomID ), Custom = ISNULL( ( SELECT kCustom FROM [DS02] BB, [DS20] CC WHERE AA.OrderID = CC.OrderID AND CC.CustomID = BB.CustomID ), '' )                                                              
         , Article = ISNULL( ( SELECT Article FROM [DS01] BB, [DS20] CC WHERE AA.OrderID = CC.OrderID AND CC.ArticleID = BB.ArticleID ), '' ), OrderID, OrderNO =  ( SELECT OrderNo FROM [DS20] BB WHERE AA.OrderID = BB.OrderID )                                                          
         , WorkName = ISNULL( ( SELECT WorkName FROM [DS19] BB, [DS20] CC WHERE AA.OrderID = CC.OrderID AND CC.WorkID = BB.WorkID ), '' )                                                            
         , stuffroll AS InRoll, stuffqty AS InQty, InQtyY=CASE (select unitclss from ds20 bb where bb.orderid = aa.orderid) WHEN '0' THEN  stuffqty ELSE Round(stuffqty*1.0936,0) END                                                            
         , UnitClssYM=CASE (select unitclss from ds20 bb where bb.orderid = aa.orderid) WHEN '0' THEN 'Y' ELSE 'M' END, '' StuffClss, '' Remark                                                            
     INTO #Temp                                                              
     FROM DS22 AA                                                               
     WHERE StuffDate BETWEEN  '20240214'  AND  '20240214'                                                                
     SELECT StuffDate, kCustom = ISNULL( ( SELECT KCustom FROM [DS02] BB WHERE AA.CustomID1 = BB.CustomID ), '' ), Custom = ISNULL( ( SELECT kCustom FROM [DS02] BB, [DS20] CC WHERE AA.OrderID = CC.OrderID AND CC.CustomID = BB.CustomID ), '' )                                                                
         , Article = ISNULL( ( SELECT Article FROM [DS01] BB, [DS20] CC WHERE AA.OrderID = CC.OrderID AND CC.ArticleID = BB.ArticleID ), '' ), OrderID, OrderNO =  ( SELECT OrderNo FROM [DS20] BB WHERE AA.OrderID = BB.OrderID )                                                           
         , WorkName = ISNULL( ( SELECT WorkName FROM [DS19] BB, [DS20] CC WHERE AA.OrderID = CC.OrderID AND CC.WorkID = BB.WorkID ), '' )                                                            
         , stuffroll AS InRoll, stuffqty AS InQty, InQtyY=CASE (select unitclss from ds20 bb where bb.orderid = aa.orderid) WHEN '0' THEN  stuffqty ELSE Round(stuffqty*1.0936,0) END                                                            
         , UnitClssYM=' ', '' StuffClss, '' Remark                                                         
     INTO #Temp1                                                             
     FROM DS22 AA                                                               
     WHERE StuffDate BETWEEN  @FromDate  AND  '20240214'                                                             
                                                                     
                                                                     
     SELECT StuffDate, Depth= 'Z1', kCustom, Custom, Article, A.OrderID, OrderNO                                                             
         , WorkName, TotQty=B.StuffINQty, SUM(InRoll) AS InRoll, SUM(InQty) AS InQty, UnitClssYM, StuffClss, Remark                                                          
     FROM #Temp A, A012 B                                                               
     WHERE   A.OrderID=B.OrderID                                                         
     GROUP BY StuffDate, kCustom, Custom, Article, A.OrderID, OrderNO, WorkName, B.StuffINQty, UnitClssYM, StuffClss, Remark                                                             
                                                                     
     UNION ALL  
                                                                     
     SELECT StuffDate, Depth= 'Z2', kCustom ='ZZZZZZ', Custom ='', Article ='', OrderID='', OrderNO=''                                                               
         , WorkName='', TotQty=0, InRoll = sum(InRoll), InQty = sum(InQtyY), UnitClssYM='Y', StuffClss=0, Remark = ''                                                            
     FROM #Temp                                                              
     GROUP BY StuffDate                                                              
                                                                     
     UNION ALL                                                                       
     SELECT StuffDate = '99999999', Depth ='Z3', kCustom ='ZZZZZZZ', Custom ='', Article ='', OrderID='', OrderNO=''                                                             
         , WorkName='', TotQty=0, InRoll = sum(InRoll), InQty = sum(InQtyY), UnitClssYM='Y', StuffClss=0, Remark = ''                                                            
     FROM #Temp1                                                             
     ORDER BY StuffDate, Depth, kCustom, Article                                                             




--printoutwarebydate
     DECLARE @Date   CHAR(8)                                                             
     SET @Date = LEFT( '20240214', 6 ) + '01'                                                                
                                                                     
     SET NOCOUNT ON                                                              
     SELECT  C.CustomID, KCustom = ISNULL(( SELECT KCustom FROM [DS02] Z WHERE Z.CustomID = C.CustomID), ''),                                                           
         C.OrderNo, B.OrderID, B.OutCustom,                                                          
         Article = ISNULL((SELECT Article FROM [DS01] Z WHERE Z.ArticleID = C.ArticleID),''),                                                          
         WorkName = ISNULL((SELECT WorkName FROM [DS19] Z WHERE Z.WorkID = C.WorkID), ''),                                                            
         OutClss = B.OutClss, C.UnitClss, B.OutRoll, B.OutQty, B.OutQtyY, B.TotalPrice ,D.UnitPrice                                                          
                                                                     
     INTO  #Temp                                                             
     FROM DS20 C, DSF05 ('20240214', '20240214') B,(select OrderID,AVG(UnitPrice) unitprice FROM DS21 WHERE OrderSeq<> 0 GROUP BY orderid) D 
     WHERE C.OrderID = B.OrderID AND C.OrderID = D.OrderID                                                             
                                                                     
                                                                     
     SELECT  SUM(B.OutRoll) AS OutRoll, SUM(B.OutQtyY) AS OutQtyY, SUM(B.TotalPrice) AS TotalPrice                                                               
     INTO #TEMP1                                                             
     FROM DS20 C, DSF05 (@Date, '20240214') B                                                             
     WHERE C.OrderID = B.OrderID                                                             
                                                                     
                                                                     
     SELECT Depth = '0', CustomID, KCustom, OrderNo, A.OrderID, OutCustom, Article, WorkName, OutClss                                                                
         , UnitClss, TotQty=B.OutQty, SUM(A.OutRoll) AS OutRoll, SUM(A.OutQty) AS OutQty, SUM(A.TotalPrice) AS TotalPrice                                                            
         , MAX(unitprice) unitprice
     FROM #TEMP A, A009 B                                                               
     WHERE A.OrderId=B.OrderID                                                               
     GROUP By CustomID, KCustom, OrderNo, A.OrderID, OutCustom, Article, WorkName, OutClss, UnitClss, B.OutQty                                                               
                                                                     
     UNION ALL                                                               
     SELECT Depth = '1', CustomID, KCustom, OrderNo = '', OrderID = '', OutCustom = '', Article, WorkName = '', OutClss = 0                                                              
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         , 0 unitPrice
     FROM #TEMP                                                              
     GROUP BY CustomID, KCustom, Article                                                             
     HAVING COUNT(DISTINCT OrderID) <> 1                                                             
                                                                     
     UNION ALL                                                               
     SELECT Depth = '2', CustomID, KCustom, OrderNo = '', OrderID = '', OutCustom = '', Article = 'XXXXX', WorkName = '',  OutClss = 0                                                               
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         ,0 unitprice     FROM #TEMP                                                              
     GROUP BY CustomID, KCustom                                                              
                                                                     
     UNION ALL                                                               
     SELECT Depth = '3', CustomID = '', KCustom = 'ZZZZZ', OrderNo = '', OrderID = '', OutCustom = '', Article = 'YYYYY', WorkName = '', OutClss = 0                                                             
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         ,0 unitprice
     FROM #TEMP                                                              
                                                                     
     UNION ALL                                                               
                                                                     
     SELECT Depth = '4', CustomID = '', KCustom = 'ZZZZZ', OrderNo = '', OrderID = '', OutCustom = '', Article = 'ZZZZZ', WorkName = '', OutClss = 0                                                             
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         , 0 UnitPrice
     FROM #TEMP1                                                             
                                                                     
     ORDER BY KCustom, Article, Depth, OrderNo, OutClss                                                              






--printoutwarebydate2
     DECLARE @Date   CHAR(8)                                                             
     SET @Date = LEFT( '20240114', 6 ) + '01'                                                                
                                                                     
     SET NOCOUNT ON                                                              
     SELECT  C.CustomID, KCustom = ISNULL(( SELECT KCustom FROM [DS02] Z WHERE Z.CustomID = C.CustomID), ''),                                                           
         C.OrderNo, B.OrderID, B.OutCustom,                                                          
         Article = ISNULL((SELECT Article FROM [DS01] Z WHERE Z.ArticleID = C.ArticleID),''),                                                          
         WorkName = ISNULL((SELECT WorkName FROM [DS19] Z WHERE Z.WorkID = C.WorkID), ''),                                                            
         OutClss = B.OutClss, C.UnitClss, B.OutRoll, B.OutQty, B.OutQtyY, B.TotalPrice ,D.UnitPrice                                                          
                                                                     
     INTO  #Temp                                                             
     FROM DS20 C, DSF05 ('20240114', '20240114') B,(select OrderID,AVG(UnitPrice) unitprice FROM DS21 WHERE OrderSeq<> 0 GROUP BY orderid) D 
     WHERE C.OrderID = B.OrderID AND C.OrderID = D.OrderID                                                             
                                                                     
                                                                     
     SELECT  SUM(B.OutRoll) AS OutRoll, SUM(B.OutQtyY) AS OutQtyY, SUM(B.TotalPrice) AS TotalPrice                                                               
     INTO #TEMP1                                                             
     FROM DS20 C, DSF05 (@Date, '20240114') B                                                             
     WHERE C.OrderID = B.OrderID                                                             
                                                                     
                                                                     
     SELECT Depth = '0', CustomID, KCustom, OrderNo, A.OrderID, OutCustom, Article, WorkName, OutClss                                                                
         , UnitClss, TotQty=B.OutQty, SUM(A.OutRoll) AS OutRoll, SUM(A.OutQty) AS OutQty, SUM(A.TotalPrice) AS TotalPrice                                                            
         , MAX(unitprice) unitprice
     FROM #TEMP A, A009 B                                                               
     WHERE A.OrderId=B.OrderID                                                               
     GROUP By CustomID, KCustom, OrderNo, A.OrderID, OutCustom, Article, WorkName, OutClss, UnitClss, B.OutQty                                                               
                                                                     
     UNION ALL                                                               
     SELECT Depth = '1', CustomID, KCustom, OrderNo = '', OrderID = '', OutCustom = '', Article, WorkName = '', OutClss = 0                                                              
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         , 0 unitPrice
     FROM #TEMP                                                              
     GROUP BY CustomID, KCustom, Article                                                             
     HAVING COUNT(DISTINCT OrderID) <> 1                                                             
                                                                     
     UNION ALL                                                               
     SELECT Depth = '2', CustomID, KCustom, OrderNo = '', OrderID = '', OutCustom = '', Article = 'XXXXX', WorkName = '',  OutClss = 0                                                               
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         ,0 unitprice     FROM #TEMP                                                              
     GROUP BY CustomID, KCustom                                                              
                                                                     
     UNION ALL                                                               
     SELECT Depth = '3', CustomID = '', KCustom = 'ZZZZZ', OrderNo = '', OrderID = '', OutCustom = '', Article = 'YYYYY', WorkName = '', OutClss = 0                                                             
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         ,0 unitprice
     FROM #TEMP                                                              
                                                                     
     UNION ALL                                                               
                                                                     
     SELECT Depth = '4', CustomID = '', KCustom = 'ZZZZZ', OrderNo = '', OrderID = '', OutCustom = '', Article = 'ZZZZZ', WorkName = '', OutClss = 0                                                             
         , UnitClss = '', TotQty=0, SUM(OutRoll) AS OutRoll, SUM(OutQtyY) AS OutQty, SUM(TotalPrice) AS TotalPrice                                                           
         , 0 UnitPrice
     FROM #TEMP1                                                             
                                                                     
     ORDER BY KCustom, Article, Depth, OrderNo, OutClss                                                              


