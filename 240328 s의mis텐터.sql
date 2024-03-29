
SELECT C.OrderNO, B.OrderSeq, A.CardID, A.MachineID
     , E.KCustom, F.Article, D.Color
     , A.StartDate, A.StartTime, A.EndDate, A.EndTime
  FROM DS_ProcessGG AS A
       LEFT JOIN [Card] AS B ON A.CardID = B.CardID		--공정에 들어간 것만 뽑아내기
       LEFT JOIN [ORDER] AS C ON B.OrderID = C.OrderID
       LEFT JOIN OrderColor AS D ON B.OrderID = D.OrderID AND B.OrderSeq = D.Orderseq
       LEFT JOIN mt_Custom AS E ON C.CustomID = E.CustomID
       LEFT JOIN mt_Article AS F ON C.ArticleID = F.ArticleID
       LEFT JOIN DyeRecipe AS G ON D.OrderID = G.OrderID AND D.OrderSeq = G.OrderSeq
 WHERE A.EndDate = '20240326'  
 ORDER BY A.EndTime

 select * from card