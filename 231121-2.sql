
 SELECT A.OrderID, A.OrderNo, A.OrderSeq, B.CustomID, B.KCustom, A.ArticleID, C.Article, A.WorkID, D.Work,
         A.WidthID, E.Width, A.OrderQty, A.OrderUnit, A.SKClss,
         F.OutID, F.OutDate, F.OutTime, F.CustomID AS OutCustomID, G.KCustom AS OutCustom,
         F.OutClss, F.OutType, F.OutOrderQty, F.OutRoll, F.OutQty, F.OutBox, F.PrintNO, F.ShipMark, F.FixDate,
         H.ChargeClss , A.PointClss, F.Boxsize, G.PHONE1, F.OutDate, A.TagItem,F.OutCustom as OutCustom2,F.ScanFlag
 FROM [DS20] A, DS02 B, DS01 C, [DS19] D, [DS13] E, [DS26] F, DS02 G, [DS61] H
 Where A.ArticleID = C.ArticleID And A.WorkID = D.WorkID And A.WidthID = E.WidthID
         AND A.OrderID = F.OrderID AND F.CustomID *= G.CustomID AND F.OrderID = H.OrderID AND F.OutID = H.OutID
         AND A.CustomID1 *= B.CustomID  AND F.OutDate BETWEEN '20230321' AND '20231121'
 ORDER BY A.OrderID, F.OutID




