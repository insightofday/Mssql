--orderId��orderNo�� ����?
SELECT A.OrderID, A.OrderNo, B.KCustom, C.Article, D.WorkName
FROM [Order] AS A
LEFT JOIN [mt_Custom] B ON A.CustomID = B.CustomID
LEFT JOIN [mt_Article] C ON A.ArticleID = C.ArticleID
LEFT JOIN [mt_Work] D ON A.WorkID = D.WorkID

--����:machine, work
--����:process