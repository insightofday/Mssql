SELECT C.keydate, A.plandate, B.KCustom, D.Article, C.Qty, F.Material, SUM(C.Qty*E.Amount) Tqty, A.WorkJISI
FROM  OutWork A
LEFT JOIN mt_custom B ON A.CustomID = B.CustomID
LEFT JOIN OutWorkSub C ON A.KeyDate = C.KeyDate AND A.KeySeq = C.KeySeq
LEFT JOIN mt_article D ON C.ArticleID = D.ArticleID
LEFT JOIN mt_ArticleSub E ON D.articleId = E.ArticleId
LEFT JOIN mt_Material F ON E.MaterialID = F.MaterialID
GROUP BY  C.keydate, A.plandate, B.KCustom, D.Article, C.Qty, F.Material, A.WorkJISI




select * from mt_material
select * from outwork