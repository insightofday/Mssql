
SELECT A.StuffDate, CASE WHEN A.StuffClss = '1' THEN '정상' ELSE '반품' END AS StuffClssName, 
   B.KCustom, C.Article, A.OrderID, D.OrderNo, E.Color, SUM(A.StuffRoll) AS TotRoll, SUM(A.StuffRoll * A.StuffUnitQty) AS TotQty, 
   A.UnitClss, CASE WHEN A.UnitClss = '0' THEN 'Y' ELSE 'M' END AS UnitClssName, 
   A.Custom, A.Remark, 
   A.KeyDate + CONVERT(VARCHAR(5), A.KeySeq) AS StuffInKey 
FROM ( 
         SELECT A.KeyDate, A.KeySeq, A.StuffDate, A.StuffClss, A.OrderID, A.CustomID, A.ArticleID, A.UnitClss, A.Custom, A.Remark, 
                B.OrderSeq, B.LotNo, B.StuffPart, 
                CAST(CASE WHEN B.StuffPart = '1' THEN SUBSTRING(B.Qty, CHARINDEX('*', B.Qty) + 1, LEN(B.Qty)) ELSE 1 END AS numeric(9, 3)) AS StuffRoll, 
                CAST(CASE WHEN B.StuffPart = '1' THEN SUBSTRING(B.Qty, 1, CHARINDEX('*', B.Qty) - 1) ELSE B.Qty END AS numeric(9, 3)) AS StuffUnitQty 
         FROM StuffIN AS A 
         INNER JOIN StuffINReturn AS B on A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq 
     ) AS A 
LEFT JOIN mt_Custom AS B ON A.CustomID = B.CustomID 
LEFT JOIN mt_Article AS C ON A.ArticleID = C.ArticleID 
LEFT JOIN [Order] AS D ON A.OrderId = D.OrderID 
LEFT JOIN [vw_OrderColor] AS E ON A.OrderID = E.OrderID AND A.OrderSeq = E.OrderSeq 
WHERE A.StuffDate <> '' 
GROUP BY A.KeyDate, A.KeySeq, A.StuffDate, A.StuffClss, A.OrderID, A.CustomID, A.ArticleID, A.UnitClss, A.Custom, A.Remark, A.OrderSeq, B.KCustom, C.Article, D.OrderNo, E.Color  
ORDER BY A.StuffDate, A.KeySeq 


