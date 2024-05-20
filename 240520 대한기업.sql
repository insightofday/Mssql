--1업체별집계
SELECT A.ProcessID, A.Process, A.CustomID, SUM(A.TCardCnt) AS CardCnt, SUM(A.TRoll) AS Roll, SUM(A.TQty) AS Qty, A.PrnSeq
FROM (
     SELECT Z.ProcessID, Z.Process,
             CASE WHEN B.CustomID = '0073' THEN '0073' WHEN B.CustomID = '0323' THEN '0323' WHEN B.CustomID = '0326' THEN '0326' 
                 WHEN B.CustomID = '0249' THEN '0249' WHEN B.CustomID = '0040' THEN '0040' WHEN B.CustomID = '0225' THEN '0225' 
				 WHEN B.CustomID= '0372' THEN '0372'
                 ELSE 'ZZZZ' END AS CustomID, D.KCustom, 
             SUM(A.CardCnt) AS TCardCnt, SUM(A.Roll) AS TRoll, SUM(A.Qty) AS TQty, Z.PrnSeq 
     FROM (SELECT ProcessID, Process, PrnSeq FROM mt_Process WHERE SUBSTRING(ProcessID, 3, 2) <> '00' AND ISNULL(UseClss,'') < '*' AND ProcessID NOT IN ('1001', '9001') ) AS Z 
     LEFT JOIN (SELECT OrderID, CardID, SplitID, WaitProcID, 1 AS CardCnt, Roll, Qty FROM [Card] WHERE ISNULL(UseClss,'') <> '*' AND ISNULL(CloseClss,'0') = '0') AS A ON Z.ProcessID = A.WaitProcID 
     LEFT JOIN [Order] B ON A.OrderID = B.OrderID 
     LEFT JOIN [mt_Custom] D ON B.CustomID = D.CustomID 
     LEFT JOIN [mt_Article] E ON B.ArticleID = E.ArticleID 
     WHERE 1 = 1 
     GROUP BY Z.ProcessID, Z.Process, B.CustomID, D.KCustom, Z.PrnSeq
     UNION ALL
     SELECT '9999' AS ProcessID, '보류' AS Process,
             CASE WHEN B.CustomID = '0073' THEN '0073' WHEN B.CustomID = '0323' THEN '0323' WHEN B.CustomID = '0326' THEN '0326' 
             WHEN B.CustomID = '0249' THEN '0249' WHEN B.CustomID = '0040' THEN '0040' WHEN B.CustomID = '0225' THEN '0225' 
			 WHEN B.CustomID= '0372' THEN '0372'
             ELSE 'ZZZZ' END AS CustomID, D.KCustom, 
             SUM(A.CardCnt) AS TCardCnt, SUM(A.Roll) AS TRoll, SUM(A.Qty) AS TQty, 99 As PrnSeq 
     FROM (SELECT OrderID, CardID, SplitID, WaitProcID, 1 AS CardCnt, Roll, Qty FROM [Card] WHERE ISNULL(UseClss,'') <> '*' AND ISNULL(CloseClss,'0') = '1') AS A 
     LEFT JOIN [Order] B ON A.OrderID = B.OrderID 
     LEFT JOIN [mt_Custom] D ON B.CustomID = D.CustomID 
     LEFT JOIN [mt_Article] E ON B.ArticleID = E.ArticleID 
     WHERE 1 = 1 
     GROUP BY B.CustomID, D.KCustom 
     ) AS A 
--	 WHERE A.CUstomID='0372'
GROUP BY A.ProcessID, A.Process, A.CustomID, A.PrnSeq
ORDER BY A.PrnSeq


-- 선시레집계
SELECT A.ProcessID, A.Process, A.CustomID, SUM(A.TCardCnt) AS CardCnt, SUM(A.TRoll) AS Roll, SUM(A.TQty) AS Qty, A.PrnSeq
FROM (
     SELECT Z.ProcessID, Z.Process,
             CASE WHEN B.CustomID = '0073' THEN '0073' WHEN B.CustomID = '0323' THEN '0323' WHEN B.CustomID = '0326' THEN '0326' 
                 WHEN B.CustomID = '0249' THEN '0249' WHEN B.CustomID = '0040' THEN '0040' WHEN B.CustomID = '0225' THEN '0225' 
				 WHEN B.CustomID= '0372' THEN '0372'
                 ELSE 'ZZZZ' END AS CustomID, D.KCustom, 
             SUM(A.CardCnt) AS TCardCnt, SUM(A.Roll) AS TRoll, SUM(A.Qty) AS TQty, Z.PrnSeq 
     FROM (SELECT ProcessID, Process, PrnSeq FROM mt_Process WHERE SUBSTRING(ProcessID, 3, 2) <> '00' AND ISNULL(UseClss,'') < '*' AND ProcessID NOT IN ('1001', '9001') ) AS Z 
     LEFT JOIN (SELECT OrderID, CardID, SplitID, WaitProcID, 1 AS CardCnt, Roll, Qty FROM [Card] WHERE ISNULL(UseClss,'') <> '*' AND ISNULL(CloseClss,'0') = '0') AS A ON Z.ProcessID = A.WaitProcID 
     LEFT JOIN [Order] B ON A.OrderID = B.OrderID 
     LEFT JOIN [mt_Custom] D ON B.CustomID = D.CustomID 
     LEFT JOIN [mt_Article] E ON B.ArticleID = E.ArticleID 
     LEFT JOIN [mt_Work] AS F ON B.WorkID = F.WorkID
     WHERE 1 = 1 
     AND F.WorkName LIKE '%선%'
     GROUP BY Z.ProcessID, Z.Process, B.CustomID, D.KCustom, Z.PrnSeq
     UNION ALL
     SELECT '9999' AS ProcessID, '보류' AS Process,
             CASE WHEN B.CustomID = '0073' THEN '0073' WHEN B.CustomID = '0323' THEN '0323' WHEN B.CustomID = '0326' THEN '0326' 
             WHEN B.CustomID = '0249' THEN '0249' WHEN B.CustomID = '0040' THEN '0040' WHEN B.CustomID = '0225' THEN '0225' 
			 WHEN B.CustomID= '0372' THEN '0372'
             ELSE 'ZZZZ' END AS CustomID, D.KCustom, 
             SUM(A.CardCnt) AS TCardCnt, SUM(A.Roll) AS TRoll, SUM(A.Qty) AS TQty, 99 As PrnSeq 
     FROM (SELECT OrderID, CardID, SplitID, WaitProcID, 1 AS CardCnt, Roll, Qty FROM [Card] WHERE ISNULL(UseClss,'') <> '*' AND ISNULL(CloseClss,'0') = '1') AS A 
     LEFT JOIN [Order] B ON A.OrderID = B.OrderID 
     LEFT JOIN [mt_Custom] D ON B.CustomID = D.CustomID 
     LEFT JOIN [mt_Article] E ON B.ArticleID = E.ArticleID 
     LEFT JOIN [mt_Work] AS F ON B.WorkID = F.WorkID
     WHERE 1 = 1 
     AND F.WorkName LIKE '%선%'
     GROUP BY B.CustomID, D.KCustom 
     ) AS A 
GROUP BY A.ProcessID, A.Process, A.CustomID, A.PrnSeq
ORDER BY A.PrnSeq

--후시레집계
SELECT A.ProcessID, A.Process, A.CustomID, SUM(A.TCardCnt) AS CardCnt, SUM(A.TRoll) AS Roll, SUM(A.TQty) AS Qty, A.PrnSeq
FROM (
     SELECT Z.ProcessID, Z.Process,
             CASE WHEN B.CustomID = '0073' THEN '0073' WHEN B.CustomID = '0323' THEN '0323' WHEN B.CustomID = '0326' THEN '0326' 
                 WHEN B.CustomID = '0249' THEN '0249' WHEN B.CustomID = '0040' THEN '0040' WHEN B.CustomID = '0225' THEN '0225' 
				 WHEN B.CustomID= '0372' THEN '0372'
                 ELSE 'ZZZZ' END AS CustomID, D.KCustom, 
             SUM(A.CardCnt) AS TCardCnt, SUM(A.Roll) AS TRoll, SUM(A.Qty) AS TQty, Z.PrnSeq 
     FROM (SELECT ProcessID, Process, PrnSeq FROM mt_Process WHERE SUBSTRING(ProcessID, 3, 2) <> '00' AND ISNULL(UseClss,'') < '*' AND ProcessID NOT IN ('1001', '9001') ) AS Z 
     LEFT JOIN (SELECT OrderID, CardID, SplitID, WaitProcID, 1 AS CardCnt, Roll, Qty FROM [Card] WHERE ISNULL(UseClss,'') <> '*' AND ISNULL(CloseClss,'0') = '0') AS A ON Z.ProcessID = A.WaitProcID 
     LEFT JOIN [Order] B ON A.OrderID = B.OrderID 
     LEFT JOIN [mt_Custom] D ON B.CustomID = D.CustomID 
     LEFT JOIN [mt_Article] E ON B.ArticleID = E.ArticleID 
     LEFT JOIN [mt_Work] AS F ON B.WorkID = F.WorkID
     WHERE 1 = 1 
     AND F.WorkName LIKE '%후%'
     GROUP BY Z.ProcessID, Z.Process, B.CustomID, D.KCustom, Z.PrnSeq
     UNION ALL
     SELECT '9999' AS ProcessID, '보류' AS Process,
             CASE WHEN B.CustomID = '0073' THEN '0073' WHEN B.CustomID = '0323' THEN '0323' WHEN B.CustomID = '0326' THEN '0326' 
             WHEN B.CustomID = '0249' THEN '0249' WHEN B.CustomID = '0040' THEN '0040' WHEN B.CustomID = '0225' THEN '0225' 
			 WHEN B.CustomID= '0372' THEN '0372'
             ELSE 'ZZZZ' END AS CustomID, D.KCustom, 
             SUM(A.CardCnt) AS TCardCnt, SUM(A.Roll) AS TRoll, SUM(A.Qty) AS TQty, 99 As PrnSeq 
     FROM (SELECT OrderID, CardID, SplitID, WaitProcID, 1 AS CardCnt, Roll, Qty FROM [Card] WHERE ISNULL(UseClss,'') <> '*' AND ISNULL(CloseClss,'0') = '1') AS A 
     LEFT JOIN [Order] B ON A.OrderID = B.OrderID 
     LEFT JOIN [mt_Custom] D ON B.CustomID = D.CustomID 
     LEFT JOIN [mt_Article] E ON B.ArticleID = E.ArticleID 
     LEFT JOIN [mt_Work] AS F ON B.WorkID = F.WorkID
     WHERE 1 = 1 
     AND F.WorkName LIKE '%후%'
     GROUP BY B.CustomID, D.KCustom 
     ) AS A 
GROUP BY A.ProcessID, A.Process, A.CustomID, A.PrnSeq
ORDER BY A.PrnSeq


