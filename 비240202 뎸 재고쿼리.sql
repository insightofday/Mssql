--1 기초재고
SELECT A.OrderID, A.ColorID, SUM(A.PassRoll - A.POutRoll) AS BPassRoll, SUM(A.PassQty - A.POutQty) AS BPassQty, 
       SUM(A.DefectRoll - A.DOutRoll) AS BDefectRoll, SUM(A.DefectQty - A.DOutQty)  AS BDefectQty
INTO #BASESTOCK
FROM (
     SELECT A.OrderID, A.ColorID, COUNT(*) AS PassRoll, SUM(A.CtrlQty) AS PassQty, 0 AS DefectRoll, 
            0 AS DefectQty, 0 AS POutRoll, 0 AS POutQty, 0 AS DOutRoll, 0 AS DOutQty
     FROM [DS24] AS A												--ds24:검사
     LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID					--ds20:수주
     WHERE A.GradeClss < B.DefectClss
       AND A.ExamDate < '20231228'
     GROUP BY A.OrderID, A.ColorID

     UNION ALL

     SELECT A.OrderID, A.ColorID, 0 AS PassRoll, 0 AS PassQty, COUNT(*) AS DefectRoll, 
            SUM(A.CtrlQty) AS DefectQty, 0 AS POutRoll, 0 AS POutQty, 0 AS DOutRoll, 0 AS DOutQty
     FROM [DS24] AS A												--ds24:검사
     LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID					--ds20:수주
     WHERE A.GradeClss >= B.DefectClss
       AND A.ExamDate < '20231228'
     GROUP BY A.OrderID, A.ColorID
     
	 UNION ALL
     
	 SELECT A.OrderID, A.ColorID, 0 AS PassRoll, 0 AS PassQty, 0 AS DefectRoll, 0 AS DefectQty, 
            SUM(A.OutRoll) AS POutRoll, SUM(A.OutQty) AS POutQty, 0 AS DOutRoll, 0 AS DOutQty
     FROM [DS27] AS A												--ds27:출고상세
     LEFT JOIN [DS26] AS B ON A.OrderID = B.OrderID AND A.OutID = B.OutID				--ds26:출고
     LEFT JOIN [DS24] AS C ON A.OrderID = C.OrderID AND A.RollID = C.RollID				--ds24:검사
     LEFT JOIN [DS20] AS D ON A.OrderID = D.OrderID										--ds20:수주
     WHERE C.GradeClss < D.DefectClss
       AND B.OutDate < '20231228'
     GROUP BY A.OrderID, A.ColorID
     
	 UNION ALL
     
	 SELECT A.OrderID, A.ColorID, 0 AS PassRoll, 0 AS PassQty, 0 AS DefectRoll, 0 AS DefectQty, 
            0 AS POutRoll, 0 AS POutQty, SUM(A.OutRoll) AS DOutRoll, SUM(A.OutQty) AS DOutQty
     FROM [DS27] AS A
     LEFT JOIN [DS26] AS B ON A.OrderID = B.OrderID AND A.OutID = B.OutID
     LEFT JOIN [DS24] AS C ON A.OrderID = C.OrderID AND A.RollID = C.RollID
     LEFT JOIN [DS20] AS D ON A.OrderID = D.OrderID
     WHERE C.GradeClss >= D.DefectClss
       AND B.OutDate < '20231228'
     GROUP BY A.OrderID, A.ColorID
) AS A
GROUP BY A.OrderID, A.ColorID

select * from #basestock

--2 수불
SELECT A.OrderID, A.ColorID, A.ExamDate AS ExamDate, SUM(A.InRoll) AS InRoll, SUM(A.InQty) AS InQty, SUM(A.PassRoll) AS PassRoll, SUM(A.PassQty) AS PassQty, 
       SUM(A.DefectRoll) AS DefectRoll, SUM(A.DefectQty) AS DefectQty, SUM(A.PassOutRoll) AS PassOutRoll, SUM(A.PassOutQty) AS PassOutQty, 
       SUM(A.DefectOutRoll) AS DefectOutRoll, SUM(A.DefectOutQty) AS DefectOutQty
INTO #SUBUL
FROM (
     SELECT A.OrderID, A.ColorID, MAX(A.StuffDate) AS ExamDate, SUM(A.StuffRoll) AS InRoll, SUM(A.StuffQty) AS InQty, 
            0 AS PassRoll, 0 AS PassQty, 0 AS DefectRoll, 0 AS DefectQty, 0 AS PassOutRoll, 0 AS PassOutQty, 0 AS DefectOutRoll, 0 AS DefectOutQty
     FROM [DS23] AS A
     WHERE A.StuffDate BETWEEN '20231228' AND '20240202'
     GROUP BY A.OrderID, A.ColorID
     UNION ALL
     SELECT A.OrderID, A.ColorID, MAX(A.ExamDate) AS ExamDate, 0 AS InRoll, 0 AS InQty, COUNT(*) AS PassRoll, SUM(A.CtrlQty) AS PassQty, 
            0 AS DefectRoll, 0 AS DefectQty, 0 AS PassOutRoll, 0 AS PassOutQty, 0 AS DefectOutRoll, 0 AS DefectOutQty
     FROM [DS24] AS A
     LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID
     WHERE A.GradeClss < B.DefectClss
       AND A.ExamDate BETWEEN '20231228' AND '20240202'
     GROUP BY A.OrderID, A.ColorID
     UNION ALL
     SELECT A.OrderID, A.ColorID, MAX(A.ExamDate) AS ExamDate, 0 AS InRoll, 0 AS InQty, 0 AS PassRoll, 0 AS PassQty, 
            COUNT(*) AS DefectRoll, SUM(A.CtrlQty) AS DefectQty, 0 AS PassOutRoll, 0 AS PassOutQty, 0 AS DefectOutRoll, 0 AS DefectOutQty
     FROM [DS24] AS A
     LEFT JOIN [DS20] AS B ON A.OrderID = B.OrderID
     WHERE A.GradeClss >= B.DefectClss
       AND A.ExamDate BETWEEN '20231228' AND '20240202'
     GROUP BY A.OrderID, A.ColorID
     UNION ALL
     SELECT A.OrderID, A.ColorID, MAX(A.FixDate) AS ExamDate, 0 AS InRoll, 0 AS InQty, 0 AS PassRoll, 0 AS PassQty, 0 AS DefectRoll, 0 AS DefectQty, 
            SUM(A.OutRoll) AS PassOutRoll, SUM(A.OutQty) AS PassOutQty, 0 AS DefectOutRoll, 0 AS DefectOutQty
     FROM [DS27] AS A
     LEFT JOIN [DS26] AS B ON A.OrderID = B.OrderID AND A.OutID = B.OutID
     LEFT JOIN [DS24] AS C ON A.OrderID = C.OrderID AND A.RollID = C.RollID
     LEFT JOIN [DS20] AS D ON A.OrderID = D.OrderID
     WHERE A.FixDate BETWEEN '20231228' AND '20240202'
       AND C.GradeClss < D.DefectClss
     GROUP BY A.OrderID, A.ColorID
     UNION ALL
     SELECT A.OrderID, A.ColorID, MAX(A.FixDate) AS ExamDate, 0 AS InRoll, 0 AS InQty, 0 AS PassRoll, 0 AS PassQty, 0 AS DefectRoll, 0 AS DefectQty, 
            0 AS PassOutRoll, 0 AS PassOutQty, SUM(A.OutRoll) AS DefectOutRoll, SUM(A.OutQty) AS DefectOutQty
     FROM [DS27] AS A
     LEFT JOIN [DS26] AS B ON A.OrderID = B.OrderID AND A.OutID = B.OutID
     LEFT JOIN [DS24] AS C ON A.OrderID = C.OrderID AND A.RollID = C.RollID
     LEFT JOIN [DS20] AS D ON A.OrderID = D.OrderID
     WHERE A.FixDate BETWEEN '20231228' AND '20240202'
       AND C.GradeClss >= D.DefectClss
     GROUP BY A.OrderID, A.ColorID
) AS A
WHERE A.OrderID <> ''
GROUP BY A.OrderID, A.ColorID, A.ExamDate


--3
SELECT F.KCustom, A.OrderNo, B.Color, E.Article, LEFT(D.ExamDate, 4) + '-' + SUBSTRING(D.ExamDate, 5, 2) + '-' + RIGHT(D.ExamDate, 2) AS JoinDate, 
       CASE WHEN A.OrderUnit = '0' THEN 'Y' ELSE 'M' END UNIT, G.Width, ISNULL(B.ColorQty, 0) AS ColorQty, 
       ISNULL(SUM(C.BPassRoll), 0) AS BPassRoll, ISNULL(SUM(C.BPassQty), 0) AS BPassQty, ISNULL(SUM(C.BDefectRoll), 0) AS BDefectRoll, ISNULL(SUM(C.BDefectQty), 0) AS BDefectQty,
       ISNULL(SUM(D.InRoll), 0) AS InRoll, ISNULL(SUM(D.InQty), 0) AS InQty, ISNULL(SUM(D.PassRoll), 0) AS PassRoll, ISNULL(SUM(D.PassQty), 0) AS PassQty, 
       ISNULL(SUM(D.DefectRoll), 0) AS DefectRoll, ISNULL(SUM(D.DefectQty), 0) AS DefectQty, 
       ISNULL(SUM(D.PassOutRoll), 0) AS PassOutRoll, ISNULL(SUM(D.PassOutQty), 0) AS PassOutQty, ISNULL(SUM(D.DefectOutRoll), 0) AS DefectOutRoll, ISNULL(SUM(D.DefectOutQty), 0) AS DefectOutQty,
       A.OrderID, A.CustomID, B.ColorID
FROM [DS20] AS A
LEFT JOIN [DS21] AS B ON A.OrderID = B.OrderID
LEFT JOIN [#BASESTOCK] AS C ON B.OrderID = C.OrderID AND B.ColorID = C.ColorID
LEFT JOIN [#SUBUL] AS D ON  B.OrderID = D.OrderID AND B.ColorID = D.ColorID
LEFT JOIN [DS01] AS E ON A.ArticleID = E.ArticleID
LEFT JOIN [DS02] AS F ON A.CustomID = F.CustomID
LEFT JOIN [DS13] AS G ON A.WidthID = G.WidthID
WHERE 1 = 1
AND D.ExamDate BETWEEN '20231228' AND '20240202' 
AND A.CustomID = '0062'
GROUP BY F.KCustom, A.OrderNo, B.Color, E.Article, D.ExamDate, A.OrderUnit, G.Width, B.ColorQty, A.CustomID, A.OrderID, B.ColorID
ORDER BY A.CustomID, A.OrderNo, E.Article, B.ColorID, D.ExamDate

