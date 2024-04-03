SELECT A.TranNo, A.FixDate, A.OutDate, A.OrderID,B.OrderNo, C.KCustom, D.Article, E.Width, A.OutRoll, A.OutQty, A.outCustom, A.Remark, 
FF.ColorID, FF.StyleNo,B.TagArticle, A.CustomID, A.OutID
FROM [DS26] A
LEFT JOIN (SELECT A.OrderID, A.OutID, B.StyleNo, B.ColorID, B.TagItem, B.ArticleID, ROW_NUMBER() OVER(Partition BY A.OrderID, A.OutID ORDER BY A.OrderID, A.OutID, B.ColorID) AS Num 
           FROM DS27 AS A 
           LEFT JOIN DS21 AS B ON A.OrderID = B.OrderID AND A.ColorID = B.ColorID) AS FF 
		   ON A.OrderID = FF.OrderID AND A.OutID = FF.OutID AND FF.Num = 1 
LEFT JOIN DS20 AS B ON A.OrderID = B.OrderID
LEFT JOIN DS02 AS C ON B.CustomID = C.CustomID
LEFT JOIN DS01 AS D ON FF.ArticleID = D.ArticleID
LEFT JOIN DS13 AS E ON B.WidthID = E.WidthID
Where 1=1
AND A.OutDate BETWEEN '20240403' AND '20240403'
ORDER BY A.OutDate, A.TranNo


select *
from ds26 a 
left join(SELECT A.OrderID, A.OutID, B.StyleNo, B.ColorID, B.TagItem, B.ArticleID, ROW_NUMBER() OVER(Partition BY A.OrderID, A.OutID ORDER BY A.OrderID, A.OutID, B.ColorID) AS Num 
           FROM DS27 AS A 
           LEFT JOIN DS21 AS B ON A.OrderID = B.OrderID AND A.ColorID = B.ColorID) AS FF 
		   ON A.OrderID = FF.OrderID AND A.OutID = FF.OutID AND FF.Num = 1 

		   