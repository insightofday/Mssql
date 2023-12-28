--외주재고(쿼리고치기 전 53개 출력됨)
 select a.kcustom, a.material, (sum(a.inmat) - sum(a.outmat)) StockQty, trim(a.materialid), a.keydate, a.keyseq   
 from ( 
       select kcustom, keydate, keyseq, materialid, material, sum(outqty) outMat, 0 inmat 
       from ( 
              select g.kcustom, a.keydate, a.keyseq, c.materialid, d.Material, c.amount, a.stuffinqty, (a.stuffinqty*c.Amount) Outqty 
              from stuffin A 
                   left JOIN [OutWork] AS f ON A.KeyDate = f.KeyDate AND A.KeySeq = f.KeySeq 
                   LEFT JOIN [outworksub] B ON A.KeyDate = b.KeyDate  AND A.KeySeq = b.KeySeq 
                   LEFT JOIN [mt_Articlesub] C ON B.articleID = c.ArticleID 
                   LEFT JOIN [mt_Material] D ON C.MaterialID = D.MaterialID 
                   LEFT JOIN [mt_Custom] AS g ON f.CustomID = g.CustomID 
              WHERE (c.Divide ='자재' or c.Divide ='원단' )
              group by a.keydate, a.keyseq, c.MaterialID, d.Material, b.articleid, g.kcustom, c.amount, a.stuffinqty 
          ) a group by kcustom, keydate, keyseq,materialid, material 
 Union 
 SELECT g.kcustom, a.keydate, a.keyseq, a.materialid, d.material , 0, Sum(A.totalQty)+isnull(h.qty,0) As inMat 
 FROM OutWorkMat AS A 
      left JOIN [OutWork] AS f ON A.KeyDate = f.KeyDate AND A.KeySeq = f.KeySeq 
      LEFT JOIN [mt_Material] D ON a.MaterialID = D.MaterialID 
      LEFT JOIN [mt_Custom] AS g ON f.CustomID = g.CustomID 
      left join [outstockbase] as h on a.materialid = h.materialid  
  GROUP BY g.kcustom, a.keydate, a.keyseq, a.materialid, d.material, h.qty 
 ) a 
 group by a.kcustom, a.keydate, a.keyseq, a.materialid, a.material 


 --외주기초재고관련부분제거
  select a.kcustom, a.material, (sum(a.inmat) - sum(a.outmat)) StockQty, trim(a.materialid), a.keydate, a.keyseq   
 from ( 
       select kcustom, keydate, keyseq, materialid, material, sum(outqty) outMat, 0 inmat 
       from ( 
              select g.kcustom, a.keydate, a.keyseq, c.materialid, d.Material, c.amount, a.stuffinqty, (a.stuffinqty*c.Amount) Outqty 
              from stuffin A 
                   left JOIN [OutWork] AS f ON A.KeyDate = f.KeyDate AND A.KeySeq = f.KeySeq 
                   LEFT JOIN [outworksub] B ON A.KeyDate = b.KeyDate  AND A.KeySeq = b.KeySeq 
                   LEFT JOIN [mt_Articlesub] C ON B.articleID = c.ArticleID 
                   LEFT JOIN [mt_Material] D ON C.MaterialID = D.MaterialID 
                   LEFT JOIN [mt_Custom] AS g ON f.CustomID = g.CustomID 
              WHERE (c.Divide ='자재' or c.Divide ='원단' )
              group by a.keydate, a.keyseq, c.MaterialID, d.Material, b.articleid, g.kcustom, c.amount, a.stuffinqty 
          ) a group by kcustom, keydate, keyseq,materialid, material 
 Union 
 SELECT g.kcustom, a.keydate, a.keyseq, a.materialid, d.material , 0, Sum(A.totalQty) As inMat 
 FROM OutWorkMat AS A 
      left JOIN [OutWork] AS f ON A.KeyDate = f.KeyDate AND A.KeySeq = f.KeySeq 
      LEFT JOIN [mt_Material] D ON a.MaterialID = D.MaterialID 
      LEFT JOIN [mt_Custom] AS g ON f.CustomID = g.CustomID 
  GROUP BY g.kcustom, a.keydate, a.keyseq, a.materialid, d.material
 ) a 
 group by a.kcustom, a.keydate, a.keyseq, a.materialid, a.material 

 
select * from OutStockBase


 --외주기초재고
SELECT A.BasisDate, B.KCustom, C.Material, C.Color, C.Standard, A.Qty, A.Remark, A.CustomID, A.MaterialID 
  FROM [OutStockBase] AS A
       LEFT JOIN [mt_Custom] AS B ON B.CustomID = A.CustomID 
       LEFT JOIN [mt_Material] AS C ON A.MaterialID = C.MaterialID 
 WHERE 1=1 
   AND A.BasisDate = '00000000' 
ORDER BY A.BasisDate, B.KCustom, C.Material, A.Qty





select * from [order]

select * from ordersub