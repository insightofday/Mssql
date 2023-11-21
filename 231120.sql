SELECT A.StuffDate, CASE WHEN A.StuffClss = '1' THEN '정상' ELSE '반품' END AS StuffClssName, 
   B.KCustom, C.Article, C.ArticleNo, D.OrderID, D.OrderNo, A.TotRoll, A.TotQty, 
   A.UnitClss, CASE WHEN A.UnitClss = '0' THEN 'Y' ELSE 'M' END AS UnitClssName, 
   A.Custom, A.Remark, 
   A.KeyDate + CONVERT(VARCHAR(5), A.KeySeq) AS StuffInKey 
FROM StuffIN AS A 
LEFT JOIN mt_Custom AS B ON A.CustomID = B.CustomID 
LEFT JOIN mt_Article AS C ON A.ArticleID = C.ArticleID 
LEFT JOIN [Order] AS D ON A.OrderId = D.OrderID 
WHERE A.StuffDate <> '' 
AND   A.InType IN ('0', '1') 
AND A.StuffDate BETWEEN '20211120' AND '20231120' 
ORDER BY A.StuffDate, A.KeyDate, A.KeySeq 



SELECT A.CustomID, A.ArticleID, A.OrderID, SUM(A.StockRoll + A.StuffRoll - A.OutRoll) As BaseRoll, SUM(A.StockQty + A.StuffQty - A.OutQty) As BaseQty, Cls = '0'  
INTO #BASESTOCK  
FROM 
 (SELECT A.CustomID, A.ArticleID, OrderID = '' , SUM(A.StockRoll) AS StockRoll,  Sum(A.StockQty) AS StockQty, StuffRoll = 0, StuffQty = 0, OutRoll = 0, OutQty = 0 
 FROM sb_Stock AS A 
 WHERE A.BasisDate = '' 
 GROUP BY A.CustomID, A.ArticleID 

 UNION ALL 

 SELECT A.CustomID, A.ArticleID, A.OrderID, StockRoll = 0, StockQty = 0, Sum(A.TotRoll) AS StuffRoll, Sum(A.TotQtyY) As StuffQty, OutRoll = 0, OutQty = 0 
 FROM StuffIN AS A 
 --StuffDate컬럼이 비어있지 않음을 검사하기 위한 구문: A.StuffDate>''
 WHERE A.StuffDate > '' AND A.StuffDate <'20231101' 
 GROUP BY A.CustomID, A.ArticleID, A.OrderID 

 UNION ALL 

 SELECT B.Customid, B.ArticleID, A.OrderID, StockRoll = 0, StockQty = 0, StuffRoll = 0, StuffQty = 0, SUM(A.OutRoll) AS OutRoll, SUM(A.OutRealQty) As OutQty 
 FROM OutWare AS A 
 LEFT JOIN [Order] AS B ON A.OrderID = B.OrderID 
 WHERE A.Outdate > '' AND A.OutDate < '20231101' 
 GROUP BY B.CustomID, B.ArticleID, A.OrderID 

 UNION ALL 

 SELECT B.CustomID, B.ArticleID, A.OrderID, StuffRoll = 0,StuffQty = 0, 0 AS OutRoll, 0 AS OutQty, 0 AS OutQtyY, SUM(A.OutQty) AS OutRealQty 
 FROM OutWareLoss As A 
 LEFT JOIN [Order] AS B ON A.OrderID = B.OrderID 
 LEFT JOIN mt_Work AS C ON B.WorkID = C.WorkID 
 WHERE A.Outdate > '' AND A.OutDate < '20231101' 
 GROUP BY B.CustomID, B.ArticleID, A.OrderID 

 ) AS A 
GROUP BY A.CustomID, A.ArticleID, A.OrderID 




SELECT C.KCustom, D.Article, D.ArticleNo,  
     SUM(A.BaseRoll) AS BaseRoll, SUM(A.BaseQty) As BaseQty, SUM(A.StuffRoll) As StuffRoll, SUM(A.StuffQty) As StuffQty, 
     SUM(A.OutRoll) As OutRoll, SUM(A.OutQty) As Outqty, SUM(A.OutQtyY) AS OutQtyY, SUM(A.OutRealQty) AS outRealQty, A.CustomID, A.ArticleID 
FROM ( 
 SELECT StuffRoll = 0, StuffQty = 0, OutRoll = 0,OutQty = 0, OutQtyY = 0, OutRealQty = 0, A.BaseRoll, A.BaseQty, A.OrderID, A.CustomID, A.ArticleID, C.WorkID, IODate = '', KeySeq = 0, Remark = '', SubulKey = '', InptDate= '', InType = ''   
 FROM #BASESTOCK AS  a
LEFT JOIN [Order] AS C ON A.OrderID = C.OrderID 
 WHERE A.BaseQty <> 0 
 Union All 
 SELECT StuffRoll, StuffQty, OutRoll, OutQty,OutQtyY, OutRealQty, BaseRoll = 0, BaseQty = 0, OrderID, CustomID, ArticleID, WorkID, IODate, KeySeq, Remark, SubulKey, InptDate, InType  
 FROM #SUBUL 
) AS A 
LEFT JOIN [Order] AS B ON A.OrderID = B.OrderID 
LEFT JOIN mt_Custom AS C ON A.CustomID = C.CustomID 
LEFT JOIN mt_Article AS D ON A.ArticleID = D.ArticleID 
LEFT JOIN mt_Work AS E ON A.WorkID = E.WorkID 
LEFT JOIN mt_StuffWidth AS F ON B.WorkWidth = F.StuffWidthID 
WHERE A.CustomID <> '' 
GROUP BY C.KCustom, D.Article, D.ArticleNo, A.CustomID, A.ArticleID, C.ShortCustom  
ORDER BY C.KCustom, D.Article 
