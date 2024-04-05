
SELECT A.TranNo, A.FixDate, A.OutDate, A.OrderID,B.OrderNo, C.KCustom, D.Article, E.Width, A.OutRoll, A.OutQty, A.outCustom, A.Remark, FF.ColorID, FF.StyleNo,B.TagArticle, A.CustomID, A.OutID
FROM [DS26] A
LEFT JOIN (SELECT A.OrderID, A.OutID, B.StyleNo, B.ColorID, B.TagItem, B.ArticleID, ROW_NUMBER() OVER(Partition BY A.OrderID, A.OutID ORDER BY A.OrderID, A.OutID, B.ColorID) AS Num 
           FROM DS27 AS A 
           LEFT JOIN DS21 AS B ON A.OrderID = B.OrderID AND A.ColorID = B.ColorID) AS FF ON A.OrderID = FF.OrderID AND A.OutID = FF.OutID AND FF.Num = 1 
LEFT JOIN DS20 AS B ON A.OrderID = B.OrderID
LEFT JOIN DS02 AS C ON B.CustomID = C.CustomID
LEFT JOIN DS01 AS D ON FF.ArticleID = D.ArticleID
LEFT JOIN DS13 AS E ON B.WidthID = E.WidthID
Where 1=1
AND A.OutDate BETWEEN '20240401' AND '20240404'
ORDER BY A.OutDate, A.TranNo



--출고: ds26 출고상세:ds27
 SELECT Distinct b.KCustom '거래처',b.CustomID
 From
 (
     SELECT b.CustomID FROM DS24 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID   
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.Examdate,6) = '202403'            
          AND   c.Spendingclss = '1'            
     UNION ALL                                               
     SELECT b.CustomID FROM DS26 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.FixDate,6) = '202403'
       AND  A.OutType = 4 and A.outclss not in(4)
       AND  c.Spendingclss = '0'            
     UNION ALL                                               
     SELECT b.CustomID FROM DS26 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID   
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.FixDate,6) = '202403'             
       AND a.Outclss = 2                                      
       AND  c.Spendingclss = '0'            
     UNION ALL                                               
     SELECT b.CustomID FROM DS26 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID   
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.FixDate,6) = '202403'             
    --   AND a.Outclss = 0                                      
       AND  c.Spendingclss = '0'            
 )    AS a
 INNER JOIN DS02 AS b ON  a.CustomID = b.CustomID


select * from ds02 where kcustom='이서 텍스'


select * from ds27 

select * from ds26

select * from ds20



 SELECT SpendingClss 
 FROM DS02
 WHERE CustomID ='0115'


 select * from ds02

