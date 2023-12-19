SELECT A.Purpose, A.Divide, B.Material, B.Color, B.Standard, A.Size, A.Amount, A.Cost, A.Price, A.MaterialID
FROM [mt_ArticleSub] AS A
LEFT JOIN [mt_Material] AS B ON A.MaterialID = B.MaterialID
WHERE A.ArticleID = 'P10112' 
ORDER BY A.ArticleID, A.SubKey
