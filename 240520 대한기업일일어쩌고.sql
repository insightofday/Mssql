--마지막!!
SELECT A.CustomID, CASE WHEN A.CustomID = 'ZZZZ' THEN '내수(각처)' ELSE B.KCustom END AS KCustom, 
       SUM(A.InsQty) AS InsQty, SUM(A.OutQty) AS OutQty, SUM(A.LeftQty) AS LeftQty, SUM(A.NoHPQty) AS NoHPQty, 
       CASE WHEN A.CustomID = '0326' THEN 1 WHEN A.CustomID = '0073' THEN 2 WHEN A.CustomID = '0249' THEN 3 
      WHEN A.CustomID = '0323' THEN 4  WHEN A.CustomID= '0372' THEN 5 WHEN A.CustomID = '0040' THEN 6 WHEN A.CustomID = '0012' THEN 7
       WHEN A.CustomID = '0225' THEN 8 ELSE 9 END Sort 
FROM 
     (SELECT CASE WHEN C.CustomID = '0040' THEN '0040' WHEN C.CustomID = '0323' THEN '0323' WHEN C.CustomID = '0073' THEN '0073'  WHEN C.CustomID= '0372' THEN '0372' 
            WHEN C.CustomID = '0249' THEN '0249' WHEN C.CustomID = '0326' THEN '0326' WHEN C.CustomID = '0012' THEN '0012' 
            WHEN C.CustomID = '0225' THEN '0225' ELSE 'ZZZZ' END AS CustomID, 
             CASE WHEN A.UnitClss = '0' THEN A.CtrlQty ELSE A.CtrlQty * 1.0936 END InsQty, 0 AS OutQty, 0 AS LeftQty, 0 AS NoHPQty 
     FROM Inspect AS A  
     LEFT JOIN [Order] AS B ON A.OrderID = B.OrderID  
     LEFT JOIN [mt_Custom] AS C ON B.CustomID = C.CustomID
     WHERE A.Examdate BETWEEN '20240501' AND '20240519' AND A.GradeID = '1'
      UNION ALL  
     SELECT CASE WHEN C.CustomID = '0040' THEN '0040' WHEN C.CustomID = '0323' THEN '0323' WHEN C.CustomID = '0073' THEN '0073'  WHEN C.CustomID= '0372' THEN '0372' 
            WHEN C.CustomID = '0249' THEN '0249' WHEN C.CustomID = '0326' THEN '0326' WHEN C.CustomID = '0012' THEN '0012' 
            WHEN C.CustomID = '0225' THEN '0225' ELSE 'ZZZZ' END AS CustomID, 
          0 AS InsQty, CASE WHEN B.UnitClss = '0' THEN A.OutQty else A.OutQty * 1.0936 END OutQty, 0 AS LeftQty, 0 AS NoHPQty
     FROM Outware AS A  
     LEFT JOIN [ORDER] AS B ON A.OrderID = B.OrderID  
     LEFT JOIN [mt_Custom] AS C ON B.CustomID = C.CustomID
     WHERE A.Outdate BETWEEN '20240501' AND '20240519'
  UNION ALL 
     SELECT CASE WHEN D.CustomID = '0040' THEN '0040' WHEN D.CustomID = '0323' THEN '0323' WHEN D.CustomID = '0073' THEN '0073'  WHEN D.CustomID= '0372' THEN '0372' 
            WHEN D.CustomID = '0249' THEN '0249' WHEN D.CustomID = '0326' THEN '0326' WHEN D.CustomID = '0012' THEN '0012' 
            WHEN D.CustomID = '0225' THEN '0225' ELSE 'ZZZZ' END AS CustomID, 
         0 AS InsQty, 0 AS OutQty, CASE WHEN B.UnitClss = '0' THEN B.OrderQty - ISNULL(C.InsQty,0) ELSE (B.OrderQty - ISNULL(C.InsQty,0)) * 1.0936 END AS LeftQty, 0 AS NoHPQty
     FROM [Order] AS B 
     LEFT JOIN (SELECT OrderID, SUM(CtrlQty) AS InsQty FROM Inspect WHERE GradeID = '1' GROUP BY OrderID) AS C ON B.OrderID = C.OrderID 
     LEFT JOIN [mt_Custom] AS D ON B.CustomID = D.CustomID
     WHERE B.AcptDate >= '20210801' AND B.AcptDate <= '20240519' 
     AND   B.CloseClss = '0' 
  UNION ALL 
     SELECT CASE WHEN E.CustomID = '0040' THEN '0040' WHEN E.CustomID = '0323' THEN '0323' WHEN E.CustomID = '0073' THEN '0073'  WHEN E.CustomID= '0372' THEN '0372'
            WHEN E.CustomID = '0249' THEN '0249' WHEN E.CustomID = '0326' THEN '0326' WHEN E.CustomID = '0012' THEN '0012' 
            WHEN E.CustomID = '0225' THEN '0225' ELSE 'ZZZZ' END AS CustomID, 
         0 AS InsQty, 0 AS OutQty, 0 AS LeftQty, ISNULL(C.InQty,0) - ISNULL(D.HPQty,0) AS NoHPQty
     FROM [Order] AS B 
     LEFT JOIN (SELECT OrderID, SUM(TotQty) AS InQty FROM StuffIN WHERE StuffDate <= '20240519' GROUP BY OrderID) AS C ON B.OrderID = C.OrderID 
     LEFT JOIN (SELECT OrderID, SUM(WorkQty) AS HPQty FROM DS_ProcessHP WHERE WorkDate <= '20240519' GROUP BY OrderID) AS D ON B.OrderID = D.OrderID 
     LEFT JOIN [mt_Custom] AS E ON B.CustomID = E.CustomID
     WHERE B.AcptDate >= '20210801' AND B.AcptDate <= '20240519' 
     AND   B.CloseClss = '0' 
  ) AS A 
LEFT JOIN mt_Custom AS B ON A.CustomID = B.CustomID 
GROUP BY A.CustomID, B.KCustom 
ORDER BY Sort


