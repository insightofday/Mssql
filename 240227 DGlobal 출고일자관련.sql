select * from ds23 --입고상세의 stuffdate

select * from ds24 --검사의 examdate

select * from ds27 --출고상세의 fixdate

SELECT * FROM ds26 order by outdate desc



 SELECT A.OrderID, A.OrderNo, A.OrderSeq, B.CustomID, B.KCustom, A.ArticleID, C.Article, A.WorkID, D.Work,
         A.WidthID, E.Width, A.OrderQty, A.OrderUnit, A.PointClss,
         F.OutID, F.FixDate AS OutDate, F.OutTime, F.CustomID AS OutCustomID, G.KCustom AS OutCustom,
         F.OutClss, F.OutType, F.OutOrderQty, F.OutRoll, F.OutQty,
         (SELECT SUM(Round(((OutQty * 1.0936*2) -0.4),0)/2) FROM DSV01 WHERE OrderID = F.OrderID AND OutID = F.OutID) AS OutQtyY,
         ISNULL(H.InRoll, 0) AS InRoll, ISNULL(H.InQty, 0) AS InQty, ISNULL(H.InQtyY, 0) AS InQtyY,
         ISNULL(I.LossRoll, 0) AS LossRoll, ISNULL(I.LossQty, 0) AS LossQty, ISNULL(I.LossQtyY, 0) AS LossQtyY,
         j.ChargeClss
 FROM [DS20] A, DS02 B, DS01 C, [DS19] D, [DS13] E, [DS26] F, DS02 G,
         (SELECT OrderID, ISNULL(SUM(StuffRoll), 0) AS InRoll, ISNULL(SUM(StuffQty), 0) AS InQty, ISNULL(SUM(Round(((StuffQty * 1.0936 * 2)-0.4),0)/2), 0) AS InQtyY
         From DS23 
 WHERE StuffDate <= '20240227'
 GROUP BY OrderID) H, 
 (SELECT OrderID, ISNULL(SUM(LossRoll), 0) AS LossRoll, ISNULL(SUM(LossQty), 0) AS LossQty, ISNULL(SUM(Round(((LossQty * 1.0936 * 2)-0.4),0)/2), 0) AS LossQtyY
 From DS41 
 WHERE LossDate <= '20240227'
 GROUP BY OrderID) I, 
         [DS61] j
     Where A.CustomID = B.CustomID And A.ArticleID = C.ArticleID And A.WorkID = D.WorkID And A.WidthID = E.WidthID
         AND A.OrderID = F.OrderID AND F.CustomID *= G.CustomID AND A.OrderID *= H.OrderID
         AND A.OrderID *= I.OrderID AND F.OrderID = J.OrderID AND F.OutID = J.OutID AND F.FixDate IS NOT NULL 
 AND F.OutDate BETWEEN '20240223' AND '20240227'
 ORDER BY A.CustomID, A.OrderID, F.OutID

