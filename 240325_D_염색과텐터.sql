--ø∞ªˆƒı∏Æ
SELECT C.OrderNO, B.OrderSeq, A.CardID, A.ProcessSeq, A.MachineID, E.KCustom, F.Article, D.Color, A.WorkTemp, A.StartDate, A.StartTime, A.EndDate, A.EndTime, H.Temperature, I.AIPDTemp
  FROM DS_ProcessPD AS A
       LEFT JOIN [Card] AS B ON A.CardID = B.CardID
       LEFT JOIN [ORDER] AS C ON B.OrderID = C.OrderID
       LEFT JOIN OrderColor AS D ON B.OrderID = D.OrderID AND B.OrderSeq = D.Orderseq
       LEFT JOIN mt_Custom AS E ON C.CustomID = E.CustomID
       LEFT JOIN mt_Article AS F ON C.ArticleID = F.ArticleID
       LEFT JOIN DyeRecipe AS G ON D.OrderID = G.OrderID AND D.OrderSeq = G.OrderSeq
       LEFT JOIN (SELECT KeyDate, KeySeq, MAX(Temperature) AS Temperature
                    FROM DyeRecipeSub
                   GROUP BY KeyDate, KeySeq) AS H ON G.KeyDate = H.KeyDate AND G.KeySeq = H.KeySeq
       LEFT JOIN WorkStandard_AI AS I ON B.AIKeyDate = I.AIKeyDate AND B.AIKeySeq = I.AIKeySeq
-- WHERE A.EndDate = '20240325'  
 ORDER BY A.EndTime
--≈Ÿ≈Õƒı∏Æ
SELECT C.OrderNO, B.OrderSeq, A.CardID, A.ProcessSeq, A.MachineID, E.KCustom, F.Article, D.Color, A.Temperature, A.Speed, A.StartDate, A.StartTime, A.EndDate, A.EndTime, H.Standard, I.AIHSTemp, I.AIHSSpeed
  FROM DS_ProcessDY_HS AS A
       LEFT JOIN [Card] AS B ON A.CardID = B.CardID
       LEFT JOIN [ORDER] AS C ON B.OrderID = C.OrderID
       LEFT JOIN OrderColor AS D ON B.OrderID = D.OrderID AND B.OrderSeq = D.Orderseq
       LEFT JOIN mt_Custom AS E ON C.CustomID = E.CustomID
       LEFT JOIN mt_Article AS F ON C.ArticleID = F.ArticleID
       LEFT JOIN (SELECT OrderID, Min(SeqNO) AS SeqNO
                    FROM Ds_WorkCard
                   WHERE WorkName = 'DY-HS'
                   GROUP BY OrderID) AS G ON B.OrderID = G.OrderID
       LEFT JOIN Ds_WorkCard AS H ON B.OrderID = H.OrderID AND G.SeqNO = H.SEQNO
       LEFT JOIN WorkStandard_AI AS I ON B.AIKeyDate = I.AIKeyDate AND B.AIKeySeq = I.AIKeySeq
-- WHERE A.EndDate = '20240325'
   AND A.ProcessID = '3011' 
   AND A.MachineID = '01' 
 ORDER BY A.EndTime


