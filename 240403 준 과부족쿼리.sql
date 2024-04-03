SET NOCOUNT ON 
 
SELECT A.OrderID, A.OrderSeq, A.WorkDate, SUM(A.InQty) AS InQty, SUM(A.DTPQty) As DTPQty,  
       SUM(A.PressQty) AS PressQty, SUM(A.InsQty) AS InsQty, SUM(A.OutQty) AS OutQty  
INTO #Temp 
FROM ( 
SELECT A.OrderID, A.OrderSeq, A.WorkDate, 0 AS InQty, SUM(A.WorkQty) AS DTPQty, 0 AS PressQty, 0 AS InsQty, 0 AS OutQty  
FROM [DS_DTP] AS A 
LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID 
WHERE A.OrderID <> '' 
GROUP BY A.OrderID, A.OrderSeq, A.WorkDate 
UNION ALL 
SELECT A.OrderID, A.OrderSeq, A.WorkDate, 0 AS InQty, 0 AS DTPQty, SUM(A.WorkQty) AS PressQty, 0 AS InsQty, 0 AS OutQty  
FROM [DS_Press] AS A 
LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID 
WHERE A.OrderID <> '' 
GROUP BY A.OrderID, A.OrderSeq, A.WorkDate 
UNION ALL 
SELECT A.OrderID, A.OrderSeq, A.WorkDate, 0 AS InQty, 0 AS DTPQty, SUM(A.WorkQty) AS PressQty, 0 AS InsQty, 0 AS OutQty  
FROM [DS_PressNEW] AS A 
LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID 
WHERE A.OrderID <> '' 
GROUP BY A.OrderID, A.OrderSeq, A.WorkDate 
UNION ALL 
SELECT A.OrderID, A.ColorID, A.ExamDate, 0 AS InQty, 0 AS DTPQty, 0 AS PressQty, SUM(A.CtrlQty) AS InsQty, 0 AS OutQty  
FROM [DS24] AS A 
LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID 
WHERE A.OrderID <> ''  
  AND A.GradeClss < B.DefectClss
GROUP BY A.OrderID, A.ColorID, A.ExamDate 
UNION ALL 
SELECT A.OrderID, A.ColorSeq, A.WorkDate, 0 AS InQty, 0 AS DTPQty, 0 AS PressQty, 0 AS InsQty, SUM(CASE WHEN A.OutClss=0 THEN CAST(A.TotQty as Float) ELSE -CAST(A.TotQty as Float)END) OutQty   
FROM [DS_PDoutRoll] AS A  
LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID 
WHERE A.OrderID <> '' 
GROUP BY A.OrderID, A.ColorSeq, A.WorkDate 
) AS A 
GROUP BY A.OrderID, A.OrderSeq, A.WorkDate 
  




SELECT A.OrderID, A.OrderNo, D.KCustom, C.Article, B.DesignNo, B.Color, B.NetQty, A.AcptDate, A.DvlyDate, 
       F.WorkName, E.StuffWidth AS WorkWidthName, B.OrderSeq, A.UnitClss, 
       G.WorkDate, G.InQty, G.DTPQty, G.PressQty, G.InsQty, G.OutQty
FROM [DS20] AS A
LEFT JOIN [DS21] AS B ON A.OrderID = B.OrderID
LEFT JOIN [DS01] AS C ON A.ArticleID = C.ArticleID
LEFT JOIN [DS02] AS D ON A.CustomID = D.CustomID
LEFT JOIN [DS13] AS E ON A.WorkWidth = E.StuffWidthID
LEFT JOIN [DS19] AS F ON A.WorkID = F.WorkID
LEFT JOIN [#Temp] AS G ON B.OrderID = G.OrderID AND B.OrderSeq = G.OrderSeq
WHERE A.OrderID <> '' AND B.OrderSeq <> 0
AND A.OrderNO LIKE '%JT24-180%' 
ORDER BY A.OrderID, A.ArticleID, B.OrderSeq, G.WorkDate


